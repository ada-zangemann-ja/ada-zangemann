<?xml version="1.0" encoding="utf-8"?>

<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: GPL-3.0-or-later
-->

<!--
Stylesheet to generate text file format intended for BrailleRAP.

Use this template like:
xsltproc -o build/Ada_Zangemann-profiled-text.nl.txt xsl/braillerap.xsl build/Ada_Zangemann.nl.dbk
-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                db:version="5.0"
                xmlns:az="https://git.fsfe.org/FSFE/ada-zangemann/"
                xmlns:its="http://www.w3.org/2005/11/its">
<xsl:output method="text" encoding="UTF-8"/>
<xsl:template match="/">

<!-- Cover -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-a00']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 1 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p01-titleonly']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="//db:simplesect[@xml:id='sec-p03']/db:literallayout[1]"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="//db:para[@xml:id='title-titlepage']"/>
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="//db:book/db:info/db:subtitle"/>
<!-- Page 2 -->[FF]
<xsl:value-of select="//db:simplesect[@xml:id='sec-p02']/db:literallayout"/>
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="//db:simplesect[@xml:id='sec-p02bb']/db:literallayout"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-cover']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 3 -->[FF]
<xsl:value-of select="//db:simplesect[@xml:id='sec-p03']/db:literallayout[1]"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="//db:para[@xml:id='title-titlepage']"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="//db:book/db:info/db:subtitle"/>
<!-- Page 4 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p04']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p04']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 5 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p05']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p05']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 6 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p06']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p06']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 7 -->[FF]
I: <xsl:value-of select="normalize-space(//db:mediaobject[@xml:id='img-ada-p07']/db:alt)"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 8 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p08']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p08b']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p08']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p08a']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 9 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p09']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p09']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p09']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p09']/db:para[3])"/>
<!-- Page 10 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p10']/db:para[1])"/>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p10']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p10']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 11 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p11']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p11']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<!-- Page 12 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p12']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p12']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p12']/db:para[2])"/>

<!-- 13 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p13']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p13']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 14 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p14']/db:para[1])"/>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p14']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p14']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 15 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p15']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p15']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p15']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 16 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p16']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p16']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 17 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p17']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 18 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p18']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p18']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 19 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p19']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p19']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p19']/db:para[2])"/>

<!-- 20 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p20']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p20']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p20']/db:para[3])"/>

<!-- 21 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p21']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 22 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p22']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p22']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p22']/db:para[3])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p22']/db:para[4])"/>

<!-- 23 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p23']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p23']/db:para[1])"/>

<!-- 24 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p24']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 25 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p25']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p25']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p25']/db:para[3])"/>

<!-- 26 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p26']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p26']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p26']/db:para[3])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p26']/db:para[4])"/>

<!-- 27 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p27']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 28 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p28']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p28']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p28']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 29 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p29']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p29']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p29']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 30 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p30']/db:para[1])"/>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p30']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p30']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 31 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p31']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p31']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p31']/db:para[3])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p31']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 32 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p32']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 33 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p33']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 34 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p34']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 35 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p35']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p35']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p35']/db:para[3])"/>

<!-- 36 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p36']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p36']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p36']/db:para[3])"/>

<!-- 37 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p37']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 38 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p38']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p38']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p38']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 39 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p39']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p39']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p39']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 40 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p40']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p40-41']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 41 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p40']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p41']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 42 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p42']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p42']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p42']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p42']/db:para[3])"/>

<!-- 43 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p43']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p43']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p43']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 44 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p44']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p44']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p44']/db:para[2])"/>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p44']/db:para[3])"/>

<!-- 45 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p45']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p45']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p45']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 46 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p46']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p46']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 47 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p47']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p47']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 48 -->[FF]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p48']/db:para[1])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p48']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 49 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p49']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 50 -->[FF]
<xsl:value-of select="//db:title[@xml:id='title-acknowledgments']"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p50']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p50']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p50']/db:para[3])"/>

<!-- 51 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p51']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 52 -->[FF]
<xsl:value-of select="//db:simplesect[@xml:id='sec-p52']/../db:info/db:title"/>
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="//db:simplesect[@xml:id='sec-p52']/../db:info/db:subtitle"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p52']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p52']/db:para[1])"/>

<!-- 53 -->[FF]
<xsl:value-of select="//db:simplesect[@xml:id='sec-p53']/../db:info/db:title"/>
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="//db:simplesect[@xml:id='sec-p53']/../db:info/db:subtitle"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p53']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p53']/db:para[1])"/>

<!-- 54 -->[FF]
<xsl:value-of select="//db:title[@xml:id='title-bookswebsite']"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p54a']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p54a']/db:para[2])"/>

<!-- 55 -->[FF]
<xsl:value-of select="//db:title[@xml:id='title-license']"/>

<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p54b']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p54b']/db:para[2])"/>

<!-- 56 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p55']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p55']/db:literallayout)"/>

<!-- 57 -->[FF]
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p56']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<!-- 58 -->[FF]
<!-- 59 -->
<!-- 60 -->
I: <xsl:value-of select="//db:mediaobject[@xml:id='img-back_cover-a']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-back-cover']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-back-cover']/db:para[2])"/>

I: <xsl:value-of select="//db:mediaobject[@xml:id='img-back_cover-b']/db:alt"/>
<xsl:text>&#xa;&#xa;</xsl:text>

</xsl:template>
</xsl:stylesheet>
