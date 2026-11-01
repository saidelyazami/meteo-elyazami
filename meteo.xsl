<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Météo</title>
            </head>
            <body>
                <h1>Mesures des températures</h1>
                <xsl:for-each select="meteo/mesure">
                    <h2>Date : <xsl:value-of select="@date"/></h2>
                    <table border="1" width="50%">
                        <tr>
                            <th>Ville</th><th>Température (°C)</th>
                        </tr>
                        <xsl:for-each select="ville">
                            <tr>
                                <td><xsl:value-of select="@nom"/></td>
                                <td><xsl:value-of select="@temperature"/></td>
                            </tr>
                        </xsl:for-each>
                        <tr>
                            <td>Température moyenne</td>
                            <td><xsl:value-of select="format-number(sum(ville/@temperature) div count(ville), '0.0')"/></td>
                        </tr>
                    </table>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
