<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Start translating

Since 2025 the story is [available for online translation on Weblate](https://hosted.weblate.org/projects/fsfe/ada-zangemann/).
The [Weblate documentation](https://docs.weblate.org/en/latest/index.html) explains how to use this software.
If you prefer to work with files, the gettext files are available in the [`docbook/po/text/` directory](https://git.fsfe.org/FSFE/ada-zangemann/src/branch/main/docbook/po/text).
These files can be contributed via git pull-requests.

The automation for the translation uses a customized Docbook XML as source format.
In most cases this won't make a difference, but in some cases the strings require valid XML for special characters (`&amp;` for `&`) or Docbook code is used for emphasis (`<emphasis role="bold">`).
More details are listed in the [docbook documentation section](docbook.md).

Translations are important to FSFE, which is why translators are supported with tooling, guidelines, a mailinglist and point of contact.
The [Translations section of the website](https://fsfe.org/contribute/translators/translators.html) provides more information on how it is organized and about other material to translate.
