<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:fns="http://www.w3.org/2002/Math/preference"
  xmlns:doc="http://www.dcarlisle.demon.co.uk/xsldoc"
  xmlns:ie5="http://www.w3.org/TR/WD-xsl"
  exclude-result-prefixes="h ie5 fns msxsl fns doc"
  extension-element-prefixes="msxsl fns doc"
>

<xsl:template match="/">
<xsl:apply-templates mode="c2p"/>
</xsl:template> 


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
  <xsl:apply-templates mode="c2p"/>
</xsl:copy>
</xsl:template>


<!-- 4.4.1.1 cn -->

<xsl:template mode="c2p" match="mml:cn">
 <mml:mn><xsl:apply-templates mode="c2p"/></mml:mn>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='complex-cartesian']">
  <mml:mrow>
    <mml:mn><xsl:apply-templates mode="c2p" select="text()[1]"/></mml:mn>
    <mml:mo>+</mml:mo>
    <mml:mn><xsl:apply-templates mode="c2p" select="text()[2]"/></mml:mn>
    <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>

    <mml:mi>i<!-- imaginary i --></mml:mi>
  </mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='rational']">
  <mml:mrow>
    <mml:mn><xsl:apply-templates mode="c2p" select="text()[1]"/></mml:mn>
    <mml:mo>/</mml:mo>
    <mml:mn><xsl:apply-templates mode="c2p" select="text()[2]"/></mml:mn>

  </mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='integer']">
  <xsl:choose>
  <xsl:when test="not(@base) or @base=10">
       <mml:mn><xsl:apply-templates mode="c2p"/></mml:mn>
  </xsl:when>
  <xsl:otherwise>
  <mml:msub>

    <mml:mn><xsl:apply-templates mode="c2p"/></mml:mn>
    <mml:mn><xsl:value-of select="@base"/></mml:mn>
  </mml:msub>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='complex-polar']">
  <mml:mrow>
    <mml:mn><xsl:apply-templates mode="c2p" select="text()[1]"/></mml:mn>

    <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>
    <mml:msup>
    <mml:mi>e<!-- exponential e--></mml:mi>
    <mml:mrow>
     <mml:mi>i<!-- imaginary i--></mml:mi>
     <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>
     <mml:mn><xsl:apply-templates mode="c2p" select="text()[2]"/></mml:mn>
    </mml:mrow>

    </mml:msup>
  </mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:cn[@type='e-notation']">
    <mml:mn><xsl:apply-templates mode="c2p" select="text()[1]"/>E<xsl:apply-templates mode="c2p" select="text()[2]"/></mml:mn>
</xsl:template>

<!-- 4.4.1.1 ci  -->

<xsl:template mode="c2p" match="mml:ci/text()">
 <mml:mi><xsl:value-of select="."/></mml:mi>

</xsl:template>

<xsl:template mode="c2p" match="mml:ci">
 <mml:mrow><xsl:apply-templates mode="c2p"/></mml:mrow>
</xsl:template>

<!-- 4.4.1.2 csymbol -->

<xsl:template mode="c2p" match="mml:csymbol/text()">
 <mml:mo><xsl:apply-templates mode="c2p"/></mml:mo>
</xsl:template>

<xsl:template mode="c2p" match="mml:csymbol">
 <mml:mrow><xsl:apply-templates mode="c2p"/></mml:mrow>

</xsl:template>

<!-- 4.4.2.1 apply 4.4.2.2 reln -->

<xsl:template mode="c2p" match="mml:apply|mml:reln">
 <mml:mrow>
 <xsl:apply-templates mode="c2p" select="*[1]">
  <xsl:with-param name="p" select="10"/>
 </xsl:apply-templates>
 <mml:mo><!--&#8290;--><!--invisible times--></mml:mo>
 <mml:mfenced open="(" close=")" separators=",">

 <xsl:apply-templates mode="c2p" select="*[position()>1]"/>
 </mml:mfenced>
 </mml:mrow>
</xsl:template>

<!-- 4.4.2.3 fn -->
<xsl:template mode="c2p" match="mml:fn">
 <mml:mrow><xsl:apply-templates mode="c2p"/></mml:mrow>
</xsl:template>

<!-- 4.4.2.4 interval -->
<xsl:template mode="c2p" match="mml:interval[*[2]]">
 <mml:mfenced open="[" close="]"><xsl:apply-templates mode="c2p"/></mml:mfenced>

</xsl:template>
<xsl:template mode="c2p" match="mml:interval[*[2]][@closure='open']">
 <mml:mfenced open="(" close=")"><xsl:apply-templates mode="c2p"/></mml:mfenced>
</xsl:template>
<xsl:template mode="c2p" match="mml:interval[*[2]][@closure='open-closed']">
 <mml:mfenced open="(" close="]"><xsl:apply-templates mode="c2p"/></mml:mfenced>
</xsl:template>
<xsl:template mode="c2p" match="mml:interval[*[2]][@closure='closed-open']">
 <mml:mfenced open="[" close=")"><xsl:apply-templates mode="c2p"/></mml:mfenced>
</xsl:template>

<xsl:template mode="c2p" match="mml:interval">
 <mml:mfenced open="{{" close="}}"><xsl:apply-templates mode="c2p"/></mml:mfenced>

</xsl:template>

<!-- 4.4.2.5 inverse -->

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:inverse]]">
 <mml:msup>
  <xsl:apply-templates mode="c2p" select="*[2]"/>
  <mml:mrow><mml:mo>(</mml:mo><mml:mn>-1</mml:mn><mml:mo>)</mml:mo></mml:mrow>
 </mml:msup>
</xsl:template>

<!-- 4.4.2.6 sep -->

