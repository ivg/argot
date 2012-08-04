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

let table = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

let size n = (n + 2 - ((n + 2) mod 3)) / 3 * 4

let encode ?(sz = 256) st =
  let buff = Buffer.create sz in
  let add x = Buffer.add_char buff (String.get table x) in
  let next3 () =
    let res = Stream.npeek 3 st in
    Stream.junk st;
    Stream.junk st;
    Stream.junk st;
    List.map Char.code res in
  let rec iter () =
    match next3 () with
    | [] ->
        ()
    | x :: [] ->
        add (x lsr 2);
        add ((x land 0x03) lsl 4);
        Buffer.add_string buff "=="
    | x :: y :: [] ->
        add (x lsr 2);
        add (((x land 0x03) lsl 4) lor (y lsr 4));
        add ((y land 0x0F) lsl 2);
        Buffer.add_char buff '='
    | x :: y :: z :: [] ->
        add (x lsr 2);
        add (((x land 0x03) lsl 4) lor (y lsr 4));
        add (((y land 0x0F) lsl 2) lor (z lsr 6));
        add (z land 0x3F);
        iter ()
    | _ -> assert false in
  iter ();
  Buffer.contents buff

let encode_string s =
  let len = String.length s in
  encode ~sz:(size len) (Stream.of_string s)

let encode_channel ch =
  let len = in_channel_length ch in
  let pos = pos_in ch in
  encode ~sz:(size (len - pos)) (Stream.of_channel ch)

let encode_file fn =
  let ch = open_in_bin fn in
  try
    let res = encode_channel ch in
    close_in_noerr ch;
    res
  with e ->
    close_in_noerr ch;
    raise e
