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

(** Icons for additional tags. *)

val attention_base64 : string
(** Data for the 'attention' icon, in base64 encoding. *)

val bug_base64 : string
(** Data for the 'bug' icon, in base64 encoding. *)

val error_base64 : string
(** Data for the 'error' icon, in base64 encoding. *)

val info_base64 : string
(** Data for the 'info' icon, in base64 encoding. *)

val new_base64 : string
(** Data for the 'new' icon, in base64 encoding. *)

val note_base64 : string
(** Data for the 'note' icon, in base64 encoding. *)

val remark_base64 : string
(** Data for the 'remark' icon, in base64 encoding. *)

val stateful_base64 : string
(** Data for the 'stateful' icon, in base64 encoding. *)

val threadsafe_base64 : string
(** Data for the 'threadsafe' icon, in base64 encoding. *)

val threadunsafe_base64 : string
(** Data for the 'threadunsafe' icon, in base64 encoding. *)

val todo_base64 : string
(** Data for the 'todo' icon, in base64 encoding. *)

val todoc_base64 : string
(** Data for the 'todoc' icon, in base64 encoding. *)

val tofix_base64 : string
(** Data for the 'tofix' icon, in base64 encoding. *)

val transparent_base64 : string
(** Data for the 'transparent' icon, in base64 encoding. *)

val warning_base64 : string
(** Data for the 'warning' icon, in base64 encoding. *)

val all : (string * string) list
(** Association list from icon names to their related image data
    (encoded in base64). *)
