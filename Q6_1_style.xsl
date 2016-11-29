<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
    <h2>Temporal Count for each department</h2>
    <table border="1">
    <tr bgcolor="#9acd32">
      <th align="left">Deptno</th>
	  <th align="left">Date</th>
	  <th align="left">Count</th>
    </tr>
    <xsl:for-each select="department_employee_count_historty/one_department/employee_count">
    <tr>
      <td><xsl:value-of select="deptno"/></td>
	  <td><xsl:value-of select="date"/></td>
	  <td><xsl:value-of select="count"/></td>
    </tr>
    </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>