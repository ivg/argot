(*
 * This file is part of Argot.
 * Copyright (C) 2010 Xavier Clerc.
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

let definitions = ref []

class argot_generator = object (self)

  inherit Odoc_html.html as super

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
    Buffer.add_string buff "<";
    Buffer.add_string buff tag;
    List.iter
      (fun (name, value) ->
        Buffer.add_string buff " ";
        Buffer.add_string buff name;
        Buffer.add_string buff "=\"";
        Buffer.add_string buff value;
        Buffer.add_string buff "\"")
      attrs;
    Buffer.add_string buff ">";
    Buffer.add_string buff (self#trimmed_string_of_text text);
    Buffer.add_string buff "</";
    Buffer.add_string buff tag;
    Buffer.add_string buff ">"

  method! html_of_custom_text buff start text =
    match start with
    | "s" -> self#render_tag "strike" [] buff text
    | "u" -> self#render_tag "u" [] buff text
    | "h" -> self#render_tag "font" ["style", "background-color: orange"] buff text
    | "table" -> self#render_tag "table" ["class", "argot"] buff text
    | "header" -> self#render_tag "th" [] buff text
    | "row" -> self#render_tag "tr" [] buff text
    | "data" -> self#render_tag "td" [] buff text
    | "caption" -> self#render_tag "caption" [] buff text
    | "token" ->
        let id = self#trimmed_string_of_text text in
        let contents =
          try
            List.assoc id !definitions
          with Not_found ->
            try
              Sys.getenv id
            with Not_found ->
              Odoc_info.warning (Printf.sprintf "unknown token %S" id);
              "" in
        Buffer.add_string buff contents
  | "image" ->
      let filename = self#trimmed_string_of_text text in
      let basename = Filename.basename filename in
      let contents = Base64.encode_file filename in
      Buffer.add_string buff "<img class=\"flag\" src=\"data:image/png;base64,";
      Buffer.add_string buff contents;
      Buffer.add_string buff "\" alt=\"";
      Buffer.add_string buff basename;
      Buffer.add_string buff "\" title=\"";
      Buffer.add_string buff basename;
      Buffer.add_string buff "\"/>"
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

  method private register_placeholder_tag name =
    let impl text =
      (self#string_of_text text) ^ "<br>\n" in
    tag_functions <- tag_functions @ [name, impl]

  method private register_tag_with_prefix name prefix =
    let impl text =
      prefix ^ (self#string_of_text text) ^ "<br>\n" in
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

  initializer begin
    (* register custom tags *)
    tag_functions <- tag_functions @ ["typevar", self#typevar_tag];

    self#register_placeholder_tag "obvious";

    self#register_tag_with_prefix "alias" "Alias for ";
    self#register_tag_with_prefix "synonym" "Synonym for ";
    self#register_tag_with_prefix "equivalent" "Equivalent to ";

    self#register_tag_with_icon "todo" ["unimplemented"];
    self#register_tag_with_icon "todoc" ["docme"];
    self#register_tag_with_icon "tofix" ["fixme"];

    self#register_tag_with_icon "stateful" [];

    self#register_tag_with_icon "threadsafe" [];
    self#register_tag_with_icon "threadunsafe" [];

    List.iter
      (fun name -> self#register_tag_with_icon name [])
      ["attention"; "bug"; "error"; "info"; "new"; "note"; "remark"; "warning"];

    (* append css *)
    default_style_options <- default_style_options
      @ ["";
         "/* Argot tables */"]
      @ Table.css
      @ ["";
         "/* Argot icons -- from the \"Silk icon set 1.3\" by Mark James, available at http://www.famfamfam.com/lab/icons/silk/ */"]
      @ (List.map
           (fun (name, base64) ->
             Printf.sprintf ".argot_%s { border: 0px; width: 24px; height: 24px; background-image:url(data:image/png;base64,%s); background-repeat:no-repeat; }"
               name
               base64)
           Icons.all)
      @ [""]
  end
end

let () =
  let open Odoc_info in
  let argot_generator = ((new argot_generator) :> Args.doc_generator) in
  Args.add_option
    ("-define",
     (let var = ref "" in
     Arg.Tuple [Arg.Set_string var;
                Arg.String (fun s -> definitions := (!var, s) :: !definitions)]),
     "<name> <value>\n\t\tDefine a variable to be used by the token tag");
  Args.set_doc_generator (Some argot_generator)
