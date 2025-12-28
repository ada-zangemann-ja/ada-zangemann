<!--
SPDX-FileCopyrightText: 2024-2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# DocBook implementation notes

Notes about the docbook implementation, taken during the implementation process.

These notes have to be reviewed for relevance. Relevant content should become part of the documentation and other information can be removed.

## Considerations

Considerations for the current DocBook format.

### Arguments for choosing DocBook

- DocBook is designed for books, the main format of the Ada Zangemann story.
- Exensibility of XML allows additional information for other formats like the presentation.
- DocBook is very well documented, including recommendations on modeling information and expectations for processing.
- Popular document processors rely on DocBook for certain output formats (Asciidoctor) or support DocBook as a format for input and output (Pandoc).
- XML enables the use of other XML standards (e.g. [ITS](https://www.w3.org/TR/its/) for internationalisation) and custom elements and attributes to add information.
- Support for reading and writing XML is available in most programming languages, often even in the standard library. This makes it easy for others to write a program that can read from the source format
- XML supports linking and including inforation.
- XSLT is a standard format of defining conversions. XSLT templates exist for DocBook for various output formats (HTML, PDF, Epub). Some of these conversions can be reused as they are modular.
- XML can be validated using a schema to prevent errors.
- XML and DocBook are open standards, but so are many other formats.
- A downside of XSL is the verbosity, which can be overwhelming for newcomers. By enabling integration with .po translation files most people won't have to work with the source format and can focus on the content.
- Other formats considered were Markdown, Pandoc Markdown, Asciidoc, Asciidoctor, Restructured Text.
- Based on the latest [DocBook 5.2](https://tdg.docbook.org/tdg/5.2/) which is currently in development.

### Implementation details

- A Docbook namespace is used ([suppored since Docbook 5.0](https://tdg.docbook.org/tdg/5.2/ch01#introduction-ns)) to enable namespaced extensions specific to Ada and Zangemann.
- DocBook describes recommended use of elements and attributes and 'processing expecations' how processors are supposed to handle the elements.
- There can be multiple ways to convey/express/model the same contents. The final modelling is a design decision. The modeling might be revisited in the future based on experiences and changes in DocBook format and parsers.
- XML ITS is used to mark the content that can be translated. It also enables the use of translator notes. See the [documentation](https://www.w3.org/TR/its/) about available elements.
  - [ITS Tool](https://itstool.org/) supports exporting and importing PO files for translations.
    - ITS Tool automatically adds information about the path in the document. It also adds translator notes for filerefs, clarifying what they are for. Custom elements also get handled.
  - Translators and proofreaders are to be registered using [book/info/othercredit elements](https://tdg.docbook.org/tdg/5.2/othercredit) as this is built-in into Docbook. The ITS standard allows registering translators using [provenance information](https://www.w3.org/TR/its/#provenance) which is more complicated to support registering more exact author information. The DocBook othercredit seems sufficient.
- XSLT templates should ideally focus on XSLT version 1.0 with minimal extensions. Basically the featureset of the popular free software Xsltproc software as part of [Libxml2](https://gitlab.gnome.org/GNOME/libxml2/-/wikis/home). XSLT 2.0 and 3.0 introduce convenient functions and come with more current processing templates.
  - DocBook processing templates for XSLT 1.0 are [available online](https://github.com/docbook/xslt10-stylesheets) and are available in many Linux distributions.
  - XSLT 3.0 had multiple benefits, as is argued in [this blogpost from 2017](https://www.xml.com/articles/2017/02/14/why-you-should-be-using-xslt-30/). The [xsltNG](https://github.com/docbook/xslTNG) Docbook XSLT Stylesheets use XSLT 3.0. These stylesheets are a reason to adopt XSLT 3.0. [Saxon XSLT](https://en.wikipedia.org/wiki/Saxon_XSLT) is the only free software XSLT 3.0 processor, which is a reason to be reluctant in using XSLT 3.0. [Xrust](https://crates.io/crates/xrust) is a XSLT 3.0 engine being developed in Rust which might end up becoming the second free software solution.
- UTF-8 encoding is selected to support more special characters and hot have to escape as much characters. The ampersand '&' character still must be escaped as `&amp;` because the ampersand is used in XML as an escape character itself.
- `az:dropcap="true"` are used on `<para>` elements to indiate that the paragraph starts with a drop cap, a larger colorful capital.
- The `<alt>` element is used in a `<mediaobject>` to provide the description for an image. This text does not contain newlines, in accordance to the [HTML standard alt attribute](https://html.spec.whatwg.org/#alt).
- A custom `<az:excerpt>` element is used to model the text on an image, for translation purposes. Even if the image is not updated directly, it might be done at some point in the future.
- The data modeling version is represented using the `az:datamodelversion="0.1.0-alpha"` attribute in the main `book` element. Previously this was a custom element `<az:datamodel version="0.1.0-alpha"/>` but that did end up in the default XSLT template rendering. The XML namespaces also include version, but this does not consider how the elements are being used.
- Elements can be made easier to link or lookup by adding an `xml:id` attribute ([documentation](https://www.w3.org/TR/xml-id/)). Benefits of using these identifiers is that they are common, can be used for linking within the document and verified by tools like Xmllint to be unique in the document.
- Custom elements in DocBook end up in the output when processing with standard XSLT templates. For this reason standard DocBook elements are used to signify pages and slide transitions.
- The contents is separators for slides using `<anchor az:slidenum="n"/>` tags. Initially the idea was to use ustom `<az:slide/>` elements are used to describe slide transitions for the book reading presentations. As the custom elements end up in the output using default processing templates, so standard DocBook elements are used instead. There is a [DocBook Slides](https://tdg.docbook.org/tdg/slides/5.2/) format for presentations, but this cannot coexist with the DocBook format. The main focus would be to add [speakernotes](https://tdg.docbook.org/tdg/slides/5.2/sl.speakernotes) elements for the reading text. Any desired presentation-oriented format can be achieved by processing according the custom elements. Also `xml:id` identifiers might be used as a more standard attribute for identifiers.
- Chapters have the `<title>`, `<subtitle>` and `<titleabbrev>` attributes inside the `<info>` element. This is more verbose but is considered a best practice for more elaborate information elements and the hierarchy can help in processing. In the standard DocBook XSLT 1.0 templates this also renders better, as direct use of `<title>` in the chapter results in space.
- Preferably [common attributes](https://tdg.docbook.org/tdg/5.2/ref-elements#common.attributes) are used to add information to elements.
- xlink href is used for external links, as suggested in the [DocBook documentation](https://tdg.docbook.org/tdg/5.2/link).
- The `dir` attribute is set to signify the direction of text (and images). This can be `ltr` for left-to-right or `rtl` for right-to-left. This very much depends on the language. Other values `lro` and `rlo` exist as override values to override the direction for a short section. See also the [XHTML documentation](https://www.w3.org/TR/xhtml2/mod-bidi.html).
- Custom models are used for elements in the book which are not the main story. This concerns the preface and appendix.
  - Docbook doesn't have a model for a titlepage. Instead the common practice is to print a page containing the title and subtile. This can be observed from this example of [pdf generation](https://doccookbook.sourceforge.net/html/en/dbc.fo.design-titlepages.html).
  - Acknowledgments are not modelled using the acknowledgments element but rather as an appendix. This is intentional to prevent the acknowledgments from ending up in front of the book. The default XSLT 1.0 HTML processing changes the order of the book by moving the acknowledgments to the front. This is standard for most books, but is undesireable for the childrens book. So even though the modelling is more correct, the end result requires more customisation.
- All involved persons have been modelled as persons to reveive credit in the main info. This increases the complexity in the modelling, but is more precise in the metadata. As the information is already in the colophon, it might as well be removed.
- Custom elements are used inside the book info element to list the named characters in the story. This allows translators to document the chosen names in case they deviate.
- Font information is added to in book/info using custom elements (az:style/az:fontset/az:font). Especially languages using non-latin charachters might require different fonts. Adding this information into the DocBook document breaks the DocBook principle of separating formatting and content. Adding it in the same file brings conveniencefor processors by having the information available in one structure.
  - Existing DocBook FO stylesheets have a method of documenting fonts that can be used as inspiration https://sagehill.net/docbookxsl/AddFont.html#ConfigureFonts on the structure of configuring. Same CSS [font properties](https://developer.mozilla.org/en-US/docs/Web/CSS/font).
  - Per font a font family can be set (e.g. Roboto), a style (normal/italic) and a weight (normal, bold).
- Use itstool extension [itst:credits](https://itstool.org/documentation/extensions.html#credits) to enable translators to insert translator credits into the document. This information is represented as othercredit.
- Scribus file is filled using XSLT by matching a custom docbook-id attribute on Scribus elements to the xml:id element in the DocBook source file. Attributes can be configured in Scribus via the properties dialog on an elements. The outline window helps to select specific elements which are harder to click on. The attribute should have name docbook-id, should be of type string and have the value of the xml:id property. (Note, in the outline window the attributes can be accessed using right-click, but only if the element is not yet selected). As xml:id needs to be unique and the docbook-id attribute only an have one element, this approach can only select one element from the Docbook source file. This single element can also be the section, which can cover multiple paragraphs. Use-cases where the content cannot be expressed using a single id can be handled using additional XSLT processing to collect the information in a single element.
- Biblioid element is used to describe ISBN numbers of both print and ebook.
- Text in paragraph is normalized, convering spaces into single spaces, and removing leading and trailing space. Leading and trailing spaces are inserted if sibling nodes are present. This does force a level of strictness that prevents certain situations like a link on part of a word, or a emphasis on part of a word. Further conditions are in place to prevent spaces before final punctuation remarks. Empty text nodes are ignored.
- Scribus character styles are ignored. Font styles in Scribus can be set on a document level, on the text frame, or on characters using the StoryText editor. The character styles override other settings, but are more complicated to recreate overrides in XSLT. The current approach is to output a warning message if character styles are encountered. This message should guide the user into fixing the template if needed.
- Generic application of robustness principle: "be conservative in what you do, be liberal in what you accept from others". Approach with Docbook-id matches and setup of templates is such that different input structures will be acceptable.
- Dropcaps images are resolved by matching the paragraph node in DocBook source and matching `az:dropcapfileref` attribute.
- Dropcap height and width are to be explicitly defined using `az:dropcaplocalsc`, `az:dropcapheightpt` and `az:dropcapwidthpt`, which are leaky abstractions, directly refering to the Scribus output. Width differs per capital. Some dropcap images are higher (Eacute) and need a relative height adjustment, in addition to the width adjustment. The original Perl script dealt with such edge-cases. A Scribus Python API is available to adjust the image frame to the used image: [SetScaleFrameToImage](https://impagina.org/scribus-scripter-api/image-frame/#setscaleframetoimage). There are multiple ways to improve on the current setup.
- All current translations use numbers for page numbers, removing the need for internationalization of this field.
- Simple sections (simplesect) elements are used to group the content that needs to end up in a single text frame in Scribus. For most pages this results in a single section per page. The [simplesect](https://tdg.docbook.org/tdg/5.2/simplesect) element is chosen because it normally doesn't end up as part of the document structure. As described on [Docbook XSL documentation](https://sagehill.net/docbookxsl/TitleFontSizes.html#SimpleSects): "By default, simplesects do not appear in the table of contents because they are usually not considered part of the document's structural hierarchy." Note that simplesect elements can still contain a title and info element, which is not fitting for a page indicator.
- Identifiers for front and back matters are drawn from the [Wikipedia page on book design](https://en.wikipedia.org/wiki/Book_design).
- Images for drawn headings are embedded in the info element of the appendix. This is allowed in DocBook modelling and prevents them from being printed by default.
- Use [parameters for 'profiling'](https://tdg.docbook.org/tdg/5.2/ref-elements#common.effectivity.attributes) to make certain formatting conditional, depending on output format or a generic condition. More details in XSLT documentation: https://sagehill.net/docbookxsl/MultiProfile.html and https://sagehill.net/docbookxsl/AlternateText.html Conditions can be used both in Scribus template (as attributes) and DocBook data.
  - In Scribus template conditions can be used to switch between titles that are written in fonts or image-based, whether to use image capitals and to show a remix edition image.
    - Condition ideas: dropcap-img, headings-img, headings-text, remix, draft. Current
  - In Docbook template conditions can be used whether to use capitals or to use different title colophon information depending on the condition.
  - XSLT 1.0 profiling stylesheets as distributed in Linux distro's can be found here as well: https://github.com/docbook/xslt10-stylesheets/blob/master/xsl/profiling/profile-mode.xsl
  - Current implementation supports a single condition in Scribus, tested against multiple conditions provided as parameter to the XSLT template. Multiple conditions need to be separated using semicolumns, like 'dropcap-img;headings-img'. If no condition parameter is provided, no condition is checked, which helps in debugging. To trigger condition checking without a value a single semicolumn ';' can be provided.
- Use its:externalResourceRefRule to enable translators to change the link to the dropcap image. The current setup doesn't enable translators to set other dropcap properties, to a different solution might be necessary.
- Scribus drop cap can be set on the paragraph. If applied manually the style of the first letter is change (as observed in the XML document), but this is not necessary. It is important that the font size of the capital matches the font size of the main text, because otherwise rendering issues can occur. See notes in [Scribus issue 15124](https://bugs.scribus.net/view.php?id=15124).
- Heebo font is the current default. Heebo font is a variant of the Roboto Font that includes characters for Hebrew. [Heebo lacks an italic font variant](https://github.com/OdedEzer/heebo/issues/3) and thus italic emphasis cannot be rendered correctly. Choosing Roboto or another font with more support for variants makes more sense.
- A out-of-source build strategy is used instead of an in-source build. Sources and built output are kept separate. This helps ensure reproducibility and it encourages to keep the source files compact and organized.
- Itstool uses a externalref by default for fileref of images. But a custom translateRule can be used to allow translating a property too:

```xml
<!-- Make link to capital image configurable -->
<!-- Option A: does not allow changing, which is default for imagedata fileref -->
<its:externalResourceRefRule xmlns:db="http://docbook.org/ns/docbook" xmlns:az="https://git.fsfe.org/FSFE/ada-zangemann/" selector="//db:para" externalResourceRefPointer="@az:dropcapfileref"/>
<!-- Option B: does allow changing -->
<its:translateRule xmlns:db="http://docbook.org/ns/docbook" xmlns:az="https://git.fsfe.org/FSFE/ada-zangemann/" translate="yes" selector="//db:para/@az:dropcapfileref"/>
<its:locNoteRule xmlns:db="http://docbook.org/ns/docbook" xmlns:az="https://git.fsfe.org/FSFE/ada-zangemann/" translate="yes" selector="//db:para/@az:dropcapfileref" locNoteType="description">
  <its:locNote>File for the capital image</its:locNote>
</its:locNoteRule>
```
- The `az:dropcapscribuscharstyle="Capital Yellow 2"` property is used to define a dropcap style that is expected in Scribus to create a dropcap.
- Itstool [built-in docbook5 rules](https://github.com/itstool/itstool/blob/master/its/docbook5.its) sets fileref as an external resource, making it impossible to translate. Itstool has the `-n` flag to not use built-in rules, and the `-i` flag to import a cusom set of rules. Moving the rules to a custom its file to import with `-i` should be possible, but did not work correctly as the presedence of the withinText rule for imagedata is not handled. The default rules set it to yes, while it should be no. Inside of the docbook file the generic rule of yes can be override using a specific no rule, but this does not work with the external file. If all rules are moved to an external file it should work just fine.
- Update existing translations simply by calling `make po/*.po`.

#### Ideas for consideration

- To add to each paragraph (`<para>` or `<literallayout>`) an `az:pagenum` attribute for easier parsing. This enables parsers to select all paragraphs with this attribute that should end up on a given page. Alternatively is to use `<az:page num="n"/>` elements to separate pages or use DocBook sections to split a chapter into separate pages. Note that sections would have to be defined within a chapter, making it more difficult to get the title, requiring navigation up the element tree.
- To create a script for validating the code using Xmllint and for making improvements lik replacing three dots with an ellipsis character.
- A DocBook [remark](https://tdg.docbook.org/tdg/5.2/remark) could be to mark 'remix' and 'draft' editions.
- It should be possible to specify whether the language is RTL or LTR. It might be concluded based on the language too.
- The additional elements appear in the final rendered output. Have observed it with `<az:datamodel/>`, `<az:page/>` and `<az:slide/>` using the default XSLT 1.0 HTML templates. Currently addressed using a custom XSLT template to remove these attributes.
- How best to model title and subtitle on the cover. A title isn't allowed. It could be ommitted as it is already present on the book info. A bridgehead seems fitting, but a para might do.
- Provide XSLT transformation to remove custom attributes and ensure it to be standard DocBook.
- Provide XSLT transformation to convert to DocBook slides for presentation.
- For formatting take inspiration from [XSL-FO](https://en.wikipedia.org/wiki/XSL_Formatting_Objects) designed for formatting pdf files.
- Use the [markup](https://tdg.docbook.org/tdg/5.2/markup) element to mark a piece of text for markup.
- A [phrase](https://tdg.docbook.org/tdg/5.2/phrase) can be used to mark a piece of text.
- Some alt text descriptions are quite lengthy and could benefit from a split. Docbook doesn't seem to offer such a feature.
- It could be interesting if initial stylesheets could be included so that the document can be converted to some basic outputs.
- Addresses from the publishers and from Creative Commons could be represented using an [address](https://tdg.docbook.org/tdg/5.2/address) element. This resulted in unwanted newlines in the XSLT 1.0 HTML output, which was the reason to not use it for now.
- Deal with conditional credits or colophon, as the English version has 2 versions: for print and for online publication. It might be that there are two version of the source document: one representing the published book and one being the upstream document version for remix versions.
- It might be necessary or convenient to add font properties for emphasis markup, because the terms used for bold and italic might depend on the font.
- Use `xml:id` attributes on the chapters for identification or reference. Could be an identifier like `ch01` or a more descriptive text.
- Consider simplifying the personname element by not modelling the firstname and lastname, but just inserting the verbatim name. This will simplify the experience of the translators.
- Deal with different credits information per language. Perhaps it shouldn't be available to translators, should be exposed as an XML structure, or should be left out entirely.
- Add testcases for the XSLT templates. If no suitable tooling exists, a directory with input and output files could suffice. It could also be done using Pytest with fixtures to create the files. Proper XML diff output would be valuable.
- Not use ANNAME attribute in Scribus, but rather use a custom attrbute, because ANNAME is supposed to be unique, but there might be cases where multiple Scribus elements refer to the same XML:ID.
- Consider modelling the dropcaps as inline images, perhaps conditionally. Making this conditional and dealing with alt-text is a challenge.

```xml
<para>
  <inlinemediaobject>
    <imageobject>
      <imagedata fileref="../illustrations/Capitals/O-cyan.png"/>
    </imageobject>
    <alt>O</alt>
  </inlinemediaobject>
  nce upon a time, there was a little girl named Ada. Her family was so poor that all their savings fit inside a cookie jar. They didn’t have enough money to live in a proper home. Instead, Ada lived with her mother and her little brother, Alan, in a cabin near a junkyard on the edge of town.
</para>
```

- Consider using the [ITSTool extension for credeits](https://itstool.org/documentation/extensions.html#credits) that is explicit on where credits of translators should end up.
- Use ITS rules to add basic locNotes to all attributes, especially the `<alt>` tags. A link to the general translation notes would also be helpful.
- The ITS rules require tweaking to be as precise to select the content for translation and discard the document structure that shouldn't be modified by translators.
- The dropcaps attributes on the para elements are not available for translation by default. That might need work to make it part of the internationalisation.
- Profiling conditions should be used to select different images. Different because they contain text or are blank, and different for different resolutions. Multiple conditions can be combined to handle different variants, using [multiple profiling conditions](https://legal.standingrock.org/docbookxsl/MultiProfile.html). It might be easiest to do two-step processing to first execute the profiling and then process the profiled docbook file. A single-pass will require more work to handle all edge cases, but could be programmed to handle the sypical use-case. Code example:

```xml
<mediaobject xml:id="img-ada-04">
  <imageobject condition="print;headings-img">
    <imagedata fileref="illustrations/print/img-ada-cover.png"/>
  </imageobject>
  <imageobject condition="web;headings-img">
    <imagedata fileref="illustrations/web/img-ada-cover.png"/>
  </imageobject>
  <!-- Text is overlayed over these blank images -->
  <imageobject condition="print;headings-text">
    <imagedata fileref="illustrations/print/img-ada-cover-blank.png"/>
  </imageobject>
  <imageobject condition="web;headings-text">
    <imagedata fileref="illustrations/web/img-ada-cover-blank.png"/>
  </imageobject>
</mediaobject>
```

- Scribus template has two separate text boxes on page 8 (8a and 8b) instead of having a text frame that wraps around the image. A single text frame is preferred to simplify handling. Same for page 54, containing both information on the website and the license.
- Validation using an XML schema or Schematron schema can be executed using xmllint which has the `--relaxng` and `--schematron` flags. In order to validate a single schema has to be created that covers all namespaces in the document. DocBook schema's are provided for the [combination of DocBook and ITS schemas](https://docs.oasis-open.org/docbook/docbook/v5.1/os/docbook-v5.1-os.html#s.docbook). Unfortunately the provided v5.1 schema's lack the `its:rules` element that is used to define many translation rules. So in order to validate a custom schema definition will have to be created that combines the used namespaces into a single namespaces. There seem to be convenient ways to combine multiple schemas into one.
- Multi-line title for 'about the author' titles will probably have to be split into 2 different text frames: one with the title 'about the author', a second with the subtitle 'Matthias Kirschner'.
- For emphasis: rather than setting the font from a known list of styles, it might be an option to change the font name with an 'italic' or 'bold' suffix. This approach would allow emphasis for all fonts defined in the Scribus template.
- What is a good way to find font variants for bold and italic for emphasis? Scribus doesn't support font variants directly. This is a longstanding issue, as can bee seen from this wiki page: https://wiki.scribus.net/canvas/Bold_/_italic_font_issues There are common font names to express variants. Fontlab documentation calls this Typographic style name (TSN): https://help.fontlab.com/transtype-4/Organining-font-families/#typographic-style-name-tsn Examples are: (ExtraLight, ExtraLight Italic, Light, Light Italic, Regular, Italic, SemiBold, SemiBold Italic, Bold, Bold Italic, Black, Black Italic, Condensed, Condensed Italic). Fonts can be made to look bold or even italic, so-called false bpold. Sribus support for false bold is not present: https://wiki.scribus.net/canvas/False_bold
- The docbook-id reference in Scribus might be defined in a more expressive way. For example by using a certain character as a separator for elements to navigate the tree, even within a matched item, like: `matching-id|para|1` to select the first paragraph element. Or a separator could be used to express that the value of an attribute should be used for the conten, like: `sec-p01@pagenum` to get a pagenum attribute of the matched section. This would enable more flexiblity in the DocBook XML modeling, at the cost of more complicated and error-prone handling when processing.
- Epub generation doesn't seem to include the images. Unsure what is going wrong. https://github.com/docbook/xslt10-stylesheets/blob/master/xsl/epub/bin/lib/docbook.rb#L167
- Output warnings, for example if the template Scribus file version is newer than tested, or if the text contains 3 dots instead of an elipsis character.
- Use profiling conditions to either use images that include titles, or have images without titles with text-based overlays done in Scribus. These would then be triggered using 'headings-img' and 'headings-text' conditions.
- Set default image size to improve HTML rendering, or provide web-resolution images.
- Provide cone drawing image without text for cases where the image is being used outside of the book and the overwrite isn't working.
- Consider trimming down images where possible to make them smaller in size and better fitting for other outputs.
- Use profiling conditions in Docbook file for full-spread images in outputs other than Scribus.
- ITSTool doesn't update external ref elements. These are merely an indicator that the sources exist, can be updated. The md5 hash can be a trigger to update the translation accordingly. Reading the [XML ITS 2.0 documentation](https://www.w3.org/TR/its/#externalresource) with this perspective is seems that internationalisation expects the file names and references to stay the same, and be updated to match. More concretely the Docbook file would have to point to generic 'capital-p04.png' instead of language-specific 'O-cyan.png'. Same for illustrations, it would point to 'illustrations/ada-p04.png' and not to 'illustrations/es/ada-p04.png' or 'illustrations/ada-p04-es.png'. The processing surrounding the Docbook would have to make sure that the translated files end up in the correct location. Alternatively the ITS rules can be changed so that the entire element including attributes can be translated. This would then allow translators to change the references, at the cost of introducing more formatting complexity to translators.
  - The question is how to deal with language-specific images and other files when they have the same name and how to make it practical. The current approach is the use of symbolic links to allow for fallbacks. In general this is a good approach, although symoblic links might not work well in all situations (see [#52](https://git.fsfe.org/FSFE/ada-zangemann/issues/52)). Rather than requiring users to define all links explicitly, a tool like [GNU Stow](https://www.gnu.org/software/stow/) can be used to manage symlinks. It could be used to first symlink a directory of base images and then override it with symlinks that are language-specific. Alternatively the translator could define a mapping which files to use instead of base files.
    - Something left to think about is how to deal with translations that share overrides, for example Spanish variants. Then it could first link the common (English) images, then link the base Spanish translations and then lastly override with the Spanish variant in question.
    - Images could be copyied to an 'assets' directory to be available in all stepf of the process. This is similar to the 'libs' directory in the Android build system.
    - Directories could be created per language variant, or nested a level deeper per output variant.
      - If processed sequentially, first the variant with image headers can be created, then the variant with text headers where images are replaced inbetween.
      - If processed parallel the files could be structured as language inside variant (`intermediates/text-headers/es/images`) or the other way around (`intermediates/es/text-headers/images`).
  - Turns out GNU Stow is not a viable option as it cannot handle conflicts in symlinks. The concept of language-packs is designed that way for simplicity and so this is not a good fit. The `cp -rs` command can create symbolic links in a recusive manner. Absolute source paths need to be used. Absolute source paths could be cleaned up later using the 'symlinks' command. See this [discussion on linking file trees](https://stackoverflow.com/questions/1240636/symlink-copying-a-directory-hierarchy).
  - An alternative approach is to determine the necessary image files and symlink (or copy) just those specific files.
- There seems to be some potential to simplify specification of capitals. All chapters start with a dropcap in the first paragraph, except for the the chapter 'One day...'. Introducing a drop capital here for consistency is allowed, it was a design decision to not do so. Most chapters have a distinct color scheme for the dropcaps, although color schemes 'cyan' and 'yellow' appear twice.
- The banners on the protest page can be translated using fonts. This has been done for the Arabic version. Templates could be provided to make this easy for translators and perhaps even automate it. Inkscape could be a good solution to apply the text along a curved path and perhas even transform the text for a better fit.
- It could be worthwhile to store the translated docbook file, to prevent the situation where the main docbook file is updated and results in missing or invalidated translations.
- There is a benefit in using character styles, because it makes it easier to apply styles in the XSLT template and it is easier to change styles across the document afterwards in Scribus.
- How to improve defining capital images? There is a beautiful simplicity in the format by Luca of enclosing the capital, providing an optional override name, like: `[Eacute|É]rase`. Ideally the text is parsed, necessary capitals and their colors derived, then generated in the right color if already available, and then put in the right place. Alternatively we could rely on the coordinator of the translation to create the necessary capital (as is already the case) and place or link it in an override directory for the specific translation with a generic name like 'capital-ch4.png'. A more declarative solution would be nicer, but perhaps a symlink override is sufficient for now.
- SVG files can be used to align text to images. This is relevant for the cover of the epub output and to render a translated version of the protest image for Scribus.
  - The protest image has the hair bun of a lady in front of the banner. An overlay image can be created with her hair so that an SVG 'sandwich' can be created: the main image on the background, then text on top and lastly a transparant image with the hair overlaying the text. Imagemagick has multiple features to [remove a background](https://usage.imagemagick.org/masking/#bg_remove) that can be used to create the hair bun with slighly transparant edges to overlay the image and text.
    - An overlay image might also be used as a pattern to create a pencil appearance on the font.
  - The SVG processing of images calls for a separate rendering setup. Processing can create png images of the SVG file and can create various cropped images for separate pages and to highlight parts of the illustration in the ebook version.
- Consider base64 encoding images and other files for the webbook version to output a single HTML that includes all necessary data to render the page.
- Standard ebooks project [recommends a standard folder structure](https://standardebooks.org/contribute/a-basic-standard-ebooks-source-folder) that can be inspiration for the folder structure.
- The docbook getting started repository contains a [folder structure for a docbook setup](https://github.com/docbook/getting-started/tree/master/book) which comes with a build.gradle script to generate outputs and assemble an epub ebook.
- A Makefile.inc file can make the Makefile setup more modular. In Coreboot each supported mainboard has a Makefile.inc file in the directoy that appends specific files to certain output files. In this way Make knows all files that have to be handled for certain steps.
- Keeping filenames the same per translation prevents having to change links in the Docbook file, but makes it more complicated to manage files as it requires replacing files (or its symbolic links) for each output. Having explicit links where all files can coexist works for the build output but also for a webserver where digibooks would be hosted.
- The current language pack idea has its downsides. First it is hard for a translator to get inspiration for items to translate. If the images of different languages would be side-by-side, it would be easier to know how to change the image. Also, the current idea of a 'blank' language pack as an override mixes format-specific needs with language-specific needs. Blank should be the base as it can be used for all languages using fonts. Images with hand drawn text can be considered an override in itself. Each output format will likely have some of its own processing done to reduce the image resolution or convert the images to greyscale. A question remains if left-to-right and right-to-left should be separated on a higher level, or if they can exist besides eachother. Many right-to-left images can be generated from left-to-right images as it is just a mirror image, except for some images that are kept the same. All image formats can be created in multiple processing steps, controlled by Make. The relevant files can be symlinked to the intermediate build directory for each specific output format. Note that capital images might be treated the same way, but due to their repetitious nature might be treated differently. Translations have a most 11 language-specific illustrations (see research in section below), which can be reduced to 3 or even 0 by using fonts to create the images. Note that a dot in the filename is discuraged and with forbidden characters in certain OS's, this leaves hyphen en dash as separators. Here are some examplary file structures, which does not feature specific folders per output format, as currently only the `-title` illustrations are output-specific:

```
fonts/fonts.xml  # default LTR fonts. Name fonts.ltr.xml could also be used.
fonts/fonts-ukr.xml
fonts/fonts-ar.xml
illustrations/ada-p04.png  # asuming LTR. Name ada-p04.ltr.png could also be used. ada-p04.rtl.png can be generated.
illustrations/ada-p40-41.png  # asuming LTR. Seperate p40 and p41 cutouts can be generated.
illustrations/ada-p40-41-de.png  # German override
illustrations/ada-p40-41-uk.png  # Ukrainian override
illustrations/ada-p03-title-en.png  # Hand-drawn title page for English (default is a font-based page)
illustrations/ada-p03-title-de.png  # Hand-drawn title page for German (default is a font-based page)
```
- Font styles for Scribus will have to be both character styles and paragraph styles. The character styles are needed for cases where character styles are changed inside a paragraph, like emphasis marks and for drop caps. Paragraph styles are needed to configure dropcaps and change font line spacing.
- In Scribus different illustrations are needed depending on the output variant. This can be managed inside the templating using A) conditions in Docbook, or B) conditions in Scribus using multiple images, or C) placing the correct image on the expected location outside of the templating.
- Rather than adjusting line spacing for fonts for all outputs, it might be easier to change the font file.
- The handdrawn subtitle fonts be converted to a font for easier editing. There are some bitmap font formats, that use bitmaps instead of vectors. Another option is to trace bitmaps into vector images as modern font files use vectors. FontForge has [suggestions for how to trace bitmaps into fonts](https://fontforge.org/docs/techref/autotrace.html). The [GNU Typewriter font](https://fontlibrary.org/en/font/gnutypewriter) can be seen as an example of a pixelated font with grain that is converted to a vector format.
- In a new Scribus file styles are created by default: "Default Character Style", "Default Paragraph Style", etc. The same goes for colors: "Black", "Cool Black", etc. It would be good to default to a naming convention of Capitalisation with spaces.
- How can the processor know what font styles to use for emphasis (bold, italic, bold italic)? A hardcoded extension could be done to the font name, but that would make it hard to update the styles if needed and would leave little opportunity to the user to change styles afterwards. Ideally the default style would have a reference to the emphasis variants. The style hierarchy in Scribus could be used, which describes such a relation in reverse. Another method is to use convention. So if the default paragraph style is 'Credits', that it expects style names 'Credits Bold', 'Credits Italic' and 'Credits Bold Italic' or even 'Credits Emphasis' as a general style. The existance of an inheritance relation to the base style could be checked, but it might be too much to ask that of users. String based matches are of course prone to typing issues, so capitalisation is best ignored.
- Inspiration of automation used by French publishers:
  - [Dude](https://framagit.org/YannKervran/dude) scripts by Yann Kervran to generate Epub and DocuWiki formats from Markdown.
  - [Système de publication DLEC](https://framagit.org/framabook/systeme-publication-framabook) as replacements of Dude scripts. "Easier to maintain as it is based upon bash scripts and makefile. The backend is pandoc and LaTeX mainly, to generate pdf and epub. But it could be expanded as needed, even it is always a bit tricky to come and modify makefiles afterwards. We use this system with an IC for Framasoft publishing house, '[Des livres en communs](https://deslivresencommuns.org/)'."
    - The PDF is generated using Pandoc from a LaTeX template.
    - The Epub is also generated using Pandoc and modified to insert the cover.
  - [Paged.js](https://pagedjs.org/) framework, used by [Julie Blanc](https://julie-blanc.fr/).
  - [PrePostPrint](https://prepostprint.org/) with various tools.
- It should be avoided to use different images for the headers with fonts or images. An edge case is the subtitle on the cover and title page. There are multiple ways of dealing with this:
  - Use separate images for the title (Ada & Zangemann) and subtitle (A tale of …)
  - Use some overlay frame in Scribus to mask out the image title, that is rendered using the same conditions as the text. Can be a colored rectangle or a blank variant on the same spot.
  - Generate custom images with fonts in a preprocessing step.
- The processing now uses clever shell script one-liners which are compact but hard to understand. By using more Python the understandability of the setup might be improved. This would make it more inviting to outsiders to contribute a new format or contribute other improvements.
- Other build tools like Scons or Meson might be more accessible to newcomers with its syntax. In general the options to provide information to GNU Make are limited. This is difficult for getting images used in the Docbook file or the capital files. GNU Make is however very common and widely understood. Scons has mixed reviews.
- The build directories are to be organized by language and then output type. For each build step a new directory might be created for clarity.
- GNU Make vpath expressions can be used to check for a given filename in multiple directories. This works like the path on a shell. This fallback mechanism can be used to resolve translations of images.
  - Besides explicit fallbacks, a language directory could have a symlinked directory with a common name like 'fallback' to point to the directory of the fallback.
- For Markdown support the Pandoc Markdown might be a good flavor to standarize on.
- Fallback of languages could include editions. For example `en_US_no-starch-press` could fall back to `en_US` and then `en` and then `ltr` (left to right). For this mechanism to work well, it should be possible to specify the fallback mechanisms.
- Besides reading direction, different languages have different conventions of spine orientation. In many countries top-to-bottom is common so that the spine can be read when the book is lying flat on a table. In Italy and French apparently it is more common to have the spine text be from bottom to top to align with typographic conventions for sidways text. This property might be included as part of the fallback hierarchy, or it could be left as a choice for the publisher of the book. Then it would need the same level of configuratability as the cover images.
- The docbook structure and its Scribus handling enables changes in layout and order. This becomes apparent when dealing with the inside cover. Adding the cover will offset the page numbers. This doesn't break the processing as content is inserted based on ids instead of page numbers.
- Translation strings can be split into multiple categories to help translators prioritize. Translate toolkit has [pogrep](https://docs.translatehouse.org/projects/translate-toolkit/en/latest/commands/pogrep.html) to select parts of the PO file, which can be merged into larger parts or into a single file using [pomerge](https://docs.translatehouse.org/projects/translate-toolkit/en/latest/commands/pomerge.html).
- Kvdaalen contributed a [Python script named FormatXML](https://wiki.scribus.net/canvas/Formatxml) to the Scribus wiki to refer Scribus styles in an XML document, including the option to override fonts in an emphasis. These features can be inspiration.
- The `fc-list` command can be used to check installed fonts.
- Dropcaps support in Scribus templates needs some logic. This can be done in multiple ways.
  - Options for the different components involved:
    - Text frames should not have a dropcaps property. As the dropcaps property relies on Scribus styles, it makes sense to have it be defined in Scribus. In case of image based dropcaps this setting needs to be removed to prevent two capitals side by side. One option is to keep the same text frame and have a machanism remove this setting. Another option is to have a dedicated text frame without dropcap settings, which could be enabled using conditions. Seperate templates are another option, which will introduce an additional burden to keep them synchronized.
    - The first character of the paragraph needs to be removed in case of capital images. The processing needs to be able to distinguish the paragraphs that need this.
    - The trigger of this behavior could be a general condition like `capitals-img` or `capitals-text`. It could also be an additional attribute on the textframe like `removefirstchar` as an explicit trigger. An explicit trigger offers the benefit of more fine-grained control.
  - Concrete proposals:
    - Double-up text frames, to be removed conditionally. Add a property to the attributes like `removefirstchar` to conditionally apply this seperate processing. This method is very explicit and offers a lot of flexiblity to the user. Another benefit of this approach is that the paragraph without properties can remain available to the existing Perl scripts. The dropcap property on a paragraph sets an explicit style on the first character, breaking the text-based pattern matching.
    - Use single text frames with scribus dropcap properties. Change the behavior based on processing conditions `capitals-img` and `capitals-text` or maybe a seperate option like `capitals-to-img` to hint at a conversion. The processing can check if dropcaps are configured and can change the contents and properties of these text frames. This method would be very powerful but is also less transparent to the user.
- In some cases the Docbook content needs changes before use in Scribus. Currently there are 2 such cases: 1) strip the first character of a paragraph with capital image 2) refer to a greyscale image variant by changing the filename or directory. Both changes could be achieved by profiling in the docbook file, but that would introduce duplication. The duplication could be done in a preprocessing step of course, but ideally this should not be necessary. In order to expose these controls to Scribus, attributes can be introduced like `strip-first-char=true` or `fileref-replace="ada-p04;ada-p04-greyscale"`. The current code (2025-03-18) is layed out to handle these edge-cases in a single pass at the deepest level. For dropcaps case it would have to pass a parameter to the template handling the first occurance of the first paragraph. Expecting more processing options in the future, making it part of the deeper would cause an increase in complexity. A clearer separation would be to have this be postprocessing steps for the given Scribus page object. So first the page object would be created and only at the end the postprocessing steps from the attributes would be called. This can be done in a second pass with a separate XSLT document, or inline by storing the output in a variable. This [Stackoverflow example of transforming already transformed XML](https://stackoverflow.com/a/29996452) does this by storing the output in a variable `pags` and postprocessing that variable before creating output.
- In an attempt to make the XSLT processing as generic as possible, handling the dropcap as an attribute of the paragraph should maybe be changed. Another approach would be to handle it as an inline image with a `role=dropcap` to clarify its purpose. The `alt` element can be used to contain the fallback character in case the drop cap cannot be shown. In case of processing a paragraph in Scribus, all inline images could automatically fall back to their alt text. Basically there are two ways of modelling:
  1. As part of the paragraph: `<para xml:id="para-p04-1" az:dropcap="true" az:dropcapfileref="../illustrations/Capitals/O-cyan.png">Once upon a time, there was a little girl named Ada. Her family was so poor that all their savings fit inside a cookie jar. They didn’t have enough money to live in a proper home. Instead, Ada lived with her mother and her little brother, Alan, in a cabin near a junkyard on the edge of town.</para>`
  2. As an inline image with alt text: `<para xml:id="para-p04-1"><inlinemediaobject role="dropcap"><imageobject><imagedata fileref="../illustrations/Capitals/O-cyan.png"/></imageobject><alt>O</alt></inlinemediaobject>Once upon a time, there was a little girl named Ada. Her family was so poor that all their savings fit inside a cookie jar. They didn’t have enough money to live in a proper home. Instead, Ada lived with her mother and her little brother, Alan, in a cabin near a junkyard on the edge of town.</para>` Here an alt-text is used as fallback for the capital image. A conditional piece of text could also be an option:
    - An example with a conditional span as fallback: `<para xml:id="para-p04-1"><inlinemediaobject role="dropcap" condition="capitals-img"><imageobject><imagedata fileref="../illustrations/Capitals/O-cyan.png"/></imageobject><alt>O</alt></inlinemediaobject><phrase condition="capitals-text">O</phrase>nce upon a time, there was a little girl named Ada. Her family was so poor that all their savings fit inside a cookie jar. They didn’t have enough money to live in a proper home. Instead, Ada lived with her mother and her little brother, Alan, in a cabin near a junkyard on the edge of town.</para>`
- The Kamishibai edition also has the text split over pages. This does not directly align with the pages of the book, as the Kamishibai format is structured around the images. To mark page transitions, separate self closing tags can be added, like `<az:section xml:id="kamishibai-p01" condition="kamishibai"/>`. A XSLT preprocessing step can be used to remove default sections for books and resructure the text according to these tags. [XSLT allows selecting content between sibling tags](https://stackoverflow.com/questions/59941584/selecting-text-between-two-self-closing-tags-via-xslt). The `xml:id` should then be added to the resulting section, so the Scribus processing can pick it up. In case a phrase of a single letter is not handled correctly, two phrases can also be an option, like: `<para><inlinemediaobject condition="capitals-img">...</inlinemediaobject><phrase condition="capitals-img">nce</phrase><phrase condition="capitals-text">Once</phrase> upon a time ...</para>`
- The upstream Docbook XSLT templates have advanced processing features and cover a lot of situations. There is a benefit in making this Scribus processing part of that ecosystem so that those processing features can be used.
- When using drop caps on a text style, each paragraph will have a drop cap, instead of just the first one as is expected for this book. This is a known issue, as can be seen in [Scribus bug report 0000204: Drop Cap only for the first paragraph](https://bugs.scribus.net/view.php?id=204).
- Rather than using XML IDs, an XPATH expression would be a more dynamic way to select content from Scribus. As an XML ID needs to be unique, it can be difficult to put it at the right place when sections are dissapearing. An XPATH expression can be more selective. Unfortunately an XPATH expression from a variable [can only be used since XSLT version 2.1](https://stackoverflow.com/questions/4630023/dynamic-xpath-in-xslt). For earlier versions of XSLT a match process can be created that functions as an approaximation. The [EXSLT dyn:evaluate command](https://exslt.github.io/dyn/functions/evaluate/index.html) can be used instead as it is implemented in Xsltproc. Another issue is how to deal with namespaces. The document currently has different namespaces. Should namespaces be ommitted? Should there be a place in Scribus to define them?
- Experimenting in Scribus to get dropcaps on just the first line. One option is to start the second paragraphs with `DROP="0"` to disable the effect. Another is to use `<breakline/>` as a newline that does not break the paragraph.
```xml
        <PAGEOBJECT XPOS="170.866771653543" YPOS="1991.02393700787" OwnPage="5" ItemID="2112934646" PTYPE="4" WIDTH="444.407244094488" HEIGHT="481.889763779528" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" ANNAME="TextP06" LOCALSCX="1" LOCALSCY="1" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="1" RATIO="1" COLUMNS="1" COLGAP="0" AUTOTEXT="0" EXTRA="0" TEXTRA="0" BEXTRA="0" REXTRA="0" VAlign="0" FLOP="0" PLTSHOW="0" BASEOF="0" textPathType="0" textPathFlipped="0" path="M0 0 L444.407 0 L444.407 481.89 L0 481.89 L0 0 Z" copath="M0 0 L444.407 0 L444.407 481.89 L0 481.89 L0 0 Z" gXpos="170.866771653543" gYpos="1991.02393700787" gWidth="0" gHeight="0" LAYER="0" NEXTITEM="-1" BACKITEM="-1">
            <StoryText>
                <DefaultStyle ParagraphEffectCharStyle="Capital" ParagraphEffectOffset="0" ParagraphEffectIndent="0" DROP="1" DROPLIN="4" Bullet="0" Numeration="0"/>
                <ITEXT CPARENT="Capital" CH="c"/>
                <ITEXT CH="hon als Kind hatten Zangemann Computer fasziniert. Da waren es noch riesengroße Maschinen mit vielen Kabeln und lauten Lüftern. In der Schule träumte der kleine Zangemann oft davon, was er mit den Computern alles machen würde, wenn sie nur etwas kleiner wären – klein genug, um sie in die verschiedensten Geräte einzubauen. Als Erstes würde er einen Computer in sein Skateboard einbauen, damit es beim Fahren coole Geräusche machen könnte – wie eine Feuerwehrsirene oder ein Raketenstart. Und er würde Eismaschinen erfinden! Der Computer könnte die tollsten Sorten mischen und das Eis automatisch verkaufen. Die Maschinen würden an jeder Straßenecke stehen, und er könnte sich sein Lieblingseis holen, wann immer er Lust hätte. Außerdem würde er einen Aufräumroboter und eine Bausteine-Sortiermaschine bauen, damit sein Zimmer immer schön aufgeräumt wäre. Zangemann hatte jeden Tag neue Ideen. Er konnte an nichts anderes "/>
                <breakline/>
                <breakline/>
                <ITEXT CH="denken."/>
                <para ParagraphEffectCharStyle="Capital" ParagraphEffectOffset="0" ParagraphEffectIndent="0" DROP="1" DROPLIN="4" Bullet="0" Numeration="0"/>
                <para ParagraphEffectCharStyle="Capital" ParagraphEffectOffset="0" ParagraphEffectIndent="0" DROP="0" DROPLIN="4" Bullet="0" Numeration="0"/>
                <ITEXT CH="Und tatsächlich: Je größer Zangemann wurde, desto kleiner wurden die Computer. Als er schließlich die Schule verließ, waren sie so klein, dass sie in seine Hosentasche passten. Die kleinsten fanden sogar auf seiner Fingerkuppe Platz."/>
                <trail ParagraphEffectCharStyle="Capital" ParagraphEffectOffset="0" ParagraphEffectIndent="0" DROP="0" DROPLIN="4" Bullet="0" Numeration="0"/>
            </StoryText>
            <PageItemAttributes>
                <ItemAttribute Name="docbook-id" Type="string" Value="sec-p06" Parameter="" Relationship="none" RelationshipTo="" AutoAddTo="none"/>
                <ItemAttribute Name="condition" Type="string" Value="capitals-img" Parameter="" Relationship="none" RelationshipTo="" AutoAddTo="none"/>
            </PageItemAttributes>
        </PAGEOBJECT>
        <PAGEOBJECT XPOS="156.693543307087" YPOS="2487.08692913386" OwnPage="5" ItemID="2113753718" PTYPE="4" WIDTH="25.5999999999999" HEIGHT="31.1811023622045" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" LOCALSCX="1" LOCALSCY="1" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="1" RATIO="1" COLUMNS="1" COLGAP="0" AUTOTEXT="0" EXTRA="0" TEXTRA="0" BEXTRA="0" REXTRA="0" VAlign="0" FLOP="0" PLTSHOW="0" BASEOF="0" textPathType="0" textPathFlipped="0" path="M0 0 L25.6 0 L25.6 31.1811 L0 31.1811 L0 0 Z" copath="M0 0 L25.6 0 L25.6 31.1811 L0 31.1811 L0 0 Z" gXpos="751.969133858269" gYpos="1851.81165354331" gWidth="0" gHeight="0" LAYER="0" NEXTITEM="-1" BACKITEM="-1">
            <StoryText>
                <DefaultStyle CPARENT="PageNumber"/>
                <ITEXT CPARENT="PageNumber" CH="6"/>
                <trail/>
            </StoryText>
        </PAGEOBJECT>
```
- For aligning the titles in Scribus it is important to set the 'First Line Offset' in 'Text Properties' to anything other than 'Maximum Ascent', as that option will cause the text baseline to shift depending on the characters used. The best option is 'Line Spacing' to ensure the base font line position remains consistent even if the font and text size changes.
- Consider replacing `<az:excerpt>` in favor of a `<phrase>` element in the alt-text of the mediaobject. In this way the individual phrase can be selected if needed while avoiding unnecessary duplication.
- Add profiling condition based on language.
  - This should work but doesn't:
```
$(targets-print-headings-text): build/%/print-headings-text/Ada_Zangemann-print-headings-text.sla: build/%/Ada_Zangemann.dbk build/%/images/illustrations build/%/images/capitals xsl/scribus.xsl
	mkdir -p $(@D)
	if [ ! -h $(@D)/images ]; then ln -s ../images $(@D)/images; fi
	xsltproc -o $@ --verbose --stringparam docbook-contents-file ../$< --stringparam profile.condition "headings-text;capitals-text" --stringparam profile.lang "$(subst build/,,$(subst /print-headings-text/Ada_Zangemann-print-headings-text.sla,,$@))" xsl/scribus.xsl templates/template-print.sla > $@.log 2>&1
```
  - This seems to have to do with the default Docbook stylesheet profiling in combination with the translation. The resulting docbook stylesheet has top-level language `ada-ZANGEMANN` and explicit `xml:lang="en"` attributes for all elements not translated. Update: ada-ZANGEMANN language resulted from wrong .mo filename. Still the rest of the content does not appear, which might have to do with the top-level language in the document for which the profiling would need to be adjusted.
  - The additional paragraph in the acknowledgements could be handled using a condition, if it works correctly. Hacking a `</para><para>` into the element doesn't work as itstool fails this, calling `Warning: Could not merge en translation for msgid`.
  - For languages to work properly, the profiling should not check the first element of the docbook file, the XML descriptor, because that also includes an language tag. An alternative approach might be to make a condition based on the language. This could be added in Makefile to be automatic.
- Support grouped elements in Scribus by not mathcing hard on the level. Groups seem to be marked with `PTYPE="2"`:
```xml
        <PAGEOBJECT XPOS="328.098897637795" YPOS="292.807559055118" OwnPage="0" ItemID="820592405" PTYPE="12" WIDTH="309.6" HEIGHT="251.300787401575" FRTYPE="0" CLIPEDIT="0" groupWidth="309.6" groupHeight="251.300787401575" groupClips="1" path="M0 0 L309.6 0 L309.6 251.301 L0 251.301 L0 0 Z" copath="M0 0 L309.6 0 L309.6 251.301 L0 251.301 L0 0 Z" gXpos="248.20157480315" gYpos="297.498897637795" gWidth="1412.45977991882" gHeight="789.227329192547" LAYER="0">
            <PAGEOBJECT XPOS="328.098897637795" YPOS="295.708346456693" OwnPage="0" ItemID="820686597" PTYPE="4" WIDTH="309.6" HEIGHT="248.4" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" LOCALSCX="1" LOCALSCY="1" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="1" RATIO="1" COLUMNS="1" COLGAP="0" AUTOTEXT="0" EXTRA="0" TEXTRA="0" BEXTRA="0" REXTRA="0" VAlign="0" FLOP="0" PLTSHOW="0" BASEOF="0" textPathType="0" textPathFlipped="0" path="M0 0 L309.6 0 L309.6 248.4 L0 248.4 L0 0 Z" copath="M0 0 L309.6 0 L309.6 248.4 L0 248.4 L0 0 Z" gXpos="0" gYpos="2.90078740157497" gWidth="309.6" gHeight="251.300787401575" LAYER="0" NEXTITEM="-1" BACKITEM="-1">
                <StoryText>
                    <DefaultStyle/>
                    <ITEXT CH="TEXT-PAGE60"/>
                    <trail/>
                </StoryText>
                <PageItemAttributes>
                    <ItemAttribute Name="docbook-id" Type="string" Value="sec-back-cover" Parameter="" Relationship="none" RelationshipTo="" AutoAddTo="none"/>
                </PageItemAttributes>
            </PAGEOBJECT>
            <PAGEOBJECT XPOS="328.498897637795" YPOS="292.807559055118" OwnPage="0" ItemID="820703045" PTYPE="2" WIDTH="33.224" HEIGHT="50.6346456692911" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" TEXTFLOWMODE="1" LOCALSCX="0.16" LOCALSCY="0.16" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="1" RATIO="1" Pagenumber="0" PFILE="../../templates/Capitals/-yellow2.png" PRFILE="sRGB display profile (ICC v2.2)" IRENDER="0" EMBEDDED="0" path="M0 0 L33.224 0 L33.224 50.6346 L0 50.6346 L0 0 Z" copath="M0 0 L33.224 0 L33.224 50.6346 L0 50.6346 L0 0 Z" gXpos="0.399999999999977" gYpos="0" gWidth="309.6" gHeight="251.300787401575" LAYER="0" NEXTITEM="-1" BACKITEM="-1"/>
        </PAGEOBJECT>
```

### Request for feedback

Specific questions that came to mind during development and could be answered during a review:

#### DocBook modelling

- Is there sufficient benefit of tapping in the larger DocBook ecosystem? (Knowing that there were some issues with DocBook conversions of dbtoepub and dblatex, which might require preprocessing.)
- Is it misuse to use section elements to separate pages or text frames?

#### Translations

- Does ITStool work well for extracing and handling PO files?
- Are the resulting strings at the correct level? Providing XML syntax where needed, but not too much?
- Is translation by paragraph workeable for translators?
- Is it acceptable to expose information about fonts and dropcaps to translators for simplicity, or should it be kept separate?

#### XSLT transformation

- Is the syntax and structure of the XSLT template (`xsl/scribus.xsl`) understandeable?
- Do the XSLT templates need to split up into smaller templates at the cost of more overhead?

### Recommendations for ongoing development

- A change in modeling might be breaking for external scripts. Breaking changes should be avoided. A version indicator is a hint at format compatibility.

### Software stack

- Many text editors support XML formatting and some even recognize the DocBook format.
- [ITS Tool](https://itstool.org/) supports exporting and importing PO files for translations.
- [Libxml2](https://gitlab.gnome.org/GNOME/libxml2/-/wikis/home) is a popular free software tool to work with XML.
  - Xmllint allows validating and reformatting the XML source text.
  - Xsltpoc supports processing using XSLT templates of version 1.0 and some convenient extensions. XSLT versions 2.0 and 3.0 exist as well, but are not supported by Libxml2.

## Some commands

    xsltproc -o output.xml --verbose --stringparam docbook-contents-file "Ada_Zangemann-en.dbk" xsl/scribus-2.xsl template-print-1.sla

    diff -C2 template-print-1.sla output.xml

    xsltproc -o docbook-xslt.html /usr/share/xml/docbook/stylesheet/nwalsh/html/docbook.xsl Ada_Zangemann-en.dbk

    pandoc -f docbook -t html -o docbook.html Ada_Zangemann-en.dbk

    itstool -o source.pot Ada_Zangemann-en.dbk

## Resources

The DocBook standard is large and will take time to comprehend. It will take more time if you include the XML standard, the XSLT processing standard, the ITS internationalisation standard and the various tools. Fortunately there are great resources like documentation, books, videos and an active community.

### DocBook

- [DocBook book website](https://docbook.org/) which includes links to different resources
  - [Overview of DocBook version 5 customizations](https://docbook.org/schemas/5x-custom) like DocBook Slides
- [DocBook wiki](https://github.com/docbook/wiki/wiki) with various articles
- [DocBook online book for version 5.2](https://tdg.docbook.org/tdg/5.2/) currently in development
- There used to be a DocBook mailinglist hosted by OASIS. A new one might be created.

### XSLT and XPath

XSLT can be used to express transformations of XML, much like a programming language. XPath is the way in which XSLT templates select certain parts of the XML document for processing.

- [XSLT section in the XML Wikibook](https://en.wikibooks.org/wiki/XML_-_Managing_Data_Exchange/XSLT_and_Style_Sheets)
- [XPath wikibook](https://en.wikibooks.org/wiki/XPath)
- [YouTube XSLT XPath Tutorial video](https://www.youtube.com/watch?v=WggVR4YI5oI) that goes into the practical aspects and pitfalls.
- [XML Prague](https://www.xmlprague.cz/) is a yearly conference focussed on XML and related standards. Talks are recorded and available online.

Some examples of XSLT intended for DocBook:

- [XSLT 1.0 stylesheets for DocBook](https://github.com/docbook/xslt10-stylesheets)
- [XSLT 3.0 stylesheets for DocBook](https://github.com/docbook/xslTNG) which includes conversions for Epub output.
- [Docbook2SLA Python package](https://pypi.org/project/docbook2sla/) that contains XSLT conversions for DocBook to Scribus and vice versa. The source code has been extracted from the source packages to [this repository](https://gitlab.com/nicorikken/docbook2sla)

<!-- TODO: add details on Scribus and XML tooling -->

## Other details

### Translation steps

Let's consider how a new translation can come to be, step by step:

- Base translation by only translating the PO file
  - Weblate can create new language PO file as a starting point to generate outputs (work needed)
  - Text/font-based output variants can be created (work in progress)
  - Necessary folder structure can be generated on the fly (work needed)
  - A font configuration is necessary if the default fonts lack used characters (work in progress)
  - Dropcaps can be used in Scribus if implement (work needed)
  - Banners on the protest illustration could be translated using fonts if template and automation is available (work needed)
- Hand-drawn texts and other improvements
  - Dropcaps can be generated by recoloring existing ones and by drawing missing characters (partially done)
  - Headings and illustrations can be translated or localized and provided as overrides (mostly done)

### Generic processing approach

```ditaa
+-----------------------+    +--------------------------+
| source DocBook files  |    | DocBook namespace only   |
| (incl. ITS, ITST, AZ) |-+->| (for further processing) |
+-----------------------+ |  +--------------------------+
            ^             |
            |             |  +-------------------------+  +-------------+
            v             +->| Scribus (fill template) |->| PDF exports |
+----------------------+  |  +-------------------------+  +-------------+
| PO translation files |  |
| (per language)       |  |  +-------------+
+----------------------+  +->| Epub (HTML) |
                          |  +-------------+
                          |
                          |  +-------------------+
                          \->| Book reading text |
                             +-------------------+
```

Shorter diagram, showing order of contents from top to bottom
```
* Ada_Zangemann.dbk . . . . . . . . . . . . . . . DocBook source
* Ada_Zangemann.pot . . . . . . . . . . . . . . . strings to translate
* Ada_Zangemann-[lang].po . . . . . . . . . . . . stranslated strings, per language
* Ada_Zangemann-[lang].mo . . . . . . . . . . . . prepared translated strings
* Ada_Zangemann-[lang].dbk  . . . . . . . . . . . translated DocBook
|\
| * Ada_Zangemann-[lang]-[variant]-[profile].sla  Scribus output, for different variants (screen/book) and profiles
| * Ada_Zangemann-[lang]-[variant]-[profile].pdf  PDF output
| * Ada_Zangemann-[lang]-[variant]-[profile].png  PNGs of pdf, also for visual comparison
|\
| * Ada_Zangemann-[lang].odp  . . . . . . . . . . Presentation with reading text in notes
|\
| * Ada_Zangemann-[lang]-reading.txt  . . . . . . Book reading text
|
* Ada_Zangemann-[lang]-pure.dbk . . . . . . . . . DocBook file restricted to DocBook properties
|\
| * Ada_Zangemann-[lang].html . . . . . . . . . . HTML output using standard DocBook stylesheets
|\
| * Ada_Zangemann-[lang].epub . . . . . . . . . . Epub output using standard DocBook stylesheets
```

### Folder structure proposal

Idea to use overrides to define language specific changes:
```
src/Ada_Zangemann.dbk
src/illustrations/ada-p04.png
src/illustrations/ada-p40-41.png
src/overrides/es/illustrations/ada-p40-41.png
src/overrides/es/fonts.xml  . . . . . . . . . . . . . language-specific font configuration
po/Ada_Zangemann.pot
po/de.po
build/intermediates/es/Ada_Zangemann.dbk
build/intermediates/es/es.mo
build/intermediates/es/fonts.xml
build/intermediates/es/Ada_Zangemann-screen-text.sla
build/intermediates/es/illustrations/ada-p04.png  . . symlink to common illustration
build/intermediates/es/illustrations/ada-p40-p41.png  symlink to ES illustration
build/outputs/es/Ada_Zangemann-screen-text.pdf
```

Build directory structure is inspired by [Android build system](https://why-rishav.medium.com/android-build-systems-part-2-ce6d9ab3adc#c87e).

## Analysis of slides and pages

Slide transitions and page transitions cross each oter (single page for multiple slides and vice-versa).

Conclusion is that slide transitions will have to be done using a custom element (anchor).
Alternatively more sections could be created for which duplicate entries of pagenum and slidenum are allowed.

NOTE: the resulting Table of contents in HTML gets additional spaces inserted when sections are introduced.

| contents                                    | page  | slide |
|---------------------------------------------|-------|-------|
| Title page                                  | 1     | X     |
| Imprint                                     | 2     | X     |
| Title                                       | 3     | 1     |
| Ada & Zangemann                             | 4-5   | 2     |
| Zangemann & Computers                       | 6-7   | 3     |
| (continued)                                 | 8-9.1 | 4     |
| (continued)                                 | 9.2   | 5     |
| (continued)                                 | 10-11 | 6     |
| (continued)                                 | 12    | 7     |
| One day...                                  | 13    | ..    |
| Skateboards no longer work                  | 18    | ..    |
| Ada and software                            | 20    | ..    |
| Programming                                 | 22    | ..    |
| A horrible night                            | 25    | ..    |
| First real project                          | 26    | ..    |
| Hacking for freedom                         | 30    | ..    |
| Zangemann and the President                 | 36    | ..    |
| Protest                                     | 39    | ..    |
| Children help the government                | 42    | ..    |
| New law                                     | 44    | ..    |
| And Zangemann?                              | 48    | ..    |
| Acknowledgments                             | 50    | ..    |
| About the Author - Matthias Kirschner       | 52    | ..    |
| About the Illustrator - Sandra Brandstätter | 53    | ..    |
| Website for the book and license            | 54    | ..    |
| Drawing templates                           | 55    | ..    |

## Analysis of commonalities in images

Commands used:
```
find . -type f -iname '*.png' | wc -l
find . -type l -iname '*.png' | wc -l
```

| Language | Custom illustrations | Illustration symlinks |
|----------|----------------------|-----------------------|
| ar       | 28                   | 60                    |
| common   | 2                    | 54                    |
| da       | 11                   | 62                    |
| de       | 11                   | 61                    |
| en       | 11                   | 62                    |
| es       | 11                   | 62                    |
| fr       | 11                   | 63                    |
| ukr      | 27                   | 60                    |

Interesting to see that certain translations have more illustrations in the folder than necessary. The Ukrainian translation for example has identical copies of images next to the symlinks.

Images to translate:

* Images (could be automated in Scribus and/or Inkscape)
  * `ada-a00.png` horizontal cover
  * `ada-a01.png` square cover
  * `ada-p40-p41.png` protest full
  * `ada-p40.png` protest left (could become post-processing of p40-p41.png)
  * `ada-p41.png` protest right (could become post-processing of p40-p41.png)
* Text (to be replaced by fonts)
  * `ada-p03-author.png`
  * `ada-p03-title.png`
  * `ada-p50-title.png`
  * `ada-p52-title.png`
  * `ada-p53-title.png`
  * `ada-p54-title.png`
  * `ada-p55-title.png`

The covers and protest sign are the hardest to replace by automation, the rest is rather easy. For the titles that are writen using fonts, there is no need to keep the images.
