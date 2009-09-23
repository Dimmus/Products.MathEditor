<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:mml="http://www.w3.org/1998/Math/MathML">

  <!-- Defaults for the editor. -->
  <xsl:param name="equation" select="not(parent::*[local-name()='equation'])"/>
  <xsl:param name="meannotation" select="''"/>
  <xsl:param name="forallequation" select="0" />
  <xsl:param name="vectornotation" select="''"/><!-- '' 'overbar' 'rightarrow' -->
  <xsl:param name="andornotation" select="''"/><!-- '' 'text' 'statlogicnotation' 'dsplogicnotation' -->
  <xsl:param name="realimaginarynotation" select="''"/><!-- '' 'text' -->
  <xsl:param name="scalarproductnotation" select="''"/><!-- TODO: stopped here -->
  <xsl:param name="vectorproductnotation" select="''"/>

  <xsl:param name="conjugatenotation" select="''" />
  <xsl:param name="curlnotation" select="''"/>
  <xsl:param name="gradnotation" select="''"/>
  <xsl:param name="remaindernotation" select="''"/>
  <xsl:param name="complementnotation" select="''"/>

<!-- The following few templates were xsl:apply-imports in cnxmathmlc2p.xsl -->

  <!--apply/forall formatting change with parameter -->
  <xsl:template match="m:apply[child::*[position()=1 and
    local-name()='forall' and $forallequation]]">
  <m:mrow>
    <xsl:apply-templates select="child::*[local-name()='ci' or local-name()='apply'or local-name()='cn' or local-name()='mo']"/>
    <m:mo><xsl:text disable-output-escaping="yes">&#x00A0;<!-- nbsp -->&#x00A0;<!-- nbsp --></xsl:text></m:mo>
    <m:mo><xsl:text disable-output-escaping="yes">&#x002C;<!-- comma --></xsl:text></m:mo>
    <m:mo><xsl:text
        disable-output-escaping="yes">&#x00A0;<!-- nbsp -->&#x00A0;<!-- nbsp --></xsl:text></m:mo>
    <xsl:for-each select="child::*[local-name()='condition']">  
      <xsl:apply-templates/>
      <m:mo><xsl:text disable-output-escaping="yes">&#x00A0;<!-- nbsp -->&#x00A0;<!-- nbsp --></xsl:text></m:mo>
    </xsl:for-each>
  </m:mrow>
  </xsl:template>
  <!-- Mean Notation choice -->
  <xsl:template match="m:apply[child::*[position()=1 and local-name()='mean' and $meannotation='anglebracket']]">
  <xsl:choose>
    <xsl:when test="count(*)&gt;2"> 
      <mo><xsl:text disable-output-escaping="yes">&#x2329;<!-- lang --></xsl:text></mo>
      <xsl:for-each select="*[position()!=1 and position()!=last()]">
        <xsl:apply-templates select="."/><mo>,</mo>
      </xsl:for-each>
      <xsl:apply-templates select="*[position()=last()]"/>
      <mo><xsl:text disable-output-escaping="yes">&#x232A;<!-- rang --></xsl:text></mo> 
    </xsl:when>
    <xsl:otherwise>
      <mo><xsl:text disable-output-escaping="yes">&#x2329;<!-- lang --></xsl:text></mo>
        <xsl:apply-templates select="*[position()=last()]"/>
      <mo><xsl:text disable-output-escaping="yes">&#x232A;<!-- rang --></xsl:text></mo> 
    </xsl:otherwise>
  </xsl:choose>
  </xsl:template>
  <!-- scalar product = A x B x cos(teta) -->
  <xsl:template match="m:apply[child::*[position()=1 and
    local-name()='scalarproduct' and $scalarproductnotation='dotnotation']]">
  <m:mrow>
    <xsl:apply-templates select="*[position()=2]"/>
    <m:mo>&#x00A0;<!-- nbsp -->&#x00B7;<!-- middot -->&#x00A0;<!-- nbsp --></m:mo>
    <xsl:apply-templates select="*[position()=3]"/>
  </m:mrow>
  </xsl:template> 
  <!-- Conjugate Notation -->
  <xsl:template match="m:apply[child::*[position()=1 and
    local-name()='conjugate' and $conjugatenotation='engineeringnotation']]">
  <m:msup>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <m:mo><xsl:text disable-output-escaping="yes">&#x002A;<!-- ast --></xsl:text></m:mo> 
  </m:msup>
  </xsl:template>
  <!-- Gradient and Curl Notation -->
  <xsl:template match="m:apply[child::*[position()=1 and
    local-name()='grad' and $gradnotation='symbolicnotation']]">
  <m:mrow>
    <m:mo>&#x2207;<!-- nabla --></m:mo>
    <xsl:choose>
      <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
        <mfenced separators=" ">
    <xsl:apply-templates select="child::*[position()=2]"/>
        </mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="child::*[position()=2]"/>
      </xsl:otherwise>
    </xsl:choose>
  </m:mrow>
  </xsl:template>
  <!-- Curl notation -->
  <xsl:template match="m:apply[child::*[position()=1 and
    local-name()='curl' and $curlnotation='symbolicnotation']]">
  <m:mrow>
    <m:mo>&#x2207;<!-- nabla --></m:mo>
    <m:mo>&#x00D7;<!-- times --></m:mo>
    <xsl:choose>
      <xsl:when test="local-name(*[position()=2])='apply' or ((local-name(*[position()=2])='ci' or local-name(*[position()=2])='cn') and contains(*[position()=2]/text(),'-'))">
        <mfenced separators=" ">
    <xsl:apply-templates select="child::*[position()=2]"/>
        </mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="child::*[position()=2]"/>

      </xsl:otherwise>
    </xsl:choose>
  </m:mrow>
  </xsl:template>
  <!-- Remainder Notation -->
  <xsl:template match="m:apply[child::*[position()=1 and
    local-name()='rem' and $remaindernotation='remainder_anglebracket']]">
  <m:mrow>
    <m:msub>
      <m:mrow>
        <m:mo>&#x2329;<!-- lang --></m:mo>
        <xsl:apply-templates select="child::*[position()=2]"/>
        <m:mo>&#x232A;<!-- rang --></m:mo>
      </m:mrow>
      <xsl:apply-templates select="child::*[position()=3]"/>
    </m:msub>
  </m:mrow>
  </xsl:template>



