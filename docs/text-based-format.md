<!--
SPDX-FileCopyrightText: 2021 Free Software Foundation Europe <https://fsfe.org>
SPDX-FileCopyrightText: 2024 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: CC-BY-SA-3.0-DE
-->

# Text-based format (deprecated)

_This documentation describes the text-based format. It has been superseded by
the docbook format. The format is still available as a fallback._

This repository is set up in a way that scripts can generate multiple output
files from the single translation. This allows you as a translator to focus on
the translation and let the automation create a transcript for book readings and
to output the formatted files for print and digital reading.

It might require some tweaking to get the best possible output from this
automation. Your translation is still valuable regardless of how well it works
with the rendering. Others from the community can help to run the scripts and
tweak it to get nice rendered formats.

To use the automation you can copy the directory structure from one of the other
languages and executed the scripts accordingly.

Some hints on how the scripting deals with the translation file:

* A line break in the source file does not always represent a line break in the
  Scribus book output.

* When a line ends with a trailing space it is considered a continuation of the
  same line. So if you to use a line break in your source file for readability
  but don't want it to show up in the render, then make sure the line has a
  trailing space.

* Explicit line breaks can be inserted by having a line end with two spaces. This
  is used to control line wrapping to prevent text over the images on page 19
  and 44.

* Some pages start with a drawn capital letter. This is signified in the source
  text in brackets, like `[A]da`. These capital letters are includes as images.
  Different pages use different colors, so it can be that the letter isn't
  available in the needed color. In that case the image will have to be created.

* The source text includes alternative text (alt text) that is added to the
  images to improve accessibility. This alt text can be recognised by the double
  bracket syntax. This should work out just fine as long as formatting is
  maintained.

* Illustrations are linked from the translation page using symbolic links. So if
  you want to translate certain images you should create translated images and
  update the links to point to the translated illustrations.

The scripts are subject to change in order to improve usability and deal with
situations encountered for new translations.

* Use punctuation style apostrophy (’) instead of straight typewriter style
  apostrophy characters ('). This is important for more correct typography in
  print. More background [on Wikipedia Apostrophe
  article](https://en.wikipedia.org/wiki/Apostrophe#Unicode).
