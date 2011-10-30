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

let predefined = [
  ["gpl"; "gpl1"; "gplv1"],
  "http://www.gnu.org/licenses/old-licenses/gpl-1.0.html";
  ["gpl2"; "gplv2"],
  "http://www.gnu.org/licenses/old-licenses/gpl-2.0.html";
  ["gpl3"; "gplv3"],
  "http://www.gnu.org/licenses/gpl.html";
  ["lgpl"; "lgplv2"],
  "http://www.gnu.org/licenses/old-licenses/lgpl-2.0.html";
  ["lgpl21"; "lgpl2.1"; "lgpl2_1"; "lgplv21"; "lgplv2.1"; "lgplv2_1"],
  "http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html";
  ["lgpl3"; "lgplv3"],
  "http://www.gnu.org/licenses/lgpl.html";
  ["agpl"],
  "http://www.gnu.org/licenses/agpl.html";
  ["bsd"],
  "http://www.freebsd.org/copyright/license.html";
  ["mit"],
  "http://www.opensource.org/licenses/mit-license.php";
  ["apache"],
  "http://www.apache.org/licenses/";
  ["qpl"],
  "http://doc.trolltech.com/3.0/license.html";
  ["cecill"; "cecill-a"],
  "http://www.cecill.info/licences/Licence_CeCILL_V2-en.html";
  ["cecill-b"],
  "http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.html";
  ["cecill-c"],
  "http://www.cecill.info/licences/Licence_CeCILL-C_V1-en.html"
]

let table =
  let res = Hashtbl.create 17 in
  List.iter
    (fun (names, addr) ->
      List.iter
        (fun name ->
          Hashtbl.add res name addr)
        names)
    predefined;
  res

let to_html name =
  let enclose addr =
    Printf.sprintf "<a href=\"%s\" target=\"_blank\">%s</a>" addr name in
  try
    enclose (Hashtbl.find table (String.lowercase name))
  with Not_found -> name
