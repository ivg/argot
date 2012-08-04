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

(** Miscellaneous utility functions. *)


(** {6 String functions} *)

val trim_left : string -> string
(** Returns a copy of the string without leading whitespace. *)

val trim_right : string -> string
(** Returns a copy of the string without trailing whitespace. *)

val trim : string -> string
(** Returns a copy of the string without leading and trailing whitespace. *)


(** {6 I/O functions} *)

val read_lines : string -> string list
(** [read_lines filename] returns the lines from the file named [filename].

    Raises an exception if an i/o error occurs. *)

val write_lines : string -> string list -> unit
(** [write_lines filename lines] writes the strings from [lines] to the file
    named [filename].

    Raises an exception if an i/o error occurs. *)
