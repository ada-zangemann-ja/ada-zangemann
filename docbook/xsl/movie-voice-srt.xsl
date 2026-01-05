<?xml version="1.0" encoding="utf-8"?>

<!--
SPDX-FileCopyrightText: 2024-2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: GPL-3.0-or-later
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook" db:version="5.0" xmlns:az="https://git.fsfe.org/FSFE/ada-zangemann/" xmlns:its="http://www.w3.org/2005/11/its" xmlns:itst="http://itstool.org/extensions/" its:version="2.0">

<!-- XSLT 1.0 file to select elements with movieVoiceTimeCode and convert timecodes from sub-second frames (00:10:20:01) to decimal count (00:10:20,040). -->

<xsl:output method="text"/>

<!-- Adjust this variable if your frame rate is different -->
<xsl:variable name="frames-per-second" select="25"/>

<!-- Disable built-in templates -->
<xsl:template match="text()|@*"/>

<!-- Match elements with movieVoiceTimeCode property -->
<xsl:template match="//node()[@az:movieVoiceTimeCodeIn]">

  <!-- Extract frames (last 2 characters) -->
  <xsl:variable name="frames-in" select="substring(@az:movieVoiceTimeCodeIn, 10, 2)"/>
  <xsl:variable name="frames-out" select="substring(@az:movieVoiceTimeCodeOut, 10, 2)"/>

  <!-- Extract hh:mm:ss (first 8 characters) -->
  <xsl:variable name="hms-in" select="substring(@az:movieVoiceTimeCodeIn, 1, 8)"/>
  <xsl:variable name="hms-out" select="substring(@az:movieVoiceTimeCodeOut, 1, 8)"/>

  <!-- Convert frames to milliseconds (3 decimal places) -->
  <xsl:variable name="milliseconds-in">
    <xsl:call-template name="format-milliseconds">
      <xsl:with-param name="frames" select="$frames-in"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="milliseconds-out">
    <xsl:call-template name="format-milliseconds">
      <xsl:with-param name="frames" select="$frames-out"/>
    </xsl:call-template>
  </xsl:variable>

<xsl:number level="any" count="*[@az:movieVoiceTimeCodeIn]" /><xsl:text>
</xsl:text><xsl:value-of select="concat($hms-in, ',', $milliseconds-in)"/><xsl:text> --> </xsl:text><xsl:value-of select="concat($hms-out, ',', $milliseconds-out)"/><xsl:text>
</xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text>

</xsl:text>
</xsl:template>

<!-- Helper template to convert frames to milliseconds -->
<xsl:template name="format-milliseconds">
  <xsl:param name="frames"/>
    <xsl:variable name="ms" select="format-number(($frames div $frames-per-second) * 1000, '000')"/>
  <xsl:value-of select="$ms"/>
</xsl:template>

</xsl:stylesheet>