<!-- 4.4.2.7 condition -->
<xsl:template mode="c2p" match="mml:condition">
 <mml:mrow><xsl:apply-templates mode="c2p"/></mml:mrow>
</xsl:template>

<!-- 4.4.2.8 declare -->
<xsl:template mode="c2p" match="mml:declare"/>

<!-- 4.4.2.9 lambda -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:lambda]]">
 <mml:mrow>
  <mml:mi>&#955;<!--lambda--></mml:mi>

 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:bvar/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates mode="c2p" select="*[last()]"/>
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

 <mml:mtd><xsl:apply-templates mode="c2p" select="*[1]"/></mml:mtd>
 <mml:mtd><mml:mtext>&#160; if &#160;</mml:mtext></mml:mtd>
 <mml:mtd><xsl:apply-templates mode="c2p" select="*[2]"/></mml:mtd>
 </mml:mtr>
 </xsl:for-each>
</mml:mtable>
</mml:mrow>
</xsl:template>


<!-- 4.4.3.1 quotient -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:quotient]]">
<mml:mrow>
<mml:mo>&#8970;<!-- lfloor--></mml:mo>
<xsl:apply-templates mode="c2p" select="*[2]"/>
<mml:mo>/</mml:mo>
<xsl:apply-templates mode="c2p" select="*[3]"/>
<mml:mo>&#8971;<!-- rfloor--></mml:mo>
</mml:mrow>
</xsl:template>



<!-- 4.4.3.2 factorial -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:factorial]]">
<mml:mrow>

