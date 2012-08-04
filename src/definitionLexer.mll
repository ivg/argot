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

{

}

let whitespace = [ ' ' '\t' ]

let letter = [ 'a'-'z' 'A'-'Z' '_' ]

let digit = [ '0'-'9' ]

let ident = letter (letter | digit)*

rule token = parse
| "#"            { comment lexbuf }
| "="            { DefinitionParser.EQUAL }
| "$"            { DefinitionParser.DOLLAR }
| "("            { DefinitionParser.OPENING_PARENT }
| ")"            { DefinitionParser.CLOSING_PARENT }
| ident as id    { DefinitionParser.IDENT id }
| "\""           { string true (Buffer.create 64) lexbuf }
| "\'"           { string false (Buffer.create 64) lexbuf }
| whitespace+    { DefinitionParser.WHITESPACE }
| eof            { DefinitionParser.EOF }
| _ as ch        { DefinitionParser.CHARACTER ch }
and string double buf = parse
| "\\\""         { Buffer.add_char buf '\"'; string double buf lexbuf }
| "\\\'"         { Buffer.add_char buf '\''; string double buf lexbuf }
| "\""           { if double
                      then DefinitionParser.STRING (Buffer.contents buf)
                      else (Buffer.add_char buf '\"'; string double buf lexbuf) }
| "\'"           { if not double
                      then DefinitionParser.STRING (Buffer.contents buf)
                      else (Buffer.add_char buf '\''; string double buf lexbuf) }
| _ as ch        { Buffer.add_char buf ch; string double buf lexbuf }
and comment = parse
| eof            { DefinitionParser.EOF }
| _              { comment lexbuf }
