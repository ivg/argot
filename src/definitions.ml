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

type t = (string, string) Hashtbl.t

let make () =
    Hashtbl.create 17

let get defs name =
  let from name =
    try
      Hashtbl.find defs name
    with Not_found ->
      try
        Sys.getenv name
      with Not_found ->
        Odoc_info.warning (Printf.sprintf "unknown token %S" name);
        "" in
  let rec g seen name =
    let name = Utils.trim name in
    if List.mem name seen then begin
      Odoc_info.warning (Printf.sprintf "circular definition of %S" name);
      ""
    end else begin
      let buff = Buffer.create 64 in
      Buffer.add_substitute
        buff
        (fun n -> g (name :: seen) n)
        (from name);
      Buffer.contents buff
    end in
  g [] name

let add defs name value =
  Hashtbl.replace defs name value

let parse_definition s =
  try
    let lexbuf = Lexing.from_string s in
    DefinitionParser.definition DefinitionLexer.token lexbuf
  with _ -> None

let add_from_file defs filename =
  let lines = Utils.read_lines filename in
  List.iter
    (fun line ->
      match parse_definition line with
      | Some (x, y) -> add defs (Utils.trim x) (Utils.trim y)
      | None -> ())
    lines
