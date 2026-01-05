<?xml version="1.0" encoding="utf-8"?>

<!--
SPDX-FileCopyrightText: 2024-2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: GPL-3.0-or-later
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook" db:version="5.0" xmlns:az="https://git.fsfe.org/FSFE/ada-zangemann/" xmlns:its="http://www.w3.org/2005/11/its" xmlns:itst="http://itstool.org/extensions/" its:version="2.0">

  <!-- XSLT 1.0 file to only select elements with movieVoiceTimeCode -->

<xsl:output method="text"/>

<!-- Disable built-in templates -->
<xsl:template match="text()|@*"/>

<!-- Match elements with movieVoiceTimeCode property -->
<xsl:template match="//node()[@az:movieVoiceTimeCodeIn]">
<xsl:number level="any" count="*[@az:movieVoiceTimeCodeIn]" /><xsl:text>
</xsl:text><xsl:value-of select="@az:movieVoiceTimeCodeIn"/><xsl:text> --> </xsl:text><xsl:value-of select="@az:movieVoiceTimeCodeOut"/><xsl:text>
</xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text>

</xsl:text>
</xsl:template>

</xsl:stylesheet>
