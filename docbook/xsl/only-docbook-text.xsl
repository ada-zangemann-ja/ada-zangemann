<?xml version="1.0" encoding="utf-8"?>

<!--
SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>

SPDX-License-Identifier: GPL-3.0-or-later
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook" db:version="5.0">

  <!-- XSLT 1.0 file to remove elements and attributes of certain namespaces -->

  <!-- Identity template to reproduce content -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Remove nodes and attributes from specific namespaces -->
  <xsl:template match="db:anchor" />
  <xsl:template match="db:mediaobject" />
  <xsl:template match="db:simplesect">
    <xsl:apply-templates select="node()"/>
  </xsl:template>
</xsl:stylesheet>
