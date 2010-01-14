<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:m="http://www.w3.org/1998/Math/MathML" 
  xmlns="http://www.w3.org/1998/Math/MathML"
  >

<!-- ************************************************** 
      mathmlc2p.xsl does disable-output-escaping.
      That doesn't work with the editor since it remains escaped when rendered
     ************************************************** -->
<!-- approximately equal -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='approx']]">
  <m:mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <m:mo>&#x02248;<!-- &#x2248; or &#x2248; should work--></m:mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:mrow>
</xsl:template>
<xsl:template match="m:reln[child::*[position()=1 and local-name()='approx']]">
  <m:mrow>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <m:mo>&#x02248;<!-- &#x2248; or &#x2248; should work--></m:mo>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:mrow>
</xsl:template>
<!-- laplacian -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='laplacian']]">
<m:mrow>
  <m:msup>
    <m:mo>&#x02207;</m:mo>  <!-- Del or nabla should work-->
    <m:mn>2</m:mn>
  </m:msup>
  <xsl:choose>
  <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
    <m:mfenced separators=" ">
      <xsl:apply-templates select="child::*[position()=2]"/>
    </m:mfenced>
  </xsl:when>
  <xsl:otherwise>
    <xsl:apply-templates select="child::*[position()=2]"/>
  </xsl:otherwise>
  </xsl:choose>
</m:mrow>
</xsl:template>
<xsl:template match="m:integers">
  <m:mi>&#x2124;</m:mi>  <!-- open face Z --> <!-- UNICODE char works -->
</xsl:template>
<!-- real numbers -->
<xsl:template match="m:reals">
  <m:mi>&#x211D;</m:mi>  <!-- open face R --> <!-- UNICODE char works -->
</xsl:template>
<!-- rational numbers -->
<xsl:template match="m:rationals">
  <m:mi>&#x211A;</m:mi>  <!-- open face Q --> <!-- UNICODE char works -->
</xsl:template>
<!-- natural numbers -->
<xsl:template match="m:naturalnumbers">
  <m:mi>&#x2115;</m:mi>  <!-- open face N --> <!-- UNICODE char works -->
</xsl:template>
<!-- complex numbers -->
<xsl:template match="m:complexes">
  <m:mi>&#x2102;</m:mi>  <!-- open face C --> <!-- UNICODE char works -->
</xsl:template>
<!-- prime numbers -->
<xsl:template match="m:primes">
  <m:mi>&#x2119;</m:mi>  <!-- open face P --> <!-- UNICODE char works -->
</xsl:template>
<!-- real part of complex number -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='real']]">
  <m:mrow>
    <m:mi>&#x0211C;<!-- &#x211C; or &#x211C; should work--></m:mi>
    <m:mo><xsl:text disable-output-escaping="yes"> <!--&ApplyFunction;--></xsl:text></m:mo>
    <m:mfenced separators=" "><xsl:apply-templates select="child::*[position()=2]"/></m:mfenced>
  </m:mrow>

</xsl:template>
<!-- imaginary part of complex number -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='imaginary']]">
  <m:mrow>
    <m:mi>&#x02111;<!-- &#x2111; or &impartl should work--></m:mi>
    <m:mo><xsl:text disable-output-escaping="yes"> <!--&ApplyFunction;--></xsl:text></m:mo>
    <m:mfenced separators=" "><xsl:apply-templates select="child::*[position()=2]"/></m:mfenced>
  </m:mrow>
</xsl:template>
  

<!--mml:csymbol cannot just copy children (may not be presentation) -->
<xsl:template match="m:csymbol">
  <xsl:choose>
  <!--test if children are not all text nodes, meaning there is markup assumed to be presentation markup-->
  <!--perhaps it would be sufficient to test if there is more than one node or text node-->
  <xsl:when test="count(node()) != count(text())"> 
    <m:mrow><xsl:apply-templates select="*"/></m:mrow>
  </xsl:when>
  <xsl:otherwise>
    <m:mo><xsl:value-of select="."/></m:mo>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- Same except the "markup assumed to be presentation markup" is no longer assumed so we get things wrapped in mml:mrow's -->
