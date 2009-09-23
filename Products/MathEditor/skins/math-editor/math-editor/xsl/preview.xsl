<?xml version="1.0" encoding="UTF-8"?> 
<!--
  DOCTYPE xsl:stylesheet SYSTEM "http://cnx.rice.edu/technology/mathml/schema/dtd/2.0/moz-mathml.ent"
  -->
<xsl:stylesheet version="1.0" 
    xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns="http://www.w3.org/1998/Math/MathML"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Use xsl:include because we are not overriding any templates. -->
    <xsl:import href="originals/cnxmathmlc2p.xsl"/>

    <!-- Just copy all presentation MathML -->
    <xsl:template match="mml:mi|mml:mo|mml:mrow|mml:mfrac|mml:msqrt|mml:mroot|mml:mstyle|mml:merror|mml:mpadded|mml:mphantom|mml:mfenced|mml:menclose|mml:msub|mml:msup|mml:msubsup|mml:munder|mml:mover|mml:munderover|mml:mmultiscripts|mml:mtable|mml:mlabeledtr|mml:mtr|mml:mtd|mml:maction|mml:mspace">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="*|text()"/>
      </xsl:copy>
    </xsl:template>

</xsl:stylesheet>