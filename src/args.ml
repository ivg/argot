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

let definitions = Definitions.make ()

let search = ref false

let search_frame = ref false

let register () =
  Odoc_info.Args.add_option
    ("-define",
     (let var = ref "" in
     Arg.Tuple [Arg.Set_string var;
                Arg.String (fun s -> Definitions.add definitions !var s)]),
     "<name> <value>\n\t\tDefine a variable to be used by the token tag");
  Odoc_info.Args.add_option
    ("-definitions",
     Arg.String (fun s -> Definitions.add_from_file definitions s),
     "<file>\n\t\tLoad definitions from file");
  Odoc_info.Args.add_option
    ("-search",
     Arg.Set search,
     "\n\t\tGenerate search information");
  Odoc_info.Args.add_option
    ("-search-frame",
     Arg.Set search_frame,
     "\n\t\tSearch from a frame");
  Odoc_info.Args.add_option
    ("-argot-version",
     Arg.Unit (fun () -> Printf.printf "Argot %s\n" Version.value; exit 0),
     "\n\t\tPrint version and exit\n")

