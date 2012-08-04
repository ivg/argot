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

(* String functions *)

let is_whitespace = function
  | ' ' | '\t' | '\r' | '\n' -> true
  | _ -> false

let trim_gen left right s =
  let i = ref 0 in
  let len = String.length s in
  if left then
    while (!i < len) && (is_whitespace s.[!i]) do
      incr i
    done;
  let j = ref (pred len) in
  if right then
    while (!j >= !i) && (is_whitespace s.[!j]) do
      decr j
    done;
  if j >= i then
    String.sub s !i (!j - !i + 1)
  else
    ""

let trim_left = trim_gen true false

let trim_right = trim_gen false true

let trim = trim_gen true true


(* I/O functions *)

let read_lines filename =
  let chan = open_in filename in
  let lines = ref [] in
  try
    while true do
      lines := (input_line chan) :: !lines
    done;
    assert false
  with
  | End_of_file ->
      close_in_noerr chan;
      List.rev !lines
  | e ->
      close_in_noerr chan;
      raise e

let write_lines filename lines =
  let chan = open_out filename in
  try
    List.iter
      (fun line ->
        output_string chan line;
        output_char chan '\n')
      lines;
    close_out_noerr chan
  with e ->
    close_out_noerr chan;
    raise e
