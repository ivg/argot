(*
 * This file is part of Argot.
 * Copyright (C) 2010-2012 Xavier Clerc.
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


let strip_module_name name module_name =
  let m = String.length module_name in
  let rec loop name i =
    let n = String.length name in
    match String.sub name i m = module_name with
    | false -> loop name (i+1)
    | exception _ -> name
    | true ->
      if n > i+m && name.[i+m] = '.' then
        let lhs = String.sub name 0 i in
        let rhs = String.sub name (i+m+1) (n-m-i-1) in
        loop (lhs^rhs) (i+1)
      else loop name (i+1) in
  loop name 0

let strip_hidden_modules name =
  List.fold_left strip_module_name name !Odoc_global.hidden_modules

module Types = struct
  module Set = StringSet
  let get m t = List.partition (Set.mem t) m

  let union m t1 t2 =
    let strip = strip_hidden_modules in
    let t1 = strip t1 and t2 = strip t2 in
    match get m t1, get m t2 with
    | ([],_),([],_) -> Set.of_list [t1; t2] :: m
    | ([s],m),([],_) -> Set.add t2 s :: m
    | ([],_),([s],m) -> Set.add t1 s :: m
    | ([s1],modulo_s1),([s2],_) ->
      if Set.equal s1 s2 then m
      else Set.union s1 s2 ::
           List.filter (fun s -> not(Set.equal s s2)) modulo_s1
    | _ -> assert false

end

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
                  StringSet.add ("\"" ^ (String.uppercase_ascii elem) ^ "\"") acc
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
      (strip_hidden_modules short_name)
      (strip_hidden_modules full_name)
      kind
      (strip_hidden_modules typ)
      ref
      doc
      words in
  let add_manifest n f t =
    Printf.fprintf chan "add_manifest(%S, %S, %S);\n"
      (strip_hidden_modules n)
      (strip_hidden_modules f)
      (strip_hidden_modules t) in
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
  let string_of_variant_constructor = function
    | Type.Cstr_tuple args -> string_of_type_expr_list args
    | Type.Cstr_record _ -> "< record_type >" in
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
    let type_equalities = ref [] in
    let union t1 t2 =
      type_equalities := Types.union !type_equalities t1 t2 in
    List.iter (* output type manifests first *)
      (fun x ->
        let type_params =
          List.map
            (fun (x, _, _) ->
              string_of_type_expr x)
            x.Type.ty_parameters in
        let type_expr =
          match type_params with
          | [] -> x.Type.ty_name
          | [e] -> e ^ " " ^ x.Type.ty_name
          | l -> "(" ^ (String.concat ", " l) ^ ") " ^ x.Type.ty_name in
        match x.Type.ty_kind with
        | Type.Type_abstract ->
            (match x.Type.ty_manifest with
              | Some (Type.Other te) ->
                let te = string_of_type_expr te in
                union type_expr te;
                union x.Type.ty_name te
              | _ -> ())
        | Type.Type_variant _ | Type.Type_open -> ()
        | Type.Type_record l ->
            let types =
              List.map
                (fun x ->
                  "(" ^ (string_of_type_expr x.Type.rf_type) ^ ")")
                l in
            let types = String.concat " * " types in
            union x.Type.ty_name type_expr;
            union type_expr types)
      self#list_types;
    List.iter (fun cls ->
        let repr = StringSet.max_elt cls in
        StringSet.iter (fun t ->
            if t <> repr then add_manifest t t repr) cls) !type_equalities;
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
        get_type = (fun x -> string_of_variant_constructor x.Exception.ex_args);
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
        | Type.Type_abstract | Type.Type_open -> ()
        | Type.Type_variant l ->
            List.iter
              (fun x ->
                let name = x.Type.vc_name in
                let typ = string_of_variant_constructor x.Type.vc_args in
                let full_text = x.Type.vc_text in
                let doc = first_setence full_text in
                add_ocaml_element name name "constructor" typ ref full_text doc)
              l
        | Type.Type_record l ->
            List.iter
              (fun x ->
                let name = x.Type.rf_name in
                let typ = string_of_type_expr x.Type.rf_type in
                let full_text = x.Type.rf_text in
                let doc = first_setence full_text in
                add_ocaml_element name name "field" typ ref full_text doc)
              l)
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
        get_ref = (fun x -> fst (Odoc_html.Naming.html_files x.Class.cl_name));
        get_doc = (fun x -> x.Class.cl_info); };
    iter
      self#list_class_types
      { get_name = (fun x -> x.Class.clt_name);
        get_kind = (fun _ -> "class type");
        get_type = (fun _ -> ellipsis "class type");
        get_ref = (fun x -> fst (Odoc_html.Naming.html_files x.Class.clt_name));
        get_doc = (fun x -> x.Class.clt_info); };
    iter
      self#list_modules
      { get_name = (fun x -> x.Module.m_name);
        get_kind = (fun _ -> "module");
        get_type = (fun _ -> ellipsis "module");
        get_ref = (fun x -> fst (Odoc_html.Naming.html_files x.Module.m_name));
        get_doc = (fun x -> x.Module.m_info); };
    iter
      self#list_module_types
      { get_name = (fun x -> x.Module.mt_name);
        get_kind = (fun _ -> "module type");
        get_type = (fun _ -> ellipsis "module type");
        get_ref = (fun x -> fst (Odoc_html.Naming.html_files x.Module.mt_name));
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
      "      <input type=\"radio\" name=\"mode\" value=\"type\"/>&nbsp;by type&nbsp;&nbsp;&nbsp;";
      "      <input type=\"radio\" name=\"mode\" value=\"typewithmanifest\"/>&nbsp;by type, using manifest<br/>";
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
    let title = match !Odoc_global.title with Some x -> x | None -> "Argot search" in
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
