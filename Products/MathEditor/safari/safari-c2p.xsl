<!-- This file was manually generated from c2p.xsl because Safari doesn't like <xsl:import> -->
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:mmled="http://cnx.rice.edu/mmled"
>

<!--
$Id: ctop.xsl,v 1.3 2002/09/20 08:41:39 davidc Exp $

Copyright David Carlisle 2001, 2002.

Use and distribution of this code are permitted under the terms of the <a
href="http://www.w3.org/Consortium/Legal/copyright-software-19980720"
>W3C Software Notice and License</a>.
-->

<xsl:output method="xml" />

<xsl:template mode="c2p" match="*">
<xsl:copy>
  <xsl:copy-of select="@*"/>
  <xsl:apply-templates/>
</xsl:copy>
</xsl:template>


<!-- 4.4.1.1 cn -->

<xsl:template mode="c2p" match="mml:cn">
 <mml:mn><xsl:apply-templates/></mml:mn>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='complex-cartesian']">
  <mml:mrow>
    <mml:mn><xsl:apply-templates select="text()[1]"/></mml:mn>
    <mml:mo>+</mml:mo>
    <mml:mn><xsl:apply-templates select="text()[2]"/></mml:mn>
    <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>
    <mml:mi>i<!-- imaginary i --></mml:mi>
  </mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='rational']">
  <mml:mrow>
    <mml:mn><xsl:apply-templates select="text()[1]"/></mml:mn>
    <mml:mo>/</mml:mo>
    <mml:mn><xsl:apply-templates select="text()[2]"/></mml:mn>
  </mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='integer']">
  <xsl:choose>
  <xsl:when test="not(@base) or @base=10">
       <mml:mn><xsl:apply-templates/></mml:mn>
  </xsl:when>
  <xsl:otherwise>
  <mml:msub>
    <mml:mn><xsl:apply-templates/></mml:mn>
    <mml:mn><xsl:value-of select="@base"/></mml:mn>
  </mml:msub>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='complex-polar']">
  <mml:mrow>
    <mml:mn><xsl:apply-templates select="text()[1]"/></mml:mn>
    <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>
    <mml:msup>
    <mml:mi>e<!-- exponential e--></mml:mi>
    <mml:mrow>
     <mml:mi>i<!-- imaginary i--></mml:mi>
     <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>
     <mml:mn><xsl:apply-templates select="text()[2]"/></mml:mn>
    </mml:mrow>
    </mml:msup>
  </mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='e-notation']">
    <mml:mn><xsl:apply-templates select="text()[1]"/>E<xsl:apply-templates select="text()[2]"/></mml:mn>
</xsl:template>

<!-- 4.4.1.1 ci  -->

<xsl:template mode="c2p" match="mml:ci/text()">
 <mml:mi><xsl:value-of select="."/></mml:mi>
</xsl:template>

<xsl:template mode="c2p" match="mml:ci">
 <mml:mrow><xsl:apply-templates/></mml:mrow>
</xsl:template>

<!-- 4.4.1.2 csymbol -->

<xsl:template mode="c2p" match="mml:csymbol/text()">
 <mml:mo><xsl:apply-templates/></mml:mo>
</xsl:template>

<xsl:template mode="c2p" match="mml:csymbol">
 <mml:mrow><xsl:apply-templates/></mml:mrow>
</xsl:template>

<!-- 4.4.2.1 apply 4.4.2.2 reln -->

<xsl:template mode="c2p" match="mml:apply|mml:reln">
 <mml:mrow>
 <xsl:apply-templates select="*[1]">
  <xsl:with-param name="p" select="10"/>
 </xsl:apply-templates>
 <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>
 <mml:mfenced open="(" close=")" separators=",">
 <xsl:apply-templates select="*[position()>1]"/>
 </mml:mfenced>
 </mml:mrow>
</xsl:template>

<!-- 4.4.2.3 fn -->
<xsl:template mode="c2p" match="mml:fn">
 <mml:mrow><xsl:apply-templates/></mml:mrow>
</xsl:template>

<!-- 4.4.2.4 interval -->
<xsl:template mode="c2p" match="mml:interval[*[2]]">
 <mml:mfenced open="[" close="]"><xsl:apply-templates/></mml:mfenced>
</xsl:template>
<xsl:template mode="c2p" match="mml:interval[*[2]][@closure='open']">
 <mml:mfenced open="(" close=")"><xsl:apply-templates/></mml:mfenced>
</xsl:template>
<xsl:template mode="c2p" match="mml:interval[*[2]][@closure='open-closed']">
 <mml:mfenced open="(" close="]"><xsl:apply-templates/></mml:mfenced>
</xsl:template>
<xsl:template mode="c2p" match="mml:interval[*[2]][@closure='closed-open']">
 <mml:mfenced open="[" close=")"><xsl:apply-templates/></mml:mfenced>
</xsl:template>

<xsl:template mode="c2p" match="mml:interval">
 <mml:mfenced open="{{" close="}}"><xsl:apply-templates/></mml:mfenced>
</xsl:template>

<!-- 4.4.2.5 inverse -->

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:inverse]]">
 <mml:msup>
  <xsl:apply-templates select="*[2]"/>
  <mml:mrow><mml:mo>(</mml:mo><mml:mn>-1</mml:mn><mml:mo>)</mml:mo></mml:mrow>
 </mml:msup>
</xsl:template>

<!-- 4.4.2.6 sep -->

<!-- 4.4.2.7 condition -->
<xsl:template mode="c2p" match="mml:condition">
 <mml:mrow><xsl:apply-templates/></mml:mrow>
</xsl:template>

<!-- 4.4.2.8 declare -->
<xsl:template mode="c2p" match="mml:declare"/>

<!-- 4.4.2.9 lambda -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:lambda]]">
 <mml:mrow>
  <mml:mi>&#955;<!--lambda--></mml:mi>
 <mml:mrow><xsl:apply-templates select="mml:bvar/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates select="*[last()]"/>
 </mml:mfenced>
</mml:mrow>
</xsl:template>


<!-- 4.4.2.10 compose -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:compose]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8728;<!-- o --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>


<!-- 4.4.2.11` ident -->
<xsl:template mode="c2p" match="mml:ident">
<mml:mo>id</mml:mo>
</xsl:template>

<!-- 4.4.2.12` domain -->
<xsl:template mode="c2p" match="mml:domain">
<mml:mo>domain</mml:mo>
</xsl:template>

<!-- 4.4.2.13` codomain -->
<xsl:template mode="c2p" match="mml:codomain">
<mml:mo>codomain</mml:mo>
</xsl:template>

<!-- 4.4.2.14` image -->
<xsl:template mode="c2p" match="mml:image">
<mml:mo>image</mml:mo>
</xsl:template>

<!-- 4.4.2.15` domainofapplication -->
<xsl:template mode="c2p" match="mml:domainofapplication">
 <mml:error/>
</xsl:template>

<!-- 4.4.2.16` piecewise -->
<xsl:template mode="c2p" match="mml:piecewise">
<mml:mrow>
<mml:mo>{</mml:mo>
<mml:mtable>
 <xsl:for-each select="mml:piece|mml:otherwise">
 <mml:mtr>
 <mml:mtd><xsl:apply-templates select="*[1]"/></mml:mtd>
 <mml:mtd><mml:mtext>&#160; if &#160;</mml:mtext></mml:mtd>
 <mml:mtd><xsl:apply-templates select="*[2]"/></mml:mtd>
 </mml:mtr>
 </xsl:for-each>
</mml:mtable>
</mml:mrow>
</xsl:template>


<!-- 4.4.3.1 quotient -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:quotient]]">
<mml:mrow>
<mml:mo>&#8970;<!-- lfloor--></mml:mo>
<xsl:apply-templates select="*[2]"/>
<mml:mo>/</mml:mo>
<xsl:apply-templates select="*[3]"/>
<mml:mo>&#8971;<!-- rfloor--></mml:mo>
</mml:mrow>
</xsl:template>



<!-- 4.4.3.2 factorial -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:factorial]]">
<mml:mrow>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
<mml:mo>!</mml:mo>
</mml:mrow>
</xsl:template>


<!-- 4.4.3.3 divide -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:divide]]">
  <xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
  <xsl:with-param name="mo"><mml:mo>/</mml:mo></xsl:with-param>
  <xsl:with-param name="p" select="$p"/>
  <xsl:with-param name="this-p" select="3"/>
</xsl:call-template>
</xsl:template>


<!-- 4.4.3.4 max  min-->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:max]]">
<mml:mrow>
  <mml:mo>max</mml:mo>
  <xsl:call-template name="set"/>
</mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:min]]">
<mml:mrow>
  <mml:mo>max</mml:mo>
  <xsl:call-template name="set"/>
</mml:mrow>
</xsl:template>

<!-- 4.4.3.5  minus-->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:minus] and count(*)=2]">
<mml:mrow>
  <mml:mo>&#8722;<!--minus--></mml:mo>
  <xsl:apply-templates select="*[2]">
      <xsl:with-param name="p" select="5"/>
  </xsl:apply-templates>
</mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:minus] and count(*)&gt;2]">
  <xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
  <xsl:with-param name="mo"><mml:mo>&#8722;<!--minus--></mml:mo></xsl:with-param>
  <xsl:with-param name="p" select="$p"/>
  <xsl:with-param name="this-p" select="2"/>
</xsl:call-template>
</xsl:template>

