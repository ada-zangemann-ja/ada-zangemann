# SPDX-FileCopyrightText: 2026 Tomas Stary
#
# SPDX-License-Identifier: GPL-3.0-or-later

FONT_DIR ?= ~/.local/share/fonts
FONTS = $(wildcard *.zip)

# helpers for the space -> newline substitution, inspired by
# https://stackoverflow.com/questions/4734985/replace-spaces-with-new-line-in-makefile
null :=
space := ${null} ${null}
${space} := ${space}# ${ }

define \n


endef
# end of helpers

help:
	@echo Install fonts to the FONT_DIR=$(FONT_DIR)
	@echo usage: make install [FONT_DIR=$(FONT_DIR)]
	@echo
	@echo The following font archives will be extracted:
	@echo --------------------------------------------------
	@echo $(subst ${ },${\n}@echo ,${FONTS})
	@echo --------------------------------------------------

install: $(FONTS:%.zip=$(FONT_DIR)/%)
	fc-cache -f -v && echo All required fonts installed successfully. || (echo Font installation failed. && exit 1 )

$(FONT_DIR)/%: %.zip
	mkdir -p $@
	unzip -o $< -d $@