<!--
  This is added to fix the "a & b => c" bug which should add parentheses around "b => c".
  Note: I swapped the order of precedence from the original c2p XSLT.
  https://trac.rhaptos.org/trac/rhaptos/ticket/8045
  
  Also, mml:implies and mml:minus did not add parentheses around nested implies
  which should also be fixed.
  
  - Phil Schatz
-->

  <!-- 4.4.3.5  minus-->
  <!-- mml:minus is NOT associative, so pass an extra param to "binary"
-->
  <xsl:template match="mml:apply[*[1][self::mml:minus] and count(*)&gt;2]">
    <xsl:param name="p" select="0"/>
    <xsl:call-template name="binary">
      <xsl:with-param name="mo"><mml:mo>&#8722;<!--minus--></mml:mo></xsl:with-param>
      <xsl:with-param name="p" select="$p"/>
      <xsl:with-param name="this-p" select="2.1"/>
      <xsl:with-param name="associative" select="'none'"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Custom "implies" -->
  <xsl:template match="mml:apply[*[1][self::mml:implies]]">
    <xsl:param name="p" select="0" />
    <xsl:call-template name="binary">
      <xsl:with-param name="mo">
        <mml:mo>&#8658;<!-- Rightarrow --></mml:mo>
      </xsl:with-param>
      <xsl:with-param name="p" select="$p" />
      <xsl:with-param name="this-p" select="1.5" />
      <xsl:with-param name="associative" select="'right'"/>
    </xsl:call-template>
  </xsl:template>

  <!-- mml:implies and mml:minus are NOT associative, so we need to add parentheses
-->
  <xsl:template name="binary" >
    <xsl:param name="mo"/>
    <xsl:param name="p" select="0"/>
    <xsl:param name="this-p" select="0"/>
    <xsl:param name="associative"  select="''"/><!-- can be: '' (both), 'none', or TODO 'left', 'right'
