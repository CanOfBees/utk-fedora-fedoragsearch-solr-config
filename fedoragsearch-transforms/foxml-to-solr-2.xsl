<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:foxml="info:fedora/fedora-system:def/foxml#"
  xmlns:rel="info:fedora/fedora-system:def/relations-external#"
  xmlns:fedora="info:fedora/fedora-system:def/relations-external#"
  xmlns:fedora-model="info:fedora/fedora-system:def/model#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
  xmlns:dwc="http://rs.tdwg.org/dwc/xsd/simpledarwincore/"
  xmlns:uvalibdesc="http://dl.lib.virginia.edu/bin/dtd/descmeta/descmeta.dtd"
  xmlns:uvalibadmin="http://dl.lib.virginia.edu/bin/admin/admin.dtd/"
  xmlns:res="http://www.w3.org/2001/sw/DataAccess/rf1/result"
  xmlns:eaccpf="urn:isbn:1-931666-33-4"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:sparql="http://www.w3.org/2001/sw/DataAccess/rf1/result"
  exclude-result-prefixes="rel mods uvalibdesc tei uvalibadmin xlink fedora-model xs oai_dc eaccpf foxml dwc fedora sparql dc rdf res"
  version="2.0">
  
  <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>
  
  <!-- params and variables -->
  <xsl:param name="REPOSITORYNAME" select="repositoryName"/>
  <xsl:param name="FEDORASOAP" select="repositoryName"/>
  <xsl:param name="FEDORAUSER" select="repositoryName"/>
  <xsl:param name="FEDORAPASS" select="repositoryName"/>
  <xsl:param name="TRUSTSTOREPATH" select="repositoryName"/>
  <xsl:param name="TRUSTSTOREPASS" select="repositoryName"/>
  
  <xsl:variable name="PROT">http</xsl:variable>
  <xsl:variable name="HOST">localhost</xsl:variable>
  <xsl:variable name="PORT">8080</xsl:variable>
  <xsl:variable name="PID" select="/foxml:digitalObject/@PID"/>
  
  <!-- includes -->
  <xsl:include href="islandora_transforms/MODS-to-solr.xsl"/>
  
  <xsl:template match="/">
    <update>
      <xsl:if test="not(foxml:digitalObject/foxml:datastream[@ID='METHODMAP' or @ID='DS-COMPOSITE-MODEL'])">
        <xsl:choose>
          <xsl:when test="foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#state' and @VALUE='Active']">
            <add>
              <xsl:apply-templates select="/foxml:digitalObject" mode="add-obj">
                <xsl:with-param name="PID" select="$PID"/>
              </xsl:apply-templates>
            </add>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="/foxml:digitalObject" mode="drop-obj"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </update>
  </xsl:template>
  
  <xsl:template match="/foxml:digitalObject" mode="add-obj">
    <xsl:param name="PID"/>
    
    <doc>
      <field name="PID"><xsl:value-of select="$PID"/></field>
      
      <xsl:apply-templates select="foxml:objectProperties/foxml:property"/>
      <xsl:apply-templates select="/foxml:digitalObject" mode="index-datastreams"/>
      
      <xsl:apply-templates select="foxml:datastream[@CONTROL_GROUP='X']/foxml:datastreamVersion[last()]">
        <xsl:with-param name="content" select="foxml:xmlContent"/>
      </xsl:apply-templates>
      
      <!-- process our MODS and DC datastreams -->
      <xsl:apply-templates select="foxml:datastream[@CONTROL_GROUP='M' and foxml:datastreamVersion[last()][@MIMETYPE = ('text/xml', 'application/xml', 'application/rdf+xml', 'text/html', 'chemical/x-cml')]]">
        <xsl:with-param 
          name="content"
          select="document(
                    concat(
                      $PROT, '://', 
                      escape-html-uri($FEDORAUSER), 
                      ':', escape-html-uri($FEDORAPASS), '@',
                      $HOST, ':', $PORT, '/fedora/objects/', $PID,
                      '/datastreams/', @ID, '/content'
                    )
                  )"/>
      </xsl:apply-templates>
      
      <!-- process non-XML files; exactly how many non-XML characters to we need to worry about in these dsids? -->
      <xsl:apply-templates select="foxml:datastream[@CONTROL_GROUP='M' and foxml:datastreamVersion[last()][not(@MIMETYPE = ('image', 'audio', 'video', 'application/pdf'))]]">
        <xsl:with-param name="content" select="normalize-space(.)"/>
      </xsl:apply-templates>
    </doc>
  </xsl:template>
  
</xsl:stylesheet>