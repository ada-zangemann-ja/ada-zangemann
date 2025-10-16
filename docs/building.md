<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Building

This is a practical guide on how to build the various output formats.
It targets the newer Docbook setup.
Documentation for the previous scripting can be found in the [README in the scripts folder](../scripts/README.md).

## Required software

The automation assumes a Linux-based operating system.
Debian is considered the default platform.

### Packages

Packages needed for most outputs:

- **make** to run the Makefile commands
- **gettext** to preprocess translations
- **itstool** to apply translations
- **xsltproc** for XSLT processing scripts
- **libxml2-utils** for other XML processing like linting
- **imagemagick** to split the protest page image
- **docbook-xsl** for standard Docbook processing
- **pandoc** to convert to Markdown and ODT
- **scribus** to open the rendered file and generate pdf
- **fonts-roboto** as standard font in the document
- **ghostscript** for lower resolution pdf files

A convenient install command:

```
sudo apt install make gettext itstool xsltproc libxml2-utils imagemagick docbook-xsl pandoc scribus fonts-roboto ghostscript
```

Other package might be necessary for more specific outputs.

## Additional fonts

You should install fonts from the `fonts/` directory.
Amatic is used for headings.
Delicious Handrawn is required for the subtitle.
Yuji Syuku is used for capitals.
Roboto is used as for paragraphs, but is available as a package on most distributions and thus is listed in the packages.

## Building

In an extracted folder, navigate to the `docbook` directory:

```
cd docbook
```

You can discover all the output formats by typing `make build/` followed by the `<tab>` key, to trigger tab completion.

Typical targets are:

```
make build/Ada_Zangemann.en.dbk
make build/Ada_Zangemann-pandoc-text-only.en.md
make build/Ada_Zangemann-pandoc-text-only.en.odt
make build/Ada_Zangemann-print-headings-text-colophon-fullpage.en.sla
make build/Ada_Zangemann-print-headings-text-colophon-fullpage.en.pdf
make build/Ada_Zangemann-print-headings-text-colophon-fullpage.en.mediumres.pdf
```
### Tips

Make caches the output.
In case you don't see the change you expect to see, you could try to build with a disabled cache.
Run make with the `-B` flag to do so:

```
make -B build/Ada_Zangemann.en.dbk
```