-->
    <xsl:variable name="parent-op" select="local-name(../mml:*[1])"/>
    <xsl:variable name="assoc-parens" select="$this-p &lt; $p or ($associative='none' and $parent-op = local-name(mml:*[1])) or ($associative='left' and $parent-op = local-name(mml:*[1]) and not(following-sibling::*[position()=1])) or ($associative='right' and $parent-op = local-name(mml:*[1]) and (../*[1] = preceding-sibling::*[position()=1]))"/>
    <mml:mrow>
    <xsl:if test="$this-p &lt; $p or $assoc-parens"><mml:mo>(</mml:mo></xsl:if>
     <xsl:apply-templates select="*[2]">
       <xsl:with-param name="p" select="$this-p"/>
     </xsl:apply-templates>
     <xsl:copy-of select="$mo"/>
     <xsl:apply-templates select="*[3]">
       <xsl:with-param name="p" select="$this-p"/>
     </xsl:apply-templates>
    <xsl:if test="$this-p &lt; $p or $assoc-parens"><mml:mo>)</mml:mo></xsl:if>
    </mml:mrow>
  </xsl:template>


  <!-- Custom "and" -->
  <xsl:template match="m:apply[*[1][self::m:and]]">
    <xsl:param name="p" select="0" />
    <xsl:variable name="separator">
    <xsl:choose>
        <xsl:when test="$andornotation = 'text'"> and </xsl:when>
        <xsl:when test="$andornotation = 'statlogicnotation'">&amp;</xsl:when>
        <xsl:when test="$andornotation = 'dsplogicnotation'">·<!-- TODO Middle dot entity --></xsl:when>
        <xsl:otherwise>&#8743;<!-- and --></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>              
    <xsl:call-template name="infix">
      <xsl:with-param name="this-p" select="3" />
      <xsl:with-param name="p" select="$p" />
      <xsl:with-param name="mo">
        <mml:mspace width=".3em"/><m:mo><xsl:value-of select="$separator"/></m:mo><mml:mspace width=".3em"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Custom "or" -->
  <xsl:template match="m:apply[*[1][self::m:or]]">
    <xsl:param name="p" select="0" />
    <xsl:variable name="separator">
    <xsl:choose>
        <xsl:when test="$andornotation = 'text'"> or </xsl:when>
        <xsl:when test="$andornotation = 'statlogicnotation'">|</xsl:when>
        <xsl:when test="$andornotation = 'dsplogicnotation'">+</xsl:when>
        <xsl:otherwise>&#8744;<!-- or --></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>              
    <xsl:call-template name="infix">
      <xsl:with-param name="this-p" select="2" />
      <xsl:with-param name="p" select="$p" />
      <xsl:with-param name="mo">
        <mml:mspace width=".3em"/><m:mo><xsl:value-of select="$separator"/></m:mo><mml:mspace width=".3em"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Use the character instead of relying on @mathvariant -->
  <!-- 4.4.12.1 integers -->
  <xsl:template match="mml:integers">
    <mml:mi>&#x2124;</mml:mi><!-- <mml:mi mathvariant="double-struck">Z</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.2 reals -->
  <xsl:template match="mml:reals">
    <mml:mi>&#x211D;</mml:mi><!-- <mml:mi mathvariant="double-struck">R</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.3 rationals -->
  <xsl:template match="mml:rationals">
    <mml:mi>&#x211A;</mml:mi><!-- <mml:mi mathvariant="double-struck">Q</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.4 naturalnumbers -->
  <xsl:template match="mml:naturalnumbers">
    <mml:mi>&#x2115;</mml:mi><!-- <mml:mi mathvariant="double-struck">N</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.5 complexes -->
  <xsl:template match="mml:complexes">
    <mml:mi>&#x2102;</mml:mi><!-- <mml:mi mathvariant="double-struck">C</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.6 primes -->
  <xsl:template match="mml:primes">
    <mml:mi>&#x2119;</mml:mi><!-- <mml:mi mathvariant="double-struck">P</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.7 exponentiale -->
  <xsl:template match="mml:exponentiale">
    <mml:mi>&#8519;<!--e exponential e--></mml:mi>
  </xsl:template>

  <!-- 4.4.3.4 max  min-->
  <!-- The original definition of mml:min used "max" in the text -->
  <xsl:template match="mml:apply[*[1][self::mml:max]]">
  <xsl:variable name="name">max</xsl:variable>
  <mml:mrow>
    <xsl:choose>
      <xsl:when test="mml:bvar and not(mml:condition)">
        <mml:msub>
          <mml:mo><xsl:value-of select="$name"/></mml:mo>
          <mml:mrow><xsl:apply-templates select="mml:bvar"/></mml:mrow>
        </mml:msub>
        <xsl:call-template name="set">
          <xsl:with-param name="children" select="*[position()&gt;1 and not(self::mml:bvar)]"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <mml:mo><xsl:value-of select="$name"/></mml:mo>
        <xsl:call-template name="set">
          <xsl:with-param name="children" select="*[position()&gt;1]"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </mml:mrow>
  </xsl:template>

  <xsl:template match="mml:apply[*[1][self::mml:min]]">
  <xsl:variable name="name">min</xsl:variable>
  <mml:mrow>
    <xsl:choose>
      <xsl:when test="mml:bvar and not(mml:condition)">
        <mml:msub>
          <mml:mo><xsl:value-of select="$name"/></mml:mo>
          <mml:mrow><xsl:apply-templates select="mml:bvar"/></mml:mrow>
        </mml:msub>
        <xsl:call-template name="set">
          <xsl:with-param name="children" select="*[position()&gt;1 and not(self::mml:bvar)]"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <mml:mo><xsl:value-of select="$name"/></mml:mo>
        <xsl:call-template name="set">
          <xsl:with-param name="children" select="*[position()&gt;1]"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </mml:mrow>
  </xsl:template>





  <!-- Need the other logic templates so parentheses are rendered -->