<!-- 4.4.3.6  plus-->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:plus]]">
  <xsl:param name="p" select="0"/>
  <mml:mrow>
  <xsl:if test="$p &gt; 2"><mml:mo>(</mml:mo></xsl:if>
  <xsl:for-each select="*[position()&gt;1]">
   <xsl:if test="position() &gt; 1">
    <mml:mo>
    <xsl:choose>
      <xsl:when test="self::mml:apply[*[1][self::mml:times] and
      *[2][self::mml:apply/*[1][self::mml:minus] or self::mml:cn[not(mml:sep) and
      (number(.) &lt; 0)]]]">&#8722;<!--minus--></xsl:when>
      <xsl:otherwise>+</xsl:otherwise>
    </xsl:choose>
    </mml:mo>
   </xsl:if>   
    <xsl:choose>
      <xsl:when test="self::mml:apply[*[1][self::mml:times] and
      *[2][self::mml:cn[not(mml:sep) and (number(.) &lt;0)]]]">
     <mml:mrow>
     <mml:mn><xsl:value-of select="-(*[2])"/></mml:mn>
      <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>
     <xsl:apply-templates select=".">
     <xsl:with-param name="first" select="2"/>
     <xsl:with-param name="p" select="2"/>
   </xsl:apply-templates>
     </mml:mrow>
      </xsl:when>
      <xsl:when test="self::mml:apply[*[1][self::mml:times] and
      *[2][self::mml:apply/*[1][self::mml:minus]]]">
     <mml:mrow>
     <xsl:apply-templates select="./*[2]/*[2]"/>
     <xsl:apply-templates select=".">
     <xsl:with-param name="first" select="2"/>
     <xsl:with-param name="p" select="2"/>
   </xsl:apply-templates>
     </mml:mrow>
      </xsl:when>
      <xsl:otherwise>
     <xsl:apply-templates select=".">
     <xsl:with-param name="p" select="2"/>
   </xsl:apply-templates>
   </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
  <xsl:if test="$p &gt; 2"><mml:mo>)</mml:mo></xsl:if>
  </mml:mrow>
</xsl:template>


<!-- 4.4.3.7 power -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:power]]">
<mml:msup>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="5"/>
</xsl:apply-templates>
<xsl:apply-templates select="*[3]">
  <xsl:with-param name="p" select="5"/>
</xsl:apply-templates>
</mml:msup>
</xsl:template>

<!-- 4.4.3.8 remainder -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:rem]]">
  <xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
  <xsl:with-param name="mo"><mml:mo>mod</mml:mo></xsl:with-param>
  <xsl:with-param name="p" select="$p"/>
  <xsl:with-param name="this-p" select="3"/>
</xsl:call-template>
</xsl:template>

<!-- 4.4.3.9  times-->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:times]]" name="times">
  <xsl:param name="p" select="0"/>
  <xsl:param name="first" select="1"/>
  <mml:mrow>
  <xsl:if test="$p &gt; 3"><mml:mo>(</mml:mo></xsl:if>
  <xsl:for-each select="*[position()&gt;1]">
   <xsl:if test="position() &gt; 1">
    <mml:mo>
    <xsl:choose>
      <xsl:when test="self::mml:cn">&#215;<!-- times --></xsl:when>
      <xsl:otherwise><!--&#8290;--><!--invisible times--></xsl:otherwise>
    </xsl:choose>
    </mml:mo>
   </xsl:if> 
   <xsl:if test="position()&gt;= $first">
   <xsl:apply-templates select=".">
     <xsl:with-param name="p" select="3"/>
   </xsl:apply-templates>
   </xsl:if>
  </xsl:for-each>
  <xsl:if test="$p &gt; 3"><mml:mo>)</mml:mo></xsl:if>
  </mml:mrow>
</xsl:template>


<!-- 4.4.3.10 root -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:root] and not(mml:degree) or mml:degree=2]" priority="4">
<mml:msqrt>
<xsl:apply-templates select="*[position()&gt;1]"/>
</mml:msqrt>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:root]]">
<mml:mroot>
<xsl:apply-templates select="*[position()&gt;1 and not(self::mml:degree)]"/>
<mml:mrow><xsl:apply-templates select="mml:degree/*"/></mml:mrow>
</mml:mroot>
</xsl:template>

<!-- 4.4.3.11 gcd -->
<xsl:template mode="c2p" match="mml:gcd">
<mml:mo>gcd</mml:mo>
</xsl:template>

<!-- 4.4.3.12 and -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:and]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8743;<!-- and --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>


<!-- 4.4.3.13 or -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:or]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="3"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8744;<!-- or --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.3.14 xor -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:xor]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="3"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>xor</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>


<!-- 4.4.3.15 not -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:not]]">
<mml:mrow>
<mml:mo>&#172;<!-- not --></mml:mo>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
</mml:mrow>
</xsl:template>




<!-- 4.4.3.16 implies -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:implies]]">
  <xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
  <xsl:with-param name="mo"><mml:mo>&#8658;<!-- Rightarrow --></mml:mo></xsl:with-param>
  <xsl:with-param name="p" select="$p"/>
  <xsl:with-param name="this-p" select="3"/>
</xsl:call-template>
</xsl:template>


<!-- 4.4.3.17 forall -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:forall]]">
 <mml:mrow>
  <mml:mi>&#8704;<!--forall--></mml:mi>
 <mml:mrow><xsl:apply-templates select="mml:bvar[not(current()/mml:condition)]/*|mml:condition/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates select="*[last()]"/>
 </mml:mfenced>
</mml:mrow>
</xsl:template>



<!-- 4.4.3.18 exists -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:exists]]">
 <mml:mrow>
  <mml:mi>&#8707;<!--exists--></mml:mi>
 <mml:mrow><xsl:apply-templates select="mml:bvar[not(current()/mml:condition)]/*|mml:condition/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates select="*[last()]"/>
 </mml:mfenced>
</mml:mrow>
</xsl:template>


<!-- 4.4.3.19 abs -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:abs]]">
<mml:mrow>
<mml:mo>|</mml:mo>
<xsl:apply-templates select="*[2]"/>
<mml:mo>|</mml:mo>
</mml:mrow>
</xsl:template>



<!-- 4.4.3.20 conjugate -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:conjugate]]">
<mml:mover>
<xsl:apply-templates select="*[2]"/>
<mml:mo>&#175;<!-- overline --></mml:mo>
</mml:mover>
</xsl:template>

<!-- 4.4.3.21 arg -->
<xsl:template mode="c2p" match="mml:arg">
 <mml:mo>arg</mml:mo>
</xsl:template>


<!-- 4.4.3.22 real -->
<xsl:template mode="c2p" match="mml:real">
 <mml:mo>&#8475;<!-- real --></mml:mo>
</xsl:template>

<!-- 4.4.3.23 imaginary -->
<xsl:template mode="c2p" match="mml:imaginary">
 <mml:mo>&#8465;<!-- imaginary --></mml:mo>
</xsl:template>

<!-- 4.4.3.24 lcm -->
<xsl:template mode="c2p" match="mml:lcm">
 <mml:mo>lcm</mml:mo>
</xsl:template>


<!-- 4.4.3.25 floor -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:floor]]">
<mml:mrow>
<mml:mo>&#8970;<!-- lfloor--></mml:mo>
<xsl:apply-templates select="*[2]"/>
<mml:mo>&#8971;<!-- rfloor--></mml:mo>
</mml:mrow>
</xsl:template>


<!-- 4.4.3.25 ceiling -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:ceiling]]">
<mml:mrow>
<mml:mo>&#8968;<!-- lceil--></mml:mo>
<xsl:apply-templates select="*[2]"/>
<mml:mo>&#8969;<!-- rceil--></mml:mo>
</mml:mrow>
</xsl:template>

<!-- 4.4.4.1 eq -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:eq]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>=</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.2 neq -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:neq]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8800;<!-- neq --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.3 eq -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:gt]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&gt;</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.4 lt -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:lt]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&lt;</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.5 geq -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:geq]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8805;</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.6 geq -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:leq]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8804;</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.7 equivalent -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:equivalent]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8801;</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.8 approx -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:approx]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="1"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8771;</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>


<!-- 4.4.4.9 factorof -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:factorof]]">
  <xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
  <xsl:with-param name="mo"><mml:mo>|</mml:mo></xsl:with-param>
  <xsl:with-param name="p" select="$p"/>
  <xsl:with-param name="this-p" select="3"/>
</xsl:call-template>
</xsl:template>

<!-- 4.4.5.1 int -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:int]]">
 <mml:mrow>
 <mml:msubsup>
  <mml:mo>&#8747;<!--int--></mml:mo>
 <mml:mrow><xsl:apply-templates select="mml:lowlimit/*|mml:interval/*[1]|mml:condition/*"/></mml:mrow>
 <mml:mrow><xsl:apply-templates select="mml:uplimit/*|mml:interval/*[2]"/></mml:mrow>
 </mml:msubsup>
 <xsl:apply-templates select="*[last()]"/>
 <mml:mo>d</mml:mo><xsl:apply-templates select="mml:bvar"/>
</mml:mrow>
</xsl:template>

<!-- 4.4.5.2 diff -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:diff] and mml:ci and count(*)=2]" priority="2">
 <mml:msup>
 <mml:mrow><xsl:apply-templates select="*[2]"/></mml:mrow>
 <mml:mo>&#8242;<!--prime--></mml:mo>
 </mml:msup>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:diff]]" priority="1">
 <mml:mfrac>
 <xsl:choose>
 <xsl:when test="mml:bvar/mml:degree">
 <mml:mrow><mml:msup><mml:mo>d</mml:mo><xsl:apply-templates select="mml:bvar/mml:degree/node()"/></mml:msup>
     <xsl:apply-templates  select="*[last()]"/></mml:mrow>
 <mml:mrow><mml:mo>d</mml:mo><mml:msup><xsl:apply-templates
 select="mml:bvar/node()"/><xsl:apply-templates
 select="mml:bvar/mml:degree/node()"/></mml:msup>
</mml:mrow>
</xsl:when>
<xsl:otherwise>
 <mml:mrow><mml:mo>d</mml:mo><xsl:apply-templates select="*[last()]"/></mml:mrow>
 <mml:mrow><mml:mo>d</mml:mo><xsl:apply-templates select="mml:bvar"/></mml:mrow>
</xsl:otherwise>
 </xsl:choose>
 </mml:mfrac>
</xsl:template>


<!-- 4.4.5.3 partialdiff -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:partialdiff] and mml:list and mml:ci and count(*)=3]" priority="2">
<mml:mrow>
 <mml:msub><mml:mo>D</mml:mo><mml:mrow>
<xsl:for-each select="mml:list[1]/*">
<xsl:apply-templates select="."/>
<xsl:if test="position()&lt;last()"><mml:mo>,</mml:mo></xsl:if>
</xsl:for-each>
</mml:mrow></mml:msub>
 <mml:mrow><xsl:apply-templates select="*[3]"/></mml:mrow>
</mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:partialdiff]]" priority="1">
 <mml:mfrac>
 <mml:mrow><mml:msup><mml:mo>&#8706;<!-- partial --></mml:mo>
<mml:mrow>
 <xsl:choose>
 <xsl:when test="mml:degree">
<xsl:apply-templates select="mml:degree/node()"/>
</xsl:when>
<xsl:when test="mml:bvar/mml:degree[string(number(.))='NaN']">
<xsl:for-each select="mml:bvar/mml:degree">
<xsl:apply-templates select="node()"/>
<xsl:if test="position()&lt;last()"><mml:mo>+</mml:mo></xsl:if>
</xsl:for-each>
<xsl:if test="count(mml:bvar[not(mml:degree)])&gt;0">
<mml:mo>+</mml:mo><mml:mn><xsl:value-of select="count(mml:bvar[not(mml:degree)])"/></mml:mn>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<mml:mn><xsl:value-of select="sum(mml:bvar/mml:degree)+count(mml:bvar[not(mml:degree)])"/></mml:mn>
</xsl:otherwise>
 </xsl:choose>
</mml:mrow>
</mml:msup>
     <xsl:apply-templates  select="*[last()]"/></mml:mrow>
<mml:mrow>
<xsl:for-each select="mml:bvar">
<mml:mrow>
<mml:mo>&#8706;<!-- partial --></mml:mo><mml:msup><xsl:apply-templates select="node()"/>
                     <mml:mrow><xsl:apply-templates select="mml:degree/node()"/></mml:mrow>
</mml:msup>
</mml:mrow>
</xsl:for-each>
</mml:mrow>
 </mml:mfrac>
</xsl:template>

<!-- 4.4.5.4  lowlimit-->
<xsl:template mode="c2p" match="mml:lowlimit"/>

<!-- 4.4.5.5 uplimit-->
<xsl:template mode="c2p" match="mml:uplimit"/>

<!-- 4.4.5.6  bvar-->
<xsl:template mode="c2p" match="mml:bvar">
 <mml:mi><xsl:apply-templates/></mml:mi>
 <xsl:if test="following-sibling::mml:bvar"><mml:mo>,</mml:mo></xsl:if>
</xsl:template>

<!-- 4.4.5.7 degree-->
<xsl:template mode="c2p" match="mml:degree"/>

<!-- 4.4.5.8 divergence-->
<xsl:template mode="c2p" match="mml:divergence">
<mml:mo>div</mml:mo>
</xsl:template>

<!-- 4.4.5.9 grad-->
<xsl:template mode="c2p" match="mml:grad">
<mml:mo>grad</mml:mo>
</xsl:template>

<!-- 4.4.5.10 curl -->
<xsl:template mode="c2p" match="mml:curl">
<mml:mo>curl</mml:mo>
</xsl:template>


<!-- 4.4.5.11 laplacian-->
<xsl:template mode="c2p" match="mml:laplacian">
<mml:msup><mml:mo>&#8711;<!-- nabla --></mml:mo><mml:mn>2</mml:mn></mml:msup>
</xsl:template>

<!-- 4.4.6.1 set -->

<xsl:template mode="c2p" match="mml:set">
  <xsl:call-template name="set"/>
</xsl:template>

<!-- 4.4.6.2 list -->

<xsl:template mode="c2p" match="mml:list">
  <xsl:call-template name="set">
   <xsl:with-param name="o" select="'('"/>
   <xsl:with-param name="c" select="')'"/>
  </xsl:call-template>
</xsl:template>

<!-- 4.4.6.3 union -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:union]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8746;<!-- union --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.4 intersect -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:intersect]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="3"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8745;<!-- intersect --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.5 in -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:in]]">
  <xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
  <xsl:with-param name="mo"><mml:mo>&#8712;<!-- in --></mml:mo></xsl:with-param>
  <xsl:with-param name="p" select="$p"/>
  <xsl:with-param name="this-p" select="3"/>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.5 notin -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:notin]]">
  <xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
  <xsl:with-param name="mo"><mml:mo>&#8713;<!-- not in --></mml:mo></xsl:with-param>
  <xsl:with-param name="p" select="$p"/>
  <xsl:with-param name="this-p" select="3"/>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.7 subset -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:subset]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8838;<!-- subseteq --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.8 prsubset -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:prsubset]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8834;<!-- prsubset --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.9 notsubset -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:notsubset]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8840;<!-- notsubseteq --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.10 notprsubset -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:notprsubset]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8836;<!-- prsubset --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.11 setdiff -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:setdiff]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="binary">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8726;<!-- setminus --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.6.12 card -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:card]]">
<mml:mrow>
<mml:mo>|</mml:mo>
<xsl:apply-templates select="*[2]"/>
<mml:mo>|</mml:mo>
</mml:mrow>
</xsl:template>

<!-- 4.4.6.13 cartesianproduct -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:cartesianproduct or self::mml:vectorproduct]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#215;<!-- times --></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<xsl:template mode="c2p"
match="mml:apply[*[1][self::mml:cartesianproduct][count(following-sibling::mml:reals)=count(following-sibling::*)]]"
priority="2">
<mml:msup>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="5"/>
</xsl:apply-templates>
<mml:mn><xsl:value-of select="count(*)-1"/></mml:mn>
</mml:msup>
</xsl:template>


<!-- 4.4.7.1 sum -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:sum]]">
 <mml:mrow>
 <mml:msubsup>
  <mml:mo>&#8721;<!--sum--></mml:mo>
 <mml:mrow><xsl:apply-templates select="mml:lowlimit/*|mml:interval/*[1]|mml:condition/*"/></mml:mrow>
 <mml:mrow><xsl:apply-templates select="mml:uplimit/*|mml:interval/*[2]"/></mml:mrow>
 </mml:msubsup>
 <xsl:apply-templates select="*[last()]"/>
</mml:mrow>
</xsl:template>

<!-- 4.4.7.2 product -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:product]]">
 <mml:mrow>
 <mml:msubsup>
  <mml:mo>&#8719;<!--product--></mml:mo>
 <mml:mrow><xsl:apply-templates select="mml:lowlimit/*|mml:interval/*[1]|mml:condition/*"/></mml:mrow>
 <mml:mrow><xsl:apply-templates select="mml:uplimit/*|mml:interval/*[2]"/></mml:mrow>
 </mml:msubsup>
 <xsl:apply-templates select="*[last()]"/>
</mml:mrow>
</xsl:template>

<!-- 4.4.7.3 limit -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:limit]]">
 <mml:mrow>
 <mml:munder>
  <mml:mi>limit</mml:mi>
 <mml:mrow><xsl:apply-templates select="mml:lowlimit|mml:condition/*"/></mml:mrow>
 </mml:munder>
 <xsl:apply-templates select="*[last()]"/>
</mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[mml:limit]/mml:lowlimit" priority="3">
<mml:mrow>
<xsl:apply-templates select="../mml:bvar/node()"/>
<mml:mo>&#8594;<!--rightarrow--></mml:mo>
<xsl:apply-templates/>
</mml:mrow>
</xsl:template>


<!-- 4.4.7.4 tendsto -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:tendsto]]">
 <xsl:param name="p"/>
<xsl:call-template name="binary">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>
  <xsl:choose>
   <xsl:when test="@type='above'">&#8600;<!--searrow--></xsl:when>
   <xsl:when test="@type='below'">&#8599;<!--nearrow--></xsl:when>
   <xsl:when test="@type='two-sided'">&#8594;<!--rightarrow--></xsl:when>
   <xsl:otherwise>&#8594;<!--rightarrow--></xsl:otherwise>
  </xsl:choose>
  </mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.8.1 trig -->
<xsl:template mode="c2p" match="mml:apply[*[1][
 self::mml:sin or self::mml:cos or self::mml:tan or self::mml:sec or
 self::mml:csc or self::mml:cot or self::mml:sinh or self::mml:cosh or
 self::mml:tanh or self::mml:sech or self::mml:csch or self::mml:coth or
 self::mml:arcsin or self::mml:arccos or self::mml:arctan or self::mml:arccosh
 or self::mml:arccot or self::mml:arccoth or self::mml:arccsc or
 self::mml:arccsch or self::mml:arcsec or self::mml:arcsech or
 self::mml:arcsinh or self::mml:arctanh or self::mml:ln]]">
<mml:mrow>
<mml:mi><xsl:value-of select="local-name(*[1])"/></mml:mi>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
</mml:mrow>
</xsl:template>




<!-- 4.4.8.2 exp -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:exp]]">
<mml:msup>
<mml:mi>e<!-- exponential e--></mml:mi>
<mml:mrow><xsl:apply-templates select="*[2]"/></mml:mrow>
</mml:msup>
</xsl:template>

<!-- 4.4.8.3 ln -->
<!-- with trig -->

<!-- 4.4.8.4 log -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:log]]">
<mml:mrow>
<xsl:choose>
<xsl:when test="not(mml:logbase) or mml:logbase=10">
<mml:mi>log</mml:mi>
</xsl:when>
<xsl:otherwise>
<mml:msub>
<mml:mi>log</mml:mi>
<mml:mrow><xsl:apply-templates select="mml:logbase/node()"/></mml:mrow>
</mml:msub>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="*[last()]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
</mml:mrow>
</xsl:template>


<!-- 4.4.9.1 mean -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:mean]]">
<mml:mrow>
 <mml:mo>&#9001;<!--langle--></mml:mo>
    <xsl:for-each select="*[position()&gt;1]">
      <xsl:apply-templates select="."/>
      <xsl:if test="position() !=last()"><mml:mo>,</mml:mo></xsl:if>
    </xsl:for-each>
<mml:mo>&#9002;<!--rangle--></mml:mo>
</mml:mrow>
</xsl:template>


<!-- 4.4.9.2 sdef -->
<xsl:template mode="c2p" match="mml:sdev">
<mml:mo>&#963;<!--sigma--></mml:mo>
</xsl:template>

<!-- 4.4.9.3 variance -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:variance]]">
<mml:msup>
<mml:mrow>
<mml:mo>&#963;<!--sigma--></mml:mo>
<mml:mo>(</mml:mo>
<xsl:apply-templates select="*[2]"/>
<mml:mo>)</mml:mo>
</mml:mrow>
<mml:mn>2</mml:mn>
</mml:msup>
</xsl:template>


<!-- 4.4.9.4 median -->
<xsl:template mode="c2p" match="mml:median">
<mml:mo>median</mml:mo>
</xsl:template>


<!-- 4.4.9.5 mode -->
<xsl:template mode="c2p" match="mml:mode">
<mml:mo>mode</mml:mo>
</xsl:template>

<!-- 4.4.9.5 moment -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:moment]]">
<mml:mrow>
 <mml:mo>&#9001;<!--langle--></mml:mo>
       <mml:msup>
      <xsl:apply-templates select="*[last()]"/>
      <mml:mrow><xsl:apply-templates select="mml:degree/node()"/></mml:mrow>
       </mml:msup>
<mml:mo>&#9002;<!--rangle--></mml:mo>
</mml:mrow>
</xsl:template>

<!-- 4.4.9.5 momentabout -->
<xsl:template mode="c2p" match="mml:momentabout"/>

<!-- 4.4.10.1 vector  -->
<xsl:template mode="c2p" match="mml:vector">
<mml:mrow>
<mml:mo>(</mml:mo>
<mml:mtable>
<xsl:for-each select="*">
<mml:mtr><mml:mtd><xsl:apply-templates select="."/></mml:mtd></mml:mtr>
</xsl:for-each>
</mml:mtable>
<mml:mo>)</mml:mo>
</mml:mrow>
</xsl:template>

<!-- 4.4.10.2 matrix  -->
<xsl:template mode="c2p" match="mml:matrix">
<mml:mrow>
<mml:mo>(</mml:mo>
<mml:mtable>
<xsl:apply-templates/>
</mml:mtable>
<mml:mo>)</mml:mo>
</mml:mrow>
</xsl:template>

<!-- 4.4.10.3 matrixrow  -->
<xsl:template mode="c2p" match="mml:matrixrow">
<mml:mtr>
<xsl:for-each select="*">
<mml:mtd><xsl:apply-templates select="."/></mml:mtd>
</xsl:for-each>
</mml:mtr>
</xsl:template>

<!-- 4.4.10.4 determinant  -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:determinant]]">
<mml:mrow>
<mml:mi>det</mml:mi>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
</mml:mrow>
</xsl:template>

<xsl:template mode="c2p"
match="mml:apply[*[1][self::mml:determinant]][*[2][self::mml:matrix]]" priority="2">
<mml:mrow>
<mml:mo>|</mml:mo>
<mml:mtable>
<xsl:apply-templates select="mml:matrix/*"/>
</mml:mtable>
<mml:mo>|</mml:mo>
</mml:mrow>
</xsl:template>

<!-- 4.4.10.5 transpose -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:transpose]]">
<mml:msup>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
<mml:mi>T</mml:mi>
</mml:msup>
</xsl:template>

<!-- 4.4.10.5 selector -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:selector]]">
<mml:msub>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
<mml:mrow>
    <xsl:for-each select="*[position()&gt;2]">
      <xsl:apply-templates select="."/>
      <xsl:if test="position() !=last()"><mml:mo>,</mml:mo></xsl:if>
    </xsl:for-each>
</mml:mrow>
</mml:msub>
</xsl:template>

<!-- *** -->
<!-- 4.4.10.6 vectorproduct see cartesianproduct -->


<!-- 4.4.10.7 scalarproduct-->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:scalarproduct or self::mml:outerproduct]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="2"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>.</mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.10.8 outerproduct-->

<!-- 4.4.11.2 semantics -->
<xsl:template mode="c2p" match="mml:semantics">
 <xsl:apply-templates select="*[1]"/>
</xsl:template>
<xsl:template mode="c2p" match="mml:semantics[mml:annotation-xml/@encoding='MathML-Presentation']">
 <xsl:apply-templates select="mml:annotation-xml[@encoding='MathML-Presentation']/node()"/>
</xsl:template>

<!-- 4.4.12.1 integers -->
<xsl:template mode="c2p" match="mml:integers">
<mml:mi mathvariant="double-struck">Z</mml:mi>
</xsl:template>

<!-- 4.4.12.2 reals -->
<xsl:template mode="c2p" match="mml:reals">
<mml:mi mathvariant="double-struck">R</mml:mi>
</xsl:template>

<!-- 4.4.12.3 rationals -->
<xsl:template mode="c2p" match="mml:rationals">
<mml:mi mathvariant="double-struck">Q</mml:mi>
</xsl:template>

<!-- 4.4.12.4 naturalnumbers -->
<xsl:template mode="c2p" match="mml:naturalnumbers">
<mml:mi mathvariant="double-struck">N</mml:mi>
</xsl:template>

<!-- 4.4.12.5 complexes -->
<xsl:template mode="c2p" match="mml:complexes">
<mml:mi mathvariant="double-struck">C</mml:mi>
</xsl:template>

<!-- 4.4.12.6 primes -->
<xsl:template mode="c2p" match="mml:primes">
<mml:mi mathvariant="double-struck">P</mml:mi>
</xsl:template>

<!-- 4.4.12.7 exponentiale -->
<xsl:template mode="c2p" match="mml:exponentiale">
  <mml:mi>e<!-- exponential e--></mml:mi>
</xsl:template>

<!-- 4.4.12.8 imaginaryi -->
<xsl:template mode="c2p" match="mml:imaginaryi">
  <mml:mi>i<!-- imaginary i--></mml:mi>
</xsl:template>

<!-- 4.4.12.9 notanumber -->
<xsl:template mode="c2p" match="mml:notanumber">
  <mml:mi>NaN</mml:mi>
</xsl:template>

<!-- 4.4.12.10 true -->
<xsl:template mode="c2p" match="mml:true">
  <mml:mi>true</mml:mi>
</xsl:template>

<!-- 4.4.12.11 false -->
<xsl:template mode="c2p" match="mml:false">
  <mml:mi>false</mml:mi>
</xsl:template>

<!-- 4.4.12.12 emptyset -->
<xsl:template mode="c2p" match="mml:emptyset">
  <mml:mi>&#8709;<!-- emptyset --></mml:mi>
</xsl:template>


<!-- 4.4.12.13 pi -->
<xsl:template mode="c2p" match="mml:pi">
  <mml:mi>&#960;<!-- pi --></mml:mi>
</xsl:template>

<!-- 4.4.12.14 eulergamma -->
<xsl:template mode="c2p" match="mml:eulergamma">
  <mml:mi>&#947;<!-- gamma --></mml:mi>
</xsl:template>

<!-- 4.4.12.15 infinity -->
<xsl:template mode="c2p" match="mml:infinity">
  <mml:mi>&#8734;<!-- infinity --></mml:mi>
</xsl:template>



  <!--  This file contains changes to the content to presentation mathml -->
  <!--  stylesheet. -->
  
  <!--  Created 2001-02-01.  -->

  
  <!--This is the template for math.-->
  <xsl:template mode="c2p" match="m:math">
    <m:math>

      <xsl:choose>
  <!-- Otherwise, explicitly set equations to mode 'display' -->
  <xsl:when test="$equation">
    <xsl:attribute name="display">block</xsl:attribute>
  </xsl:when>
  <xsl:when test="@display">
    <xsl:attribute name="display"><xsl:value-of select="@display" /></xsl:attribute>
  </xsl:when>

  <xsl:otherwise>
    <xsl:attribute name="display">inline</xsl:attribute>
  </xsl:otherwise>
      </xsl:choose>
      <m:semantics>
  <m:mrow>
    <xsl:apply-templates/>
  </m:mrow>

  <m:annotation-xml encoding="MathML-Content">
      <xsl:copy-of select="child::*"/>
  </m:annotation-xml>
      </m:semantics>
    </m:math>
  </xsl:template>
  
  <!-- New equal for equation -->

 
  <!-- Places the power of a function or a trig function in the middle
  of it -->
  
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='power']]">
    <xsl:choose>

      <!-- checks to see if it is a function then formats -->
      
      <xsl:when test="child::*[position()=2 and child::*[local-name()='ci' and @type='fn']]">
  <m:mrow>
    <m:msup>
      <xsl:apply-templates select="child::*/child::*[local-name()='ci' and @type='fn']"/>
      <xsl:apply-templates select="child::*[position()=3]"/>
    </m:msup>
    <m:mfenced>
      <xsl:if test="child::*[position()=2 and child::*[local-name()='ci' and @class='discrete']]">

        <xsl:attribute name="open">[</xsl:attribute>
        <xsl:attribute name="close">]</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="child::*/child::*[position()!=1]"/>
    </m:mfenced>
  </m:mrow>
      </xsl:when>
      <!-- puts the exponent of a sin function between the sin and the
      rest -->

      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='sin']]">
  <m:msup>
    <m:mi>sin</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>

      </xsl:when>
      <!-- puts the exponent of a cos function between the cos and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='cos']]">
  <m:msup>
    <m:mi>cos</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">

    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of a tan function between the tan and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='tan']]">
  <m:msup>
    <m:mi>tan</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>

  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of a sec function between the sec and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='sec']]">
  <m:msup>
    <m:mi>sec</m:mi>

    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of a sec function between the csc and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='csc']]">
  <m:msup>

    <m:mi>csc</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of a cot function between the cot and the
      rest -->

      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='cot']]">
  <m:msup>
    <m:mi>cot</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>

      </xsl:when>
      <!-- puts the exponent of a sinh function between the sinh and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='sinh']]">
  <m:msup>
    <m:mi>sinh</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">

    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of a cosh function between the cosh and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='cosh']]">
  <m:msup>
    <m:mi>cosh</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>

  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of a tanh function between the tanh and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='tanh']]">
  <m:msup>
    <m:mi>tanh</m:mi>

    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of a sech function between the sech and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='sech']]">
  <m:msup>

    <m:mi>sech</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of a csch function between the csch and the
      rest -->

      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='csch']]">
  <m:msup>
    <m:mi>csch</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>

      </xsl:when>
      <!-- puts the exponent of a coth function between the coth and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='coth']]">
  <m:msup>
    <m:mi>coth</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">

    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arcsin function between the arcsin and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arcsin']]">
  <m:msup>
    <m:mi>arcsin</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>

  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arccos function between the arccos and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arccos']]">
  <m:msup>
    <m:mi>arccos</m:mi>

    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arctan function between the arctan and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arctan']]">
  <m:msup>

    <m:mi>arctan</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arccosh function between the arccosh and the
      rest -->

      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arccosh']]">
  <m:msup>
    <m:mi>arccosh</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>

      </xsl:when>
      <!-- puts the exponent of an arccot function between the arccot and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arccot']]">
  <m:msup>
    <m:mi>arccot</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">

    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arccoth function between the arccoth and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arccoth']]">
  <m:msup>
    <m:mi>arccoth</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>

  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arccsc function between the arccsc and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arccsc']]">
  <m:msup>
    <m:mi>arccsc</m:mi>

    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arccsch function between the arccsch and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arccsch']]">
  <m:msup>

    <m:mi>arccsch</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arcsec function between the arcsec and the
      rest -->

      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arcsec']]">
  <m:msup>
    <m:mi>arcsec</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>

      </xsl:when>
      <!-- puts the exponent of an arcsech function between the arcsech and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arcsech']]">
  <m:msup>
    <m:mi>arcsech</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">

    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arcsinh function between the arcsinh and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arcsinh']]">
  <m:msup>
    <m:mi>arcsinh</m:mi>
    <xsl:apply-templates select="child::*[position()=3]"/>

  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- puts the exponent of an arctanh function between the arctanh and the
      rest -->
      <xsl:when test="m:apply[child::*[position()=1 and
    local-name()='arctanh']]">
  <m:msup>
    <m:mi>arctanh</m:mi>

    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
  <m:mfenced separators=" ">
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>
      </xsl:when>
      <!-- for normal power applications -->
      <xsl:when test="local-name(*[position()=2])='apply'">
  <m:msup>

    <m:mfenced separators=" ">
      <xsl:apply-templates select="child::*[position()=2]"/></m:mfenced>
    <xsl:apply-templates select="child::*[position()=3]"/>
  </m:msup>
      </xsl:when>
      <xsl:otherwise>
  <m:msup>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <xsl:apply-templates select="child::*[position()=3]"/>

  </m:msup>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- places the -1 of a inverted function or trig function in the -->
  <!-- middle of the function -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='inverse']]">
    <xsl:choose>

      <xsl:when test="descendant::*[position()=3 and @type='fn']">
  <m:msup>
    <xsl:apply-templates select="descendant::*[position()=3]"/>
    <m:mo>-1</m:mo>
  </m:msup>
  <m:mfenced>
    <xsl:apply-templates select="descendant::*[position()=4]"/>
  </m:mfenced>

      </xsl:when>
      <xsl:when test="local-name(*[position()=2])='apply'">
  <m:msup>
    <m:mfenced separators=" ">
      <m:mrow>
        <xsl:apply-templates select="*[position()=2]"/>
      </m:mrow>
    </m:mfenced>
    <m:mn>-1</m:mn>

  </m:msup>
      </xsl:when>
      <xsl:otherwise>
  <m:msup> <!-- elementary classical functions have two templates: apply[func] for standard case, func[position()!=1] for inverse and compose case-->
    <m:mrow><xsl:apply-templates select="*[position()=2]"/></m:mrow><!-- function to be inversed-->
    <m:mn>-1</m:mn>
  </m:msup>
      </xsl:otherwise>

    </xsl:choose>
  </xsl:template>

  
  <!-- csymbol stuff: Connexions MathML extensions -->

  <!-- Combination -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='csymbol' and @definitionURL='http://www.openmath.org/cd/combinat1.ocd']]">
    <m:mrow>
      
      <m:mfenced>
  <m:mtable>

    <m:mtr>
      <m:mtd>
        <xsl:apply-templates select="child::*[position()=2]"/>
      </m:mtd>
    </m:mtr>
    <m:mtr>
      <m:mtd>
        <xsl:apply-templates select="child::*[position()=3]"/>
      </m:mtd>

    </m:mtr>
  </m:mtable>
      </m:mfenced>
    </m:mrow>
  </xsl:template>

  <!-- Probability --> 

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#probability']]">
    <xsl:choose>
      <xsl:when test='m:condition'>

  <m:mrow>  
    <m:mi><xsl:text
    disable-output-escaping="yes">Pr</xsl:text></m:mi>
    <m:mfenced open='[' close=']' separators=" ">
          <m:mfenced open=' ' close=' '> 
       <xsl:apply-templates select="*[local-name()!='condition' and local-name()!='csymbol']"/>
      </m:mfenced>
      <m:mspace width=".3em"/>
      <m:mo>|</m:mo>
      <m:mspace width=".3em"/>

      <xsl:apply-templates select="m:condition"/>
    </m:mfenced>
  </m:mrow>
      </xsl:when>
      <xsl:otherwise>
  <m:mrow>
    <m:mi><xsl:text disable-output-escaping="yes">Pr</xsl:text></m:mi>
    <m:mfenced open='[' close=']'>

      <xsl:apply-templates select="*[local-name()!='csymbol']"/>
    </m:mfenced>
  </m:mrow>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Complement -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#complement']]">

    <xsl:choose>
      <xsl:when test="$complementnotation='overbar'">
  <m:mover>
     <xsl:choose>
      <xsl:when test="local-name(*[position()=2])='apply'">
        <m:mfenced separators=" ">
    <xsl:apply-templates select="child::*[position()=2]" /> 
        </m:mfenced>
      </xsl:when>

      <xsl:otherwise>
        <xsl:apply-templates select="child::*[position()=2]" /> 
      </xsl:otherwise>
    </xsl:choose>
    <m:mo>&#x00AF;<!-- OverBar --></m:mo>
  </m:mover>
      </xsl:when>
      <xsl:otherwise>
  <m:msup>

    <xsl:choose>
      <xsl:when test="local-name(*[position()=2])='apply'">
        <m:mfenced separators=" ">
    <xsl:apply-templates select="child::*[position()=2]" /> 
        </m:mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="child::*[position()=2]" /> 
      </xsl:otherwise>
    </xsl:choose>

    <m:mo>&#x2032;<!-- prime --></m:mo>
  </m:msup>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Expected value -->
  
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='csymbol' and
    @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#expectedvalue']]">
    <m:mrow>

      <xsl:choose>
  <xsl:when test='m:bvar'>
    <m:msub>
      <m:mi><xsl:text disable-output-escaping="yes">E</xsl:text></m:mi>
      <xsl:apply-templates select="child::*[local-name()='bvar']"/>
    </m:msub>
    <m:mfenced open='[' close=']' seperators=" ">
      <m:mrow>

        <xsl:apply-templates select="child::*[local-name()!='condition' and position()=last()]"/>
        <xsl:if test="m:condition">
    <m:mrow>
      <m:mspace width=".1em"/>
      <m:mo>|</m:mo>
      <m:mspace width=".1em"/>
      <m:mfenced open=" " close=" ">
      <xsl:apply-templates select="child::*[local-name()='condition']"/>

      </m:mfenced>
    </m:mrow>
        </xsl:if>
      </m:mrow>
    </m:mfenced>
  </xsl:when>
  <xsl:otherwise>   
    <m:mi><xsl:text
        disable-output-escaping="yes">E</xsl:text></m:mi>
    <m:mfenced open='[' close=']' seperators=" ">

      <m:mrow>
        <xsl:apply-templates select="child::*[local-name()!='condition' and position()=last()]"/>
        <xsl:if test="m:condition">
    <m:mrow>
      <m:mspace width=".1em"/>
      <m:mo>|</m:mo>
      <m:mspace width=".1em"/>
      <m:mfenced open=" " close=" "> 
      <xsl:apply-templates select="child::*[local-name()='condition']"/>

      </m:mfenced>
    </m:mrow>
        </xsl:if>
      </m:mrow>
    </m:mfenced>
  </xsl:otherwise>
      </xsl:choose>
    </m:mrow>
  </xsl:template>

  <!-- Estimate -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#estimate']]">
    <xsl:choose>
      <xsl:when test="child::*[position()=2 and local-name()='ci' and child::*[local-name()='msub']]">
  <m:msub>
    <m:mover>
      <xsl:apply-templates select="m:ci/m:msub/*[1]"/>
      <m:mo>&#x0302;<!-- Hat --></m:mo>

    </m:mover>
    <m:mrow>
      <xsl:apply-templates select="m:ci/m:msub/*[2]"/>
    </m:mrow>
  </m:msub>
      </xsl:when>
      <xsl:otherwise>
    <m:mover>
      <m:mrow><xsl:apply-templates /></m:mrow>

      <m:mo>&#x0302;<!-- Hat --></m:mo>
    </m:mover>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

 <!--PDF (Probability Density Function)-->

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='csymbol' and
    @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#pdf']]">
    <m:mrow>

      <m:mrow>
  <xsl:choose>
    <xsl:when test="m:bvar">
      <m:msub>
        <m:mrow><xsl:apply-templates select="child::*[local-name()='csymbol']"/></m:mrow>
        <m:mfenced open="" close="">
    <m:mrow>
      <m:mfenced open=" " close=" ">
        <xsl:apply-templates select="child::*[local-name()='bvar']"/>

      </m:mfenced>
      <xsl:if test="m:condition">
        <m:mrow>
          <m:mspace width=".1em"/>
          <m:mo>|</m:mo>
          <m:mspace width=".1em"/>
          <xsl:apply-templates select="child::*[local-name()='condition']"/>
        </m:mrow>

      </xsl:if>
    </m:mrow>
        </m:mfenced>
      </m:msub>
    </xsl:when>
    <xsl:otherwise>
      <m:mrow><xsl:apply-templates select="child::*[local-name()='csymbol']"/></m:mrow>
    </xsl:otherwise>
  </xsl:choose>

      </m:mrow>
      <m:mfenced>
  <m:mrow>
    <m:mfenced open=" " close=" ">
      <xsl:apply-templates select="child::*[not(local-name()='condition' or local-name()='csymbol' or local-name()='bvar')]"/>
    </m:mfenced>
    <xsl:if test="m:condition and not(m:bvar)">
      <m:mrow>
        <m:mspace width=".1em"/>

        <m:mo>|</m:mo>
        <m:mspace width=".1em"/>
        <xsl:apply-templates select="child::*[local-name()='condition']"/>
      </m:mrow>
    </xsl:if>
  </m:mrow>
      </m:mfenced>
    </m:mrow>

  </xsl:template>

<!-- CDF (Cumulative Distribution Function) -->

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='csymbol' and
    @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#cdf']]">
    <m:mrow>
      <m:mrow>
  <xsl:choose>
    <xsl:when test="m:bvar">
      <m:msub>

        <m:mrow><xsl:apply-templates select="child::*[local-name()='csymbol']"/></m:mrow>
        <m:mfenced open="" close="">
    <m:mrow>
      <m:mfenced open=" " close=" ">
        <xsl:apply-templates select="child::*[local-name()='bvar']"/>
      </m:mfenced>
      <xsl:if test="m:condition">
        <m:mrow>
          <m:mspace width=".1em"/>

          <m:mo>|</m:mo>
          <m:mspace width=".1em"/>
          <xsl:apply-templates select="child::*[local-name()='condition']"/>
        </m:mrow>
      </xsl:if>
    </m:mrow>
        </m:mfenced>
      </m:msub>

    </xsl:when>
    <xsl:otherwise>
      <m:mrow><xsl:apply-templates select="child::*[local-name()='csymbol']"/></m:mrow>
    </xsl:otherwise>
  </xsl:choose>
      </m:mrow>
      <m:mfenced>
  <m:mrow>
    <m:mfenced open=" " close=" ">

      <xsl:apply-templates select="child::*[not(local-name()='condition' or local-name()='csymbol' or local-name()='bvar')]"/>
    </m:mfenced>
     <xsl:if test="m:condition and not(m:bvar)">
      <m:mrow>
        <m:mspace width=".1em"/>
        <m:mo>|</m:mo>
        <m:mspace width=".1em"/>
        <xsl:apply-templates select="child::*[local-name()='condition']"/>

      </m:mrow>
    </xsl:if>
  </m:mrow>
      </m:mfenced>
    </m:mrow>
  </xsl:template>
  
<!-- Normal Distribution -->
<xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#normaldistribution']]">
    <m:mrow>

      <m:mi>&#xEF3B;<!-- Nscr --></m:mi>
      <m:mfenced>
  <xsl:apply-templates select="child::*[position()=2 or position()=3]" />
      </m:mfenced>
    </m:mrow>
  </xsl:template>

<!-- Distributed In -->
<xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#distributedin']]">
    <m:mrow>

      <xsl:apply-templates select="child::*[position()=2]" />
      <m:mo>&#x223C;<!-- Tilde --></m:mo>
      <xsl:apply-templates select="child::*[position()=3]" />
    </m:mrow>
  </xsl:template>

<!-- Distance -->
<xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#distance']]">
    <m:mrow>
      <m:mi>&#xEF37;<!-- Dscr --></m:mi>

      <m:mfenced>
  <m:mrow>
    <xsl:apply-templates select="child::*[position()=2]" />
    <m:mo>&#x2225;<!-- DoubleVerticalBar --></m:mo>
    <xsl:apply-templates select="child::*[position()=3]" />
  </m:mrow>
      </m:mfenced>
    </m:mrow>
  </xsl:template>

<!-- Mutual Information -->
<xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#mutualinformation']]">
    <m:mrow>
      <m:mi>&#x2110;<!-- Iscr --></m:mi>
      <m:mfenced>
  <m:mrow>
    <xsl:apply-templates select="child::*[position()=2]" />
    <m:mo>&#x003B;<!-- semi --></m:mo>
    <xsl:apply-templates select="child::*[position()=3]" />

  </m:mrow>
      </m:mfenced>
    </m:mrow>
  </xsl:template>

 <!-- Peicewise Stochastic Process -->

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#stochastic']]">
   <m:mrow>
      <xsl:element name="m:mfenced" namespace="http://www.w3.org/1998/Math/MathML">

  <xsl:attribute name="open">{</xsl:attribute>
  <xsl:attribute name="close"></xsl:attribute>
  <m:mtable>
    <xsl:for-each select="m:apply[child::*[position()=1 and
      local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#stochasticpiece']]">
      <m:mtr><m:mtd>
    <xsl:apply-templates select="*[position()=2]"/>
    <m:mspace width="0.3em"/><m:mtext>Prob</m:mtext><m:mspace width="0.3em"/>
    <xsl:apply-templates select="*[position()=3]"/>

        </m:mtd></m:mtr>
    </xsl:for-each>
  </m:mtable>
      </xsl:element>
    </m:mrow>
  </xsl:template>  

  <!-- Vector Derivative -->
  
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='diff' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#vectorderivative']]">
    <m:mrow>

      <xsl:choose>
  <xsl:when test="m:degree">
    <m:msubsup>
      <m:mi>&#x2207;<!-- Del --></m:mi>
      <xsl:apply-templates select='m:bvar'/>
      <xsl:apply-templates select='m:degree'/>
    </m:msubsup>
  </xsl:when>
  <xsl:otherwise>

    <m:msub>
      <m:mi>&#x2207;<!-- Del --></m:mi>
      <xsl:apply-templates select='m:bvar'/>
    </m:msub>
  </xsl:otherwise>
      </xsl:choose>
      <m:mfenced>
  <xsl:apply-templates select="*[position()=last()]"/>
      </m:mfenced>

    </m:mrow>
  </xsl:template>

  <!-- infimum -->
  <xsl:template mode="c2p"  match="m:apply[child::*[position()=1 and
    local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#infimum']]">
    <m:mrow>
      <xsl:choose>
  <xsl:when test="m:bvar"> <!-- if there are bvars-->
    <m:msub>

      <m:mi>inf</m:mi>
      <m:mrow>
        <xsl:for-each select="m:bvar[position()!=last()]">  <!--select every bvar except the last one (position() only counts bvars, not the other siblings)-->
    <xsl:apply-templates select="."/><m:mo>,</m:mo>
        </xsl:for-each>
        <xsl:apply-templates select="m:bvar[position()=last()]"/>
      </m:mrow>

    </m:msub>
    <m:mrow><m:mo>{</m:mo>
      <xsl:apply-templates select="*[local-name()!='condition' and local-name()!='bvar']"/>
      <xsl:if test="m:condition">
        <m:mo>|</m:mo><xsl:apply-templates select="m:condition"/>
      </xsl:if>
      <m:mo>}</m:mo></m:mrow>

  </xsl:when>
  <xsl:otherwise> <!-- if there are no bvars-->
    <m:mo>inf</m:mo>
    <m:mrow><m:mo>{</m:mo>
      <m:mfenced open="" close=""><xsl:apply-templates select="*[local-name()!='condition' and local-name()!='min']"/></m:mfenced>
      <xsl:if test="m:condition">
        <m:mo>|</m:mo><xsl:apply-templates select="m:condition"/>

      </xsl:if>
      <m:mo>}</m:mo></m:mrow>
  </xsl:otherwise>
      </xsl:choose>
    </m:mrow>
  </xsl:template>

  

  
  
  <!-- Horizontally Partitioned Matrix -->
  <!-- FIXME: not in use till futher discussion-->

  <!--
<xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#partitionedmatrix'
  and @type='horizontal']]">
<mrow>
<mfenced separators=" ">
<mtable>
<xsl:apply-templates select="child::*[position()=2]"/>
</mtable>
<mo>|</mo>
<mtable>
<xsl:apply-templates select="child::*[position()=3]"/>
</mtable>
</mfenced>
</mrow>
</xsl:template>
  -->

  <!-- Vertically Partitioned Matrix -->
  <!-- FIXME: not in use till futher discussion-->
  <!-- FIXME: Doesn't work -->

  <!--
<xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#partitionedmatrix'
  and @type='vertical']]">
<mrow>
<mfenced>
<mtable>
<mtr>
<mtd>
<mtable>
<xsl:apply-templates select="child::*[position()=2]"/>
</mtable>
</mtd>
</mtr>
<mtr>
<mtd>
  &#x2500;--><!-- HorizontalLine --><!--
</mtd>
</mtr>
<mtr>
<mtd>
<mtable>
<xsl:apply-templates select="child::*[position()=3]"/>
</mtable>
</mtd>
</mtr>
</mtable>
</mfenced>
</mrow>
</xsl:template> 
  -->

  <!-- Quad Partitioned Matrix -->
  <!-- FIXME: not in use till futher discussion-->

  <!-- FIXME: Doesn't work -->

  <!--
<xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#partitionedmatrix' and @type='quad']]">
  
<mrow>
<mfenced separators=" ">
<mfrac>
<mtable>
<xsl:apply-templates select="child::*[position()=2]"/>
</mtable>
<mtable>
<xsl:apply-templates select="child::*[position()=3]"/>
</mtable>
</mfrac>
<mo>|</mo>
<mfrac>
<mtable>
<xsl:apply-templates select="child::*[position()=4]"/>
</mtable>
<mtable>
<xsl:apply-templates select="child::*[position()=5]"/>
</mtable>
</mfrac>
</mfenced>
</mrow>
</xsl:template>
  -->

  <!--<xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
  local-name()='csymbol' and
  @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#partition']]">