<xsl:apply-templates mode="c2p" select="*[2]">
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

  <xsl:apply-templates mode="c2p" select="*[2]">
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
     <xsl:apply-templates mode="c2p" select=".">
     <xsl:with-param name="first" select="2"/>
     <xsl:with-param name="p" select="2"/>
   </xsl:apply-templates>
     </mml:mrow>
      </xsl:when>

      <xsl:when test="self::mml:apply[*[1][self::mml:times] and
      *[2][self::mml:apply/*[1][self::mml:minus]]]">
     <mml:mrow>
     <xsl:apply-templates mode="c2p" select="./*[2]/*[2]"/>
     <xsl:apply-templates mode="c2p" select=".">
     <xsl:with-param name="first" select="2"/>
     <xsl:with-param name="p" select="2"/>
   </xsl:apply-templates>
     </mml:mrow>
      </xsl:when>

      <xsl:otherwise>
     <xsl:apply-templates mode="c2p" select=".">
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
<xsl:apply-templates mode="c2p" select="*[2]">
  <xsl:with-param name="p" select="5"/>
</xsl:apply-templates>
<xsl:apply-templates mode="c2p" select="*[3]">
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
   <xsl:apply-templates mode="c2p" select=".">
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

<xsl:apply-templates mode="c2p" select="*[position()&gt;1]"/>
</mml:msqrt>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:root]]">
<mml:mroot>
<xsl:apply-templates mode="c2p" select="*[position()&gt;1 and not(self::mml:degree)]"/>
<mml:mrow><xsl:apply-templates mode="c2p" select="mml:degree/*"/></mml:mrow>
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
<xsl:apply-templates mode="c2p" select="*[2]">
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
 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:bvar[not(current()/mml:condition)]/*|mml:condition/*"/></mml:mrow>
 <mml:mo>.</mml:mo>
 <mml:mfenced>
  <xsl:apply-templates mode="c2p" select="*[last()]"/>

 </mml:mfenced>
</mml:mrow>
</xsl:template>



<!-- 4.4.3.18 exists -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:exists]]">
 <mml:mrow>
  <mml:mi>&#8707;<!--exists--></mml:mi>
 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:bvar[not(current()/mml:condition)]/*|mml:condition/*"/></mml:mrow>
 <mml:mo>.</mml:mo>

 <mml:mfenced>
  <xsl:apply-templates mode="c2p" select="*[last()]"/>
 </mml:mfenced>
</mml:mrow>
</xsl:template>


<!-- 4.4.3.19 abs -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:abs]]">
<mml:mrow>
<mml:mo>|</mml:mo>
<xsl:apply-templates mode="c2p" select="*[2]"/>
<mml:mo>|</mml:mo>

</mml:mrow>
</xsl:template>



<!-- 4.4.3.20 conjugate -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:conjugate]]">
<mml:mover>
<xsl:apply-templates mode="c2p" select="*[2]"/>
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
<xsl:apply-templates mode="c2p" select="*[2]"/>
<mml:mo>&#8971;<!-- rfloor--></mml:mo>
</mml:mrow>
</xsl:template>


<!-- 4.4.3.25 ceiling -->

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:ceiling]]">
<mml:mrow>
<mml:mo>&#8968;<!-- lceil--></mml:mo>
<xsl:apply-templates mode="c2p" select="*[2]"/>
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
  <mml:mi>&#8747;<!--int--></mml:mi>
 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:lowlimit/*|mml:interval/*[1]|mml:condition/*"/></mml:mrow>
 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:uplimit/*|mml:interval/*[2]"/></mml:mrow>

 </mml:msubsup>
 <xsl:apply-templates mode="c2p" select="*[last()]"/>
 <mml:mo>d</mml:mo><xsl:apply-templates mode="c2p" select="mml:bvar"/>
</mml:mrow>
</xsl:template>

<!-- 4.4.5.2 diff -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:diff] and mml:ci and count(*)=2]" priority="2">
 <mml:msup>
 <mml:mrow><xsl:apply-templates mode="c2p" select="*[2]"/></mml:mrow>
 <mml:mo>&#8242;<!--prime--></mml:mo>

 </mml:msup>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:diff]]" priority="1">
 <mml:mfrac>
 <xsl:choose>
 <xsl:when test="mml:bvar/mml:degree">
 <mml:mrow><mml:msup><mml:mo>d</mml:mo><xsl:apply-templates mode="c2p" select="mml:bvar/mml:degree/node()"/></mml:msup>
     <xsl:apply-templates mode="c2p"  select="*[last()]"/></mml:mrow>
 <mml:mrow><mml:mo>d</mml:mo><mml:msup><xsl:apply-templates mode="c2p"
 select="mml:bvar/node()"/><xsl:apply-templates mode="c2p"
 select="mml:bvar/mml:degree/node()"/></mml:msup>

</mml:mrow>
</xsl:when>
<xsl:otherwise>
 <mml:mrow><mml:mo>d</mml:mo><xsl:apply-templates mode="c2p" select="*[last()]"/></mml:mrow>
 <mml:mrow><mml:mo>d</mml:mo><xsl:apply-templates mode="c2p" select="mml:bvar"/></mml:mrow>
</xsl:otherwise>
 </xsl:choose>
 </mml:mfrac>
</xsl:template>


<!-- 4.4.5.3 partialdiff -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:partialdiff] and mml:list and mml:ci and count(*)=3]" priority="2">
<mml:mrow>
 <mml:msub><mml:mo>D</mml:mo><mml:mrow>
<xsl:for-each select="mml:list[1]/*">
<xsl:apply-templates mode="c2p" select="."/>
<xsl:if test="position()&lt;last()"><mml:mo>,</mml:mo></xsl:if>
</xsl:for-each>
</mml:mrow></mml:msub>
 <mml:mrow><xsl:apply-templates mode="c2p" select="*[3]"/></mml:mrow>
</mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:partialdiff]]" priority="1">
 <mml:mfrac>
 <mml:mrow><mml:msup><mml:mo>&#8706;<!-- partial --></mml:mo>
<mml:mrow>
 <xsl:choose>
 <xsl:when test="mml:degree">
<xsl:apply-templates mode="c2p" select="mml:degree/node()"/>
</xsl:when>
<xsl:when test="mml:bvar/mml:degree[string(number(.))='NaN']">
<xsl:for-each select="mml:bvar/mml:degree">
<xsl:apply-templates mode="c2p" select="node()"/>
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
     <xsl:apply-templates mode="c2p"  select="*[last()]"/></mml:mrow>
<mml:mrow>
<xsl:for-each select="mml:bvar">

<mml:mrow>
<mml:mo>&#8706;<!-- partial --></mml:mo><mml:msup><xsl:apply-templates mode="c2p" select="node()"/>
                     <mml:mrow><xsl:apply-templates mode="c2p" select="mml:degree/node()"/></mml:mrow>
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
 <mml:mi><xsl:apply-templates mode="c2p"/></mml:mi>
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
<xsl:apply-templates mode="c2p" select="*[2]"/>
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

<xsl:template
match="mml:apply[*[1][self::mml:cartesianproduct][count(following-sibling::mml:reals)=count(following-sibling::*)]]"
priority="2">
<mml:msup>
<xsl:apply-templates mode="c2p" select="*[2]">
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
 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:lowlimit/*|mml:interval/*[1]|mml:condition/*"/></mml:mrow>
 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:uplimit/*|mml:interval/*[2]"/></mml:mrow>

 </mml:msubsup>
 <xsl:apply-templates mode="c2p" select="*[last()]"/>
</mml:mrow>
</xsl:template>

<!-- 4.4.7.2 product -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:product]]">
 <mml:mrow>
 <mml:msubsup>
  <mml:mo>&#8719;<!--product--></mml:mo>
 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:lowlimit/*|mml:interval/*[1]|mml:condition/*"/></mml:mrow>

 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:uplimit/*|mml:interval/*[2]"/></mml:mrow>
 </mml:msubsup>
 <xsl:apply-templates mode="c2p" select="*[last()]"/>
</mml:mrow>
</xsl:template>

<!-- 4.4.7.3 limit -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:limit]]">
 <mml:mrow>
 <mml:munder>
  <mml:mi>limit</mml:mi>

 <mml:mrow><xsl:apply-templates mode="c2p" select="mml:lowlimit|mml:condition/*"/></mml:mrow>
 </mml:munder>
 <xsl:apply-templates mode="c2p" select="*[last()]"/>
</mml:mrow>
</xsl:template>

<xsl:template mode="c2p" match="mml:apply[mml:limit]/mml:lowlimit" priority="3">
<mml:mrow>
<xsl:apply-templates mode="c2p" select="../mml:bvar/node()"/>
<mml:mo>&#8594;<!--rightarrow--></mml:mo>
<xsl:apply-templates mode="c2p"/>
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
<xsl:apply-templates mode="c2p" select="*[2]">
  <xsl:with-param name="p" select="7"/>

</xsl:apply-templates>
</mml:mrow>
</xsl:template>




<!-- 4.4.8.2 exp -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:exp]]">
<mml:msup>
<mml:mi>e<!-- exponential e--></mml:mi>
<mml:mrow><xsl:apply-templates mode="c2p" select="*[2]"/></mml:mrow>
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
<mml:mrow><xsl:apply-templates mode="c2p" select="mml:logbase/node()"/></mml:mrow>
</mml:msub>
</xsl:otherwise>

</xsl:choose>
<xsl:apply-templates mode="c2p" select="*[last()]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
</mml:mrow>
</xsl:template>


<!-- 4.4.9.1 mean -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:mean]]">
<mml:mrow>
 <mml:mo>&#9001;<!--langle--></mml:mo>
    <xsl:for-each select="*[position()&gt;1]">
      <xsl:apply-templates mode="c2p" select="."/>

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
<xsl:apply-templates mode="c2p" select="*[2]"/>
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

      <xsl:apply-templates mode="c2p" select="*[last()]"/>
      <mml:mrow><xsl:apply-templates mode="c2p" select="mml:degree/node()"/></mml:mrow>
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
<mml:mtr><mml:mtd><xsl:apply-templates mode="c2p" select="."/></mml:mtd></mml:mtr>
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
<xsl:apply-templates mode="c2p"/>

</mml:mtable>
<mml:mo>)</mml:mo>
</mml:mrow>
</xsl:template>

<!-- 4.4.10.3 matrixrow  -->
<xsl:template mode="c2p" match="mml:matrixrow">
<mml:mtr>
<xsl:for-each select="*">
<mml:mtd><xsl:apply-templates mode="c2p" select="."/></mml:mtd>
</xsl:for-each>
</mml:mtr>
</xsl:template>

<!-- 4.4.10.4 determinant  -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:determinant]]">

<mml:mrow>
<mml:mi>det</mml:mi>
<xsl:apply-templates mode="c2p" select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
</mml:mrow>
</xsl:template>

<xsl:template
match="mml:apply[*[1][self::mml:determinant]][*[2][self::mml:matrix]]" priority="2">
<mml:mrow>
<mml:mo>|</mml:mo>
<mml:mtable>
<xsl:apply-templates mode="c2p" select="mml:matrix/*"/>
</mml:mtable>

<mml:mo>|</mml:mo>
</mml:mrow>
</xsl:template>

<!-- 4.4.10.5 transpose -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:transpose]]">
<mml:msup>
<xsl:apply-templates mode="c2p" select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
<mml:mi>T</mml:mi>
</mml:msup>
</xsl:template>

<!-- 4.4.10.5 selector -->
<xsl:template mode="c2p" match="mml:apply[*[1][self::mml:selector]]">
<mml:msub>
<xsl:apply-templates mode="c2p" select="*[2]">
  <xsl:with-param name="p" select="7"/>
</xsl:apply-templates>
<mml:mrow>
    <xsl:for-each select="*[position()&gt;2]">
      <xsl:apply-templates mode="c2p" select="."/>
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
 <xsl:apply-templates mode="c2p" select="*[1]"/>
</xsl:template>
<xsl:template mode="c2p" match="mml:semantics[mml:annotation-xml/@encoding='MathML-Presentation']">
 <xsl:apply-templates mode="c2p" select="mml:annotation-xml[@encoding='MathML-Presentation']/node()"/>
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
   <xsl:apply-templates mode="c2p" select=".">
     <xsl:with-param name="p" select="$this-p"/>
   </xsl:apply-templates>
  </xsl:for-each>

  <xsl:if test="$this-p &lt; $p"><mml:mo>)</mml:mo></xsl:if>
  </mml:mrow>
</xsl:template>

<xsl:template name="binary" >
  <xsl:param name="mo"/>
  <xsl:param name="p" select="0"/>
  <xsl:param name="this-p" select="0"/>
  <mml:mrow>
  <xsl:if test="$this-p &lt; $p"><mml:mo>(</mml:mo></xsl:if>

   <xsl:apply-templates mode="c2p" select="*[2]">
     <xsl:with-param name="p" select="$this-p"/>
   </xsl:apply-templates>
   <xsl:copy-of select="$mo"/>
   <xsl:apply-templates mode="c2p" select="*[3]">
     <xsl:with-param name="p" select="$this-p"/>
   </xsl:apply-templates>
  <xsl:if test="$this-p &lt; $p"><mml:mo>)</mml:mo></xsl:if>

  </mml:mrow>
</xsl:template>

<xsl:template name="set" >
  <xsl:param name="o" select="'{'"/>
  <xsl:param name="c" select="'}'"/>
  <mml:mrow>
   <mml:mo><xsl:value-of select="$o"/></mml:mo>
   <xsl:choose>
   <xsl:when test="mml:condition">

   <mml:mrow><xsl:apply-templates mode="c2p" select="mml:bvar/*[not(self::bvar or self::condition)]"/></mml:mrow>
   <mml:mo>|</mml:mo>
   <mml:mrow><xsl:apply-templates mode="c2p" select="mml:condition/node()"/></mml:mrow>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="*">
      <xsl:apply-templates mode="c2p" select="."/>
      <xsl:if test="position() !=last()"><mml:mo>,</mml:mo></xsl:if>

    </xsl:for-each>
   </xsl:otherwise>
   </xsl:choose>
   <mml:mo><xsl:value-of select="$c"/></mml:mo>
  </mml:mrow>
</xsl:template>

<!--
$Id: pmathml.xsl,v 1.8 2003/06/23 14:46:44 davidc Exp $

Copyright David Carlisle 2001, 2002.

Use and distribution of this code are permitted under the terms of the <a
href="http://www.w3.org/Consortium/Legal/copyright-software-19980720"
>W3C Software Notice and License</a>.
-->

<!-- MathPlayer mpdialog code for contributed by
     Jack Dignan and Robert Miner, both of Design Science.
-->

<xsl:output method="xml" omit-xml-declaration="yes"  />

<ie5:if doc:id="iehack" test=".">
    <ie5:eval no-entities="t">'&lt;!--'</ie5:eval>
</ie5:if>


<fns:x name="mathplayer" o="MathPlayer.Factory.1">

<object id="mmlFactory" 
        classid="clsid:32F66A20-7614-11D4-BD11-00104BD3F987">
</object>
<?import namespace="mml" implementation="#mmlFactory"?>
</fns:x>

<fns:x name="techexplorer" o="techexplorer.AxTchExpCtrl.1">
<object id="mmlFactory" classid="clsid:0E76D59A-C088-11D4-9920-002035EFB1A4">
</object>
<?import namespace="mml" implementation="#mmlFactory"?>
</fns:x>


<!-- SCRIPT not script due to weird mozilla bug
http://bugzilla.mozilla.org/show_bug.cgi?id=158457
-->

<fns:x name="css" o="Microsoft.FreeThreadedXMLDOM">
<SCRIPT for="window" event="onload">
var xsl = new ActiveXObject("Microsoft.FreeThreadedXMLDOM");
xsl.async = false;
xsl.validateOnParse = false;
xsl.load("pmathmlcss.xsl");
var xslTemplate = new ActiveXObject("MSXML2.XSLTemplate.3.0");
xslTemplate.stylesheet=xsl.documentElement;
var xslProc = xslTemplate.createProcessor();
xslProc.input = document.XMLDocument;
xslProc.transform();
var str = xslProc.output;

<!-- work around bug in IE6 under Win XP, RM 6/5/2002 -->
var repl = "replace";
if (window.navigator.appVersion.match(/Windows NT 5.1/)) { repl = ""; }
var newDoc = document.open("text/html", repl);
newDoc.write(str);
</SCRIPT>
</fns:x>


<h:p>
in mpdialog mode, we just write out some JavaScript to display 
dialog to the reader asking whether they want to install MathPlayer 
Depending on the response we get, we then instantiate an XSL processor
and reprocess the doc, passing $secondpass according to the
reader response.
</h:p>
<h:p>Using d-o-e is fairly horrible, but this code is only for IE
anyway, and we need to force HTML semantics in this case.</h:p>

<xsl:variable name="mpdialog">
var cookieName = "MathPlayerInstall=";
function MPInstall(){
 var showDialog=true;
 var c = document.cookie;
 var i = c.indexOf(cookieName);
 if (i >= 0) {
  if ( c.substr(i + cookieName.length, 1) >= 2) { showDialog=false; }
 }
 if (showDialog) {
  MPDialog();
  c = document.cookie;
  i = c.indexOf(cookieName);
 }
 if (i >= 0) return c.substr(i + cookieName.length, 1);
 else return null;
}

function MPDialog() {
 var vArgs="";
 var sFeatures="dialogWidth:410px;dialogHeight:190px;help:off;status:no";
 var text = "";
 text += "javascript:document.write('"
 text += '&lt;script>'
 text += 'function fnClose(v) { '
 text += 'var exp = new Date();'
 text += 'var thirtyDays = exp.getTime() + (30 * 24 * 60 * 60 * 1000);'
 text += 'exp.setTime(thirtyDays);'
 text += 'var cookieProps = ";expires=" + exp.toGMTString();'
 text += 'if (document.forms[0].dontask.checked) v+=2;'
 text += 'document.cookie="' + cookieName + '"+v+cookieProps;'
 text += 'window.close();'
 text += '}'
 text += '&lt;/' + 'script>'
 text += '&lt;head>&lt;title>Install MathPlayer?&lt;/title>&lt;/head>'
 text += '&lt;body bgcolor="#D4D0C8">&lt;form>'
 text += '&lt;table cellpadding=10 style="font-family:Arial;font-size:10pt" border=0 width=100%>'
 text += '&lt;tr>&lt;td align=left>This page requires Design Science\\\'s MathPlayer&amp;trade;.&lt;br>'
 text += 'Do you want to download and install MathPlayer?&lt;/td>&lt;/tr>';
 text += '&lt;tr>&lt;td align=center>&lt;input type="checkbox" name="dontask">'
 text += 'Don\\\'t ask me again&lt;/td>&lt;/tr>'
 text += '&lt;tr>&lt;td align=center>&lt;input id=yes type="button" value=" Yes "'
 text += ' onClick="fnClose(1)">&amp;nbsp;&amp;nbsp;&amp;nbsp;'
 text += '&lt;input type="button" value="  No  " onClick="fnClose(0)">&lt;/td>&lt;/tr>'
 text += '&lt;/table>&lt;/form>';
 text += '&lt;/body>'
 text += "')"
 window.showModalDialog( text , vArgs, sFeatures );
}

function WaitDialog() {
 var vArgs="";
 var sFeatures="dialogWidth:510px;dialogHeight:150px;help:off;status:no";
 var text = "";
 text += "javascript:document.write('"
 text += '&lt;script>'
 text += 'window.onload=fnLoad;'
 text += 'function fnLoad() {document.forms[0].yes.focus();}'
 text += 'function fnClose(v) { '
 text += 'window.returnValue=v;'
 text += 'window.close();'
 text += '}'
 text += '&lt;/' + 'script>'
 text += '&lt;head>&lt;title>Wait for Installation?&lt;/title>&lt;/head>'
 text += '&lt;body bgcolor="#D4D0C8" onload="fnLoad()">&lt;form>&lt;'
 text += 'table cellpadding=10 style="font-family:Arial;font-size:10pt" border=0 width=100%>'
 text += '&lt;tr>&lt;td align=left>Click OK once MathPlayer is installed '
 text += 'to refresh the page.&lt;br>'
 text += 'Click Cancel to view the page immediately without MathPlayer.&lt;/td>&lt;/tr>';
 text += '&lt;tr>&lt;td align=center>&lt;input id=yes type="button" '
 text += 'value="   OK   " onClick="fnClose(1)">&amp;nbsp;&amp;nbsp;&amp;nbsp;'
 text += '&lt;input type="button" value="Cancel" onClick="fnClose(0)">&lt;/td>&lt;/tr>'
 text += '&lt;/table>&lt;/form>';
 text += '&lt;/body>'
 text += "')"
 return window.showModalDialog( text , vArgs, sFeatures );
}

var result = MPInstall();

var action = "fallthrough";
if (result == 1 || result == 3) {
 window.open("http://www.dessci.com/webmath/mathplayer");
 var wait = WaitDialog();
 if ( wait == 1) {
  action =  "install";
  document.location.reload();

 }
}
if (action == "fallthrough") {
var xsl = new ActiveXObject("Microsoft.FreeThreadedXMLDOM");
xsl.async = false;
xsl.validateOnParse = false;
xsl.load("pmathmlcss.xsl");
var xslTemplate = new ActiveXObject("MSXML2.XSLTemplate.3.0");
xslTemplate.stylesheet=xsl.documentElement;
var xslProc = xslTemplate.createProcessor();
xslProc.input = document.XMLDocument;

xslProc.transform();
var str = xslProc.output;

<!-- work around bug in IE6 under Win XP, RM 6/5/2002 -->
var repl = "replace";
if (window.navigator.appVersion.match(/Windows NT 5.1/)) { repl = ""; }
var newDoc = document.open("text/html", repl);
newDoc.write(str);
document.close();
}
</xsl:variable>

<fns:x name="mathplayer-dl" >mathplayer-dl</fns:x>

<fns:x name="techexplorer-plugin" >techexplorer-plugin</fns:x>

<xsl:variable name="root" select="/"/>



<xsl:param name="activex">
   <xsl:choose>

     <xsl:when test="/*/@fns:renderer='techexplorer-plugin'">techexplorer-plugin</xsl:when>
     <xsl:when test="system-property('xsl:vendor')!='Microsoft'"/>
     <xsl:otherwise>
<xsl:variable name="docpref" select="document('')/*/fns:x[@name=$root/*/@fns:renderer][1]"/>
     <xsl:choose>
     <xsl:when test="$docpref='mathplayer-dl'">mathplayer-dl</xsl:when>
     <xsl:when test="$docpref and fns:isinstalled(string($docpref/@o))='true'">
           <xsl:copy-of select="$docpref/node()"/>

     </xsl:when>
     <xsl:otherwise>
       <xsl:copy-of select="(document('')/*/fns:x[fns:isinstalled(string(@o))='true'])[1]/node()"/>
     </xsl:otherwise>
  </xsl:choose>
     </xsl:otherwise>
  </xsl:choose>
</xsl:param>

<h:div doc:ref="iehack">

<h:h3>IE5 hacks</h:h3>
<h:p>This code will be ignored by an XSLT engine as a top level
element in a foreign namespace. It will be executed by an IE5XSL
engine and insert &lt;!-- into the output stream, ie the start of a
comment. This will comment out all the XSLT code which will be copied
to the output. A similar clause below will close this comment, it is
then followed by the IE5XSL templates to be executed.</h:p>
<h:p>This trick is due to Jonathan Marsh of Microsoft, and used in
<h:a href="http://www.w3.org/TR/2001/WD-query-datamodel-20010607/xmlspec-ie-dm.xsl">the stylesheet for
the XPath 2 data model draft</h:a>.</h:p>
</h:div>

<h:h2>XSLT stylesheet</h:h2>
<h:h3>MSXSL script block</h:h3>

<h:p>The following script block implements an extension function that
tests whether a specified ActiveX component is known to the client.
This is used below to test for the existence of MathML rendering
components.</h:p>

<msxsl:script language="JScript" implements-prefix="fns">
    function isinstalled(ax) 
    {
    try {
        var ActiveX = new ActiveXObject(ax);
        return "true";
    } catch (e) {
        return "false";
    }
}
</msxsl:script>

<h:p>The main bulk of this stylesheet is an identity transformation so...</h:p>
<xsl:template match="*|comment()">
<xsl:copy>
<xsl:copy-of select="@*"/>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>



<h:p>XHTML elements are copied sans prefix (XHTML is default namespace
here, so these elements will still be in XHTML namespace</h:p>

<xsl:template match="h:*">
<xsl:element name="{local-name(.)}">
 <xsl:copy-of select="@*"/>
<xsl:apply-templates/>
</xsl:element>
</xsl:template>

<h:p>IE's treatment of XHTML as HTML needs a little help here...</h:p>
<xsl:template match="h:br|h:hr">
<xsl:choose>
<xsl:when test="system-property('xsl:vendor')='Microsoft'">
  <xsl:value-of disable-output-escaping="yes" select="concat('&lt;',local-name(.))"/>
  <xsl:apply-templates mode="verb" select="@*"/>

  <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:element name="{local-name(.)}">
 <xsl:copy-of select="@*"/>
<xsl:apply-templates/>
</xsl:element>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<h:p>This just ensures the mathml prefix declaration isn't copied from
the source at this stage, so that the system will use the mml prefix
coming from this stylesheet</h:p>
<xsl:template match="h:html|html">
<html>

<xsl:copy-of select="@*[not(namespace-uri(.)='http://www.w3.org/2002/Math/preference')]"/>
<xsl:apply-templates/>
</html>
</xsl:template>

<h:p>We modify the head element to add code to specify a Microsoft
"Behaviour" if the behaviour component is known to the system.</h:p>
<h:span doc:ref="mp">Test for MathPlayer (Design Science)</h:span>
<h:span doc:ref="te">Test for Techexplorer (IBM)</h:span>
<h:span doc:ref="ms"><h:div>Test for Microsoft. In this case we just
output a small HTML file that executes a script that will re-process
the source docuument with a different stylesheet. Doing things this
way avoids the need to xsl:import the second stylesheet, which would
very much increase the processing overhead of running this
stylesheet.</h:div></h:span>
<h:span doc:ref="other">Further tests (eg for netscape/mozilla) could
be added here if necessary</h:span>
<xsl:template match="h:head|head">
<head>

<!-- new if for IE frames bug -->
<xsl:if test="system-property('xsl:vendor')='Microsoft'">
<xsl:if test="name(msxsl:node-set($activex)/*)=''">
<object id="mmlFactory" 
        classid="clsid:32F66A20-7614-11D4-BD11-00104BD3F987">
</object>
<xsl:processing-instruction name="import">
 namespace="mml" implementation="#mmlFactory"
</xsl:processing-instruction>
</xsl:if>
</xsl:if>

<xsl:choose>
<xsl:when doc:id="mp" test="$activex='mathplayer-dl'">
    <xsl:if test="fns:isinstalled('MathPlayer.Factory.1')='false'">

     <SCRIPT for="window" event="onload">
       <xsl:value-of select="$mpdialog" disable-output-escaping="yes"/>
     </SCRIPT>
    </xsl:if>
   <xsl:copy-of select="document('')/*/fns:x[@name='mathplayer']"/>
</xsl:when>
<xsl:when doc:id="mp" test="not($activex='techexplorer-plugin') and system-property('xsl:vendor')='Microsoft'">
  <xsl:copy-of select="$activex"/>
</xsl:when>
<xsl:otherwise doc:id="other">
</xsl:otherwise>

</xsl:choose>
  <xsl:apply-templates/>
</head>
</xsl:template>


<xsl:template match="mml:math" priority="22">
<xsl:choose>
<xsl:when test="$activex='techexplorer-plugin'">
<embed  type="text/mathml" height="75" width="300">
<xsl:attribute name="mmldata">
<xsl:apply-templates mode="verb" select="."/>
</xsl:attribute>
</embed>
</xsl:when>
<xsl:otherwise>

<xsl:element name="mml:{local-name(.)}">
 <xsl:copy-of select="@*"/>
<xsl:apply-templates/>
</xsl:element>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- squash annotation elements -->



<h:p>Somewhat bizarrely in an otherwise namespace aware system,
Microsoft behaviours are defined to trigger off the
<h:em>prefix</h:em> not the <h:em>Namespace</h:em>. In the code above
we associated a MathML rendering behaviour (if one was found) with the
prefix <h:code>mml:</h:code> so here we ensure that this is the prefix
that actually gets used in the output.</h:p>

<xsl:template match="mml:*">
<xsl:element name="mml:{local-name(.)}">
 <xsl:copy-of select="@*"/>
<xsl:apply-templates/>
</xsl:element>
</xsl:template>

<h:p>Copy semantics element through in IE (so mathplayer gets to see
mathplayer annotations, otherwise use first child or a presentation annotation.</h:p>
<xsl:template match="mml:semantics">
<xsl:choose>
 <xsl:when test="system-property('xsl:vendor')='Microsoft'">
   <xsl:element name="mml:{local-name(.)}">
    <xsl:copy-of select="@*"/>

    <xsl:apply-templates/>
   </xsl:element>
 </xsl:when>
 <xsl:when test="mml:annotation-xml[@encoding='MathML-Presentation']">
   <xsl:apply-templates select="mml:annotation-xml[@encoding='MathML-Presentation']/node()"/>  
 </xsl:when>
 <xsl:otherwise>
   <xsl:apply-templates select="*[1]"/>  
 </xsl:otherwise>
</xsl:choose>

</xsl:template>

<!-- a version of my old verb.xsl -->

<!-- non empty elements and other nodes. -->
<xsl:template mode="verb" match="*[*]|*[text()]|*[comment()]|*[processing-instruction()]">
  <xsl:value-of select="concat('&lt;',local-name(.))"/>
  <xsl:apply-templates mode="verb" select="@*"/>
  <xsl:text>&gt;</xsl:text>
  <xsl:apply-templates mode="verb"/>
  <xsl:value-of select="concat('&lt;/',local-name(.),'&gt;')"/>
</xsl:template>

<!-- empty elements -->
<xsl:template mode="verb" match="*">
  <xsl:value-of select="concat('&lt;',local-name(.))"/>
  <xsl:apply-templates mode="verb" select="@*"/>
  <xsl:text>/&gt;</xsl:text>
</xsl:template>

<!-- attributes
     Output always surrounds attribute value by "
     so we need to make sure no literal " appear in the value  -->
<xsl:template mode="verb" match="@*">
  <xsl:value-of select="concat(' ',local-name(.),'=')"/>
  <xsl:text>"</xsl:text>

  <xsl:call-template name="string-replace">
    <xsl:with-param name="from" select="'&quot;'"/>
    <xsl:with-param name="to" select="'&amp;quot;'"/> 
    <xsl:with-param name="string" select="."/>
  </xsl:call-template>
  <xsl:text>"</xsl:text>
</xsl:template>

<!-- pis -->
<xsl:template mode="verb" match="processing-instruction()"/>

<!-- only works if parser passes on comment nodes -->
<xsl:template mode="verb" match="comment()"/>


<!-- text elements
     need to replace & and < by entity references-->
<xsl:template mode="verb" match="text()">
  <a name="{generate-id(.)}"/>
  <xsl:call-template name="string-replace">
    <xsl:with-param name="to" select="'&amp;gt;'"/>
    <xsl:with-param name="from" select="'&gt;'"/> 
    <xsl:with-param name="string">
      <xsl:call-template name="string-replace">

        <xsl:with-param name="to" select="'&amp;lt;'"/>
        <xsl:with-param name="from" select="'&lt;'"/> 
        <xsl:with-param name="string">
          <xsl:call-template name="string-replace">
            <xsl:with-param name="to" select="'&amp;amp;'"/>
            <xsl:with-param name="from" select="'&amp;'"/> 
            <xsl:with-param name="string" select="."/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>

    </xsl:with-param>
  </xsl:call-template>
</xsl:template>


<!-- end  verb mode -->

<!-- replace all occurences of the character(s) `from'
     by the string `to' in the string `string'.-->
<xsl:template name="string-replace" >
  <xsl:param name="string"/>
  <xsl:param name="from"/>
  <xsl:param name="to"/>

  <xsl:choose>
    <xsl:when test="contains($string,$from)">
      <xsl:value-of select="substring-before($string,$from)"/>
      <xsl:value-of select="$to"/>
      <xsl:call-template name="string-replace">
      <xsl:with-param name="string" select="substring-after($string,$from)"/>
      <xsl:with-param name="from" select="$from"/>
      <xsl:with-param name="to" select="$to"/>
      </xsl:call-template>

    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- end of verb.xsl -->



<h:h2>IE5XSL stylesheet</h:h2>
<h:p>In a rare fit of sympathy for users of
<h:em>the-language-known-as-XSL-in-IE5</h:em> this file incorporates a
version of the above code designed to work in the Microsoft dialect.
This is needed otherwise users of a MathML rendering behaviour would
have to make a choice whether they wanted to use this stylesheet
(keeping their source documents conforming XHTML+MathML) or to use
the explicit Microsoft Object code, which is less portable, but would
work in at least IE5.5.</h:p>

<h:p>This entire section of code, down to the end of the stylesheet is
contained within this ie5:if. Thus XSLT sees it as a top level element
from a foreign namespace and silently ignores it. IE5XSL sees it as
"if true" and so executes the code.</h:p>


<h:p doc:ref="closecomment">First close the comment started at the beginning. This ensures
that the bulk of the XSLT code, while being copied to the result tree
by the IE5XSL engine, will not be rendered in the browser.</h:p>

<h:span doc:ref="eval">Lacking attribute value templates in
xsl:element, and the local-name() function, we resort to constructing
the start and end tags in strings in javascript, then using
no-entities attribute which is the IE5XSL equivalent of disable-output-encoding</h:span>

<ie5:if test=".">

<ie5:eval doc:id="closecomment" no-entities="t">'--&gt;'</ie5:eval>

<ie5:apply-templates select=".">


<ie5:script>
    function mpisinstalled() 
    {
    try {
        var ActiveX = new ActiveXObject("MathPlayer.Factory.1");
        return "true";
    } catch (e) {
        return "false";
    }
}
</ie5:script>

<ie5:template match="/">
<ie5:apply-templates/>
</ie5:template>

<ie5:template match="head|h:head"/>

<ie5:template match="text()">
<ie5:value-of select="."/>
</ie5:template>

<ie5:template match="*|@*">
<ie5:copy>
<ie5:apply-templates select="*|text()|@*"/>
</ie5:copy>
</ie5:template>


<ie5:template match="mml:*">
<ie5:eval  no-entities="t" doc:id="eval">'&lt;mml:' + this.nodeName.substring(this.nodeName.indexOf(":")+1)</ie5:eval>

<ie5:for-each select="@*">
<ie5:eval no-entities="t">' ' + this.nodeName</ie5:eval>="<ie5:value-of select="."/>"
</ie5:for-each>
<ie5:eval no-entities="t">'&gt;'</ie5:eval>
<ie5:apply-templates select="*|text()"/>
<ie5:eval no-entities="t">'&lt;/mml:' +  this.nodeName.substring(this.nodeName.indexOf(":")+1) + '&gt;'</ie5:eval>
</ie5:template>


<ie5:template match="mml:math">

<ie5:if expr="mpisinstalled()=='false'">
<embed  type="text/mathml" height="75" width="300">
<ie5:attribute name="mmldata">
<ie5:eval  doc:id="eval"  no-entities="t">'&lt;math&gt;'</ie5:eval>
<ie5:apply-templates/>
<ie5:eval  doc:id="eval"  no-entities="t">'&lt;/math&gt;'</ie5:eval>
</ie5:attribute>
</embed>
</ie5:if>
<ie5:if expr="mpisinstalled()=='true'">
<ie5:eval  doc:id="eval"  no-entities="t">'&lt;mml:' + this.nodeName.substring(this.nodeName.indexOf(":")+1)</ie5:eval>

<ie5:for-each select="@*">
<ie5:eval no-entities="t">' ' + this.nodeName</ie5:eval>="<ie5:value-of select="."/>"
</ie5:for-each>
<ie5:eval no-entities="t">'&gt;'</ie5:eval>
<ie5:apply-templates select="*|text()"/>
<ie5:eval no-entities="t">'&lt;/mml:' +  this.nodeName.substring(this.nodeName.indexOf(":")+1) + '&gt;'</ie5:eval>
</ie5:if>
</ie5:template>

<ie5:template match="html|h:html">

<html   xmlns:mml="http://www.w3.org/1998/Math/MathML">
<head>
<ie5:if expr="mpisinstalled()=='true'">
<object id="mmlFactory"
        classid="clsid:32F66A20-7614-11D4-BD11-00104BD3F987">
</object>
<ie5:pi name="IMPORT">
 namespace="mml" implementation="#mmlFactory"
</ie5:pi>
</ie5:if>
<ie5:apply-templates select="h:head/*|head/*"/>
</head>
<body>
<ie5:apply-templates select="body|h:body"/>
</body>
</html>
</ie5:template>

</ie5:apply-templates>


</ie5:if>

</xsl:stylesheet>

