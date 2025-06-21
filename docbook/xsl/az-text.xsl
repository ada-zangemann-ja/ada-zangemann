<?xml version="1.0" encoding="utf-8"?>

<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: GPL-3.0-or-later
-->

<!--
Stylesheet to generate text file format for other Ada Zangemann automation.

Use this template like:
xsltproc -o build/Ada_Zangemann-profiled-text.nl.txt xsl/az-text.xsl build/Ada_Zangemann.nl.dbk
-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                db:version="5.0"
                xmlns:az="https://git.fsfe.org/FSFE/ada-zangemann/"
                xmlns:its="http://www.w3.org/2005/11/its">
<xsl:output method="text"/>
<xsl:template match="/">
** 0 **

[[IDX:
toc:<!-- TODO -->
text:<!-- TODO -->
cover:<!-- TODO -->
other.titlepage:<!-- TODO -->
chapter-01,cover:<!-- TODO -->
chapter-02,page_02:<xsl:value-of select="/db:book/db:colophon/db:info/db:title"/>
chapter-03,page_04:<xsl:value-of select="//db:simplesect[@xml:id='sec-p04']/../db:info/db:title"/>
chapter-04,page_06:<xsl:value-of select="//db:simplesect[@xml:id='sec-p06']/../db:info/db:title"/>
chapter-05,page_13:<xsl:value-of select="//db:simplesect[@xml:id='sec-p13']/../db:info/db:title"/>
chapter-06,page_18:<xsl:value-of select="//db:simplesect[@xml:id='sec-p18']/../db:info/db:title"/>
chapter-07,page_20:<xsl:value-of select="//db:simplesect[@xml:id='sec-p20']/../db:info/db:title"/>
chapter-08,page_22:<xsl:value-of select="//db:simplesect[@xml:id='sec-p22']/../db:info/db:title"/>
chapter-09,page_25:<xsl:value-of select="//db:simplesect[@xml:id='sec-p25']/../db:info/db:title"/>
chapter-10,page_26:<xsl:value-of select="//db:simplesect[@xml:id='sec-p26']/../db:info/db:title"/>
chapter-11,page_30:<xsl:value-of select="//db:simplesect[@xml:id='sec-p30']/../db:info/db:title"/>
chapter-12,page_36:<xsl:value-of select="//db:simplesect[@xml:id='sec-p36']/../db:info/db:title"/>
chapter-13,page_39:<xsl:value-of select="//db:simplesect[@xml:id='sec-p39']/../db:info/db:title"/>
chapter-14,page_42:<xsl:value-of select="//db:simplesect[@xml:id='sec-p42']/../db:info/db:title"/>
chapter-15,page_44:<xsl:value-of select="//db:simplesect[@xml:id='sec-p44']/../db:info/db:title"/>
chapter-16,page_48:<xsl:value-of select="//db:simplesect[@xml:id='sec-p48']/../db:info/db:title"/>
chapter-17,page_50:<xsl:value-of select="//db:simplesect[@xml:id='sec-p50']/../db:info/db:title"/>
chapter-18,page_52:<xsl:value-of select="//db:simplesect[@xml:id='sec-p52']/../db:info/db:titleabbrev"/>
chapter-19,page_53:<xsl:value-of select="//db:simplesect[@xml:id='sec-p53']/../db:info/db:titleabbrev"/>
chapter-20,page_54:<xsl:value-of select="//db:simplesect[@xml:id='sec-p54a']/../db:info/db:title"/>
chapter-21,page_55:<!-- TODO -->
chapter-22,back_cover:<!-- TODO -->
]]

[[I:cover
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-a00']/db:alt"/>
]]

** 1 **

[[I:ada-p01
<xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p01-titleonly']/db:alt"/>
]]

<xsl:value-of select="//db:simplesect[@xml:id='sec-p03']/db:literallayout[1]"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="//db:para[@xml:id='title-titlepage']"/>
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="//db:book/db:info/db:subtitle"/>

## 2 ##

<xsl:value-of select="//db:simplesect[@xml:id='sec-p02']/db:literallayout"/>

## 2BB ##