<xsl:apply-templates select="*"/>
</xsl:template>
  -->


  <!-- Convolution -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#convolve']]">
    <xsl:choose>
      <xsl:when test="count(child::*)&gt;=3">

  <m:mrow>
    <xsl:for-each select="child::*[position()!=last() and  position()!=1]">
      <xsl:choose>
        <xsl:when test="m:plus"> <!--add brackets around + children for priority purpose-->
    <m:mfenced separators=" "><xsl:apply-templates select="."/></m:mfenced><m:mo><xsl:text disable-output-escaping="yes">&#x002A;<!-- midast --></xsl:text></m:mo>
        </xsl:when>
        <xsl:when test="m:minus"> <!--add brackets around - children for priority purpose-->
    <m:mfenced separators=" "><xsl:apply-templates select="."/></m:mfenced><m:mo><xsl:text disable-output-escaping="yes">&#x002A;<!-- midast --></xsl:text></m:mo>

        </xsl:when>
        <!-- if some csymbol is used put parentheses around it -->
        <xsl:when test="m:csymbol"> <!--add brackets around - children for priority purpose-->
    <m:mfenced separators=" "><xsl:apply-templates select="."/></m:mfenced><m:mo><xsl:text disable-output-escaping="yes">&#x002A;<!-- midast --></xsl:text></m:mo>
        </xsl:when>
        <xsl:otherwise>
    <xsl:apply-templates select="."/><m:mo><xsl:text disable-output-escaping="yes">&#x002A;<!-- midast --></xsl:text></m:mo>
        </xsl:otherwise>

      </xsl:choose>
    </xsl:for-each>
    <xsl:for-each select="child::*[position()=last()]">
      <xsl:choose>
        <xsl:when test="m:plus">
    <m:mfenced separators=" "><xsl:apply-templates select="."/></m:mfenced>
        </xsl:when>
        <xsl:when test="m:minus">
    <m:mfenced separators=" "><xsl:apply-templates select="."/></m:mfenced>

        </xsl:when>
        <!-- if some csymbol is used put parentheses around it -->
        <xsl:when test="m:csymbol">
    <m:mfenced separators=" "><xsl:apply-templates select="."/></m:mfenced>
        </xsl:when>
        <xsl:when test="(local-name(.)='ci' or local-name(.)='cn') and contains(text(),'-')"> <!-- have to do it using contains because starts-with doesn't seem to work well in  XT-->
    <m:mfenced separators=" "><xsl:apply-templates select="."/></m:mfenced>
        </xsl:when>

        <xsl:otherwise>
    <xsl:apply-templates select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </m:mrow>
      </xsl:when>
      <xsl:when test="count(child::*)=2">  <!-- unary -->

  <m:mrow>
    <m:mo><xsl:text disable-output-escaping="yes">&#x002A;<!-- midast --></xsl:text></m:mo>
    <xsl:choose>
      <xsl:when test="m:plus">
        <m:mfenced separators=" "><xsl:apply-templates select="*[position()=2]"/></m:mfenced>
      </xsl:when>
      <xsl:when test="m:minus">
        <m:mfenced separators=" "><xsl:apply-templates select="*[position()=2]"/></m:mfenced>
      </xsl:when>

      <xsl:when test="(*[position()=2 and self::m:ci] or *[position()=2 and self::m:cn]) and contains(*[position()=2]/text(),'-')">
        <m:mfenced separators=" "><xsl:apply-templates select="*[position()=2]"/></m:mfenced>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="*[position()=2]"/>
      </xsl:otherwise>
    </xsl:choose>
  </m:mrow>
      </xsl:when>

      <xsl:otherwise>  <!-- no operand -->
  <m:mo><xsl:text disable-output-escaping="yes">&#x002A;<!-- midast --></xsl:text></m:mo>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Adjoint -->
  <!-- FIXME: the notation here really needs to be customizable -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='csymbol' and
    @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#adjoint']]">

    <m:msup accent="true">
      <xsl:choose>
  <xsl:when test="child::m:apply">
    <m:mfenced><m:mrow><xsl:apply-templates select="*[position()=2]"/></m:mrow></m:mfenced>
  </xsl:when>
  <xsl:otherwise>
    <m:mrow><xsl:apply-templates select="*[position()=2]"/></m:mrow>
  </xsl:otherwise>
      </xsl:choose>

      <m:mo>H</m:mo>
    </m:msup>
  </xsl:template>
  
 <!-- norm -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='csymbol' and
    @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#norm']]">
    <xsl:choose>
      <xsl:when test='m:domainofapplication'>
  <m:mrow>

    <m:msub>
      <m:mrow>
        <m:mo>&#x2225;<!-- DoubleVerticalBar --></m:mo>
        <xsl:apply-templates select="child::*[position()=3]"/>
        <m:mo>&#x2225;<!-- DoubleVerticalBar --></m:mo>
      </m:mrow>
      <m:mrow>
        <xsl:apply-templates select="*[position()=2 and
        local-name()='domainofapplication']"/>
      </m:mrow>

    </m:msub>
  </m:mrow>
      </xsl:when>
      <xsl:otherwise>     
  <m:mrow>
    <m:mo>&#x2225;<!-- DoubleVerticalBar --></m:mo>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <m:mo>&#x2225;<!-- DoubleVerticalBar --></m:mo>
  </m:mrow>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Evaluated At -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#evaluateat']]">
    <m:mrow>
      <xsl:choose>
  <xsl:when test="m:condition"> <!-- evaluation expressed by a condition-->

    <xsl:apply-templates select="*[position()=last()]"/>
    <xsl:choose>
      <xsl:when test="m:bvar">
        <m:msub>
    <m:mo><xsl:text  disable-output-escaping="yes">&#x007C;<!-- verbar --></xsl:text></m:mo>
    <m:mrow>
      <xsl:apply-templates select="m:bvar"/>
      <m:mo><xsl:text disable-output-escaping="yes">&#x002C;<!-- comma --></xsl:text></m:mo>
      <xsl:apply-templates select="m:bvar"/>

      <m:mo><xsl:text disable-output-escaping="yes">&#x003D;<!-- equals --></xsl:text></m:mo>
      <xsl:apply-templates select="m:condition"/>
    </m:mrow>
        </m:msub>
      </xsl:when>
      <xsl:otherwise>
        <m:msub>
    <m:mrow><m:mo><xsl:text disable-output-escaping="yes">&#x007C;<!-- verbar --></xsl:text></m:mo></m:mrow>
    <m:mrow>

              <xsl:for-each select="m:condition[position()!=last()]"><xsl:apply-templates/><m:mo>,</m:mo></xsl:for-each>
              <xsl:for-each select="m:condition[position()=last()]"><xsl:apply-templates/></xsl:for-each>
            </m:mrow>
        </m:msub>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:otherwise>

    <xsl:choose>
      <xsl:when test="m:interval"> <!-- evaluation expressed by an interval-->
        <xsl:apply-templates select="*[position()=last()]"/>
        <xsl:choose>
    <xsl:when test="m:bvar">
      <m:msubsup>
        <m:mo><xsl:text disable-output-escaping="yes">&#x007C;<!-- verbar --></xsl:text></m:mo>
        <m:mrow>

          <xsl:apply-templates select="m:bvar"/> 
          <m:mo><xsl:text disable-output-escaping="yes">&#x003D;<!-- equals --></xsl:text></m:mo>
          <xsl:apply-templates select="m:interval/*[position()=1]"/>
        </m:mrow>
        <xsl:apply-templates select="m:interval/*[position()=2]"/>
      </m:msubsup>
    </xsl:when>
    <xsl:otherwise>
      <m:msubsup>

        <m:mo><xsl:text disable-output-escaping="yes">&#x007C;<!-- verbar --></xsl:text></m:mo>
        <xsl:apply-templates select="m:interval/*[position()=1]"/>
        <xsl:apply-templates select="m:interval/*[position()=2]"/>
      </m:msubsup>
    </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="m:lowlimit"> <!-- evaluation domain expressed by lower and upper limits-->

        <xsl:apply-templates select="*[position()=last()]"/>
        <xsl:choose>
    <xsl:when test="m:bvar">
      <m:msubsup>       
        <m:mo><xsl:text disable-output-escaping="yes">&#x007C;<!-- verbar --></xsl:text></m:mo>
        <m:mrow>
          <xsl:apply-templates select="m:bvar"/>
          <m:mo><xsl:text disable-output-escaping="yes">&#x003D;<!-- equals --></xsl:text></m:mo>
          <xsl:apply-templates select="m:lowlimit"/>

        </m:mrow>
        <m:mrow><xsl:apply-templates select="m:uplimit"/></m:mrow>
      </m:msubsup>
    </xsl:when>
    <xsl:otherwise>
      <m:msubsup>
        <m:mo><xsl:text disable-output-escaping="yes">&#x007C;<!-- verbar --></xsl:text></m:mo>
        <xsl:apply-templates select="m:lowlimit"/>
        <xsl:apply-templates select="m:uplimit"/>

      </m:msubsup>
    </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>     
  </xsl:otherwise>
      </xsl:choose>
    </m:mrow>
  </xsl:template>

  <!-- Surface Integral -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#surfaceintegral']]">
    <m:mrow>
      <xsl:choose>
  <xsl:when test="m:condition"> <!-- surface integration domain expressed by a condition-->
    <m:munder>
      <m:mo><xsl:text disable-output-escaping="yes">&#x222E;<!-- conint --></xsl:text></m:mo>
      <xsl:apply-templates select="m:condition"/>

    </m:munder>
    <m:mrow><xsl:apply-templates select="*[position()=last()]"/></m:mrow>
    <m:mrow><mo>d<!--DifferentialD does not work--></mo><xsl:apply-templates select="m:bvar"/></m:mrow>
  </xsl:when>
  <xsl:when test="m:domainofapplication"> <!-- surface integration domain expressed by a domain of application-->
    <m:munder>
      <m:mo><xsl:text disable-output-escaping="yes">&#x222E;<!-- conint --></xsl:text></m:mo>
      <xsl:apply-templates select="m:domainofapplication"/>

    </m:munder>
    <m:mrow><xsl:apply-templates select="*[position()=last()]"/></m:mrow>
    <m:mrow><m:mo>d<!--DifferentialD does not work--></m:mo><xsl:apply-templates select="m:bvar"/></m:mrow>  <!--not sure about this line: can get rid of it if there is never a bvar elem when integ domain specified by domainofapplication-->
  </xsl:when>
  <xsl:when test="m:lowlimit"><!-- surface integration expressed
    by lowlimit and uplimit -->
    <m:munderover>       
      <m:mo><xsl:text disable-output-escaping="yes">&#x222E;<!-- conint --></xsl:text></m:mo>
      <m:mrow><xsl:apply-templates select="m:lowlimit"/></m:mrow>

      <m:mrow><xsl:apply-templates select="m:uplimit"/></m:mrow>
    </m:munderover>
    <m:mrow><xsl:apply-templates select="*[position()=last()]"/></m:mrow>
    <m:mrow><m:mo>d<!--DifferentialD does not work--></m:mo><xsl:apply-templates select="m:bvar"/></m:mrow>
  </xsl:when>
  <xsl:otherwise><!-- surface integral with no condition -->
    <m:mo><xsl:text disable-output-escaping="yes">&#x222E;<!-- conint --></xsl:text></m:mo>
    <m:mrow><xsl:apply-templates select="*[position()=last()]"/></m:mrow>

    <m:mrow><m:mo>d<!--DifferentialD does not
        work--></m:mo><xsl:apply-templates select="m:bvar"/></m:mrow>
  </xsl:otherwise>
      </xsl:choose>
    </m:mrow>
  </xsl:template>
  
  <!-- arg min -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#argmin']]">
    <m:mrow>

      <xsl:choose>
  <xsl:when test="m:condition"> <!-- arg min domain expressed by
    a condition-->
    <m:mrow>
      <xsl:text disable-output-escaping="yes">arg</xsl:text>
      <m:munder>
        <m:mo><xsl:text disable-output-escaping="yes">min</xsl:text></m:mo>
        <xsl:apply-templates select="m:condition"/>

      </m:munder>
    </m:mrow>
    <m:mrow><xsl:apply-templates select="*[position()=3]"/></m:mrow>
  </xsl:when>
  <xsl:when test="m:domainofapplication"> <!-- arg min domain
    expressed with domain of application-->
    <m:mrow>
      <xsl:text disable-output-escaping="yes">arg</xsl:text>
      <m:munder>

        <m:mo><xsl:text disable-output-escaping="yes">min</xsl:text></m:mo>
        <xsl:apply-templates select="m:domainofapplication"/>
      </m:munder>
    </m:mrow>
    <m:mrow><xsl:apply-templates select="*[position()=3]"/></m:mrow>
  </xsl:when> 
  <xsl:otherwise><!--condition with no condition -->
    <m:mrow>
      <xsl:text disable-output-escaping="yes">arg</xsl:text>

      <m:mo><xsl:text disable-output-escaping="yes">min</xsl:text></m:mo>
      <m:mrow><xsl:apply-templates select="*[position()=last()]"/></m:mrow>
    </m:mrow>
  </xsl:otherwise>
      </xsl:choose>
    </m:mrow>
  </xsl:template>

  <!-- arg max -->

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='csymbol' and @definitionURL='http://cnx.rice.edu/cd/cnxmath.ocd#argmax']]">
    <m:mrow>
      <xsl:choose>
  <xsl:when test="m:condition"> <!-- arg max domain expressed by
    a condition-->
    <m:mrow>
      <xsl:text disable-output-escaping="yes">arg</xsl:text> 
      <m:munder>
        <m:mo><xsl:text disable-output-escaping="yes">max</xsl:text></m:mo>

        <xsl:apply-templates select="m:condition"/>
      </m:munder>
    </m:mrow>
    <m:mrow><xsl:apply-templates select="*[position()=3]"/></m:mrow>
  </xsl:when>
  <xsl:when test="m:domainofapplication"> <!-- arg max domain
    expressed with domain of application-->
    <m:mrow>
      <xsl:text disable-output-escaping="yes">arg</xsl:text> 
      <m:munder>

        <m:mo><xsl:text disable-output-escaping="yes">max</xsl:text></m:mo>
        <xsl:apply-templates select="m:domainofapplication"/>
      </m:munder>
    </m:mrow>
    <m:mrow><xsl:apply-templates select="*[position()=3]"/></m:mrow>
  </xsl:when>
  <xsl:otherwise><!-- arg max with no condition -->
    <m:mrow>

      <xsl:text disable-output-escaping="yes">arg</xsl:text>
      <m:mo><xsl:text disable-output-escaping="yes">max</xsl:text></m:mo>
      <m:mrow><xsl:apply-templates select="*[position()=last()]"/></m:mrow>
    </m:mrow>
  </xsl:otherwise>
      </xsl:choose>
    </m:mrow>
  </xsl:template>

  <!-- Presentation Changes -->
 
  <!-- apply/apply/diff formatting change-->    

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='apply' and child::*[position()=1 and
    local-name()='diff'] ]]">
    <xsl:choose>
      <xsl:when test="count(child::*)&gt;=2">
  <m:mrow>
    <xsl:apply-templates select="child::*[position()=1]"/>
    <m:mfenced><xsl:apply-templates select="child::*[position()!=1]"/></m:mfenced>
  </m:mrow>

      </xsl:when>
      <xsl:otherwise><!-- apply only contains apply, no operand
  -->
  <m:mfenced separators=" "><xsl:apply-templates select="child::*"/></m:mfenced>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!--apply/forall formatting change with parameter -->

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='forall' and $forallequation]]">
    <xsl:choose>
      <xsl:when test="$forallequation">
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
      </xsl:when>  
      <xsl:otherwise>
  <xsl:apply-imports />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    
            
  <!-- Parameters -->

  <!-- Mean Notation choice -->

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and local-name()='mean']]">
    <xsl:choose>
      <xsl:when test="$meannotation='anglebracket'"><!--use angle
  notation -->
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
      </xsl:when>
      <xsl:otherwise>
  <xsl:apply-imports />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    
  <!-- Vector notation choice -->

  <xsl:template mode="c2p" match="m:ci[@type='vector']">
    <xsl:choose>

      <xsl:when test="$vectornotation='overbar'">
  <!--vector with overbar -->
  <xsl:choose>
    <xsl:when test="count(node()) != count(text())">
      <!--test if children are not all text nodes, meaning there
      is markup assumed to be presentation markup-->

      <xsl:choose>
        <xsl:when test="child::*[position()=1 and
      local-name()='msub']"><!-- test to see if the first
    child is msub so that the subscript will not be bolded -->
    <m:msub>
      <m:mover><m:mi><xsl:apply-templates select="./m:msub/child::*[position()=1]"/></m:mi><m:mo>&#x2212;<!-- minus --></m:mo></m:mover>
      <m:mrow><xsl:apply-templates select="./m:msub/child::*[position()=2]"/></m:mrow>
    </m:msub>
        </xsl:when>
        <xsl:otherwise>
    <m:mrow><xsl:copy-of select="child::*"/></m:mrow>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>  <!-- common case -->
      <m:mover><m:mi><xsl:value-of select="text()"/></m:mi><m:mo>&#x2212;<!-- minus --></m:mo></m:mover>
    </xsl:otherwise>
  </xsl:choose>
      </xsl:when>

      <xsl:when test="$vectornotation='rightarrow'">
  <!--vector with rightarrow over -->
  <xsl:choose>
    <xsl:when test="count(node()) != count(text())">
      <!--test if children are not all text nodes, meaning there
      is markup assumed to be presentation markup-->
      <xsl:choose>
        <xsl:when test="child::*[position()=1 and
      local-name()='msub']"><!-- test to see if the first child
    is msub so that the subscript will not be bolded -->
    <m:msub>

      <m:mover><m:mi><xsl:apply-templates select="./m:msub/child::*[position()=1]"/></m:mi><m:mo>&#x21C0;<!-- rharu --></m:mo></m:mover>
      <m:mrow><xsl:apply-templates select="./m:msub/child::*[position()=2]"/></m:mrow>
    </m:msub>
        </xsl:when>
        <xsl:otherwise>
    <m:mrow><xsl:copy-of select="child::*"/></m:mrow>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:otherwise>  <!-- common case -->
      <m:mover><m:mi><xsl:value-of select="text()"/></m:mi><m:mo>&#x21C0;<!-- rharu --></m:mo></m:mover>
    </xsl:otherwise>
  </xsl:choose>
      </xsl:when>
      
      <xsl:otherwise>
  <!-- vector bolded -->
  <xsl:apply-imports />

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- And/Or notation choice -->

  <!-- added to cnxmathmlc2p-custom.xsl -->

  <!-- Real/Imaginary notation choice -->

  <!-- real part of complex number -->

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='real']]">
    <xsl:choose>
      <xsl:when test="$realimaginarynotation='text'">
  <m:mrow>
    <m:mi><xsl:text disable-output-escaping="yes">Re</xsl:text></m:mi>
    <m:mo><xsl:text disable-output-escaping="yes"><!-- ApplyFunction --></xsl:text></m:mo>
    <m:mfenced separators=" "><xsl:apply-templates select="child::*[position()=2]"/></m:mfenced>
  </m:mrow>

      </xsl:when>
      <xsl:otherwise>
  <xsl:apply-imports />
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>

  <!-- imaginary part of complex number -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='imaginary']]">
    <xsl:choose>

      <xsl:when test="$realimaginarynotation='text'">
  <m:mrow>
    <m:mi><xsl:text disable-output-escaping="yes">Im</xsl:text></m:mi>
    <m:mo><xsl:text disable-output-escaping="yes"><!-- ApplyFunction --></xsl:text></m:mo>
    <m:mfenced separators=" "><xsl:apply-templates select="child::*[position()=2]"/></m:mfenced>
  </m:mrow>
      </xsl:when>
      <xsl:otherwise>

  <xsl:apply-imports />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
 
  <!-- Scalar Product Notation -->

 <!-- scalar product = A x B x cos(teta) -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='scalarproduct']]">
    <xsl:choose>

      <xsl:when
      test="$scalarproductnotation='dotnotation'"><!--dot
      notation -->
  <m:mrow>
    <xsl:apply-templates select="*[position()=2]"/>
    <m:mo>&#x00A0;<!-- nbsp -->&#x00B7;<!-- middot -->&#x00A0;<!-- nbsp --></m:mo>
    <xsl:apply-templates select="*[position()=3]"/>
  </m:mrow>
      </xsl:when>
      <xsl:otherwise>
  <xsl:apply-imports />

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template> 

 
  <!-- Conjugate Notation -->
  
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='conjugate']]">
    <xsl:choose>
      <xsl:when
      test="$conjugatenotation='engineeringnotation'"><!-- asterik notation -->    
  <m:msup>
    <xsl:apply-templates select="child::*[position()=2]"/>
    <m:mo><xsl:text disable-output-escaping="yes">&#x002A;<!-- ast --></xsl:text></m:mo> 
  </m:msup>

      </xsl:when>
      <xsl:otherwise>
  <xsl:apply-imports />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Gradient and Curl Notation -->

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='grad']]">

    <xsl:choose>
      <xsl:when test="$gradnotation='symbolicnotation'">
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
      </xsl:when>
      <xsl:otherwise>
  <xsl:apply-imports />

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='curl']]">
    <xsl:choose>
      <xsl:when test="$curlnotation='symbolicnotation'">
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
      </xsl:when>
      <xsl:otherwise>
  <xsl:apply-imports />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Remainder Notation -->
  <xsl:template mode="c2p" match="m:apply[child::*[position()=1 and
    local-name()='rem']]">
    <xsl:choose>
      <xsl:when test="$remaindernotation='remainder_anglebracket'">
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
      </xsl:when>
      <xsl:otherwise>
  <xsl:apply-imports />

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Defaults for the editor. -->
  <xsl:param name="equation" select="not(parent::*[local-name()='equation'])"/>
  <xsl:param name="meannotation" select="''"/>
  <xsl:param name="forallequation" select="0" />
  <xsl:param name="vectornotation" select="'rightarrow'"/><!-- '' 'overbar' 'rightarrow' -->
  <xsl:param name="andornotation" select="''"/><!-- '' 'text' 'statlogicnotation' 'dsplogicnotation' -->
  <xsl:param name="realimaginarynotation" select="''"/><!-- '' 'text' -->
  <xsl:param name="scalarproductnotation" select="''"/><!-- TODO: stopped here -->
  <xsl:param name="vectorproductnotation" select="''"/>

  <xsl:param name="conjugatenotation" select="''" />
  <xsl:param name="curlnotation" select="''"/>
  <xsl:param name="gradnotation" select="''"/>
  <xsl:param name="remaindernotation" select="''"/>
  <xsl:param name="complementnotation" select="''"/>


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
  <xsl:template mode="c2p" match="mml:apply[*[1][self::mml:minus] and count(*)&gt;2]">
    <xsl:param name="p" select="0"/>
    <xsl:call-template name="binary">
      <xsl:with-param name="mo"><mml:mo>&#8722;<!--minus--></mml:mo></xsl:with-param>
      <xsl:with-param name="p" select="$p"/>
      <xsl:with-param name="this-p" select="2.1"/>
      <xsl:with-param name="associative" select="'none'"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Custom "implies" -->
  <xsl:template mode="c2p" match="mml:apply[*[1][self::mml:implies]]">
    <xsl:param name="p" select="0" />
    <xsl:call-template name="binary">
      <xsl:with-param name="mo">
        <mml:mo>&#8658;<!-- Rightarrow --></mml:mo>
      </xsl:with-param>
      <xsl:with-param name="p" select="$p" />
      <xsl:with-param name="this-p" select="1.5" />
      <xsl:with-param name="associative" select="'none'"/>
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
    <mml:mrow>
    <xsl:if test="$this-p &lt; $p or ($associative='none' and $parent-op = local-name(mml:*[1]))"><mml:mo>(</mml:mo></xsl:if>
     <xsl:apply-templates select="*[2]">
       <xsl:with-param name="p" select="$this-p"/>
     </xsl:apply-templates>
     <xsl:copy-of select="$mo"/>
     <xsl:apply-templates select="*[3]">
       <xsl:with-param name="p" select="$this-p"/>
     </xsl:apply-templates>
    <xsl:if test="$this-p &lt; $p or ($associative='none' and $parent-op = local-name(mml:*[1]))"><mml:mo>)</mml:mo></xsl:if>
    </mml:mrow>
  </xsl:template>


  <!-- Custom "and" -->
  <xsl:template mode="c2p" match="m:apply[*[1][self::m:and]]">
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
  <xsl:template mode="c2p" match="m:apply[*[1][self::m:or]]">
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
  <xsl:template mode="c2p" match="mml:integers">
    <mml:mi>&#x2124;</mml:mi><!-- <mml:mi mathvariant="double-struck">Z</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.2 reals -->
  <xsl:template mode="c2p" match="mml:reals">
    <mml:mi>&#x211D;</mml:mi><!-- <mml:mi mathvariant="double-struck">R</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.3 rationals -->
  <xsl:template mode="c2p" match="mml:rationals">
    <mml:mi>&#x211A;</mml:mi><!-- <mml:mi mathvariant="double-struck">Q</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.4 naturalnumbers -->
  <xsl:template mode="c2p" match="mml:naturalnumbers">
    <mml:mi>&#x2115;</mml:mi><!-- <mml:mi mathvariant="double-struck">N</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.5 complexes -->
  <xsl:template mode="c2p" match="mml:complexes">
    <mml:mi>&#x2102;</mml:mi><!-- <mml:mi mathvariant="double-struck">C</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.6 primes -->
  <xsl:template mode="c2p" match="mml:primes">
    <mml:mi>&#x2119;</mml:mi><!-- <mml:mi mathvariant="double-struck">P</mml:mi> -->
  </xsl:template>
  <!-- 4.4.12.7 exponentiale -->
  <xsl:template mode="c2p" match="mml:exponentiale">
    <mml:mi>&#8519;<!--e exponential e--></mml:mi>
  </xsl:template>

  <!-- 4.4.3.4 max  min-->
  <!-- The original definition of mml:min used "max" in the text -->
  <xsl:template mode="c2p" match="mml:apply[*[1][self::mml:max]]">
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

  <xsl:template mode="c2p" match="mml:apply[*[1][self::mml:min]]">
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
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:xor]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
 <xsl:with-param name="this-p" select="3"/>
 <xsl:with-param name="p" select="$p"/>
 <xsl:with-param name="mo"><mml:mo>&#8853;<!--xor--></mml:mo></xsl:with-param>
