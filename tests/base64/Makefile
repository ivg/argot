#
# This file is part of Argot.
# Copyright (C) 2010-2012 Xavier Clerc.
#
# Argot is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# Argot is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

INCLUDES=-I ../../_build/src
LIBRARIES=base64.cmo

default: compile run compare clean

compile: FORCE
	@ocamlc -c $(INCLUDES) source.ml
	@ocamlc -o ./program $(INCLUDES) $(LIBRARIES) source.cmo

run: FORCE
	@for file in text*.txt; do \
	  ./program < $$file > `basename $$file txt`result; \
	done \

compare: FORCE
	@for file in text*.txt; do \
	  ((diff -q `basename $$file txt`reference `basename $$file txt`result > /dev/null 2> /dev/null) || echo "*** invalid $$file encoding"); \
	done \

clean: FORCE
	@rm -f *.cm* ./program *.result

FORCE:
