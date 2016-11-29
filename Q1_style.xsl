<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
    <h2>Anneke Preusig's Employment History</h2>
    <table border="1">
    <tr bgcolor="#9acd32">
      <th align="left">Deptno</th>
      <th align="left">Start Time</th>
	  <th align="left">End Time</th>
    </tr>
    <xsl:for-each select="employment_history/employment">
    <tr>
      <td><xsl:value-of select="deptno"/></td>
      <td><xsl:value-of select="tstart"/></td>
	  <td><xsl:value-of select="tend"/></td>
    </tr>
    </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>