</xsl:call-template>
</xsl:template>
<!-- 4.4.3.15 not -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:not]]">
<mml:mrow>
<mml:mo>&#172;<!-- not --></mml:mo>
<xsl:apply-templates select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
</mml:mrow>
</xsl:template>
<!-- 4.4.3.17 forall -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:forall]]">
 <mml:mrow>
  <mml:mi>&#8704;<!--forall--></mml:mi>
 <mml:mrow><xsl:apply-templates select="mml:bvar[not(current()/mml:condition)]/*|mml:condition/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates select="*[last()]"/>
 </mml:mfenced>
</mml:mrow>
</xsl:template>
<!-- 4.4.3.18 exists -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:exists]]">
 <mml:mrow>
  <mml:mi>&#8707;<!--exists--></mml:mi>
 <mml:mrow><xsl:apply-templates select="mml:bvar[not(current()/mml:condition)]/*|mml:condition/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates select="*[last()]"/>
 </mml:mfenced>
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
  
    <!--
    This XSLT adds id's around Converted content elements for the editor
    so that when someone clicks on something the editor knows what it
    was.
  -->
  <!-- Presentation MathML elements (There is a template below):
    mml:mi|mml:mo|mml:mrow|mml:mfrac|mml:msqrt|mml:mroot|mml:mstyle|mml:merror|mml:mpadded|mml:mphantom|mml:mfenced|mml:menclose|mml:msub|mml:msup|mml:msubsup|mml:munder|mml:mover|mml:munderover|mml:mmultiscripts|mml:mtable|mml:mlabeledtr|mml:mtr|mml:mtd|mml:maction 
    -->
  <!-- Content MathML elements with id's (There is a template below):
   mmled:block|mml:cn|mml:ci|mml:apply|mml:integers|mml:reals|mml:rationals|mml:naturalnumbers|mml:complexes|mml:primes|mml:exponentiale|mml:imaginaryi|mml:notanumber|mml:true|mml:false|mml:emptyset|mml:pi|mml:eulergamma|mml:infinity|mml:vector|mml:matrix|mml:piecewise|mml:piece|mml:set
    -->

  <xsl:template match="mml:*|mmled:*">
    <xsl:param name="p" select="0" />
    <xsl:apply-templates mode="id-maker" select=".">
      <xsl:with-param name="p" select="$p"/>
    </xsl:apply-templates>
  </xsl:template>


  <xsl:template name="add-id3">
    <xsl:param name="prefix">pres-</xsl:param>
    <xsl:if test="@id">
      <xsl:attribute name="id"><xsl:value-of
        select="$prefix" /><xsl:value-of select="@id" /></xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="add-id2">
    <xsl:param name="prefix">pres-</xsl:param>
    <xsl:param name="skip-content-attribute" />
    <xsl:param name="value" />
    <xsl:if test="@id">
      <xsl:attribute name="id"><xsl:value-of
        select="$prefix" /><xsl:value-of select="@id" /></xsl:attribute>
      <xsl:if test="not($skip-content-attribute)">
        <xsl:attribute name="class">math-content</xsl:attribute>
      </xsl:if>
      <!--
        <xsl:choose> <xsl:when test="local-name(.)='apply'">
        <xsl:attribute name="title">Click here to select the
        <xsl:value-of select="local-name(*[1])"/>
        operation</xsl:attribute> </xsl:when> <xsl:when
        test="local-name(.)='ci'"> <xsl:attribute name="title">Click
        here to select the variable</xsl:attribute> </xsl:when>
        <xsl:when test="local-name(.)='cn'"> <xsl:attribute
        name="title">Click here to select the number</xsl:attribute>
        </xsl:when> </xsl:choose>
      -->

      <!-- only display input box when it's not a button -->
      <!-- TODO: These should match the cursor functions -->
      <xsl:choose>
        <xsl:when
          test="local-name(.)='block' and (@__type='piece' or @__type='matrixrow')"></xsl:when>
        <xsl:when test="local-name(.)='block'">
          <mml:mi>$$$</mml:mi>
          <span type="text" id="input-{@id}" title="Click here to insert a {@__type}"
            class="mathEditorInvisibleInput" onblur="MmlEditor_InputOnblur    (event, this, '{@id}');"
            onfocus="MmlEditor_InputOnfocus   (event, this, '{@id}');"
            onkeyup="MmlEditor_InputOnkeyup   (event, this, '{@id}');"
            onkeydown="MmlEditor_InputOnkeydown (event, this, '{@id}');">
            <xsl:attribute name="class"><xsl:choose>
                    <xsl:when test="local-name(.)='block' and not(@extra)">mathEditorInput</xsl:when>
                    <xsl:when
              test="local-name(.)='block' and @extra and not(@__type='piece' or @__type='matrixrow')">mathEditorInputExpandable</xsl:when>
                    <xsl:otherwise>mathEditorInvisibleInput</xsl:otherwise>
                  </xsl:choose></xsl:attribute>
            <xsl:attribute name="value">
                    <xsl:choose>
                      <xsl:when
              test="local-name(.)='block' and @extra and not(@__type='piece' or @__type='matrixrow')"><!-- &hellip; --></xsl:when>
                      <xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
          </span>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!-- ****************************************** -->
  <!--   Add button for mml:piece mml:matrixrow   -->
  <!-- ****************************************** -->
  <xsl:template mode="c2p" match="mmled:block">
    <xsl:if
      test="@extra = 'expandable' and (@__type='piece' or @__type='matrixrow')">
      <span title="{@__type}">
        <mml:mi>
          <button class="block"
            onclick="MathEditor.expandableOnclick(event, this, '{@id}', '{@__type}');">...</button>
        </mml:mi>
      </span>
    </xsl:if>
  </xsl:template>


  <!-- Make sure we don't add an id to Presentation MathML. -->
  <!--
    Apparently m10154 is an exception. the "transmitted" inside
    Probability is in a mml:mrow so we need to traverse them
    <xsl:template mode="id-maker"
    match="mml:mrow|mml:mfrac|mml:msqrt|mml:mroot|mml:mstyle|mml:merror|mml:mpadded|mml:mphantom|mml:mfenced|mml:menclose|mml:msub|mml:msup|mml:msubsup|mml:munder|mml:mover|mml:munderover|mml:mmultiscripts|mml:mtable|mml:mlabeledtr|mml:mtr|mml:mtd|mml:maction">
    <xsl:copy-of select="."/> </xsl:template>
  -->

  <!-- Make id's for the following elements -->
  <!--
    Wraps content that is converted into presentation with an id for the
    editor
  -->
  <xsl:template mode="id-maker"
    match="mmled:block|mml:cn|mml:ci|mml:apply|mml:integers|mml:reals|mml:rationals|mml:naturalnumbers|mml:complexes|mml:primes|mml:exponentiale|mml:imaginaryi|mml:notanumber|mml:true|mml:false|mml:emptyset|mml:pi|mml:eulergamma|mml:infinity|mml:vector|mml:matrix|mml:piecewise|mml:piece|mml:set">
    <xsl:param name="p" select="0" />
    <mml:mrow>
      <xsl:call-template name="add-id2" />
      <xsl:apply-templates mode="c2p" select=".">
        <xsl:with-param name="p" select="$p"/>
      </xsl:apply-templates>
    </mml:mrow>
  </xsl:template>

  <!-- Don't make id's for the rest of the elements (lower priority) -->
  <xsl:template mode="id-maker" match="mml:*">
    <xsl:param name="p" select="0" />
    <xsl:apply-templates mode="c2p" select=".">
      <xsl:with-param name="p" select="$p"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- ******************************* -->
  <!-- Custom overrides for the editor -->
  <!-- ******************************* -->

  <!-- 4.4.2.16` piecewise -->
  <!--
    Special piecewise code to handle the input boxes for the mml:mtr
  -->
  <xsl:template mode="c2p" match="mml:piecewise">
    <mml:mrow>
      <mml:mfenced open="{{" close="]">
        <mml:mtable>
          <xsl:for-each select="mml:piece">
            <mml:mtr>
              <xsl:call-template name="add-id3" />
              <mml:mtd></mml:mtd>
              <mml:mtd>
                <xsl:apply-templates
                  select="*[1]" />
              </mml:mtd>
              <mml:mtd>
                <mml:mtext>&#160; if &#160;</mml:mtext>
              </mml:mtd>
              <mml:mtd>
                <xsl:apply-templates select="*[2]" />
              </mml:mtd>
            </mml:mtr>
          </xsl:for-each>
          <!-- **************************** -->
          <!-- In the middle, so otherwise shows up below the expandable part -->
          <!-- **************************** -->
          <xsl:for-each select="mmled:block">
            <mml:mtr>
              <mml:mtd/>
              <mml:mtd>
                <xsl:apply-templates select="." />
              </mml:mtd>
            </mml:mtr>
          </xsl:for-each>
          <xsl:for-each select="mml:otherwise">
            <mml:mtr>
              <mml:mtd/><!--Blank for the inputs on the if clauses-->
              <mml:mtd>
                <xsl:apply-templates select="*[1]" />
              </mml:mtd>
              <mml:mtd />
              <mml:mtd>
                <mml:mtext>otherwise</mml:mtext>
              </mml:mtd>
            </mml:mtr>
          </xsl:for-each>
        </mml:mtable>
      </mml:mfenced>
    </mml:mrow>
  </xsl:template>

  <!-- 4.4.10.3 matrixrow  -->
  <!-- Add special stuff for mml:mtr support -->
  <xsl:template mode="c2p" match="mml:matrixrow">
    <mml:mtr>
      <xsl:call-template name="add-id3" />
      <mml:mtd><xsl:call-template name="add-id2"/></mml:mtd>
      <xsl:for-each select="*">
        <mml:mtd>
          <xsl:apply-templates select="." />
        </mml:mtd>
      </xsl:for-each>
    </mml:mtr>
  </xsl:template>

  <!-- 4.4.10.2 matrix  -->
  <!-- Add an extra invisible column for cursor (mml:mtr support) -->
  <xsl:template mode="c2p" match="mml:matrix">
    <mml:mfenced open="(" close=")">
      <mml:mtable>
        <xsl:apply-templates select="mml:matrixrow"/>
        <xsl:for-each select="mmled:block">
          <mml:mtr>
            <mml:mtd/>
            <mml:mtd>
              <xsl:apply-templates select="."/>
            </mml:mtd>
          </mml:mtr>
        </xsl:for-each>
      </mml:mtable>
    </mml:mfenced>
  </xsl:template>

  <!-- 4.4.3.3 divide -->
  <!-- Draw a vertical fraction for division instead of the "/" -->
  <xsl:template mode="c2p" match="mml:apply[*[1][self::mml:divide]]">
    <xsl:param name="p" select="0" />
    <mml:mfrac bevelled="false">
      <xsl:apply-templates select="*[2]" />
      <mml:mpadded height="+.5em">
        <!--
          Add spacing so the user can click on it
        -->
        <xsl:apply-templates select="*[3]" />
      </mml:mpadded>
    </mml:mfrac>
  </xsl:template>

  <!-- 4.4.5.1 int -->
  <!-- Use mml:mo instead of mml:mi so the integral sign stretches -->
  <xsl:template mode="c2p" match="mml:apply[*[1][self::mml:int]]">
    <mml:mrow>
      <mml:msubsup>
        <mml:mo>&#8747;<!--int-->
        </mml:mo>
        <mml:mrow>
          <xsl:apply-templates
            select="mml:lowlimit/*|mml:interval/*[1]|mml:condition/*" />
        </mml:mrow>
        <mml:mrow>
          <xsl:apply-templates select="mml:uplimit/*|mml:interval/*[2]" />
        </mml:mrow>
      </mml:msubsup>
      <xsl:apply-templates select="*[last()]" />
      <mml:mo>d</mml:mo>
      <xsl:apply-templates select="mml:bvar" />
    </mml:mrow>
  </xsl:template>

  <!-- Presentation MathML should belong to a separate "class" and invalid presentation (with Content in it) should be marked as invalid. -->
  <xsl:template mode="c2p" match="mml:mi|mml:mo|mml:mrow|mml:mfrac|mml:msqrt|mml:mroot|mml:mstyle|mml:merror|mml:mpadded|mml:mphantom|mml:mfenced|mml:menclose|mml:msub|mml:msup|mml:msubsup|mml:munder|mml:mover|mml:munderover|mml:mmultiscripts|mml:mtable|mml:mlabeledtr|mml:mtr|mml:mtd|mml:maction">
    <xsl:copy>
      <xsl:attribute name="isPresentation">true</xsl:attribute>
      <xsl:choose>
        <xsl:when test="mmled:block|mml:cn|mml:ci|mml:apply|mml:integers|mml:reals|mml:rationals|mml:naturalnumbers|mml:complexes|mml:primes|mml:exponentiale|mml:imaginaryi|mml:notanumber|mml:true|mml:false|mml:emptyset|mml:pi|mml:eulergamma|mml:infinity|mml:vector|mml:matrix|mml:piecewise|mml:piece|mml:set">
          <xsl:attribute name="class">invalid-content</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">presentation-math</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="*|text()"/>
    </xsl:copy>
  </xsl:template>

  <!-- 4.4.5.2 diff -->
  <!-- TODO remove me when I no longer use expandables (and the diff template relies on mml:bvar See m11299-->
  <xsl:template mode="c2p" match="mml:apply[*[1][self::mml:diff] and mml:ci and (count(mml:*)-count(mml:bvar))=2]" priority="2">
   <mml:msup>
   <mml:mrow><xsl:apply-templates select="*[2]"/></mml:mrow>
   <mml:mo>&#8242;<!--prime--></mml:mo>
   </mml:msup>
  </xsl:template>
  
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
</xsl:stylesheet>

