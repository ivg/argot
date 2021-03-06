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

(** Support for search. *)

val generate_data : string -> Odoc_html.Generator.html -> unit
(** Generates the JavaScript data file in the passed directory. *)

val generate_html : string -> unit
(** Generates the HTML file for search page in the passed directory. *)

val link : string
(** HTML link to search page. *)

val css : string list
(** The piece of CSS used for search results. *)
