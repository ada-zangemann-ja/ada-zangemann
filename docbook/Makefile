# SPDX-FileCopyrightText: 2024-2025 Nico Rikken <nico.rikken@fsfe.org>
# SPDX-FileCopyrightText: 2025 ירון שהרבני Yaron Shahrabani <sh.yaron@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

# GNU Make is used to automate the creation of various output formats. Each rule
# defines the output and prerequisites. This way files only get created if
# needed and files only get updated if a prerequisite was updated. More
# information is available in the GNU Make manual:
# https://www.gnu.org/software/make/manual/

# Summary of variables used:
# $@    The file name of the target.
# $<    The name of the first prerequisite.
# $^    The names of all prerequisites, with spaces between them
# $(@D) The directory part of $@.
# $(@F) The file-within-directory part of $@.

# Ensure default shell
SHELL = /bin/sh

# Delete resulting files if an error occurs, to avoid the situation of caching corrupt files
.DELETE_ON_ERROR:

# FIXME: use $(srcdir) best practice https://www.gnu.org/software/make/manual/html_node/Makefile-Basics.html

# List known translations to generate pattern rules for autocomplete by scanning translation files.
# Explicitly filter out 'en' language as it will be generated for English targets.
translations = $(filter-out en, $(notdir $(basename $(wildcard po/text/*.po))))

# List known languages to generate pattern rules for autocomplate. Use translations and add English because there is no en.po file (unsupported by Weblate).
languages = en $(translations)

# Targets to create split protest pages based on protest pages present
ada-p40s := $(addprefix build/,$(subst ada-p40-41,ada-p40,$(wildcard images/illustrations/ada-p40-41.*.png)))
ada-p41s := $(addprefix build/,$(subst ada-p40-41,ada-p41,$(wildcard images/illustrations/ada-p40-41.*.png)))

# Targets to create rotated spine images
ada-spine-btt := $(addprefix build/,$(subst .ttb.,.btt.,$(wildcard images/illustrations/ada-a01-spine*.ttb.png)))
ada-spine-ttb := $(addprefix build/,$(subst .btt.,.ttb.,$(wildcard images/illustrations/ada-a01-spine*.btt.png)))

# PHONY target for illustrations that includes postprocessing
# TODO: add targets for ttb and btt spine images
.PHONY: build/images/illustrations/all
build/images/illustrations/all: build/images/illustrations $(ada-p40s) $(ada-p41s) $(ada-spine-btt) $(ada-spine-ttb)

# Update split .po files when .pot strings get updated due to source changes, with po/Ada_Zangemann.pot as intermediary file
# POT-Creation-Date line is removed to prevent unnecessary changes detected by git
po/text/Ada_Zangemann.pot: Ada_Zangemann.dbk
	itstool -n -o po/Ada_Zangemann.pot Ada_Zangemann.dbk
	msggrep --invert-match --msgid -e '^images/' --extracted-comment -e 'info/biblioid' --no-wrap -o - po/Ada_Zangemann.pot | sed '/^"POT-Creation-Date:/d' > $@

po/editorial/Ada_Zangemann.pot: Ada_Zangemann.dbk
	itstool -n -o po/Ada_Zangemann.pot Ada_Zangemann.dbk
	msggrep --msgid -e '^images/' --extracted-comment -e 'info/biblioid' --no-wrap -o - po/Ada_Zangemann.pot | sed '/^"POT-Creation-Date:/d' > $@

# TODO: migrate existing translations with:
# msggrep --invert-match --msgid -e '^images/' --extracted-comment -e 'info/biblioid' --no-wrap -o po/text/nl.po po/nl.po
.PRECIOUS: po/text/%.po
# Update .po file if .pot file has changed. Otherwise don't, but touch it so Make doesn't rebuild it
po/text/%.po: po/text/Ada_Zangemann.pot
	if [ ! -e $@ ]; then cp $< $@; fi
	msgmerge --update --no-wrap $@ $<
	touch $@

# TODO: migrate existing translations with:
# msggrep --msgid -e '^images/' --extracted-comment -e 'info/biblioid' --no-wrap -o po/editorial/nl.po po/nl.po
.PRECIOUS: po/editorial/%.po
# Update .po file if .pot file has changed. Otherwise don't, but touch it so Make doesn't rebuild it
po/editorial/%.po: po/editorial/Ada_Zangemann.pot
	if [ ! -e $@ ]; then cp $< $@; fi
	msgmerge --update --no-wrap $@ $<
	touch $@

.PRECIOUS: build/%.po
build/%.po: po/text/%.po po/editorial/%.po
	msgcat -o $@ $+

# Generate message strings for further processing.
# Stored alongside .po files to deal with assumptions by tools.
# Use fuzzy entries that might need some more editing.
.PRECIOUS: build/%.mo
build/%.mo: build/%.po
	msgfmt --use-fuzzy -o $@ $<

.PHONY: status
status:
	for p in po/text/*.po; do printf "$$p "; msgfmt -o /dev/null --stat $$p; done

# Derived images
# NOTE: using images from source instead of build directory to prevent ordering conflict
build/images/illustrations/ada-p40.%.png: images/illustrations/ada-p40-41.%.png
	convert $< -crop "3430x3527+0+0" $@

build/images/illustrations/ada-p41.%.png: images/illustrations/ada-p40-41.%.png
	convert $< -gravity East -crop "3430x3527+0+0" $@

# Create spine variants (bottom-to-top and top-to-bottom)
build/images/illustrations/%.btt.png: images/illustrations/%.ttb.png
	convert $< -rotate 180 $@

build/images/illustrations/%.ttb.png: images/illustrations/%.btt.png
	convert $< -rotate 180 $@

# Link illustrations
# NOTE: marked as precious to prevent cleanup of symbolic link
.PRECIOUS: build/images/illustrations
build/images/illustrations:
	mkdir -p build/images/illustrations || exit 0
	cd build/images/illustrations; ln -f -s ../../../images/illustrations/*.png ./

# Link to capitals-opague
# TODO: add separate target for transparent capitals
# NOTE: marked as precious to prevent cleanup of symbolic link
.PRECIOUS: build/images/capitals
build/images/capitals:
	mkdir -p build/images || exit 0
	if [ ! -h $@ ]; then ln -s ../../images/capitals-opague build/images/capitals; fi

# Create docbook files
targets-dbk = $(addprefix build/Ada_Zangemann.,$(addsuffix .dbk,$(languages)))
$(targets-dbk): build/Ada_Zangemann.%.dbk: build/%.mo Ada_Zangemann.dbk
	itstool --strict --merge $< --out $@ Ada_Zangemann.dbk

.PHONY: build/Ada_Zangemann.all.dbk
build/Ada_Zangemann.all.dbk: $(targets-dbk)

# Create 'pure' docbook files without custom elements
build/Ada_Zangemann-pure.%.dbk: build/Ada_Zangemann.%.dbk xsl/clean-docbook.xsl
	xsltproc -o $@ xsl/clean-docbook.xsl $<

# Profile 'pure' docbook for text processing
# Relies on XSLT 1.0 stylesheets https://github.com/docbook/xslt10-stylesheets/ included in Debian docbook-xsl package
# FIXME: returns exit code 6 'Error in one of the documents' without a clear issue or error in output.
build/Ada_Zangemann-pure-profiled-text.%.dbk: build/Ada_Zangemann-pure.%.dbk
	xsltproc -o $@ --verbose \
	/usr/share/xml/docbook/stylesheet/docbook-xsl/profiling/profile.xsl \
	--stringparam profile.condition "headings-text;capitals-text;colophon-halfpage" \
	$< > $@.log 2>&1 || exit 0

# Profile Ada Zangemann docbook for text processing
# Relies on XSLT 1.0 stylesheets https://github.com/docbook/xslt10-stylesheets/ included in Debian docbook-xsl package
build/Ada_Zangemann-profiled-text.%.dbk: build/Ada_Zangemann.%.dbk
	xsltproc -o $@ --verbose \
	/usr/share/xml/docbook/stylesheet/docbook-xsl/profiling/profile.xsl \
	--stringparam profile.condition "headings-text;capitals-text;colophon-halfpage" \
	$< > $@.log 2>&1 || exit 0

# Remove non-text elements from pure profiled docbook
build/Ada_Zangemann-pure-profiled-text-only.%.dbk: build/Ada_Zangemann-pure-profiled-text.%.dbk
	xsltproc -o $@ --verbose \
	xsl/only-docbook-text.xsl \
	$< > $@.log 2>&1 || exit 0

# Generate text output for non-other processing scripts
targets-txt = $(addprefix build/Ada_Zangemann.,$(addsuffix .txt,$(languages)))
$(targets-txt): build/Ada_Zangemann.%.txt: build/Ada_Zangemann-profiled-text.%.dbk
	xsltproc -o $@ --verbose \
	xsl/az-text.xsl \
	$< > $@.log 2>&1 || exit 0

.PHONY: build/Ada_Zangemann.all.txt
build/Ada_Zangemann.all.txt: $(targets-txt)

# HTML output using standard docbook processing
# TODO: use lower resolution images
# FIXME: warning 'No localization exists for "ada_zangemann" or "ada". Using default "en".'
# Relies on XSLT 1.0 stylesheets https://github.com/docbook/xslt10-stylesheets/ included in Debian docbook-xsl package
targets-html = $(addprefix build/Ada_Zangemann.,$(addsuffix .html,$(languages)))
$(targets-html): build/Ada_Zangemann.%.html: \
 build/Ada_Zangemann-pure-profiled-text.%.dbk \
 | build/images/illustrations/all
	xsltproc -o $@ /usr/share/xml/docbook/stylesheet/nwalsh/html/docbook.xsl $<

.PHONY: build/Ada_Zangemann.all.html
build/Ada_Zangemann.all.html: $(targets-html)

# LaTeX based pdf processing
# FIXME: not yet working
build/Ada_Zangemann-dblatex.%.pdf: \
 build/Ada_Zangemann-pure-profiled-text.%.dbk \
 | build/images/illustrations/all
	dblatex -o $@ $<

# Epub processing
targets-dbtoepub = $(addprefix build/Ada_Zangemann-dbtoepub.,$(addsuffix .epub,$(languages)))
$(targets-dbtoepub): build/Ada_Zangemann-dbtoepub.%.epub: \
 build/Ada_Zangemann-pure-profiled-text.%.dbk \
 | build/images/illustrations/all
	dbtoepub -o $@ $<
	epubcheck $@

.PHONY: build/Ada_Zangemann-dbtoepub.all.epub
build/Ada_Zangemann-dbtoepub.all.epub: $(targets-dbtoepub)

# Pandoc HTML
targets-pandoc-html = $(addprefix build/Ada_Zangemann-pandoc.,$(addsuffix .html,$(languages)))
$(targets-pandoc-html): build/Ada_Zangemann-pandoc.%.html: \
 build/Ada_Zangemann-pure-profiled-text.%.dbk \
 | build/images/illustrations/all
	pandoc -f docbook -o $@ $<

.PHONY: build/Ada_Zangemann-pandoc.all.html
build/Ada_Zangemann-pandoc.all.html: $(targets-pandoc-html)

# Pandoc textonly HTML
targets-pandoc-text-only-html = $(addprefix build/Ada_Zangemann-pandoc-text-only.,$(addsuffix .html,$(languages)))
$(targets-pandoc-text-only-html): build/Ada_Zangemann-pandoc-text-only.%.html: \
 build/Ada_Zangemann-pure-profiled-text-only.%.dbk
	pandoc -f docbook -o $@ $<

.PHONY: build/Ada_Zangemann-pandoc-text-only.all.html
build/Ada_Zangemann-pandoc-text-only.all.html: $(targets-pandoc-text-only-html)

# Pandoc markdown
targets-pandoc-md = $(addprefix build/Ada_Zangemann-pandoc.,$(addsuffix .md,$(languages)))
$(targets-pandoc-md): build/Ada_Zangemann-pandoc.%.md: \
 build/Ada_Zangemann-pure-profiled-text.%.dbk \
 | build/images/illustrations/all
	pandoc -f docbook --shift-heading-level=1 --template templates/template.md -o $@ $<

.PHONY: build/Ada_Zangemann-pandoc.all.md
build/Ada_Zangemann-pandoc.all.md: $(targets-pandoc-md)

# Pandoc textonly markdown
targets-pandoc-text-only-md = $(addprefix build/Ada_Zangemann-pandoc-text-only.,$(addsuffix .md,$(languages)))
$(targets-pandoc-text-only-md): build/Ada_Zangemann-pandoc-text-only.%.md: \
 build/Ada_Zangemann-pure-profiled-text-only.%.dbk \
 | build/images/illustrations/all
	pandoc -f docbook --shift-heading-level=1 --template templates/template.md -o $@ $<

.PHONY: build/Ada_Zangemann-pandoc-text-only.all.md
build/Ada_Zangemann-pandoc-text-only.all.md: $(targets-pandoc-text-only-md)

# Pandoc odt
targets-pandoc-odt = $(addprefix build/Ada_Zangemann-pandoc.,$(addsuffix .odt,$(languages)))
$(targets-pandoc-odt): build/Ada_Zangemann-pandoc.%.odt: \
 build/Ada_Zangemann-pure-profiled-text.%.dbk \
 | build/images/illustrations/all
	pandoc -f docbook -o $@ $<

.PHONY: build/Ada_Zangemann-pandoc.all.odt
build/Ada_Zangemann-pandoc.all.odt: $(targets-pandoc-odt)

# Pandoc textonly odt
targets-pandoc-text-only-odt = $(addprefix build/Ada_Zangemann-pandoc-text-only.,$(addsuffix .odt,$(languages)))
$(targets-pandoc-text-only-odt): build/Ada_Zangemann-pandoc-text-only.%.odt: \
 build/Ada_Zangemann-pure-profiled-text-only.%.dbk
	pandoc -f docbook -o $@ $<

.PHONY: build/Ada_Zangemann-pandoc-text-only.all.odt
build/Ada_Zangemann-pandoc-text-only.all.odt: $(targets-pandoc-text-only-odt)

# Pandoc odt Hebrew template
# Create default reference ODT and patch styles to RTL + Hebrew
build/pandoc-reference.he.odt:
	pandoc --print-default-data-file reference.odt > build/reference.odt
	mkdir -p build/odt-ref && unzip -q -o build/reference.odt -d build/odt-ref

	# Force RTL writing-mode on page and paragraph-level styles
	sed -i 's/style:writing-mode="lr-tb"/style:writing-mode="rl-tb"/g' build/odt-ref/styles.xml
	sed -i 's/style:writing-mode="page"/style:writing-mode="rl-tb"/g' build/odt-ref/styles.xml
	sed -i -r '/<style:paragraph-properties/{ /style:writing-mode/! s/<style:paragraph-properties /<style:paragraph-properties style:writing-mode="rl-tb" / }' build/odt-ref/styles.xml

	# Set Hebrew locale
	sed -i 's/fo:language="en"/fo:language="he"/g' build/odt-ref/styles.xml
	sed -i 's/fo:country="US"/fo:country="IL"/g' build/odt-ref/styles.xml

	# Switch fonts to Noto Sans Hebrew (paragraph default + headings)
	sed -i 's/style:font-name="Times New Roman"/style:font-name="Noto Sans Hebrew"/g' build/odt-ref/styles.xml
	sed -i 's/style:font-name-asian="Lucida Sans Unicode"/style:font-name-asian="Noto Sans Hebrew"/g' build/odt-ref/styles.xml
	sed -i 's/style:font-name-complex="Tahoma"/style:font-name-complex="Noto Sans Hebrew"/g' build/odt-ref/styles.xml
	sed -i 's/style:font-name="Arial"/style:font-name="Noto Sans Hebrew"/g' build/odt-ref/styles.xml

	# Start from Pandoc reference and update only styles.xml to preserve ODT packaging
	cp build/reference.odt $@
	zip -q -j -u $@ build/odt-ref/styles.xml

# Pandoc textonly for Hebrew odt using custom style
build/Ada_Zangemann-pandoc-text-only.he.odt: \
 build/Ada_Zangemann-pure-profiled-text-only.he.dbk \
 build/pandoc-reference.he.odt
	pandoc -f docbook --reference-doc=build/pandoc-reference.he.odt -o $@ $<

# Braille Ready Format
# NOTE: lacks alt-text in output. See https://git.fsfe.org/FSFE/ada-zangemann/issues/106
targets-brf = $(addprefix build/Ada_Zangemann.,$(addsuffix .brf,$(languages)))
$(targets-brf): build/Ada_Zangemann.%.brf: \
 build/Ada_Zangemann.%.html
	file2brl -t $< $@

.PHONY: build/Ada_Zangemann.all.brf
build/Ada_Zangemann.all.brf: $(targets-brf)


# Generic function for Scribus template processing
# Params:
#   1. filename_extension (example: print-all)
#   2. scribus_template   (example: templates/template-print.sla)
#   3. profile_conditions (example: "colophon-halfpage;halftitle-original;halftitle-global;halftitle-global-text")
define scribus_template
build/Ada_Zangemann-$(1).%.sla: \
 build/Ada_Zangemann.%.dbk \
 xsl/scribus.xsl \
 | build/images/illustrations/all \
 build/images/capitals
	xsltproc -o $$@ --verbose \
	--stringparam docbook-contents-file ../$$< \
	--stringparam profile.condition "$(3)" \
	xsl/scribus.xsl \
	$(2) \
	> $$@.log 2>&1
endef


# Build version with all images (for debugging)
$(eval $(call scribus_template,print-all,templates/template-print.sla,colophon-halfpage;halftitle-original;halftitle-global;halftitle-global-text))


# Build version with image headers
targets-print-headings-img = $(addprefix build/Ada_Zangemann-print-headings-img.,$(addsuffix .sla,$(languages)))
$(targets-print-headings-img): $(eval $(call scribus_template,print-headings-img,templates/template-print.sla,headings-img;capitals-img;colophon-halfpage;halftitle-original))

.PHONY: build/Ada_Zangemann-print-headings-img.all.sla
build/Ada_Zangemann-print-headings-img.all.sla: $(targets-print-headings-img)

targets-print-headings-img-colophon-fullpage = $(addprefix build/Ada_Zangemann-print-headings-img-colophon-fullpage.,$(addsuffix .sla,$(languages)))
$(targets-print-headings-img-colophon-fullpage): $(eval $(call scribus_template,print-headings-img-colophon-fullpage,templates/template-print.sla,headings-img;capitals-img;colophon-fullpage;halftitle-original))

.PHONY: build/Ada_Zangemann-print-headings-img-colophon-fullpage.all.sla
build/Ada_Zangemann-print-headings-img-colophon-fullpage.all.sla: $(targets-print-headings-img-colophon-fullpage)

# Build version with text headers
targets-print-headings-text = $(addprefix build/Ada_Zangemann-print-headings-text.,$(addsuffix .sla,$(languages)))
$(targets-print-headings-text): $(eval $(call scribus_template,print-headings-text,templates/template-print.sla,headings-text;capitals-text;colophon-halfpage;halftitle-original))

.PHONY: build/Ada_Zangemann-print-headings-text.all.sla
build/Ada_Zangemann-print-headings-text.all.sla: $(targets-print-headings-text)

targets-print-headings-text-colophon-fullpage = $(addprefix build/Ada_Zangemann-print-headings-text-colophon-fullpage.,$(addsuffix .sla,$(languages)))
$(targets-print-headings-text-colophon-fullpage): $(eval $(call scribus_template,print-headings-text-colophon-fullpage,templates/template-print.sla,headings-text;capitals-text;colophon-fullpage;halftitle-original))

.PHONY: build/Ada_Zangemann-print-headings-text-colophon-fullpage.all.sla
build/Ada_Zangemann-print-headings-text-colophon-fullpage.all.sla: $(targets-print-headings-text-colophon-fullpage)

# Build version with text headers and halftitle for global distribution
targets-print-headings-text-halftitle-global = $(addprefix build/Ada_Zangemann-print-headings-text-halftitle-global.,$(addsuffix .sla,$(languages)))
$(targets-print-headings-text-halftitle-global): $(eval $(call scribus_template,print-headings-text-halftitle-global,templates/template-print.sla,headings-text;capitals-text;colophon-halfpage;halftitle-global;halftitle-global-text))

.PHONY: build/Ada_Zangemann-print-headings-text-halftitle-global.all.sla
build/Ada_Zangemann-print-headings-text-halftitle-global.all.sla: $(targets-print-headings-text-halftitle-global)

targets-print-headings-text-colophon-fullpage-halftitle-global = $(addprefix build/Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.,$(addsuffix .sla,$(languages)))
$(targets-print-headings-text-colophon-fullpage-halftitle-global): $(eval $(call scribus_template,print-headings-text-colophon-fullpage-halftitle-global,templates/template-print.sla,headings-text;capitals-text;colophon-fullpage;halftitle-global;halftitle-global-text))

.PHONY: build/Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.all.sla
build/Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.all.sla: $(targets-print-headings-text-colophon-fullpage-halftitle-global)

# Build version with text subtitle
targets-coverhard-text = $(addprefix build/Ada_Zangemann-coverhard-text.,$(addsuffix .sla,$(languages)))
$(targets-coverhard-text): $(eval $(call scribus_template,coverhard-text,templates/template-coverhard.sla,capitals-text;cover-print-text;colophon-halfpage))

# Build version with text subtitle
targets-coversoft-216x216x4_728x3_175-text = $(addprefix build/Ada_Zangemann-coversoft-216x216x4_728x3_175-text.,$(addsuffix .sla,$(languages)))
$(targets-coversoft-216x216x4_728x3_175-text): $(eval $(call scribus_template,coverhard-coversoft-216x216x4_728x3_175-text,templates/template-coversoft-216x216x4_728x3_175.sla,capitals-text;cover-print-text;colophon-halfpage))

# Build screen cover (page 1 is back, page 2 is front)
$(eval $(call scribus_template,coverscreen,templates/template-coverscreen.sla,capitals-text;cover-print-text;colophon-halfpage))

# Split front cover from screen cover
build/Ada_Zangemann-coverscreen.front.%.pdf: \
 build/Ada_Zangemann-coverscreen.%.screen.pdf
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=2 -dLastPage=2 -sOutputFile=$@ $<

# Split back cover from screen cover
build/Ada_Zangemann-coverscreen.back.%.pdf: \
 build/Ada_Zangemann-coverscreen.%.screen.pdf
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=1 -dLastPage=1 -sOutputFile=$@ $<

# Combine screen pdf contents with front and back cover
targets-screen = $(addprefix build/Ada_Zangemann-screen.,$(addsuffix .pdf,$(languages)))
$(targets-screen): build/Ada_Zangemann-screen.%.pdf: \
 build/Ada_Zangemann-coverscreen.front.%.pdf \
 build/Ada_Zangemann-print-headings-text.%.screen.pdf \
 build/Ada_Zangemann-coverscreen.back.%.pdf
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=$@ $^

# Confidential overlay for screen pdf
# FIXME: Ghostscript gives an error. Output seems fine though.
targets-screen-confidential = $(addprefix build/Ada_Zangemann-screen-confidential.,$(addsuffix .pdf,$(languages)))
$(targets-screen-confidential): build/Ada_Zangemann-screen-confidential.%.pdf: \
 templates/overlay-confidential.ps \
 build/Ada_Zangemann-screen.%.pdf
	gs -dSAFER -dBATCH -dNOPAUSE -dALLOWPSTRANSPARENCY -dPDFSTOPONERROR -sDEVICE=pdfwrite -sOutputFile=$@ $^ || true

.PHONY: build/Ada_Zangemann-screen.all.pdf
build/Ada_Zangemann-screen.all.pdf: $(targets-screen)

# Build version with no conditional content (for debugging)
$(eval $(call scribus_template,print-headings-none,templates/template-print.sla,;colophon-halfpage))

# Build/copy inside cover spread
build/Ada_Zangemann-insidecover.sla: templates/template-insidecover.sla
	cp $< $@

# Keep intermediary pdf files around as processing takes a while
.PRECIOUS: build/%.pdf

# Specific output convention for pdf without bleeds or crop marks
# TODO: screen might require a different colophon text via docbook profiling
%.screen.pdf: %.sla
	../scripts/./to_screen_pdf.sh $<

# TODO: add autocompletion for these pdf conversions
%.pdf: %.sla
	../scripts/./to_pdf.sh $<

# Create a pdf with low quality images for file size of about 1,5MB
%.lowres.pdf: %.pdf
	gs -sDEVICE=pdfwrite -dPDFSETTINGS=/screen -o $@ $<

# Create a pdf with medium quality images for file size of about 4MB
%.mediumres.pdf: %.pdf
	gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -o $@ $<

# Create a textfile from the pdf, intended for verification like spellcheck
%.pdf.txt: %.pdf
	pdftotext $< $@

# Text format for BrailleRAP processing
# Uses [FF] placeholder between Docbook and Sed because xsltproc cannot insert form-feed.
# Presence of form-feed can be checked using 'cat -v'.
targets-braillerap = $(addprefix build/Ada_Zangemann-braillerap.,$(addsuffix .txt,$(languages)))
build/Ada_Zangemann-braillerap.%.txt: build/Ada_Zangemann.%.dbk
	xsltproc xsl/braillerap.xsl $< | sed 's/\[FF\]/\x0C/g' > $@

.PHONY: build/Ada_Zangemann-braillerap.all.brf
build/Ada_Zangemann-braillerap.all.brf: $(targets-braillerap)

# Tab-delimited voiceover output
build/Ada_Zangemann-voiceover.%.csv: build/Ada_Zangemann.%.dbk
	xsltproc -o $@ xsl/movie-voice-timecodes.xsl $<

# SRT file from voiceover data
build/Ada_Zangemann-voiceover.%.srt: build/Ada_Zangemann.%.dbk
	xsltproc -o $@ xsl/movie-voice-srt.xsl $<

# Format docbook file using xmllint
.PHONY: xmllint-format
xmllint-format: Ada_Zangemann.dbk
	mv Ada_Zangemann.dbk Ada_Zangemann.dbk.xmllintbak
	xmllint --format Ada_Zangemann.dbk.xmllintbak > Ada_Zangemann.dbk

.PHONY: targets-all-scribus
targets-all-scribus: \
 build/Ada_Zangemann-print-headings-img.all.sla \
 build/Ada_Zangemann-print-headings-img-colophon-fullpage.all.sla \
 build/Ada_Zangemann-print-headings-text.all.sla \
 build/Ada_Zangemann-print-headings-text-colophon-fullpage.all.sla

.PHONY: targets-all
targets-all: \
 targets-all-scribus \
 build/Ada_Zangemann.all.html \
 build/Ada_Zangemann-pandoc.all.md \
 build/Ada_Zangemann-dbtoepub.all.epub

.PHONY: all
all: $(targets-all)

targets-all-po-text = $(addprefix po/text/,$(addsuffix .po,$(translations)))
targets-all-po-editorial = $(addprefix po/editorial/,$(addsuffix .po,$(translations)))
targets-all-po = $(targets-all-po-text) $(targets-all-po-editorial)

# Release into separate folder, intended for public sharing
# Ordered to prioritize quick text formats
.PHONY: release
release: $(targets-pandoc-text-only-md) $(targets-pandoc-text-only-odt) $(targets-brf) $(patsubst %.pdf,%.mediumres.pdf,$(targets-screen))
	mkdir -p build/release
	cp $^ build/release/

.PHONY: update
update: po/text/Ada_Zangemann.pot po/editorial/Ada_Zangemann.pot $(targets-all-po)

# Remove build output and uncommitted editorial files (which are kept around on purpose)
.PHONY: clean
clean:
	rm -r build/ || exit 0
	git restore build
	rm po/editorial/*.po
	git restore po/editorial/*.po

# Print obsolete translations no longer matching source strings
.PHONY: check-obsolete
check-obsolete:
	grep -e '^#~' po/text/*.po
	grep -e '^#~' po/editorial/*.po

# Validation commands (work in progress)
# TODO; not yet working
docbook-5.1-its.sch:
	wget -O docbook-5.1-its.sch http://docs.oasis-open.org/docbook/docbook/v5.1/os/schemas/sch/docbookxi.sch

docbook-5.1-its.rng:
	wget -O docbook-5.1-its.rng http://docs.oasis-open.org/docbook/docbook/v5.1/os/schemas/rng/dbits.rng

docbook-5.2.rng:
	wget -O docbook-5.2.rng https://docs.oasis-open.org/docbook/docbook/v5.2/os/rng/docbookxi.rng

.PHONY: validate
validate: docbook-5.1-its.rng docbook-5.1-its.sch Ada_Zangemann-en.dbk
	xmllint --noout --relaxng docbook-5.1-its.rng Ada_Zangemann-en.dbk
	xmllint --noout --schematron docbook-5.1-its.sch Ada_Zangemann-en.dbk

# Lint generated output. Phony target to trigger the analysis. Does not check with XML schema.
.PHONY: build/Ada_Zangemann.%.dbk.lint
build/Ada_Zangemann.%.dbk.lint: build/Ada_Zangemann.%.dbk
	xmllint --noout $<

lulu-nb-book: build/Ada_Zangemann-print-headings-text-colophon-fullpage.nb-scaled.pdf

# scale to 8.5"x8.5" with bleed 0.125" to match page size required by
# size used on lulu.com (8.5"+0.125")*72 = 621pt, while removing crop
# marks.
build/Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.nb-scaled.pdf: build/Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.nb.sla
	mkdir templates/tmp
	cp templates/template-*.sla templates/tmp/

	sed -i -e 's/cropMarks="1"/cropMarks="0"/g' \
	  -e 's/docInfoMarks="1"/docInfoMarks="0"/' \
	  templates/template-*.sla

	$(MAKE) build/Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.nb.pdf
	gs -o $@ -sDEVICE=pdfwrite \
	  -dDEVICEWIDTHPOINTS=621 -dDEVICEHEIGHTPOINTS=621 \
	  -dFIXEDMEDIA \
	  -dPDFFitPage \
	  -dCompatibilityLevel=1.4 \
	  build/Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.nb.pdf

	mv templates/tmp/template-*.sla  templates/
	rmdir templates/tmp

# Generate all translated docbook files and run xmllint on them. Early exit in case of failure.
.PHONY: quick-check
quick-check: $(addprefix build/Ada_Zangemann.,$(addsuffix .dbk.lint,$(languages)))
