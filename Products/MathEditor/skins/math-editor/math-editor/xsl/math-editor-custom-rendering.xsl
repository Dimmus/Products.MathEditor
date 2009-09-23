<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mmled="http://cnx.rice.edu/mmled"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns="http://www.w3.org/1999/xhtml">


  <!-- ******************************* -->
  <!-- Custom overrides for the editor -->
  <!-- ******************************* -->

  <!-- 4.4.2.16` piecewise -->
  <!--
    Special piecewise code to handle the input boxes for the mml:mtr
  -->
  <xsl:template match="mml:piecewise">
    <mml:mrow>
      <mml:mfenced open="{{" close="]">
        <mml:mtable>
          <xsl:for-each select="mml:piece">
            <mml:mtr>
              <xsl:call-template name="add-id3" />
              <mml:mtd><!-- For cursor --></mml:mtd>
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
              <mml:mtd><!-- For cursor --></mml:mtd>
            </mml:mtr>
          </xsl:for-each>
          <!-- **************************** -->
          <!-- In the middle, so otherwise shows up below the expandable part -->
          <!-- **************************** -->
          <xsl:for-each select="mmled:block">
            <mml:mtr>
              <mml:mtd><!-- For cursor --></mml:mtd>
              <mml:mtd/>
              <mml:mtd>
                <xsl:apply-templates select="." />
              </mml:mtd>
              <mml:mtd/>
              <mml:mtd><!-- For cursor --></mml:mtd>
            </mml:mtr>
          </xsl:for-each>
          <xsl:for-each select="mml:otherwise">
            <mml:mtr>
              <xsl:call-template name="add-id3" />
              <mml:mtd><!-- For cursor --></mml:mtd>
              <mml:mtd>
                <xsl:apply-templates select="*[1]" />
              </mml:mtd>
              <mml:mtd />
              <mml:mtd>
                <mml:mtext>otherwise</mml:mtext>
              </mml:mtd>
              <mml:mtd><!-- For cursor --></mml:mtd>
            </mml:mtr>
          </xsl:for-each>
        </mml:mtable>
      </mml:mfenced>
    </mml:mrow>
  </xsl:template>

  <!-- 4.4.10.3 matrixrow  -->
  <!-- Add special stuff for mml:mtr support -->
  <xsl:template match="mml:matrixrow">
    <mml:mtr>
      <xsl:call-template name="add-id3" />
      <mml:mtd/><!--For cursor -->
      <xsl:for-each select="*">
        <mml:mtd>
          <xsl:apply-templates select="." />
        </mml:mtd>
      </xsl:for-each>
      <mml:mtd/><!--For cursor -->
    </mml:mtr>
  </xsl:template>

  <!-- 4.4.10.2 matrix  -->
  <!-- Add an extra invisible column for cursor (mml:mtr support) -->
  <xsl:template match="mml:matrix">
    <mml:mfenced open="(" close=")">
      <mml:mtable>
        <xsl:apply-templates select="mml:matrixrow"/>
        <xsl:for-each select="mmled:block">
          <mml:mtr>
            <mml:mtd/><!--For cursor -->
            <mml:mtd>
              <xsl:apply-templates select="."/>
            </mml:mtd>
            <!--TODO: Maybe be smart and figure out how many mml:mtd's to insert here -->
            <mml:mtd/><!--For cursor -->
          </mml:mtr>
        </xsl:for-each>
      </mml:mtable>
    </mml:mfenced>
  </xsl:template>

  <!-- 4.4.3.3 divide -->
  <!-- Draw a vertical fraction for division instead of the "/" -->
  <xsl:template match="mml:apply[*[1][self::mml:divide]]">
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
  <xsl:template match="mml:apply[*[1][self::mml:int]]">
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
  <!-- NOTE: the class stuff is also interspersed in cnxmathmlc2p-custom.xsl -->
  <xsl:template match="mml:mn|mml:mi|mml:mo|mml:mtext|mml:mrow|mml:mfrac|mml:msqrt|mml:mroot|mml:mstyle|mml:merror|mml:mpadded|mml:mfenced|mml:menclose|mml:msub|mml:msup|mml:msubsup|mml:munder|mml:mover|mml:munderover|mml:mmultiscripts|mml:mtable|mml:mlabeledtr|mml:mtr|mml:mtd|mml:maction">
    <mml:mrow>
      <xsl:attribute name="isPresentation">true</xsl:attribute>
      <xsl:choose>
        <xsl:when test="mmled:block|mml:cn|mml:ci|mml:apply|mml:integers|mml:reals|mml:rationals|mml:naturalnumbers|mml:complexes|mml:primes|mml:exponentiale|mml:imaginaryi|mml:notanumber|mml:true|mml:false|mml:emptyset|mml:pi|mml:eulergamma|mml:infinity|mml:vector|mml:matrix|mml:piecewise|mml:piece|mml:set|mml:csymbol|mml:ident">
          <xsl:attribute name="class">invalid-content</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="add-id2">
        <xsl:with-param name="class">presentation-math</xsl:with-param>
      </xsl:call-template>
    <xsl:copy>
      <xsl:copy-of select="@*[name()!='id']"/>
      <xsl:apply-templates select="*|text()"/>
    </xsl:copy>
    </mml:mrow>
  </xsl:template>

  <!-- 4.4.5.2 diff -->
  <!-- TODO remove me when I no longer use expandables (and the diff template relies on mml:bvar See m11299-->
  <xsl:template match="mml:apply[*[1][self::mml:diff] and mml:ci and (count(mml:*)-count(mml:bvar))=2]" priority="2">
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


<!-- For mml:sum and mml:product, we need to ALWAYS render the bvar -->
<!-- sum -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='sum']]">
<m:mrow>
  <xsl:choose>
  <xsl:when test="m:condition and m:domainofapplication"><!-- domainofapplication as well as condition -->
    <m:munder>
      <m:mo><xsl:text disable-output-escaping="yes">&#8721;<!--sum--></xsl:text></m:mo>
      <m:mrow><m:munder>
              <m:mrow><xsl:apply-templates select="m:domainofapplication"/></m:mrow>
              <m:mrow><xsl:apply-templates select='m:condition'/></m:mrow>
            </m:munder>
      </m:mrow>
    </m:munder>
  </xsl:when> 
  <xsl:when test="m:condition and m:lowlimit and m:uplimit"><!-- uplimit and lowlimit as well as condition -->
    <m:munderover>
      <m:mo><xsl:text disable-output-escaping="yes">&#8721;<!--sum--></xsl:text></m:mo>
      <m:mrow><m:munder>
              <m:mrow><xsl:apply-templates select="m:bvar"/><m:mo>=</m:mo><xsl:apply-templates
      select="m:lowlimit"/></m:mrow>
              <m:mrow><xsl:apply-templates select='m:condition'/></m:mrow>
            </m:munder>
      </m:mrow>
      <m:mrow><xsl:apply-templates select="m:uplimit"/></m:mrow>
    </m:munderover>
  </xsl:when>    
  <xsl:when test="m:condition">  <!-- domain specified by a condition -->
    <m:munder>
      <m:mo><xsl:text disable-output-escaping="yes">&#8721;<!--sum--></xsl:text></m:mo>
      <m:mrow>
      <xsl:apply-templates select="m:bvar"/><!-- PHIL added -->
      <xsl:apply-templates select="m:condition"/>
      </m:mrow>
    </m:munder>
  </xsl:when>
  <xsl:when test="m:domainofapplication">  <!-- domain specified by domain of application -->
    <m:munder>
      <m:mo><xsl:text disable-output-escaping="yes">&#8721;<!--sum--></xsl:text></m:mo>
      <xsl:apply-templates select="m:domainofapplication"/>
    </m:munder>
  </xsl:when>
  <xsl:when test="m:lowlimit and m:uplimit">  <!-- domain specified by low and up limits -->
    <m:munderover>
      <m:mo><xsl:text disable-output-escaping="yes">&#8721;<!--sum--></xsl:text></m:mo>
      <m:mrow><xsl:apply-templates select="m:bvar"/><m:mo>=</m:mo><xsl:apply-templates select="m:lowlimit"/></m:mrow>
      <m:mrow><xsl:apply-templates select="m:uplimit"/></m:mrow>
    </m:munderover>
  </xsl:when>
  <!-- PHIL added clause for mml:interval -->
  <xsl:when test="m:interval">  <!-- domain specified by an interval -->
    <m:munderover>
      <m:mo><xsl:text disable-output-escaping="yes">&#8721;<!--sum--></xsl:text></m:mo>
      <m:mrow><xsl:apply-templates select="m:bvar"/><m:mo>=</m:mo><xsl:apply-templates select="m:interval/*[1]"/></m:mrow>
      <m:mrow><xsl:apply-templates select="m:interval/*[2]"/></m:mrow>
    </m:munderover>
  </xsl:when>
  <xsl:otherwise>
      <m:mo><xsl:text disable-output-escaping="yes">&#8721;<!--sum--></xsl:text></m:mo>
  </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
  <xsl:when test="*[position()=last() and self::m:apply]">  <!-- if expression is complex, wrap it in brackets -->
    <m:mfenced separators=" "><xsl:apply-templates select="*[position()=last()]"/></m:mfenced>
  </xsl:when>
  <xsl:otherwise>  <!-- if not put it in an mrow -->
    <m:mrow><xsl:apply-templates select="*[position()=last()]"/></m:mrow>
  </xsl:otherwise>
  </xsl:choose>
</m:mrow>
</xsl:template>

<!-- product -->
<xsl:template match="m:apply[child::*[position()=1 and local-name()='product']]">
<m:mrow>
  <xsl:choose>
  <xsl:when test="m:condition and m:domainofapplication"><!-- domainofapplication as well as condition -->
    <m:munder>
      <m:mo><xsl:text disable-output-escaping="yes">&#8719;<!--product--></xsl:text></m:mo>
      <m:mrow><m:munder>
              <m:mrow><xsl:apply-templates select="m:domainofapplication"/></m:mrow>
              <m:mrow><xsl:apply-templates select='m:condition'/></m:mrow>
            </m:munder>
      </m:mrow>
    </m:munder>
  </xsl:when> 
  <xsl:when test="m:condition and m:lowlimit and m:uplimit"><!-- uplimit and lowlimit as well as condition -->
    <m:munderover>
      <m:mo><xsl:text disable-output-escaping="yes">&#8719;<!--product--></xsl:text></m:mo>
      <m:mrow><m:munder>
              <m:mrow><xsl:apply-templates select="m:bvar"/><m:mo>=</m:mo><xsl:apply-templates
      select="m:lowlimit"/></m:mrow>
              <m:mrow><xsl:apply-templates select='m:condition'/></m:mrow>
            </m:munder>
      </m:mrow>
      <m:mrow><xsl:apply-templates select="m:uplimit"/></m:mrow>
    </m:munderover>
  </xsl:when>  
  <xsl:when test="m:condition">   <!-- domain specified by a condition -->
    <m:munder>
      <m:mo><xsl:text disable-output-escaping="yes">&#8719;<!--product--></xsl:text></m:mo>
      <m:mrow>
      <xsl:apply-templates select="m:bvar"/><!-- PHIL added -->
      <xsl:apply-templates select="m:condition"/>
      </m:mrow>
    </m:munder>
  </xsl:when>
  <xsl:when test="m:domainofapplication"> <!--domain specified by a domain -->
    <m:munder>
      <m:mo><xsl:text disable-output-escaping="yes">&#8719;<!--product--></xsl:text></m:mo>
      <xsl:apply-templates select="m:domainofapplication"/>
    </m:munder>
  </xsl:when>
  <!-- PHIL added clause for mml:interval -->
  <xsl:when test="m:interval">  <!-- domain specified by an interval -->
    <m:munderover>
      <m:mo><xsl:text disable-output-escaping="yes">&#8719;<!--product--></xsl:text></m:mo>
      <m:mrow><xsl:apply-templates select="m:bvar"/><m:mo>=</m:mo><xsl:apply-templates select="m:interval/*[1]"/></m:mrow>
      <m:mrow><xsl:apply-templates select="m:interval/*[2]"/></m:mrow>
    </m:munderover>
  </xsl:when>

  <xsl:otherwise>  <!-- domain specified by low and up limits -->
    <m:munderover>
      <m:mo><xsl:text disable-output-escaping="yes">&#8719;<!--product--></xsl:text></m:mo>
      <m:mrow><xsl:apply-templates select="m:bvar"/><m:mo>=</m:mo><xsl:apply-templates select="m:lowlimit"/></m:mrow>
      <m:mrow><xsl:apply-templates select="m:uplimit"/></m:mrow>
    </m:munderover>
  </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
  <xsl:when test="*[position()=last() and self::m:apply]">  <!-- if expression is complex, wrap it in brackets -->
    <m:mfenced separators=" "><xsl:apply-templates select="*[position()=last()]"/></m:mfenced>
  </xsl:when>
  <xsl:otherwise>  <!-- if not put it in an mrow -->
    <m:mrow><xsl:apply-templates select="*[position()=last()]"/></m:mrow>
  </xsl:otherwise>
  </xsl:choose>
</m:mrow>
</xsl:template>


  <!--first ci is supposed to be a function-->
  <xsl:template match="m:apply[child::*[position()=1 and (local-name()='mo' or local-name()='ci' or local-name()='block')]]">
      <m:mrow roxor="woot">
        <xsl:call-template name="add-id2" />
        <!-- Not sure why I can't just do apply-templates *[1] and have it grab the id -->
        <xsl:choose>
        	<xsl:when test="child::*[position()=1 and local-name()='ci']">
		        <xsl:for-each select="*[position()=1]">
		        	<m:mrow>
		        		<xsl:call-template name="add-id2" />
		        		<xsl:apply-templates select="."/>
		        	</m:mrow>
		        </xsl:for-each>
		    </xsl:when>
        	<xsl:otherwise>
        		<xsl:apply-templates select="*[1]"/>
        	</xsl:otherwise>
        </xsl:choose>
        <!-- xsl:apply-templates select="*[1]"/ --> 
        <m:mfenced open='(' close=')' separators=",">
	      <xsl:for-each select="child::*[position()!=1]">
    	    <xsl:apply-templates select="."/>
    	  </xsl:for-each>
    	</m:mfenced>
      </m:mrow>
  </xsl:template>


<!-- composition -->
<xsl:template match="m:apply[child::m:apply[position()=1]/m:compose]">
  <m:mrow> <!-- elementary classical functions have two templates: apply[func] for standard case, func[position()!=1] for inverse and compose case-->
  	<!-- Attach the @id -->
  	<m:mrow>
  	<xsl:for-each select="child::m:apply[position()=1]">
  		<xsl:call-template name="add-id2"/>
  	</xsl:for-each>
    <xsl:for-each select="m:apply[position()=1]/*[position()!=1 and position()!=last()]">
      <xsl:apply-templates select="."/><m:mo><xsl:text disable-output-escaping="yes">&#x2218;</xsl:text></m:mo> <!-- compose functions --><!-- does not work, perhaps compfn, UNICODE 02218-->
    </xsl:for-each>
    <xsl:apply-templates select="m:apply[position()=1]/*[position()=last()]"/>
    </m:mrow>
    <xsl:if test="count(*)>=2"> <!-- deal with operands, if any-->
      <m:mo><xsl:text disable-output-escaping="yes"> <!--&ApplyFunction;--></xsl:text></m:mo>
      <m:mrow><m:mo>(</m:mo>
      <xsl:for-each select="*[position()!=1 and position()!=last()]">
        <xsl:apply-templates select="."/><m:mo>,</m:mo>

      </xsl:for-each>
      <xsl:apply-templates select="*[position()=last()]"/>
      <m:mo>)</m:mo></m:mrow>
    </xsl:if>
  </m:mrow>
</xsl:template>

<!-- Made it so mphantom nodes are stil l editable -->
<xsl:template match="m:mphantom">
	<m:mrow woot="true">
		<xsl:call-template name="add-id2">
			<xsl:with-param name="class">mphantom</xsl:with-param>
		</xsl:call-template>
		<xsl:apply-templates select="*" />
	</m:mrow>
</xsl:template>

<!-- mml:mtr and mml:mtd can't be wrapped in an mrow -->
<xsl:template match="m:mtr">
	<m:mtr>
		<xsl:copy-of select="@*"/>
		<xsl:call-template name="add-id2">
			<xsl:with-param name="class">presentation-math</xsl:with-param>
		</xsl:call-template>
		<m:mtd/><!--For cursor-->
		<xsl:apply-templates select="*"/>
		<m:mtd/><!--For cursor-->
	</m:mtr>
</xsl:template>
<xsl:template match="m:mtd">
	<m:mtd>
		<xsl:copy-of select="@*"/>
		<xsl:call-template name="add-id2">
			<xsl:with-param name="class">presentation-math</xsl:with-param>
		</xsl:call-template>
		<xsl:apply-templates select="*"/>
	</m:mtd>
</xsl:template>



  <!-- partial differentiation -->
  <!-- PHIL: Need to not sum up mmled:blocks for the degree. 1 change, later in the template -->
  <!-- the latest working draft sets the default rendering of the numerator
  to only one mfrac with one PartialD for the numerator, exponent being the sum
  of every partial diff's orders; not supported yet (I am not sure it is even possible with XSLT)-->
  <xsl:template match="m:apply[child::*[position()=1 and local-name()='partialdiff']]">
    <m:mrow>
      <xsl:choose>
  <xsl:when test="m:list">
    <m:msub>
      <m:mo>D</m:mo>
      <m:mfenced separators="," open="" close=""><xsl:apply-templates select="m:list/*"/></m:mfenced>
    </m:msub>
    <m:mfenced open="(" close=")"><xsl:apply-templates select="*[local-name()!='list']"/></m:mfenced>
  </xsl:when>
    <xsl:otherwise>
    <xsl:choose>
      <xsl:when test="child::*[local-name()='degree' and position()>0]">
        <m:mfrac>           
    <m:mrow><m:msup><m:mo><xsl:text disable-output-escaping="yes">&#x2202;</xsl:text></m:mo><xsl:apply-templates select="m:degree"/></m:msup></m:mrow>
    <m:mrow>
      <xsl:for-each select="m:bvar">
        <xsl:choose>
          <xsl:when test="m:degree"> <!-- if order is specified" -->    
      <xsl:choose>         
        <xsl:when test="contains(m:degree/m:cn/text(),'1') and string-length(normalize-space(m:degree/m:cn/text()))=1">
          <m:mrow><m:mo><xsl:text disable-output-escaping="yes">&#x2202;</xsl:text></m:mo><xsl:apply-templates select="*[local-name(.)!='degree']"/></m:mrow>
        </xsl:when>
        <xsl:otherwise> <!-- if order of the derivative is not 1 -->
          <m:mrow><m:mrow><m:mo><xsl:text disable-output-escaping="yes">&#x2202;</xsl:text></m:mo></m:mrow><m:msup><m:mrow><xsl:apply-templates select="*[local-name(.)!='degree']"/></m:mrow><m:mrow><xsl:apply-templates select="m:degree"/></m:mrow></m:msup></m:mrow>
        </xsl:otherwise>
      </xsl:choose>
          </xsl:when>
          <xsl:otherwise> <!-- no order specifiied, default to 1 -->         
      <m:mrow><m:mo><xsl:text disable-output-escaping="yes">&#x2202;</xsl:text></m:mo><xsl:apply-templates select="."/></m:mrow>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </m:mrow>
        </m:mfrac>
        <m:mrow>
    <xsl:choose>
      <xsl:when test="m:apply[position()=last()]/m:fn[position()=1]"> 
        <xsl:apply-templates select="*[position()=last()]"/>
      </xsl:when> <!--add brackets around expression if not a function (MathML 1.0 )-->
      <xsl:when test="m:apply[position()=last()]/m:ci[position()=1 and @type='fn']">
        <xsl:apply-templates select="*[position()=last()]"/>
      </xsl:when> <!-- add brackets around expression if not a function -->
      <xsl:when test="*[position()=last() and local-name()!='bvar' and local-name()!='degree']">
        <m:mfenced separators=" "><xsl:apply-templates select="*[position()=last()]"/></m:mfenced>
      </xsl:when>
      <xsl:otherwise>
        <!-- do nothing in this case -->
      </xsl:otherwise>
    </xsl:choose>
        </m:mrow>
      </xsl:when>
      <xsl:otherwise>
        <m:mfrac>
    <m:mrow><m:msup><m:mo><xsl:text disable-output-escaping="yes">&#x2202;</xsl:text></m:mo>
        <m:mrow> 
          <xsl:if test="count(m:bvar/m:degree[child::*[local-name()='cn']])>=1 or count(m:bvar)>1">
      <xsl:variable name="sumdeg" select="sum(m:bvar/m:degree/m:cn/text())"/>
      <xsl:variable name="degsum" select="count(m:bvar[m:degree/mmled:block])-1"/>
      <xsl:variable name="totalsum" select="$sumdeg+$degsum"/>
      <m:mn><xsl:value-of select="$totalsum"/></m:mn>
          </xsl:if>
          <xsl:for-each select="child::*[position()=2 and local-name()='bvar']">
      <xsl:if test="m:degree[child::*[local-name()!='cn' and local-name()!='block']]">
        <xsl:apply-templates select="child::*[position()!=1]"/>
      </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="child::*[position()>2 and local-name()='bvar']">
      <xsl:if test="m:degree[child::*[local-name()!='cn' and local-name()!='block']]">
        <m:mo>+</m:mo>
        <xsl:apply-templates select="child::*[position()!=1]"/>
      </xsl:if>
          </xsl:for-each>
        </m:mrow>
      </m:msup></m:mrow>
    <m:mrow>
      <xsl:for-each select="m:bvar">
        <xsl:choose>
          <xsl:when test="m:degree"> <!-- if the order of the derivative is specified-->
      <xsl:choose>
        <xsl:when test="contains(m:degree/m:cn/text(),'1') and string-length(normalize-space(m:degree/m:cn/text()))=1">
          <m:mrow><m:mo><xsl:text disable-output-escaping="yes">&#x2202;</xsl:text></m:mo><xsl:apply-templates select="*[local-name(.)!='degree']"/></m:mrow>
        </xsl:when>
        <xsl:otherwise> <!-- if the order of the derivative is not 1-->
          <m:mrow><m:mrow><m:mo><xsl:text disable-output-escaping="yes">&#x2202;</xsl:text></m:mo></m:mrow><m:msup><m:mrow><xsl:apply-templates select="*[local-name(.)!='degree']"/></m:mrow><m:mrow><xsl:apply-templates select="m:degree"/></m:mrow></m:msup></m:mrow>
        </xsl:otherwise>
      </xsl:choose>
          </xsl:when>
          <xsl:otherwise> <!-- if no order is specified, default to 1-->
      <m:mrow><m:mo><xsl:text disable-output-escaping="yes">&#x2202;</xsl:text></m:mo><xsl:apply-templates select="."/></m:mrow>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </m:mrow>
        </m:mfrac>
        <m:mrow>
    <xsl:choose>
      <xsl:when test="m:apply[position()=last()]/m:fn[position()=1]"> 
        <xsl:apply-templates select="*[position()=last()]"/>
      </xsl:when> <!--add brackets around expression if not a function (MathML 1.0) -->
      <xsl:when test="m:apply[position()=last()]/m:ci[position()=1 and @type='fn']"> 
        <xsl:apply-templates select="*[position()=last()]"/>
      </xsl:when> <!-- add brackets around expression if not a function -->
      <xsl:when test="*[position()=last() and local-name()!='bvar' and local-name()!='degree']">
        <m:mfenced separators=" "><xsl:apply-templates select="*[position()=last()]"/></m:mfenced>
      </xsl:when>
      <xsl:otherwise>
        <!-- do nothing -->
      </xsl:otherwise>
    </xsl:choose>
        </m:mrow>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:otherwise>
      </xsl:choose>
    </m:mrow>
  </xsl:template>


  <xsl:template match="m:apply[child::*[position()=1 and local-name()='diff']]">
    <m:mrow>
      <m:mfrac>
        <m:mrow><m:msup><m:mo>d<!--DifferentialD does not work--></m:mo><m:mrow><xsl:apply-templates select="m:bvar/m:degree"/></m:mrow></m:msup></m:mrow>
        <m:mrow><m:mo>d<!--DifferentialD does not work--></m:mo><m:msup><m:mrow><xsl:apply-templates select="m:bvar/*[local-name(.)!='degree']"/></m:mrow><m:mrow><xsl:apply-templates select="m:bvar/m:degree"/></m:mrow></m:msup></m:mrow>
      </m:mfrac>
      <m:mrow>
        <xsl:choose>
          <xsl:when test="(m:apply[position()=last()]/m:fn[position()=1] or m:apply[position()=last()]/m:ci[@type='fn'] or m:matrix)">
      <xsl:apply-templates select="*[position()=last()]"/>
          </xsl:when>
          <xsl:otherwise>
      <m:mfenced separators=" "><xsl:apply-templates select="*[position()=last()]"/></m:mfenced>
          </xsl:otherwise>
        </xsl:choose>
      </m:mrow>
   
    </m:mrow>
  </xsl:template>

</xsl:stylesheet>