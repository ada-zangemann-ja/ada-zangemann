<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# DocBook

Part of the [automation design](automation-design.md) is implemented using the DocBook standard. This section describes the details how the DocBook standard is used and what automation is in place.

## Two colophon variants

The docbook process supports two colophon variants.
The 'colophon-fullpage' is intended for print which typically needs to contain more information.
The 'colophon-halfpage' is intended for the digital edition where less details are included.
This halfpage colophon is combined with a grey box about free culture licenses.

## Schema summary

A brief overview of the Docbook elements and custom attributes used in the source format. Most elements are closed elements without content to just show the structure.

```xml
<?xml version="1.0" encoding="utf-8"?>
<book
   xmlns="http://docbook.org/ns/docbook" version="5.0"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:its="http://www.w3.org/2005/11/its" its:version="2.0"
   xmlns:itst="http://itstool.org/extensions/"
   xmlns:az="https://git.fsfe.org/FSFE/ada-zangemann/"
   xml:lang="en"
   az:datamodelversion="0.1.0-alpha"
   dir="ltr">
  <its:rules version="2.0"/>
  <info>
    <title/>
    <subtitle/>
    <biblioid class="isbn" role="print"/>
    <biblioid class="isbn" role="ebook"/>
    <author>
      <personname/>
    </author>
    <copyright/>
    <legalnotice/>
    <author/>
    <othercredit class="illustrator"/>
    <othercredit class="translator"/> <!-- or proofreader, reviewer -->
    <az:namedcharacters>
      <az:character role="ada"> <!-- and other characters -->
        <az:charactername>Ada</az:charactername>
      </az:character>
    </az:namedcharacters>
    <cover role="front"/> <!-- and back -->
      <bridgehead role="title"/>
  </info>
  <preface role="half-title-page"/>
  <colophon>
    <literallayout condition="colophon-halfpage"/>
    <literallayout condition="colophon-fullpage"/>
  </colophon>
  <chapter xml:id="ch1">
    <info>
      <title/>
    </info>
    <simplesect xml:id="sec-p04" az:pagenum="4">
      <anchor az:slidenum="2"/>
      <para xml:id="para-p04-1"
         az:dropcap="true"
         az:dropcapcharacter="O"
         az:dropcapfileref="images/capitals/O-cyan.png"
         az:dropcapcolor="#5cb2d4"
         az:dropcapbackgroundcolor="#ffffff"
         az:dropcapheightpt="50.56"
         az:dropcapwidthpt="42.72"
         az:dropcaplocalsc="0.16"
         az:dropcapscribuscharstyle="Capital Cyan">
        <phrase condition="capitals-text">Once</phrase>
        <phrase condition="capitals-img">nce</phrase>
        upon a time, there was a little girl named Ada.
        <emphasis role="bold"/>
        <link xlink:href="https://ada.fsfe.org">https://ada.fsfe.org</link>
      </para>
      <mediaobject xml:id="img-ada-p04">
        <imageobject>
          <imageobject condition="print">
            <imagedata fileref="images/illustrations/ada-p04.ltr.png"/>
          </imageobject>
        </imageobject>
        <alt/>
      </mediaobject>
    </simplesect>
  </chapter>
  <appendix xml:id="ch17"/>
    <info>
      <title/>
      <subtitle/>
      <titleabbrev/>
    </info>
</book>
```
