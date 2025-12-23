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
