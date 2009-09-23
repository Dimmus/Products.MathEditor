<?xml version='1.0' encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'
xmlns:m="http://www.w3.org/1998/Math/MathML"
>

<!-- TODO: These paths are relative to the html document, not this file -->
<xsl:include href="mml2tex/mmltex.xsl"/>

<!-- Safari needs bbox's 2nd argument to have a trailing "pt" -->
<xsl:template match="m:mrow[@id]">\matheditor[<xsl:value-of select="@id"/>]{<xsl:apply-templates/><!-- Same as the template for m:mrow -->}</xsl:template>

</xsl:stylesheet>
