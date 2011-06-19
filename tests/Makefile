#
# This file is part of Argot.
# Copyright (C) 2010-2011 Xavier Clerc.
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

GENERATOR=../../_build/argot.cmo

default: FORCE
	@echo 'Available targets:'
	@echo '  all              runs all tests'
	@echo '  one NAME=dir     runs the test whose name is passed'
	@echo '  clean            deletes log and result files'
	@echo '  log              print log for last execution'
	@echo '  new NAME=dir     creates a new test directory'

all: clean
	@for file in *; do \
	  if [ -d $$file ]; then \
	    $(MAKE) one NAME=$$file; \
	  fi \
	done 2>&1 | tee _log
	@echo ''
	@echo "`grep '^\*\*\*' _log | wc -l` error(s) in `grep '^Running tests for' _log | wc -l` test(s)"

one: FORCE
	@if [ -z $(NAME) ]; then echo "*** value for 'NAME' is missing"; exit 1; fi
	@echo "Running tests for '$(NAME)'..."
	@if [ -f $(NAME)/Makefile ]; then \
	  cd $(NAME) \
	    && $(MAKE) \
	    && cd ..; \
	else \
	  cd $(NAME) \
	    && mkdir -p result.html \
	    && ocamldoc -g $(GENERATOR) `cat args` -d result.html *.mli > result 2>&1 \
	    && ((diff -r -q reference.html result.html > /dev/null 2> /dev/null) \
	       || echo "*** invalid $(NAME)/result.html") \
	    && ((diff -q reference result > /dev/null 2> /dev/null) \
	       || echo "*** invalid $(NAME)/result") \
	    && cd ..; \
	fi

clean: FORCE
	@rm -f _log
	@rm -fr */result */result.html

log: FORCE
	@cat _log
	@echo ''
	@echo "`grep '^\*\*\*' _log | wc -l` error(s) in `grep '^Running tests for' _log | wc -l` test(s)"

new: FORCE
	@if [ -z $(NAME) ]; then echo "*** value for 'NAME' is missing"; exit 1; fi
	@mkdir -p $(NAME)
	@cd $(NAME) \
	  && touch args reference \
	  && mkdir reference.html \
	  && cd ..
FORCE:
