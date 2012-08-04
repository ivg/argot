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

(** Support for definitions. *)

type t
(** The type of definitions, that is bindings from names to values. *)

val make : unit -> t
(** Create an empty set of definitions. *)

val get : t -> string -> string
(** [get defs name] returns the value associated to [name] in [defs]. *)

val add : t -> string -> string -> unit
(** [add defs name value] adds a binding from [name] to [value] to the set
    of definitions [defs]. *)

val add_from_file : t -> string -> unit
(** [add_from_file defs filename] adds the bindings read from the file
    named [filename] to the set of definitions [defs]. *)

