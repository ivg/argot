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

(** Base64 encoding. *)

val encode : ?sz:int -> char Stream.t -> string
(** [encode ~sz st] returns the contents of the stream [st] encoded
    in base64. [sz] (defaulting to 256) is the initial size of the buffer
    used during encoding. *)

val encode_string : string -> string
(** [encode_string s] returns the contents of the string [s] encoded in base64. *)

val encode_channel : in_channel -> string
(** [encode_channel ch] returns the contents of the channel [ch] (from the
    current position to the end of the channel) encoded in base64.

    Raises an exception if an i/o error occurs. *)

val encode_file : string -> string
(** [encode_file f] returns the contents of the file [f] encoded in base64.

    Raises an exception if either the file does not exist,
    or an i/o error occurs. *)
