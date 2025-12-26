<!--
SPDX-FileCopyrightText: 2024-2025 Nico Rikken <nico.rikken@fsfe.org>
SPDX-FileCopyrightText: 2024 Miroslav Suchý <msuchy@redhat.com>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Scripts

**Deprecation notice:** most of the scripts in this directory should no longer
be run individually. They are integrated in the build automation. The
[building documentation](../docs/building.md) describes how to use it.

This directory contains scripts to automatically generate book variants based on
templates and the translated text. It also contains a Makefile to easily run
these scripts. Automation allows translators to focus on the text and spend
less time formatting the translation for the various publication formats. The
scripts are linked from the various book translation directories so that these
scripts can easily be executed from the context of a translation.

## Fonts

Before running any script, you should install fonts from the `fonts/` directory.
You will need `heebo` and `delicious` fonts. Various localizations may need
other fonts from `fonts/` directory.

## Usage

The scripts print their use when called without arguments. Typically the source
text is taken as the first argument and a template as second argument if the
script requires a template. Output is typically provides to stdout and needs to
be directed to a file in order to write to disk.

Example of rendering a Scribus file

```shell
cd Book/en/
./to_scribus.pl Ada_Zangemann-en.txt template-print.sla > rendered-print.sla
```

## Scripts overview

Different scripts are available for different purposes:

### new_language.sh

Set up a directory structure and the necessary symbolic links for a new
language. You can provide the script with an existing language so it will be
used as the starting point.

### to_reading.pl

Create a script for book readings. The final text includes hints for changing
slides in the book reading presentation, based on slide change hints in the
source text.

### to_scribus.pl

Insert the translation in one of the [Scribus](https://www.scribus.net/)
templates or .odp presentation templates. These Scribus files are used for the
printed book (cover and contents) as well as pdf format.

### to_odp.pl

Insert the translation in the .odp presentation notes, to be used for
reading sessions. As template you can use an .odp file from other languages.

### to_pdf.sh

Automatically generate a pdf file from a Scribus .sla file. The output filename
is determined by replacing the file extension to .pdf. Scribus will show a user
interface while doing the conversion.

```shell
./to_pdf.sh ../Book/nl/nl-screen.sla
```

### png_from_pdf.sh

Script to generate .png files from a certain page of the corresponding .pdf
file. The aim of this script is to more easily check the rendering across
translation when changes have been made. it is intended for use from the
Makefile.

```shell
./png_from_pdf.sh en-print-08.png  # to render page 8 of en-print.pdf
```

### unwrapada.pl

Remove hard line breaks so that each paragraph is on a single line. This unwraps
hard line breaks preceded by a space.

```shell
./unwrapada.pl Ada_Zangemann-en.txt > Ada_Zangemann-en-unwrapped.txt
```

This script can be used together with another regex to have each sentence on a
separate line. This can help to compare different languages sentence by
sentence.

```shell
cat Ada_Zangemann-en.txt | scripts/./unwrapada.pl | sed 's/\.\s/\.\n/g' > Ada_Zangemann-en-sl.txt
```

### wrapada.pl

Add hard line breaks in lines to limited the length. Each line is wrapped on a
whole word to stay in a length of maximum 72 characters.

```shell
scripts/wrapada.pl Ada_Zangemann-en.txt > Ada_Zangemann-en-wrapped.txt
```

Line breaks with a preceding space signify a continuation of the paragraph.
These types of line breaks are not treated as a special case. So in order to
change the line breaks inside paragraphs, the unwrapdata.pl and wrapada.pl
scripts can be combined:

```shell
cat Ada_Zangemann-en.txt | scripts/./unwrapada.pl | scripts/./wrapada.pl > Ada_Zangemann-en-wrapped.txt
```

### Makefile

The typical tasks of generating output files is simplified using GNU Make. For
each output file a job has been defined. All available output jobs can be
called using the 'make all' command. Some examples:

```shell
make help
make clean
make nl-screen.sla
make all
```

#### Image comparison

First generate a base set of images to compare against, before the change:

```shell
make all-png
make compare-base
```

Then do the change, like adjusting the template or translation. Generate the
.png files and generate a comparison:

```shell
make compare
```

The resulting images and log file can be found in the `compare-result` directory.

### scribus_pdf.py

This is not a script to be run directly. It is a script that can be called from
Scribus to automatically generate a pdf file. This process is automated in the
to_pdf.sh script.

## Compatibility and development

There is currently no versioning of scripts and source texts. Changes in scripts
are combined with changes in source texts and templates. Translations should be
committed upstream to benefit from these ongoing improvements.
