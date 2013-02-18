<?xml version="1.0" encoding="iso-8859-1"?>
<!--
dblatex(1) XSL user stylesheet for asciidoc(1).
See dblatex(1) -p option.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- TOC links in the titles, and in blue.
  <xsl:param name="latex.hyperparam">colorlinks,linkcolor=black,pdfstartview=FitH</xsl:param>
  -->

  <xsl:param name="doc.publisher.show">0</xsl:param>
  <xsl:param name="doc.lot.show">figure,table</xsl:param>
  <xsl:param name="term.breakline">1</xsl:param>
  <xsl:param name="doc.collab.show">1</xsl:param>
  <xsl:param name="doc.section.depth">3</xsl:param>
  <xsl:param name="table.in.float">0</xsl:param>
  <xsl:param name="monoseq.hyphenation">0</xsl:param>
  <xsl:param name="latex.output.revhistory">1</xsl:param>
  <xsl:param name="doc.toc.show">1</xsl:param>
  
  <!-- { -->
  <xsl:param name="figure.note">images/icons/note.ps</xsl:param>

  <xsl:param name="latex.output.revhistory">1</xsl:param>
<!--
  <xsl:param name="draft.mode">yes</xsl:param>
  <xsl:param name="draft.watermark">1</xsl:param>
-->
  <xsl:param name="index.numbered">1</xsl:param>
  <xsl:param name="figure.title.top">0</xsl:param>
  <xsl:param name="imagedata.file.check">1</xsl:param>
  
  <!-- does not work
<xsl:param name="paper.type">A4</xsl:param>
<xsl:param name="body.margin.right">30mm</xsl:param>  
<xsl:param name="body.margin.bottom" select="'0.5in'"/>
<xsl:param name="body.margin.top" select="'0.5in'"/>
<xsl:param name="body.margin.left" select="'2in'"/>
<xsl:param name="body.margin.right" select="'4in'"/>
  -->
  <!-- } -->
  
  <!--
    Override default literallayout template.
    See `./dblatex/dblatex-readme.txt`.
  -->
  <xsl:template match="address|literallayout[@class!='monospaced']">
    <xsl:text>\begin{alltt}</xsl:text>
    <xsl:text>&#10;\normalfont{}&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;\end{alltt}</xsl:text>
  </xsl:template>

  <xsl:template match="processing-instruction('asciidoc-pagebreak')">
    <!-- force hard pagebreak, varies from 0(low) to 4(high) -->
    <xsl:text>\pagebreak[4] </xsl:text>
    <xsl:apply-templates />
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="processing-instruction('asciidoc-br')">
    <xsl:text>\newline&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="processing-instruction('asciidoc-hr')">
    <!-- draw a 444 pt line (centered) -->
    <xsl:text>\begin{center}&#10; </xsl:text>
    <xsl:text>\line(1,0){444}&#10; </xsl:text>
    <xsl:text>\end{center}&#10; </xsl:text>
  </xsl:template>

</xsl:stylesheet>

