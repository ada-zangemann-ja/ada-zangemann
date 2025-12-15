<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Publishing

The book has been published in many languages, by paid specialists in the field and by volunteers.
Publishing a book can seem daunting if you have never done it before.
Actually it involves a series of steps that can be tackled one by one.

Please contact FSFE if you are considering publishing the book.
We can help with different aspects, raise funds, and increase the reach.

## Team up

Publishing a book can be quite some work and will include reviewing work that can be delegated.
Taking on this work together should help you stay motivated to bring it to completion.

## Finalizing translation

First make sure that the translation process is done.
This includes the headings, capitals and the protest signs.

Not all image source files are included in this repository.
They are available on request.

Please also ensure that you have read the book aloud to children and others to see if the translation actually works.

## Budget

The budget should contain:

- amount of books
- printing cost
- book price when selling
- amount of pre-ordered books
- sponsor income
- cost of ISBN code(s)

It is recommended to explore different options by creating multiple budget variants.

Printing books is more cost-effective for larger amounts.
A softcover (paperback) book is cheaper than a hardcover.
Features like a color printed inside cover (yellow with outlines) or a bookmark ribbon come at an additional cost.

Print on demand services are another option.
Then the book is printed for each order, piece by piece.
This might be a good option when interest is low, it is hard for yourself to distribute the book, or there is no sponsor to cover upfront costs.

A sponsor can be the key to get the book published, so it is important to look for sponsors.

At this stage, one or two quotes for the books provide a good indication of the final printing cost.

In a collaboration with FSFE the international aspect should not be overlooked.
Books could be printed in Germany and distributed from there.
Printing in other countries could bring tax implications for FSFE.

If FSFE is involved, the FSFE Finance team needs to be involved for the tax side for the approval of the budget.

## ISBN code

The International Standard Book Number (ISBN) is a unique identifier for the book.
The entity and process of requesting an ISBN code differs per country.
ISBN codes can be purchased as a single code or by a set of ten.
Getting multiple ISBN codes can be relevant in order to use a second code to publish an ebook with an ISBN code.
In general you need different ISBN codes for different variants, versions, and formats.

You might be required to specify categories as part of requesting the ISBN.
Typical categories for this book are: youth fiction, 6+ year, programming.

## Printing company

Many printing companies print books.
The book has 56 pages (28 spreads) and is designed for a page size of 210×210mm.
Some printing companies have prices listed for this size.
For others you might need to ask a quote.

Printing companies differ in the size of their operation and the services they offer.
Some have a focus on publishing books and might offer additional services like keeping an inventory.

Besides price, the customer service is important to consider.
Typically you'd have to communicate back and forth a couple of times about specifications, a review of the files and feedback on a test print.

## Printing specifications

Each printing company has its own printing specifications that are derived from the paper and printers used.
This information is necessary to prepare the documents for print.
Often this information is listed on their website.
It can also be sent by mail, especially if it involved a custom size.

Information to gather:

- Dimensions for the 56 pages of content, including margins, bleed and cut marks
- Dimensions for the cover, also including margins, bleed and cut marks
- Dimensions for an inside cover in case of a printed inside cover
- Color profiles for the paper involved, which might be different for the pages and the cover
- Recommendations on submitting the files, like pdf version and embedding of fonts

It is likely that the Scribus template of the cover needs to be changed according to the provider's specifications.

## Colophon

The colophon in the beginning of the book contains details about the publication.
Information about authors, publisher and ISBN should be included here.
Other books can provide inspiration for information and formatting.

## Pdfs for print

Now that the specifications are known and the colophon is updated, the final pdf files can be generated.

First generate the Scribus files using the automation so that the text is up to date and the images are linked.

Make sure that the necessary fonts are installed on your system and are available in Scribus.
These fonts will be embedded into the pdf to make sure that the printer uses the correct font as well.

It is advised to install the icc color profiles from the printer for the different paper types.
These color profiles correct the colors to make them look how they would look like on paper.
This includes corrections for the inks used and how paper reflects the light.
You can use the built-in profile in Scribus in case the printer didn't provide a profile or if your computer doesn't support icc color profiles.
In that case it is advised to mention this to the printer so they are aware of this.

The cover template might need to be changed, because the dimensions will differ by the paper used.
You can update the template file according to the specifications and fill the contents using the automation.

The hard transition from green to yellow on the spine is unforgiving to print margins.
With printing margins typically being 3mm the edge could misalign or even appear skewed.
For thin soft covers the edge can be avoided by using the spine image that continues the white cord lines across the spine.
For the hard cover the yellow of the spine can be continued into the joint so the edges are on the cover sides.

An ISBN barcode can be created in Scribus, GIMP or an online tool, but Inkscape offers the most control over the final output.
Besides the ISBN you can also include a separate barcode section for the price, in case the book has a fixed price.
The vector image from Inkscape can be imported into the Scribus file.

It is important to keep to the recommended specification of the barcode.
Some distributors state they will reject a book if the barcode is not according to the specification.
The ISBN EAN-13 barcode specification is governed by GS1.
Professional scanners get certified according to this standard and therefore it is quite strict.
The size and surrounding whitespace are important to ensure correct scanning.
Some size variants are allowed according to the standard.
The OCR-B font is recommended in the standard, although other fonts are allowed as long as they are sufficiently legible.

Even though there is automation in place to export the pdfs, it is advised to do this manually for the print.
In this way you will see any warnings that Scribus might raise before exporting.
Also you can select the color profile and set the bleed for exporting.
Revert to the Scribus documentation for advice on the different options.

It is a best practice to place the rendered files for print, and only the files for print, into a separate folder labeled 'for print'.
This should prevent the common mistake of sending an older version to the printer.

## Final proofread

Right before sending the files to the printer is a good moment for a final check.
The goal of this proofread is to check for technical errors like misalignment, incorrect colors, and missing fonts.

## Printing

Double check that you are sending the correct files to the printer.

Most printers will do a verification on the files before printing, sometimes at a small fee.
This should check technical errors and is strongly advised, especially if you are less experienced with the printing process.

## Test print

Many printing companies offer the option of a test print of one or a few books.
Often a small fee is involved, which sometimes is offered as a discount on the final order.
If time allows, it is advised to make a test print.
This allows you to verify that the printer used the files correctly and delivers the quality you wanted.

## Archival

It is important to archive the files for the future.
They might be of value for a reprint, or as a reference for another language.
The generic files can be contributed to this repository.
Other files can be submitted to FSFE for safekeeping.
Some printers allow you to save the files of the order.
It is advised to use this option, as you might in future be able to easily do a reprint at the same provider.