<!-- 4.4.3.14 xor -->
<xsl:template match="mml:apply[*[1][self::mml:xor]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="3"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8853;<!--xor--></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>
<!-- 4.4.3.15 not -->
<xsl:template match="mml:apply[*[1][self::mml:not]]">
<mml:mrow>
<mml:mo>&#172;<!-- not --></mml:mo>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
</mml:mrow>
</xsl:template>
<!-- ****************************** -->
<xsl:template name="infix" >
  <xsl:param name="mo"/>
  <xsl:param name="p" select="0"/>
  <xsl:param name="this-p" select="0"/>
  <mml:mrow>
  <xsl:if test="$this-p &lt; $p"><mml:mo>(</mml:mo></xsl:if>
  <xsl:for-each select="*[position()&gt;1]">
   <xsl:if test="position() &gt; 1">
    <xsl:copy-of select="$mo"/>
   </xsl:if>   
   <xsl:apply-templates select=".">
     <xsl:with-param name="p" select="$this-p"/>
   </xsl:apply-templates>
  </xsl:for-each>
  <xsl:if test="$this-p &lt; $p"><mml:mo>)</mml:mo></xsl:if>
  </mml:mrow>
</xsl:template>
<!-- "set" is taken from math-editor.xsl -->
<!-- Added custom "xsl:where" so the 1st child of a mml:apply isn't rendered. -->
  <xsl:template name="set" >
    <xsl:param name="o" select="'{'"/>
    <xsl:param name="c" select="'}'"/>
    <xsl:param name="children" select="*"/>
    <mml:mrow>
     <mml:mo><xsl:value-of select="$o"/></mml:mo>
     <xsl:choose>
     <xsl:when test="mml:condition">
     <mml:mrow><xsl:apply-templates select="mml:bvar/*[not(self::bvar or self::condition)]"/></mml:mrow>
     <mml:mo>|</mml:mo>
     <mml:mrow><xsl:apply-templates select="mml:condition/node()"/></mml:mrow>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="$children">
        <xsl:apply-templates select="."/>
        <xsl:if test="position() !=last()"><mml:mo>,</mml:mo></xsl:if>
      </xsl:for-each>
     </xsl:otherwise>
     </xsl:choose>
     <mml:mo><xsl:value-of select="$c"/></mml:mo>
    </mml:mrow>
  </xsl:template>
    

