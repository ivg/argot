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

let css = [
  "";
  "/* Argot tables */";
  "table.argot { border-collapse:collapse; }";
  "table.argot caption { font-size: smaller; }";
  "table.argot th { background-color: #90DDFF; border-color: black; border-spacing: 0px; border-width: 1px; border-style: solid; }";
  "table.argot tr { border-color: black; border-spacing: 0px; border-width: 1px; border-style: solid; }";
  "table.argot td { border-color: black; border-spacing: 0px; border-width: 1px; border-style: solid; }"
]

type state = {
    row_stack : (int option * int) Stack.t;
    mutable last_row_length : int option;
    mutable current_row_length : int;
  }

let make_state () =
  { row_stack = Stack.create ();
    last_row_length = None;
    current_row_length = 0; }

let begin_table st =
  Stack.push (st.last_row_length, st.current_row_length) st.row_stack;
  st.last_row_length <- None;
  st.current_row_length <- 0

let end_table st =
  let last, curr = Stack.pop st.row_stack in
  st.last_row_length <- last;
  st.current_row_length <- curr

let begin_row _ =
  ()

let end_row st =
  (match st.last_row_length with
  | Some x ->
      if x <> st.current_row_length then
        let msg =
          Printf.sprintf "table line has invalid length (%d instead of %d)"
            st.current_row_length
            x in
        Odoc_info.warning msg
  | None ->
      st.last_row_length <- Some st.current_row_length);
  st.current_row_length <- 0

let add_cell st =
  st.current_row_length <- succ st.current_row_length

let add_cells n st =
  st.current_row_length <- st.current_row_length + n
