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

(** Support for tables. *)

val css : string list
(** The piece of CSS used for tables. *)

type state
(** The state of (possibly embedded) tables. *)

val make_state : unit -> state
(** Creates an empty state containing no table. *)

val begin_table : state -> unit
(** To be called when a new table begins. *)

val end_table : state -> unit
(** To be called when the current table ends. *)

val begin_row : state -> unit
(** To be called when a new row begins. *)

val end_row : state -> unit
(** To be called when the current row ends.

    Will issue a warning if the current table is ill-formed. *)

val add_cell : state -> unit
(** To be called to notify the presence of a cell on the current row. *)

val add_cells : int -> state -> unit
(** To be called to notify the presence of several cells on the current row. *)
