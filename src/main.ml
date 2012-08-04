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

type text_kind =
  | Text of Odoc_info.text
  | String of string

class argot_generator = object (self)

  inherit Odoc_html.html as super

  val tables = Tables.make_state ()

  val mutable next_fold_id = 0

  method private string_of_text text =
    let buff = Buffer.create 256 in
    self#html_of_text buff text;
    Buffer.contents buff

  method private trimmed_string_of_text text =
    let str = self#string_of_text text in
    let len = String.length str in
    if len > 0 then
      let first = str.[0] in
      if (first = ' ') || (first = '\t') then
        String.sub str 1 (pred len)
      else
        str
    else
      str

  method private render_tag tag attrs buff text =
    let add = Buffer.add_string buff in
    add "<";
    add tag;
    List.iter
      (fun (name, value) ->
        add " ";
        add name;
        add "=\"";
        add value;
        add "\"")
      attrs;
    add ">";
    add
      (match text with
      | Text t -> self#trimmed_string_of_text t
      | String s -> s);
    add "</";
    add tag;
    add ">"

  method! html_of_custom_text buff start text =
    let add = Buffer.add_string buff in
    match start with
    | "s" -> self#render_tag "strike" [] buff (Text text)
    | "u" -> self#render_tag "u" [] buff (Text text)
    | "h" -> self#render_tag "font" ["style", "background-color: orange"] buff (Text text)
    | "table" ->
        Tables.begin_table tables;
        self#render_tag "table" ["class", "argot"] buff (Text text);
        Tables.end_table tables
    | "header" ->
        Tables.add_cell tables;
        self#render_tag "th" [] buff (Text text)
    | "row" ->
        Tables.begin_row tables;
        self#render_tag "tr" [] buff (Text text);
        Tables.end_row tables
    | "data" ->
        Tables.add_cell tables;
        self#render_tag "td" [] buff (Text text)
    | "span" ->
        let text = self#trimmed_string_of_text text in
        let idx1 = try String.index text ' ' with Not_found -> max_int in
        let idx2 = try String.index text '\t' with Not_found -> max_int in
        let idx = min idx1 idx2 in
        if idx < max_int then
          let sz = String.sub text 0 idx in
          try
            let n = int_of_string sz in
            if n >= 1 then begin
              Tables.add_cells n tables;
              let text = String.sub text idx ((String.length text) - idx) in
              self#render_tag "td" ["colspan", sz] buff (String text)
            end else
              Odoc_info.warning "span size should be positive"
          with Failure _ ->
            Odoc_info.warning "span size should be an integer"
        else
          Odoc_info.warning "span size is missing"
    | "caption" -> self#render_tag "caption" [] buff (Text text)
    | "token" ->
        let id = self#trimmed_string_of_text text in
        add (Definitions.get Args.definitions id)
    | "image" ->
        let filename = self#trimmed_string_of_text text in
        let basename = Filename.basename filename in
        let contents = Base64.encode_file filename in
        add "<img class=\"flag\" src=\"data:image/png;base64,";
        add contents;
        add "\" alt=\"";
        add basename;
        add "\" title=\"";
        add basename;
        add "\"/>"
    | "fold" ->
        let id = string_of_int next_fold_id in
        next_fold_id <- succ next_fold_id;
        let text = Printf.sprintf "%S" (self#trimmed_string_of_text text) in
        add "<script type=\"text/javascript\">\n";
        add "<!--\n";
        add ("  var argot_fold_state_" ^ id ^ " = false;\n");
        add ("  var argot_fold_text_" ^ id ^ " = " ^ text ^ ";\n");
        add ("  function argot_fold_" ^ id ^ "() {\n");
        add ("    if (argot_fold_state_" ^ id ^ ") {\n");
        add ("      document.getElementById('argot_fold_" ^ id ^ "').innerHTML = \"\";\n");
        add ("    } else {\n");
        add ("      document.getElementById('argot_fold_" ^ id ^ "').innerHTML = argot_fold_text_" ^ id ^ ";\n");
        add ("    };\n");
        add ("    argot_fold_state_" ^ id ^ " = !argot_fold_state_" ^ id ^";\n");
        add ("  }\n");
        add "//-->\n";
        add "</script>\n";
        add ("<a href=\"javascript:argot_fold_" ^ id ^ "();\">...</a>\n");
        add ("<div id=\"argot_fold_" ^ id ^ "\">\n");
        add "</div>\n"
    | _ -> super#html_of_custom_text buff start text

  method private typevar_tag text =
    let str = self#string_of_text text in
    let index_of ch = try String.index str ch with Not_found -> max_int in
    let idx = min (index_of ' ') (index_of '\t') in
    if idx < max_int then
      let id = String.sub str 0 idx in
      let desc = String.sub str (succ idx) (String.length str - idx - 1) in
      Printf.sprintf "<code class=\"code\">%s</code>&nbsp;: %s<br>\n" id desc
    else begin
      Odoc_info.warning "invalid comment associated to @typevar tag";
      ""
    end

  method private register_text_tag ?(prefix="") ?(modifier=(fun s -> s)) name =
    let impl text =
      let text = self#string_of_text text in
      prefix ^ (modifier text) ^ "<br>\n" in
    tag_functions <- tag_functions @ [name, impl]

  method private register_tag_with_icon name synonyms =
    let impl text =
      Printf.sprintf "<img class=\"argot_%s\" src=\"data:image/png;base64,%s\" alt=\"%s\" title=\"%s\" align=\"middle\"/>&nbsp;%s<br>\n"
        name
        Icons.transparent_base64
        name
        name
        (self#string_of_text text) in
    tag_functions <- tag_functions @ (List.map (fun x -> x, impl) (name :: synonyms))

  method! print_navbar b pre post name =
    super#print_navbar b pre post name;
    if !Args.search && not !Args.search_frame then
      Buffer.add_string b Search.link

  method! html_of_Index_list b =
    super#html_of_Index_list b;
    if !Args.search && not !Args.search_frame then
      Buffer.add_string b Search.link

  method! generate module_list =
    super#generate module_list;
    if !Args.search then
      Search.generate_data
        !Odoc_info.Args.target_dir
        (self :> Odoc_html.html)

  initializer begin
    (* register custom tags *)
    tag_functions <- tag_functions @ ["typevar", self#typevar_tag];

    self#register_text_tag "obvious";

    self#register_text_tag ~prefix:"Alias for " "alias";
    self#register_text_tag ~prefix:"Synonym for " "synonym" ;
    self#register_text_tag ~prefix:"Abbreviation for " "abbreviation";
    self#register_text_tag ~prefix:"Equivalent to " "equivalent";

    self#register_text_tag ~prefix:"<b>Copyright:</b> " "copyright";
    self#register_text_tag ~prefix:"<b>License:</b> " ~modifier:Licenses.to_html "license";

    self#register_tag_with_icon "todo" ["unimplemented"];
    self#register_tag_with_icon "todoc" ["undocumented"; "docme"];
    self#register_tag_with_icon "tofix" ["fixme"];

    self#register_tag_with_icon "stateful" [];

    self#register_tag_with_icon "threadsafe" [];
    self#register_tag_with_icon "threadunsafe" [];

    List.iter
      (fun name -> self#register_tag_with_icon name [])
      ["attention"; "bug"; "error"; "info"; "new"; "note"; "remark"; "warning"];

    (* append css *)
    default_style_options <- default_style_options
      @ Tables.css
      @ Icons.css
      @ Search.css
      @ [""]
  end
end

let () =
  let generator = (new argot_generator :> Odoc_info.Args.doc_generator) in
  Args.register ();
  at_exit
    (fun () ->
      if !Args.search then begin
        Search.generate_html !Odoc_info.Args.target_dir;
        Search_js.generate_files !Odoc_info.Args.target_dir
      end);
  Odoc_info.Args.set_doc_generator (Some generator)
