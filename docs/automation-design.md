<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Automation design

Notes on technical decisions of this automation.

## Goals and requirements

The impact of the story is increased when the story is available in more
languages and more formats. Therefore the automation should make it easy to add
new translations and formats. It should also be easy to generate and finetune
output files, regardless of technical skill or operating system. Free culture
should be supported when selecting programs and content like fonts.

### For translators

- Duplication of translations should be avoided to prevent additional work and
  ensure consistency.
- All formats should become available when translation is done.
   - Translating images by hand should be optional to reduce necessary skills.
- Technical requirements to contribute a translation should be minimal.

### For contributors of new output formats

- Integration with tools should be possible by getting the text in a commonly
  used file format.
- Fonts and other relevant language dependent style information should be
  available in a structured file format so new formats can use it to support all
  languages.

### For publishers

- Generating output formats should be possible with free software, regardless of
  operating system.
- Running the automation should be easy as possible.
   - It should use free software components.
   - System requirements should be minimal, including operating system and disk
  space.
- Offering multiple languages side-by-side, on a website for instance, should be
  supported.
- Adding necessary colophon information should be easy.

## Architectural decisions

Noteworthy decisions made in the automation.

### Text-based automation in Pascal

- A plaintext format is used with minimal formatting, to reduce complexity for
  translators.
- Perl is used because of how powerful it is in processing text.
- Scribus templates are filled by replacing the substitute text in the template.
- Files are organized by language.
   - Symbolic links are used share common files and so prevent duplication.
- PDF generation from Scribus is automated according to the best practices of the
  Scribus Python API.
- GNU Make is used to automate the processing.

### Docbook-based automation

- Docbook is selected for the source text because of its structured format and
  broad support of book related tools.
   - Docbook 5 is used because of its use of namespaces, so that extensions can be
     used in other namespaces.
   - Source text is modelled as much as possible in standard docbook for maximum
     compatibility with existing docbook tools.
      - A simplesect is used to group pages.
   - Profiling (conditions) is used to handle output variants like different
     covers.
   - A custom namespace is used for other information.
- Scribus templates are filled by specifying a docbook-id as attribute, that
  refers to a xml:id in the source text. Depending on the target object an text
  or image path is inserted. This is handled using XSLT processing.
   - To reduce the effort of image editing, the Scribus templates support images
     and fonts for the drop caps and headings text. Conditions in Scribus are
     used for this too.
   - Another attribute xslt-processing-configuration can be set as an attribute in
     Scribus to enable certain processing features. At the moment there is one
     feature available called strip-first-character that strips the first
     character of the text frame. This is used for the case where an image is used
     for the handdrawn capital letter.
- Illustration filenames use language suffixes to be able to store them in the
  same directory for an overview. A script is used to create symbolic links for
  the output languages.
- XSLT is used to process the docbook files because it is already used in docbook
  processing stylesheets and is suitable for processing XML.
   - The older XSLT 1.0 standard is used so that the commonly used Xsltproc
     program can be used.
- Translation is supported using the commonly used .po files for which many tools
  are available.
   - The ITS standard is used to configure the translations, combined with the
     Itstool program to merge translations.

More details are on the [DocBook page](docbook.md).

### Subtitles

- The simple and common SRT file format is used.
