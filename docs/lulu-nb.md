<!--
SPDX-FileCopyrightText: 2026 Petter Reinholdtsen

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# How lulu.com sale of Norwegian Bokmål Ada and Zangeman was set up

## Preparing the cover and body PDFs

Make sure the interiour PDF
(Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.nb-scaled.pdf)
is sized 8.5 x 8.5 in (216 x 216 mm) plus bleed of 0.125 in (3.175
mm).  Make sure the cover PDF
(Ada_Zangemann-coversoft-216x216x4_728x3_175-text.nb.pdf) is the size
of the front, back and the spine plus bleed.  For the Norwegian Bokmål
edition with 56 pages, this is 17.436 in x 8.75 in ( 442.87 mm x
222.25 mm).  The spine width is 0.186in (4.72 mm).

These are the build rules used for git tag
2025-11-20-nb-softcover-print and 2025-12-29-nb-softcover-print:

```
make -C docbook build/Ada_Zangemann-coversoft-216x216x4_728x3_175-text.nb.pdf
make -C docbook build/Ada_Zangemann-print-headings-text-colophon-fullpage-halftitle-global.nb-scaled.pdf
```

Note, the default body PDF from Scribus is too small, so it is scaled
up a bit to fit the size required by lulu.com.

# Creating the Lulu project

Here are the settings used when creating the project.  The design
options were picked to get a good looking book close in size to the
original German edition, but I expect other options might have worked
too.  It was decided to use soft covers instead of hard covers to keep
the cost and price down.  It make sense to also provide a hard cover
edition in parallel to the first soft cover edition.

The price (EUR 19.95) was picked to match other editions of the same
book.  This give FSFE a sizable cut.

## Start

Select "Print book", 
"Publish Your Book"
"Lulu Bookstore"
"Global Distribution"

Project title: Ada og Zangeman
Book language: Norwegian
Book category: Children's

## Copyright

Title: Ada og Zangemann
Subtitle: En fortelling om programvare, rullebrett og bringebæris
Contributors:
 Original author: Matthias Kirschner
 Illustrated by SandraBrandstätter
 Translated by Petter Reinholdtsen
 Translated by Henrik G. Sund (should be Sundt?)
 Translated by: Hagen Echzell
Copyright: Some Rights Reserved - Creative Commons CC-BY
 Copyright holder name: Matthias Kirschner
 [x] ShareAlike SA

ISBN: I have my own ISBN
 ISBN: 978-82-93828-24-2
 Imprint: Petter Reinholdtsen
 Contact information: [address]

## Design

Upload body PDF

Interior Color: Standard Color
Paper type: 80# White — Coated
Binding type: Paperback Perfect Bound
Cover finish: Matte
Book Cover Design: "Upload Your Cover"

Upload the cover PDF

Print Book: Square (8.5 x 8.5 in / 216 x 216 mm), Color, 80# White — Coated, Paperback Perfect Bound, Matte Cover

## Details

Project Details
 Description:
 
   Oppﬁnneren Zangemann er verdenskjent og uhorvelig rik. Både voksne
   og barn elsker hans fantastiske tekniske oppﬁnnelser. Men en dag er
   det et problem: barnas elektroniske rullebrett virker ikke lenger
   som de skal. Hva er det som skjer? Den nysgjerrige jenta Ada innser
   hva som foregår. Sammen med sine venner eksperimenterer hun med
   maskin- og programvare, og barna lager en plan: Zangemann kan ikke
   lenger være den eneste som kontrollerer dingsene!

   En bok som vekker interessen for ﬁkling og oppmuntrer til å forme
   teknologien.

 Contributor Notes

   Mer om Ada, Zangemann og boken finnes via
   https://fsfe.org/activities/ada-zangemann/ .

Categories and Keywords

Lulu Bookstore Category: Children's
Bisac Main Category: Juvenile Fiction / Computers & Digital Media
Bisac category 2: Young Adult Fiction / Computers & Digital Media
Keywords: programming, right to repair, source code, free software, tinkering

Audience

Young Adult - Teen fiction and nonfiction, age range 12-20, not for
educational purposes

## Pricing and Payees

Set price: Fixed List Price
Price: 19.95 EUR

Payees for Your Book:
  Free Software F. Europe e.V.
  Paypal: finance@fsfe.org
  Share: 100%
