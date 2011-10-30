/*
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
 */

%{

%}

%token EQUAL DOLLAR OPENING_PARENT CLOSING_PARENT WHITESPACE EOF
%token <string> IDENT
%token <char> CHARACTER
%token <string> STRING

%start definition
%type <(string * string) option> definition

%%

definition: EOF               { None }
| whitespace IDENT whitespace EQUAL elements
                              { Some ($2, (String.concat "" (List.rev $5))) }

elements: /* epsilon */       { [] }
| elements element            { $2 :: $1 }

element:
| DOLLAR OPENING_PARENT IDENT CLOSING_PARENT
                              { "$(" ^ $3 ^ ")" }
| IDENT                       { $1 }
| CHARACTER                   { String.make 1 $1 }
| STRING                      { $1 }
| WHITESPACE                  { " " }

whitespace: /* epsilon */     { "" }
| WHITESPACE                  { " " }

%%
