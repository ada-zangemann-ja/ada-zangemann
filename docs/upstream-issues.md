<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Upstream issues

During development we encountered various things that could be improved by the upstream software projects.
This page serves as an overview of these issues, with links to the reported issue.
It also hints at any changes that should be done after the upstream change.

## Scribus

- [Scribus bug tracker](https://bugs.scribus.net/my_view_page.php)

### RTL language support

Support for right-to-left languages is limited.
Various related improvements are needed to get it to work.

- [0014544: Layout should aware of RTL pages](https://bugs.scribus.net/view.php?id=14544)
- [0017715: RTL Changes are causing weird page pushes](https://bugs.scribus.net/view.php?id=17715)
- [0017537: Metabug: Inital support for RTL document for Scribus 1.8](https://bugs.scribus.net/view.php?id=17537)

Once available, the print template would have to be adjusted (perhaps using a script) for right-to-left.

### Dropcaps in text frame

Scribus supports using a different font style for the first capital of a text (dropcap).
However, it does this for every paragraph in a text frame.
In order to get the effect of a single drop cap per text frame, line breaks have to be used instead of paragraph breaks.

- [0000204: Drop Cap only for the first paragraph](https://bugs.scribus.net/view.php?id=204)
- [0015421: Drop-caps style is not removed after paragraph style change](https://bugs.scribus.net/view.php?id=15421)
- [0015124: Drop caps style fails randomly](https://bugs.scribus.net/view.php?id=15124) (related but slightly different issue)

### Equal page resize

Covers might have to be resized. It helps if the page is resized equally on all sides.
At the moment the user has to change the page size and then recenter the content.

- [0017098: Page Resize: Add New Real Estate Equally Around Page](https://bugs.scribus.net/view.php?id=17098)

### Script support for validation

Before exporting for print, Scribus runs a set of preflight checks to warn of potential issues.
These are issues of missing fonts, missing images and text too long to fit in the frame.
These issues are hard to detect otherwise.

- [0014597: Script command to get preflight errors or warnings](https://bugs.scribus.net/view.php?id=14597)

Once this is available it can be included in the build process to spot issues earlier and easier.

### More control over word breaks

Some texts should be treated as a phrase which ideally isn't split across lines.
The term 'CC-BY-SA' is such a word.
Similar case is for URLs like 'https://ada.fsfe.org' which ideally should be on a single line.

The control for word breaks in Scribus is too limited to change this behavior.

- [0004676: feature to mark words as "do not hyphenate"](https://bugs.scribus.net/view.php?id=4676)

### Support multiple fonts per style

No font covers all scripts.
Dejavu fonts get close, but is still missing characters for certain languages.
Noto Sans has more characters, but is split across multiple fonts, depending on the use-case.
Scribus could allow users to provide different fonts, like all the Noto Sans variants, in a style, to cover all scripts.

Without this feature, fonts will have to be changed or even combined, depending on the script and language.

- [0016114: Multi fonts within one paragraph style](https://bugs.scribus.net/view.php?id=16114)

## Pandoc

- [Pandoc issue tracker](https://github.com/jgm/pandoc/issues)

### Literallayout is set as monospace (Fixed in 3.7)

Pandoc used write Docbook text in literallayout elements as monospaced text.

- [Docbook literallayout is treated as monospace by default #10825](https://github.com/jgm/pandoc/issues/10825)

Fix is implemented in [3.7](https://github.com/jgm/pandoc/releases/tag/3.7).

### Last title element is taken as book title (Fixed, not yet released)

The last title element is taken as the book title, resulting in incorrect output.

- [Docbook chapter title overwrites book title #11300](https://github.com/jgm/pandoc/issues/11300)

There is currently a workaround in place in the Makefile, that can be removed if this is fixed and widely available.

### RTL output to ODT not working

The right-to-left ODT output is not working.
Not even if text direction is set explicitly.

- [ODT output RTL doesn't work #11301](https://github.com/jgm/pandoc/issues/11301)

## Weblate

- [Weblate issue tracker](https://github.com/WeblateOrg/weblate/issues)

### Extract Weblate flags from gettext comments

Weblate can load configurations from each translation entry, but cannot import it from the comment.
Itstool places information from the source Docbook file into the comments, so the comments section is the place where the configuration resides.
If this feature in place, the manual Weblate configuration can be abolished in favor of a configuration that is derived from the source file.

- [Support flags in gettext description for ITS toolchain #14722](https://github.com/WeblateOrg/weblate/issues/14722)
- [Support Weblate Flags in Gettext Files via Extracted Comments #11655](https://github.com/WeblateOrg/weblate/issues/11655)

## Itstool

- [Itstool issue tracker](https://github.com/itstool/itstool/issues)

### No active maintainer

Itstool has not active maintainer.
Different improvement proposals are still awaiting a review and merge.

- [ITS Tool project maintenance 🛠️ #53](https://github.com/itstool/itstool/issues/53)

## Libxslt

- [Libxslt issue tracker](https://gitlab.gnome.org/GNOME/libxslt/-/issues)

### XSLT 2.0 or 3.0 are not supported

Libxslt implements XSLT 1.0 with some extensions.
Newer versions XSLT 2.0 and 3.0 have additional processing features that can help make the code more compact.

- [Support for XLST 2.0 and XSLT 3.0](https://gitlab.gnome.org/GNOME/libxslt/-/issues/153)

## LibreTranslate

- [LibreTranslate issue tracker](https://github.com/LibreTranslate/LibreTranslate/issues)

### Support more languages

Support more languages in Argos Translate, the software underlying  LibreTranslate.
LibreTranslate is important to make sense of translations for keeping translations up to date with format changes.

- [Language reqests #91](https://github.com/argosopentech/argos-translate/discussions/91)
