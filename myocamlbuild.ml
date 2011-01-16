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

open Ocamlbuild_plugin

let odocl_file = Pathname.pwd / "argot.odocl"
let mlpack_file = Pathname.pwd / "argot.mlpack"
let src_path = Pathname.pwd / "src"

let () =
  let odocl_chan = open_out odocl_file in
  let mlpack_chan = open_out mlpack_file in
  Array.iter
    (fun filename ->
      if Pathname.check_extension filename "mli" then begin
        let modulename = Pathname.remove_extension filename in
        let modulename = Pathname.basename modulename in
        let modulename = String.capitalize modulename in
        output_string odocl_chan modulename;
        output_char odocl_chan '\n';
        output_string mlpack_chan modulename;
        output_char mlpack_chan '\n'
      end)
    (Pathname.readdir src_path);
  close_out_noerr odocl_chan;
  close_out_noerr mlpack_chan

let version_tag = "src_version_ml"
let version_ml = "src/version.ml"
let version_file = "../VERSION"

let () =
  let safe_cp src dst =
    let src = Pathname.mk src in
    let dst = Pathname.mk dst in
    let dir = Pathname.dirname dst in
    let cmd = Printf.sprintf "mkdir -p %s" (Pathname.to_string dir) in
    if Sys.command cmd <> 0 then failwith ("cannot run " ^ cmd);
    cp src dst in
  dispatch begin function
    | After_rules ->
        dep [version_tag] [version_ml];
        rule ("generation of " ^ version_ml)
          ~prod:version_ml
          ~insert:`bottom
          (fun _ _ ->
            let version =
              try
                List.hd (string_list_of_file (Pathname.mk version_file))
              with _ -> "unknown" in
            let name, channel = Filename.open_temp_file "version" ".ml" in
            Printf.fprintf channel "let value = %S\n" version;
            close_out_noerr channel;
            safe_cp name version_ml);
    | _ -> ()
  end
