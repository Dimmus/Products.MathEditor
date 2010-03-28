<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mmled="http://cnx.rice.edu/mmled"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns="http://www.w3.org/1999/xhtml">

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

  <!-- We need to import the other Math. Unfortunately this can't be done in a 
       file that includes this one because this file uses xsl:apply-imports
       to wrap what is rendered with an ID -->

  <xsl:template name="add-id3">
    <xsl:param name="prefix"><!-- pres- --></xsl:param>
    <xsl:if test="@id">
      <xsl:attribute name="id"><xsl:value-of
        select="$prefix" /><xsl:value-of select="@id" /></xsl:attribute>
    </xsl:if>
    <xsl:if test="@__optional">
      <xsl:attribute name="class">optional</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="add-id2">
    <xsl:param name="class">content-math</xsl:param>
    <xsl:param name="value" select="text()"/>
    <xsl:if test="@id">
      <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
      <xsl:if test="$class != ''">
        <xsl:attribute name="class"><xsl:value-of select="$class"/><xsl:if test="@__type-error"> type-error</xsl:if></xsl:attribute>
      </xsl:if>
      <xsl:if test="@__type-error">
        <xsl:attribute name="title">
          <xsl:value-of select="@__type-error"/>
        </xsl:attribute>
      </xsl:if>

      <!-- only display input box when it's not a button -->
      <!-- TODO: These should match the cursor functions -->
      <xsl:choose>
        <xsl:when
          test="local-name(.)='block' and (@__type='piece' or @__type='matrixrow')"></xsl:when>
        <xsl:when test="local-name(.)='block' and $value">
          <span class="parse-error" title="Could not parse this. Please try again">
            <xsl:value-of select="$value"/>
          </span>
        </xsl:when>
        <xsl:when test="local-name(.)='block' or ((text()='' or not(text())) and (local-name(.)='mi' or local-name(.)='mn' or local-name(.)='mo' or local-name(.)='mtext' or (local-name(.)='csymbol' and text())))">
          <input type="text" id="input-{@id}"
            class="mathEditorInvisibleInput" onblur="MathInput.onblurBlock    (event, this, '{@id}');"
            onfocus="MathInput.onfocusBlock   (event, this, '{@id}');"
            onkeyup="MathInput.onkeyupBlock   (event, this, '{@id}');"
            onkeydown="MathInput.onkeydownBlock (event, this, '{@id}');">
            <xsl:attribute name="class">
              <xsl:if test="$value">parse-error </xsl:if><!-- Need the space for multiple classes -->
              <xsl:if test="not(@extra)">mathEditorInput </xsl:if>
              <xsl:if
                test="@extra and not(@__type='piece' or @__type='matrixrow')">mathEditorInputExpandable </xsl:if>
              <xsl:if test="../@__optional">optional</xsl:if>
            </xsl:attribute>
            <xsl:attribute name="value">
                    <xsl:choose>
                      <xsl:when
              test="local-name(.)='block' and @extra and not(@__type='piece' or @__type='matrixrow')"><!-- &hellip; --></xsl:when>
                      <xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
          </input>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!-- ****************************************** -->
  <!--   Add button for mml:piece mml:matrixrow   -->
  <!-- ****************************************** -->
  <xsl:template match="mmled:block">
    <mrow>
      <xsl:call-template name="add-id2" />
    <xsl:if
      test="@extra = 'expandable' and (@__type='piece' or @__type='matrixrow')">
      <mi>
        <span title="{@__type}">
          <button class="block"
            onclick="MmlEditor_Input.expandableOnclick(event, this, '{@id}', '{@__type}');">...</button>
        </span>
      </mi>
    </xsl:if>
    </mrow>
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
  <xsl:template
    match="mml:cn|mml:ci|mml:apply|mml:integers|mml:reals|mml:rationals|mml:naturalnumbers|mml:complexes|mml:primes|mml:exponentiale|mml:imaginaryi|mml:notanumber|mml:true|mml:false|mml:emptyset|mml:pi|mml:eulergamma|mml:infinity|mml:vector|mml:matrix|mml:piecewise|mml:piece|mml:list|mml:set|mml:csymbol|mml:ident">
    <xsl:param name="p" select="0" /><!-- Used by the w3c version to send precedence-information -->
    <mrow>
      <xsl:call-template name="add-id2" />
<!-- Need to use element in WebKit so the math elements belong to the html namespace and can be found by document.getElementById() -->
<xsl:copy>

	      <xsl:apply-templates select="@*|node()">
	        <xsl:with-param name="p" select="$p"/>
	      </xsl:apply-templates>
</xsl:copy>
    </mrow>
  </xsl:template>

  <!-- Don't make id's for the rest of the elements (lower priority) -->
  <xsl:template match="@*|node()">
    <xsl:param name="p" select="0" />
    <xsl:copy>
      <xsl:apply-templates select="@*|node()">
        <xsl:with-param name="p" select="$p"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
    
</xsl:stylesheet>
