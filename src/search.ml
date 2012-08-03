(*
 * This file is part of Argot.
 * Copyright (C) 2010-2011 Xavier Clerc.
 *
 * Argot is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Argot is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *)

type 'a element_access = {
    get_name : 'a -> Odoc_info.Name.t;
    get_kind : 'a -> string;
    get_type : 'a -> string;
    get_ref : 'a -> string;
    get_doc : 'a -> Odoc_info.info option;
  }

let empty_info =
  { Odoc_types.i_desc = None;
    Odoc_types.i_authors = [];
    Odoc_types.i_version = None;
    Odoc_types.i_sees = [];
    Odoc_types.i_since = None;
    Odoc_types.i_before = [];
    Odoc_types.i_deprecated = None;
    Odoc_types.i_params = [];
    Odoc_types.i_raised_exceptions = [];
    Odoc_types.i_return_value = None;
    Odoc_types.i_custom = []; }

let make_info desc =
  Some { empty_info with Odoc_types.i_desc = desc }

let predefined_types =
  ["int"; "char"; "string"; "float"; "bool"; "unit"; "exn";
   "array"; "list"; "option";
   "int32"; "int64"; "nativeint"; "format4"; "lazy_t"]

let predefined_exceptions =
  ["Match_failure", "string * int * int";
   "Assert_failure", "string * int * int";
   "Invalid_argument", "string";
   "Failure", "string";
   "Not_found", "";
   "Out_of_memory", "";
   "Stack_overflow", "";
   "Sys_error", "string";
   "End_of_file", "";
   "Division_by_zero", "";
   "Sys_blocked_io", "";
   "Undefined_recursive_module", "string * int * int"]

let predefined_constructors =
  ["Some"; "None"]

module StringSet = Set.Make (String)

let word_boundary = Str.regexp "\\b"
let is_word = Str.regexp "[a-zA-Z0-9]+"

let generate_data path self =
  let args_full_text = !Args.full_text in
  let open Odoc_info in
  let first_setence info =
    let buff = Buffer.create 512 in
    self#html_of_info_first_sentence buff info;
    Buffer.contents buff in
  let ellipsis s =
    Printf.sprintf "<i>(... %s ...)</i>" s in
  let filename = Filename.concat path "argot_data.js" in
  let chan = open_out filename in
  let add_ocaml_element short_name full_name kind typ ref full_text doc =
    let words =
      if args_full_text then begin
        let set = match full_text with
        | Some info ->
            let str = string_of_info info in
            let l = Str.split word_boundary str in
            List.fold_left
              (fun acc elem ->
                if (String.length elem > 2) && (Str.string_match is_word elem 0) then
                  StringSet.add ("\"" ^ (String.uppercase elem) ^ "\"") acc
                else
                  acc)
              StringSet.empty
              l
        | None -> StringSet.empty in
        "[" ^ (String.concat ", " (StringSet.elements set)) ^ "]"
      end else
        "[]" in
    Printf.fprintf
      chan
      "add_ocaml_element(%S, %S, %S, %S, %S, %S, %s);\n"
      short_name
      full_name
      kind
      typ
      ref
      doc
      words in
  let iter l access =
    List.iter
      (fun x ->
        reset_type_names ();
        let full = access.get_name x in
        let simple = Name.simple full in
        let kind = access.get_kind x in
        let typ = access.get_type x in
        let ref = access.get_ref x in
        let full_text = access.get_doc x in
        let doc = first_setence full_text in
        add_ocaml_element simple full kind typ ref full_text doc)
      l in
  let string_of_type_expr_list l =
    String.concat " * " (List.map string_of_type_expr l) in
  try
    List.iter
      (fun t -> add_ocaml_element t t "type" t "" None "built-in")
      predefined_types;
    List.iter
      (fun (n, t) -> add_ocaml_element n n "exception" t "" None "built-in")
      predefined_exceptions;
    List.iter
      (fun n -> add_ocaml_element n n "constructor" "option" "" None "built-in")
      predefined_constructors;
    iter
      self#list_values
      { get_name = (fun x -> x.Value.val_name);
        get_kind = (fun _ -> "value");
        get_type = (fun x -> string_of_type_expr x.Value.val_type);
        get_ref = (fun x -> Odoc_html.Naming.complete_value_target x);
        get_doc = (fun x -> x.Value.val_info); };
    iter
      self#list_exceptions
      { get_name = (fun x -> x.Exception.ex_name);
        get_kind = (fun _ -> "exception");
        get_type = (fun x -> string_of_type_expr_list x.Exception.ex_args);
        get_ref = (fun x -> Odoc_html.Naming.complete_exception_target x);
        get_doc = (fun x -> x.Exception.ex_info); };
    iter
      self#list_types
      { get_name = (fun x -> x.Type.ty_name);
        get_kind = (fun _ -> "type");
        get_type = (fun _ -> ellipsis "type");
        get_ref = (fun x -> Odoc_html.Naming.complete_type_target x);
        get_doc = (fun x -> x.Type.ty_info); };
    List.iter
      (fun x ->
        let ref = Odoc_html.Naming.complete_type_target x in
        match x.Type.ty_kind with
        | Type.Type_abstract -> ()
        | Type.Type_variant l ->
            List.iter
              (fun x ->
                let name = x.Type.vc_name in
                let typ = string_of_type_expr_list x.Type.vc_args in
                let full_text = make_info x.Type.vc_text in
                let doc = first_setence full_text in
                add_ocaml_element name name "constructor" typ ref full_text doc)
              l
        | Type.Type_record l ->
            List.iter
              (fun x ->
                let name = x.Type.rf_name in
                let typ = string_of_type_expr x.Type.rf_type in
                let full_text = make_info x.Type.rf_text in
                let doc = first_setence full_text in
                add_ocaml_element name name "field" typ ref full_text doc)
              l
)
      self#list_types;
    iter
      self#list_attributes
      { get_name = (fun x -> x.Value.att_value.Value.val_name);
        get_kind = (fun _ -> "attribute");
        get_type = (fun x -> string_of_type_expr x.Value.att_value.Value.val_type);
        get_ref = (fun x -> Odoc_html.Naming.complete_attribute_target x);
        get_doc = (fun x -> x.Value.att_value.Value.val_info); };
    iter
      self#list_methods
      { get_name = (fun x -> x.Value.met_value.Value.val_name);
        get_kind = (fun _ -> "method");
        get_type = (fun x -> string_of_type_expr x.Value.met_value.Value.val_type);
        get_ref = (fun x -> Odoc_html.Naming.complete_method_target x);
        get_doc = (fun x -> x.Value.met_value.Value.val_info); };
    iter
      self#list_classes
      { get_name = (fun x -> x.Class.cl_name);
        get_kind = (fun _ -> "class");
        get_type = (fun _ -> ellipsis "class");
        get_ref = (fun x -> Odoc_html.Naming.file_type_class_complete_target x.Class.cl_name);
        get_doc = (fun x -> x.Class.cl_info); };
    iter
      self#list_class_types
      { get_name = (fun x -> x.Class.clt_name);
        get_kind = (fun _ -> "class type");
        get_type = (fun _ -> ellipsis "class type");
        get_ref = (fun x -> Odoc_html.Naming.file_type_class_complete_target x.Class.clt_name);
        get_doc = (fun x -> x.Class.clt_info); };
    iter
      self#list_modules
      { get_name = (fun x -> x.Module.m_name);
        get_kind = (fun _ -> "module");
        get_type = (fun _ -> ellipsis "module");
        get_ref = (fun x -> Odoc_html.Naming.complete_target "" x.Module.m_name);
        get_doc = (fun x -> x.Module.m_info); };
    iter
      self#list_module_types
      { get_name = (fun x -> x.Module.mt_name);
        get_kind = (fun _ -> "module type");
        get_type = (fun _ -> ellipsis "module type");
        get_ref = (fun x -> Odoc_html.Naming.complete_target "" x.Module.mt_name);
        get_doc = (fun x -> x.Module.mt_info); };
    close_out_noerr chan
  with e ->
    close_out_noerr chan;
    raise e