<xsl:value-of select="//db:simplesect[@xml:id='sec-p02bb']/db:literallayout"/>

** 3 **
=== Slide 1

[[I:ada-p03
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-cover']/db:alt"/>
]]
<xsl:value-of select="//db:simplesect[@xml:id='sec-p03']/db:literallayout[1]"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="//db:para[@xml:id='title-titlepage']"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="//db:book/db:info/db:subtitle"/>

## 4 ##
==== Slide 2
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p04']/db:para[1])"/>
[[I:ada-p04
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p04']/db:alt"/>
]]

** 5 **

[[I:ada-p05
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p05']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p05']/db:para[1])"/>

## 6 ##
==== Slide 3
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p06']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p06']/db:para[2])"/>

** 7 **

[[I:ada-p07
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p07']/db:alt"/>
]]

## 8 ##
==== Slide 4
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p08']/db:para[1])"/>

[[I:ada-p08b
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p08b']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p08']/db:para[2])"/>
[[I:ada-p08a
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p08a']/db:alt"/>
]]

** 9 **

[[I:ada-p09
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p09']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p09']/db:para[1])"/>
==== Slide 5
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p09']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p09']/db:para[3])"/>

## 10 ##
==== Slide 6
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p10']/db:para[1])"/>

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p10']/db:para[2])"/>
[[I:ada-p10
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p10']/db:alt"/>
]]

** 11 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p11']/db:para[1])"/>

[[I:ada-p11
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p11']/db:alt"/>
]]

## 12 ##
==== Slide 7
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p12']/db:para[1])"/>
[[I:ada-p12
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p12']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p12']/db:para[2])"/>

** 13 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p13']/db:para[1])"/>
[[I:ada-p13
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p13']/db:alt"/>
]]

## 14 ##

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p14']/db:para[1])"/>
==== Slide 8
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p14']/db:para[2])"/>
[[I:ada-p14
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p14']/db:alt"/>
]]

** 15 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p15']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p15']/db:para[2])"/>
[[I:ada-p15
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p15']/db:alt"/>
]]

## 16 ##
==== Slide 9
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p16']/db:para[1])"/>
[[I:ada-p16
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p16']/db:alt"/>
]]

** 17 **

[[I:ada-p17
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p17']/db:alt"/>
]]

## 18 ##
==== Slide 10
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p18']/db:para[1])"/>
[[I:ada-p18
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p18']/db:alt"/>
]]

** 19 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p19']/db:para[1])"/>

[[I:ada-p19
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p19']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p19']/db:para[2])"/>

## 20 ##
==== Slide 11
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p20']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p20']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p20']/db:para[3])"/>

** 21 **

[[I:ada-p21
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p21']/db:alt"/>
]]

## 22 ##
==== Slide 12
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p22']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p22']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p22']/db:para[3])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p22']/db:para[4])"/>

** 23 **

[[I:ada-p23
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p23']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p23']/db:para[1])"/>

## 24 ##

[[I:ada-p24
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p24']/db:alt"/>
]]

** 25 **
==== Slide 13
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p25']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p25']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p25']/db:para[3])"/>

## 26 ##
==== Slide 14
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p26']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p26']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p26']/db:para[3])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p26']/db:para[4])"/>

** 27 **

[[I:ada-p27
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p27']/db:alt"/>
]]

## 28 ##
==== Slide 15
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p28']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p28']/db:para[2])"/>
[[I:ada-p28
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p28']/db:alt"/>
]]

** 29 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p29']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p29']/db:para[2])"/>
[[I:ada-p29
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p29']/db:alt"/>
]]

## 30 ##
==== Slide 16
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p30']/db:para[1])"/>
==== Slide 17
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p30']/db:para[2])"/>
[[I:ada-p30
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p30']/db:alt"/>
]]

** 31 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p31']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p31']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p31']/db:para[3])"/>
[[I:ada-p31
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p31']/db:alt"/>
]]

## 32 ##

[[I:ada-p32
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p32']/db:alt"/>
]]

** 33 **

[[I:ada-p33
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p33']/db:alt"/>
]]

## 34 ##

[[I:ada-p34
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p34']/db:alt"/>
]]

