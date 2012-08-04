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

(** Auxiliary Javascript files. *)

val parser : string list
(** Contents of ["argot_parser.js"] file. *)

val search : string list
(** Contents of ["argot_search.js"] file. *)

val types : string list
(** Contents of ["argot_types.js"] file. *)

val generate_files : string -> unit
(** Generates JavaScript files in the passed directory. *)

