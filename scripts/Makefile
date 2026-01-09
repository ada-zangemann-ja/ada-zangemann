# SPDX-FileCopyrightText: 2024,2026 Nico Rikken <nico.rikken@fsfe.org>
# SPDX-FileCopyrightText: 2024 Petter Reinholdtsen <pere@hungry.com>
#
# SPDX-License-Identifier: CC0-1.0

# This Makefile is written to work in all language directories and is supposed
# to be symlinked in all directories from a shared location.

.DEFAULT_GOAL := help

lang = $(notdir $(CURDIR))
scripts-dir = ../../scripts
src-text = Ada_Zangemann-$(lang).txt
sla-output = $(lang)-print.sla $(lang)-screen.sla $(lang)-coversoft.sla $(lang)-coverhard.sla
pdf-output = $(sla-output:.sla=.pdf)
reading-output = $(lang)-reading.txt

screen-png = $(addprefix $(lang)-screen-, $(addsuffix .png, $(shell seq -w 1 60)))
print-png = $(addprefix $(lang)-print-, $(addsuffix .png, $(shell seq -w 1 56)))
covers-png = $(lang)-coversoft-1.png $(lang)-coverhard-1.png

all-png = $(screen-png) $(print-png) $(covers-png)
all-output = $(reading-output) $(sla-output) $(pdf-output)

$(lang)-%.sla: template-%.sla $(src-text)
	./to_scribus.pl $(src-text) template-$*.sla > $(lang)-$*.sla

$(lang)-reading.txt: $(src-text)
	./to_reading.pl $(src-text) > $(reading-output)

%.pdf: %.sla
	$(scripts-dir)/./to_pdf.sh $<

# Specific png targets for pdf files to maintain source and target relation.

$(lang)-screen-%.png: $(lang)-screen.pdf
	$(scripts-dir)/./png_from_pdf.sh $@

$(lang)-print-%.png: $(lang)-print.pdf
	$(scripts-dir)/./png_from_pdf.sh $@

$(lang)-coversoft-%.png: $(lang)-coversoft.pdf
	$(scripts-dir)/./png_from_pdf.sh $@

$(lang)-coverhard-%.png: $(lang)-coverhard.pdf
	$(scripts-dir)/./png_from_pdf.sh $@

# Generate all .png files and copy them to a separate directory to compare against.
# Defined as a PHONY target to ensure conscious creation.
# A log file is generate with some useful details on the state of the repository.

.PHONY: compare-base
compare-base: $(all-png)
	$(scripts-dir)/makefile_helpers/./compare_base.sh $(all-png)

compare-result/%.png compare-result/%.metrics compare-result/%.status: %.png
	$(scripts-dir)/makefile_helpers/./compare.sh $@

# Commands

.PHONY: compare
compare: $(all-png) $(addprefix compare-result/, $(all-png))
	$(scripts-dir)/makefile_helpers/./compare_summary.sh

.PHONY: help
help:
	@echo "Use this Makefile to generate output files:" >&2
	@echo "Create a single output file:" >&2
	@echo "  make nl-screen.sla" >&2
	@echo "Create all defined output files:" >&2
	@echo "  make all" >&2
	@echo "Remove output files" >&2
	@echo "  make clean" >&2
	@echo "Print this help output" >&2
	@echo "  make help" >&2
	@echo "All defined output files to make here:" >&2
	@echo "  $(all-output)"
	@echo "Additionally png images can be generated from the pdf files:" >&2
	@echo "  single: make en-print-08.png" >&2
	@echo "  all:    make all-png" >&2
	@echo "Compare pdf output using image comparison:" >&2
	@echo "  make compare-base  # < before the change, to compare against" >&2
	@echo "  make compare       # < after the change, to review" >&2
	@echo "Check Scribus file to see if Capital files can be resolved:" >&2
	@echo "  make check" >&2

.PHONY: all
all: $(all-output)

.PHONY: all-png
all-png: $(all-png)

.PHONY: clean
clean:
	rm -f $(all-output)

# Command to debug this Makefile
.PHONY: debug
debug:
	@echo lang: $(lang)
	@echo all-output: $(all-output)

.PHONY: check
check: $(sla-output)
	for f in $$(grep Capitals/ $(sla-output) | tr \" "\n" | grep Capitals/); do if [ ! -e $$f ] ; then echo $(lang) missing $$f; fi; done | sort -u