** 35 **
==== Slide 18
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p35']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p35']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p35']/db:para[3])"/>

## 36 ##
==== Slide 19
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p36']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p36']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p36']/db:para[3])"/>

** 37 **

[[I:ada-p37
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p37']/db:alt"/>
]]

## 38 ##
==== Slide 20
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p38']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p38']/db:para[2])"/>
[[I:ada-p38
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p38']/db:alt"/>
]]

** 39 **
==== Slide 21
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p39']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p39']/db:para[2])"/>
[[I:ada-p39
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p39']/db:alt"/>
]]

## 40 ##

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p40']/db:para[1])"/>
[[I:ada-p40-41
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p40-41']/db:alt"/>
]]

	## BIG SIGN: "<xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p40-41']/db:info/az:excerpt[1]"/>"

** 41 **

[[I:ada-p40
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p40']/db:alt"/>
]]
[[I:ada-p41
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p41']/db:alt"/>
]]
	## TEACHER SIGN: "<xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p41']/db:info/az:excerpt[1]"/>"

	## MEDIUM SIGN: "<xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p41']/db:info/az:excerpt[2]"/>"

## 42 ##

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p42']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p42']/db:para[2])"/>
==== Slide 22
[[I:ada-p42
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p42']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p42']/db:para[3])"/>

** 43 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p43']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p43']/db:para[2])"/>
[[I:ada-p43
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p43']/db:alt"/>
]]

## 44 ##

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p44']/db:para[1])"/>

[[I:ada-p44
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p44']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p44']/db:para[2])"/>
==== Slide 23
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p44']/db:para[3])"/>

** 45 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p45']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p45']/db:para[2])"/>
[[I:ada-p45
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p45']/db:alt"/>
]]

## 46 ##
==== Slide 24
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p46']/db:para[1])"/>
[[I:ada-p46
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p46']/db:alt"/>
]]

** 47 **

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p47']/db:para[1])"/>
[[I:ada-p47
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p47']/db:alt"/>
]]

## 48 ##
==== Slide 25
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p48']/db:para[1])"/>
[[I:ada-p48
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p48']/db:alt"/>
]]
===== Slide 26
** 49 **

[[I:ada-p49
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p49']/db:alt"/>
]]

## 50 ##

<xsl:value-of select="//db:title[@xml:id='title-acknowledgments']"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p50']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p50']/db:para[2])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p50']/db:para[3])"/>

** 51 **

[[I:ada-p51
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p51']/db:alt"/>
]]

## 52 ##

<xsl:value-of select="//db:simplesect[@xml:id='sec-p52']/../db:info/db:title"/>
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="//db:simplesect[@xml:id='sec-p52']/../db:info/db:subtitle"/>

[[I:ada-p52
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p52']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p52']/db:para[1])"/>

** 53 **

<xsl:value-of select="//db:simplesect[@xml:id='sec-p53']/../db:info/db:title"/>
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="//db:simplesect[@xml:id='sec-p53']/../db:info/db:subtitle"/>

[[I:ada-p53
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p53']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p53']/db:para[1])"/>

## 54 ##

<xsl:value-of select="//db:title[@xml:id='title-bookswebsite']"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p54a']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p54a']/db:para[2])"/>

** 55 **

<xsl:value-of select="//db:title[@xml:id='title-license']"/>

<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p54b']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p54b']/db:para[2])"/>

## 56 ##

[[I:ada-p56
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p55']/db:alt"/>
]]
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-p55']/db:literallayout)"/>

** 57 **

[[I:ada-p57
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-ada-p56']/db:alt"/>
]]

## 58 ##

** 59 **

## 60 ##

[[I:back_cover-a
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-back_cover-a']/db:alt"/>
]]

<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-back-cover']/db:para[1])"/>
<xsl:text>&#xa;&#xa;</xsl:text>
<xsl:value-of select="normalize-space(//db:simplesect[@xml:id='sec-back-cover']/db:para[2])"/>

[[I:back_cover-b
IMAGE: <xsl:value-of select="//db:mediaobject[@xml:id='img-back_cover-b']/db:alt"/>
]]
</xsl:template>
</xsl:stylesheet>
