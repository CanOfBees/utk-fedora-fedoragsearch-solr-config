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

  <!--
    notes:
    xmlns:islandora-exts="xalan://ca.upei.roblib.DataStreamForXSLT": invoked in text_to_solr.xslt but unused
    drop all xalan namespaces:
    xmlns:exts="xalan://dk.defxws.fedoragsearch.server.GenericOperationsImpl": invoked in text_to_solr.xslt but unused
    xmlns:encoder="xalan://java.net.URLEncoder": used to encode query URLs in traverse-graph.xslt

    drop java namespace:
    xmlns:java="http://xml.apache.org/xalan/java"
  -->
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
    <update type="test">
      <!-- ignore the foxml if foxml:datastream/@ID='methodmap' or 'ds-composite-model' -->
      <xsl:apply-templates select="foxml:digitalObject[foxml:datastream[@ID='METHODMAP' or @ID='DS-COMPOSITE-MODEL']]"/>

      <xsl:apply-templates select="foxml:digitalObject[foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#state' and @VALUE='Active'] and not(foxml:datastream[@ID='METHODMAP' or @ID='DS-COMPOSITE-MODEL'])]" mode="add-obj-to-index">
        <xsl:with-param name="PID" select="$PID"/>
      </xsl:apply-templates>
      
      <xsl:apply-templates select="foxml:digitalObject[not(foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#state' and @VALUE='Active'])]" mode="remove-obj-from-index"/>
    </update>
  </xsl:template>
  
  <!--
    <xsl:template match="foxml:digitalObject[foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#state' and @VALUE='Active'] and not(foxml:datastream[@ID='METHODMAP' or @ID='DS-COMPOSITE-MODEL'])]" mode="add-obj-to-index">
    <xsl:call-template name="get-content-for-solr">
      <xsl:with-param name="PID" select="$PID"/>
    </xsl:call-template>
    <xsl:apply-templates mode="add-obj-to-index">
      <xsl:with-param name="PID" select="$PID"/>
    </xsl:apply-templates>
  </xsl:template>
  -->
  
  <xsl:template match="foxml:digitalObject[not(foxml:objectProperties/foxml:proptery[@NAME='info:fedora/fedora-system:def/model#state' and @VALUE='Active'])]" mode="remove-obj-from-index">
    <xsl:comment>from DGI's implementation.</xsl:comment>
    <delete>
      <id><xsl:value-of select="$PID"/></id>
    </delete>
  </xsl:template>

  <!-- ignore these templates -->
  <xsl:template match="foxml:digitalObject[foxml:datastream[@ID='METHODMAP' or @ID='DS-COMPOSITE-MODEL']]"/>
  
  <xsl:template name="get-content-for-solr">
    <xsl:param name="PID" select="$PID"/>
    <add>
      <doc>
        <field name="PID"><xsl:value-of select="$PID"/></field>
        
      </doc>
    </add>
    
  </xsl:template>
</xsl:stylesheet>