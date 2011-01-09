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

include Makefile.config

# PATHS

PATH_BASE=`pwd`
PATH_BUILD=$(PATH_BASE)/_build
PATH_OCAMLDOC=$(PATH_BASE)/ocamldoc
PATH_SRC=$(PATH_BASE)/src
PATH_TESTS=$(PATH_BASE)/tests
PATH_INSTALL=`$(PATH_OCAML_PREFIX)/bin/ocamldoc -customdir`


# DEFINITIONS

PROJECT_NAME=argot
OCAMLBUILD=$(PATH_OCAML_PREFIX)/bin/ocamlbuild
OCAMLBUILD_FLAGS=-classic-display -no-links
MODULES_ODOCL=$(PROJECT_NAME).odocl
MODULES_MLPACK=$(PROJECT_NAME).mlpack


# TARGETS

default:
	@echo "available targets:"
	@echo "  all         compiles all files"
	@echo "  doc         generates ocamldoc documentations"
	@echo "  tests       runs tests"
	@echo "  clean       deletes all produced files (excluding documentation)"
	@echo "  veryclean   deletes all produced files (including documentation)"
	@echo "  install     copies executable and library files"
	@echo "  generate    generates files needed for build"

all: generate
	$(OCAMLBUILD) $(OCAMLBUILD_FLAGS) $(PROJECT_NAME).otarget

doc: FORCE
	$(OCAMLBUILD) $(OCAMLBUILD_FLAGS) $(PROJECT_NAME).docdir/index.html
	cp $(PATH_BUILD)/$(PROJECT_NAME).docdir/*.html $(PATH_BUILD)/$(PROJECT_NAME).docdir/*.css $(PATH_OCAMLDOC)

tests: FORCE
	test -f $(PATH_TESTS)/Makefile && (cd $(PATH_TESTS) && $(MAKE) all && cd ..) || true

clean: FORCE
	$(OCAMLBUILD) $(OCAMLBUILD_FLAGS) -clean
	test -f $(PATH_TESTS)/Makefile && (cd $(PATH_TESTS) && $(MAKE) clean && cd ..) || true
	rm -f $(MODULES_ODOCL) $(MODULES_MLPACK) $(PROJECT_NAME).itarget

veryclean: clean
	rm -f $(PATH_OCAMLDOC)/*.html $(PATH_OCAMLDOC)/*.css

install: all
ifeq ($(OCAMLFIND),)
	mkdir -p $(PATH_INSTALL)
	cp $(PATH_BUILD)/$(PROJECT_NAME).cmo $(PATH_INSTALL)
	(test -x $(PATH_OCAML_PREFIX)/bin/ocamlopt && cp $(PATH_BUILD)/$(PROJECT_NAME).cmx $(PATH_INSTALL)) || true
	(test -x $(PATH_OCAML_PREFIX)/bin/ocamljava && cp $(PATH_BUILD)/$(PROJECT_NAME).cmj $(PATH_INSTALL)) || true
else
	$(OCAMLFIND) query $(PROJECT_NAME) && $(OCAMLFIND) remove $(PROJECT_NAME) || true
	$(OCAMLFIND) install $(PROJECT_NAME) META $(PATH_BUILD)/*.cm* $(PATH_BUILD)/*.a $(PATH_BUILD)/*.ja* $(PATH_BUILD)/*.byte $(PATH_BUILD)/*.native
endif

generate: FORCE
	find $(PATH_SRC) -name '*.mli' | xargs basename | $(SED) -e 's|\.mli$$||' | $(SED) -e 's|^.|\U&|' > $(MODULES_ODOCL)
	cp $(MODULES_ODOCL) $(MODULES_MLPACK)
	echo '$(PROJECT_NAME).cmo' > $(PROJECT_NAME).itarget
	(test -x $(PATH_OCAML_PREFIX)/bin/ocamlopt && echo '$(PROJECT_NAME).cmx' >> $(PROJECT_NAME).itarget) || true
	(test -x $(PATH_OCAML_PREFIX)/bin/ocamljava && echo '$(PROJECT_NAME).cmj' >> $(PROJECT_NAME).itarget) || true

FORCE:
