<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:foxml="info:fedora/fedora-system:def/foxml#"
                xmlns:mods="http://www.loc.gov/mods/v3"
                exclude-result-prefixes="xsl xs foxml mods"
                version="2.0">

  <xsl:output encoding="UTF-8" method="xml"/>

  <!-- initial template -->
  <xsl:template match="foxml:datastream[@ID='MODS']/foxml:datastreamVersion[last()]"></xsl:template>

</xsl:stylesheet>