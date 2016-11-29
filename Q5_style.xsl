<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
    <h2>Duration Results</h2>
    <table border="1">
    <tr bgcolor="#9acd32">
      <th align="left">Name</th>
	  <th align="left">Title</th>
	  <th align="left">Start Time</th>
	  <th align="left">End Time</th>
    </tr>
    <xsl:for-each select="employees/employee">
    <tr>
      <td><xsl:value-of select="name"/></td>
	  <xsl:for-each select="employees/employee/title">
		  <td><xsl:value-of select="title"/></td>
		  <td><xsl:value-of select="tstart"/></td>
		  <td><xsl:value-of select="tend"/></td>
	  <xsl:for-each>
    </tr>
    </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>