let generate_html path =
  let filename = Filename.concat path "argot_search.html" in
  let where =
    if !Args.search_frame then "'frame'" else "'window'" in
  Utils.write_lines
    filename
    [ "<html>";
      "  <head>";
      "    <title>Search</title>";
      "    <link rel=\"stylesheet\" href=\"style.css\" type=\"text/css\">";
      "    <script type=\"text/javascript\" src=\"argot_types.js\"></script>";
      "    <script type=\"text/javascript\" src=\"argot_parser.js\"></script>";
      "    <script type=\"text/javascript\" src=\"argot_search.js\"></script>";
      "    <script type=\"text/javascript\" src=\"argot_data.js\"></script>";
      "  </head>";
      "  <body onload=\"document.form.query.focus();\">";
      "    <form name=\"form\" action=\"javascript:exec_query(" ^ where ^ ");\">";
      "      <input type=\"text\" name=\"query\" value=\"\" size=\"42\"/>";
      "      <input type=\"submit\" value=\"search\"/>";
      "      <br/>";
      "      <input type=\"radio\" name=\"mode\" value=\"name\" checked=\"checked\"/>&nbsp;by name<br/>"; 
      "      <input type=\"radio\" name=\"mode\" value=\"regexp\"/>&nbsp;by regexp<br/>";
      "      <input type=\"radio\" name=\"mode\" value=\"type\"/>&nbsp;by type<br/>";
      "      <input type=\"radio\" name=\"mode\" value=\"fulltext\"/>&nbsp;by full text<br/>";
      "    </form>";
      "    <hr width=\"80%\" style=\"border-color: black; border-width: 1px; border-style: solid;\"/>";
      "    <br/>";
      (if !Args.search_frame then
        "    <div id=\"results\"\">"
      else
        "    <div id=\"results\" style=\"height: 75%; overflow: scroll;\">");
      "    </div>";
      "  </body>";
      "</html>" ];
  if !Args.search then begin
    let filename = Filename.concat path "argot_index.html" in
    let title = match !Odoc_args.title with Some x -> x | None -> "Argot search" in
    Utils.write_lines
      filename
      [ "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\">";
        "<html>";
        "  <head>";
        "    <title>" ^ title ^ "</title>";
        "  </head>";
        "  <frameset cols=\"400,*\">";
        "    <frame src=\"argot_search.html\" name=\"search_frame\">";
        "    <frame src=\"index.html\" name=\"main_frame\">";
        "    <noframe><body><i>frames are not supported</i></body></noframe>";
        "  </frameset>";
        "</html>" ];
  end

let link =
  let code = "window.open('argot_search.html', 'search', 'width=400,height=500,toolbar=no,menubar=no,resizable=no,status=no')" in
  Printf.sprintf "<a href=\"#\" onclick=\"javascript:%s\"><img src=\"data:image/png;base64,%s\" alt=\"%s\" title=\"%s\" align=\"middle\"/></a><br>\n"
    code
    Icons.search_base64
    "search"
    "search"

let css = [
  "";
  "/* Argot search results */";
  ".argot_result { font-size:75%; }"
]
