<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
    <h2>Duration Results</h2>
    <xsl:for-each select="employees/employee">
	<h3>*************** One Employee ***************</h3>
	<h4>Title History</h4>
	<table border="1">
    <tr bgcolor="#9acd32">
	  <th align="left">Name</th>
	  <th align="left">Title</th>
	  <th align="left">Start Time</th>
	  <th align="left">End Time</th>
    </tr>
	<xsl:for-each select="title_history/title">
	<tr>
	  <td><xsl:value-of select="../../name"/></td>
	  <td><xsl:value-of select="title_name"/></td>
	  <td><xsl:value-of select="tstart"/></td>
	  <td><xsl:value-of select="tend"/></td>
	</tr>
	</xsl:for-each>
	</table>
	
	<h4>Manager History</h4>
	<table border="1">
    <tr bgcolor="#9acd32">
	  <th align="left">Name</th>
	  <th align="left">Mgrno</th>
	  <th align="left">Start Time</th>
	  <th align="left">End Time</th>
    </tr>
	<xsl:for-each select="manager_history/manager">
	<tr>
	  <td><xsl:value-of select="../../name"/></td>
	  <td><xsl:value-of select="mgrno"/></td>
	  <td><xsl:value-of select="tstart"/></td>
	  <td><xsl:value-of select="tend"/></td>
	</tr>
	</xsl:for-each>
	</table>
	<h3>**********************************************</h3>
    </xsl:for-each>
    
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>