<xsl:template match="m:cn">
  <xsl:choose>
  <xsl:when test="@base and (@base != '10')">  <!-- base specified and different from 10 ; if base = 10 we do not display it -->
    <m:msub>
      <m:mrow> <!-- mrow to be sure that the base is actually the element put as sub in case the number is a composed one-->
      <xsl:choose>  
      <xsl:when test="./@type='complex-cartesian' or ./@type='complex'">
        <m:mn><xsl:value-of select="text()[position()=1]"/></m:mn>
  <xsl:choose>
  <xsl:when test="contains(text()[position()=2],'-')">
    <m:mo>-</m:mo><m:mn><xsl:value-of select="substring-after(text()[position()=2],'-')"/></m:mn> 
    <!--substring-after does not seem to work well in XT : if imaginary part is expressed with at least one space char before the minus sign, then it does not work (we end up with two minus sign since the one in the text is kept)-->
  </xsl:when>
  <xsl:otherwise>
    <m:mo>+</m:mo><m:mn><xsl:value-of select="text()[position()=2]"/></m:mn>
  </xsl:otherwise>
  </xsl:choose>
  <m:mo><xsl:text disable-output-escaping="yes"> <!--&InvisibleTimes;--></xsl:text></m:mo><m:mi><xsl:value-of select="$imaginaryi"/></m:mi>
      </xsl:when>
      <xsl:when test="./@type='complex-polar'">
        <m:mrow><m:mn><xsl:value-of select="text()[position()=1]"/></m:mn><m:mo>&#x2220;</m:mo><m:mn><xsl:value-of select="text()[position()=2]"/></m:mn></m:mrow>
      </xsl:when>
      <xsl:when test="./@type='rational'">
        <m:mn><xsl:value-of select="text()[position()=1]"/></m:mn><m:mo>/</m:mo><m:mn><xsl:value-of select="text()[position()=2]"/></m:mn>
      </xsl:when>
      <xsl:otherwise>
        <m:mn><xsl:value-of select="."/></m:mn>
      </xsl:otherwise>
      </xsl:choose>
      </m:mrow>
      <m:mn><xsl:value-of select="@base"/></m:mn>
    </m:msub>
  </xsl:when>
  <xsl:otherwise>  <!-- no base specified -->
    <xsl:choose>  
    <xsl:when test="./@type='complex-cartesian' or ./@type='complex'">
      <m:mrow>
        <m:mn><xsl:value-of select="text()[position()=1]"/></m:mn>
        <xsl:choose>
        <xsl:when test="contains(text()[position()=2],'-')">
      <m:mo>-</m:mo><m:mn><xsl:value-of select="substring(text()[position()=2],2)"/></m:mn><m:mo><xsl:text disable-output-escaping="yes"> <!--&InvisibleTimes;--></xsl:text></m:mo><m:mi><xsl:value-of select="$imaginaryi"/></m:mi><!-- perhaps ii-->
        </xsl:when>
        <xsl:otherwise>
    <m:mo>+</m:mo><m:mn><xsl:value-of select="text()[position()=2]"/></m:mn><m:mo><xsl:text disable-output-escaping="yes"> <!--&InvisibleTimes;--></xsl:text></m:mo><m:mi><xsl:value-of select="$imaginaryi"/></m:mi><!-- perhaps ii-->
        </xsl:otherwise>
        </xsl:choose>
      </m:mrow>
    </xsl:when>
    <xsl:when test="./@type='complex-polar'">
      <m:mrow><m:mn><xsl:value-of select="text()[position()=1]"/></m:mn><m:mo>&#x2220;</m:mo><m:mn><xsl:value-of select="text()[position()=2]"/></m:mn></m:mrow>
    </xsl:when> 
    <xsl:when test="./@type='e-notation'">
      <m:mrow>
        <m:mn><xsl:value-of select="text()[position()=1]"/></m:mn>
  <m:mo>&#x00D7;</m:mo>
  <m:msup><m:mn>10</m:mn><m:mn><xsl:value-of select="text()[position()=2]"/></m:mn></m:msup>
      </m:mrow>
    </xsl:when>
    <xsl:when test="./@type='rational'">
      <m:mrow><m:mn><xsl:value-of select="text()[position()=1]"/></m:mn><m:mo>/</m:mo><m:mn><xsl:value-of select="text()[position()=2]"/></m:mn></m:mrow>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
      <xsl:when test="count(node()) != count(text())">
      <!--test if children are not all text nodes, meaning there is -->
<!--markup assumed to be presentation markup-->
      <m:mrow><xsl:apply-templates select="child::*"/></m:mrow>
      </xsl:when>
      <xsl:otherwise>  <!-- common case -->
      <m:mn><xsl:value-of select="."/></m:mn>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Removed ALL special cases because some contained xsl:copy -->
<xsl:template match="m:ci">
	<xsl:choose>
	    <xsl:when test="count(node()) != count(text())">
	        <!--test if children are not all text nodes, meaning there is markup assumed to be presentation markup-->
	        <m:mrow>
	            <xsl:apply-templates select="child::*"/>
	        </m:mrow>
	    </xsl:when>
	    <xsl:otherwise>
	        <!-- common case -->
	        <m:mi>
	            <xsl:value-of select="."/>
	        </m:mi>
	    </xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