<!-- When mml:degree isn't in the correct position, this breaks -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='root']]">
  <xsl:choose>
  <xsl:when test="m:degree">
    <xsl:choose>
    <xsl:when test="m:degree/m:cn/text()='2'"> <!--if degree=2 display
    a standard square root-->
      <m:msqrt>
        <xsl:apply-templates select="child::*[position()>1 and local-name()!='degree']"/>
        </m:msqrt>
    </xsl:when>
    <xsl:otherwise>
      <m:mroot>
        <xsl:apply-templates select="child::*[position()>1 and local-name()!='degree']"/>
        <m:mrow><xsl:apply-templates select="m:degree/*"/></m:mrow>
      </m:mroot>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:otherwise> <!-- no degree specified-->
    <m:msqrt>
      <xsl:apply-templates select="child::*[position()=2]"/>
    </m:msqrt>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

  <!-- Always force multiline equals when there is more than 1 eq -->
  <xsl:template match="m:apply[child::*[position()=1 and local-name()='eq']]">
    <xsl:choose>
      <xsl:when test="count(child::*)&gt;3">
  <m:mtable align="center" columnalign="right center left">
    <m:mtr>
      <m:mtd columnalign="right">
        <m:mrow><xsl:apply-templates select="child::*[position()=2]"/></m:mrow>
      </m:mtd>
      <m:mtd columnalign="center"><m:mo>=</m:mo></m:mtd>
      <m:mtd columnalign="left">
        <m:mrow><xsl:apply-templates select="child::*[position()=3]"/></m:mrow>
      </m:mtd>
    </m:mtr>
    <xsl:for-each select="child::*[position()&gt;3]">
      <m:mtr>
        <m:mtd columnalign="right"/>
        <m:mtd columnalign="center"><m:mo>=</m:mo></m:mtd>
        <m:mtd columnalign="left">
    <m:mrow><xsl:apply-templates select="."/></m:mrow>
        </m:mtd>
      </m:mtr>
    </xsl:for-each>
  </m:mtable>
      </xsl:when>
      <xsl:otherwise>
  <m:mrow><xsl:apply-templates select="child::*[position()=2]"/></m:mrow>
        <m:mrow><m:mo>=</m:mo></m:mrow>
        <m:mrow><xsl:apply-templates select="child::*[position()=last()]"/></m:mrow>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


<!-- 4.4.3.17 forall -->
<!-- Allow the mml:bvar template to add commas if appropriate (changed the @select) -->
<xsl:template match="mml:apply[*[1][self::mml:forall]]">
 <mml:mrow>
  <xsl:choose>
  	<xsl:when test="mml:bvar and mml:condition">
  		<mml:msub>
  			<mml:mi>&#8704;<!--forall--></mml:mi>
  			<mml:mrow>
  				<xsl:apply-templates select="mml:bvar"/>
  			</mml:mrow>
  		</mml:msub>
  	</xsl:when>
  	<xsl:otherwise>
  		<mml:mi>&#8704;<!--forall--></mml:mi>
  	</xsl:otherwise>
  </xsl:choose>
 <mml:mrow><xsl:apply-templates select="mml:bvar[not(current()/mml:condition)]|mml:condition/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates select="*[last()]"/>
 </mml:mfenced>
</mml:mrow>
</xsl:template>

<!-- 4.4.3.18 exists -->
<!-- Allow the mml:bvar template to add commas if appropriate (changed the @select) -->
<xsl:template match="mml:apply[*[1][self::mml:exists]]">
 <mml:mrow>
  <xsl:choose>
  	<xsl:when test="mml:bvar and mml:condition">
  		<mml:msub>
  			<mml:mi>&#8707;<!--exists--></mml:mi>
  			<mml:mrow>
  				<xsl:apply-templates select="mml:bvar"/>
  			</mml:mrow>
  		</mml:msub>
  	</xsl:when>
  	<xsl:otherwise>
		<mml:mi>&#8707;<!--exists--></mml:mi>
  	</xsl:otherwise>
  </xsl:choose>
 <mml:mrow><xsl:apply-templates select="mml:bvar[not(current()/mml:condition)]|mml:condition/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates select="*[last()]"/>
 </mml:mfenced>
</mml:mrow>
</xsl:template>

</xsl:stylesheet>