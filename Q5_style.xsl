<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
    <h2>Duration Results</h2>
    <xsl:for-each select="employees/employee">
	<h3>Title History</h3>
	<table border="1">
    <tr bgcolor="#9acd32">
	  <th align="left">Name</th>
	  <th align="left">Title</th>
	  <th align="left">Start Time</th>
	  <th align="left">End Time</th>
    </tr>
	<xsl:for-each select="title_history">
	<tr>
	  <td><xsl:value-of select="../name"/></td>
	  <td><xsl:value-of select="title"/></td>
	  <td><xsl:value-of select="tstart"/></td>
	  <td><xsl:value-of select="tend"/></td>
	</tr>
	</xsl:for-each>
	</table>
	
	<h3>Manager History</h3>
	<table border="1">
    <tr bgcolor="#9acd32">
	  <th align="left">Name</th>
	  <th align="left">Mgrno</th>
	  <th align="left">Start Time</th>
	  <th align="left">End Time</th>
    </tr>
	<xsl:for-each select="manager_history">
	<tr>
	  <td><xsl:value-of select="../name"/></td>
	  <td><xsl:value-of select="manager/mgrno"/></td>
	  <td><xsl:value-of select="manager/tstart"/></td>
	  <td><xsl:value-of select="manager/tend"/></td>
	</tr>
	</xsl:for-each>
	</table>
    </xsl:for-each>
    
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>