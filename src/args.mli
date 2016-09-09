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

(** Support for command-line switches. *)

val definitions : Definitions.t
(** Definitions, that is bindings from names to values. *)

val search : bool ref
(** Whether search information should be generated. *)

val search_frame : bool ref
(** Whether search should appear in a frame. *)

val full_text : bool ref
(** Whether full-text search is enabled. *)

val hide_undocumented : bool ref
(** Whether we should ignore undocumented values.  *)

val register : unit -> unit
(** Registers the various command-line switches. *)
