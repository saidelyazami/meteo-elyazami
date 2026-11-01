<?xml version="1.0" encoding="UTF-8"?>
<!--
  Transforme le document météo en histogramme SVG animé.
  Un histogramme par mesure (date), une barre par ville.
  Hauteur d'une barre = température x 10 pixels.
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <!-- Dimensions -->
    <xsl:variable name="echelle" select="10"/>     <!-- pixels par degré -->
    <xsl:variable name="largeurBarre" select="50"/>
    <xsl:variable name="pas" select="80"/>         <!-- distance entre deux barres -->
    <xsl:variable name="hauteurBloc" select="400"/> <!-- hauteur d'un histogramme -->
    <xsl:variable name="base" select="340"/>       <!-- ligne de base dans un bloc -->

    <xsl:template match="/">
        <svg width="740" height="{count(meteo/mesure) * $hauteurBloc + 20}"
             font-family="Arial, sans-serif">
            <xsl:apply-templates select="meteo/mesure"/>
        </svg>
    </xsl:template>

    <xsl:template match="mesure">
        <xsl:variable name="dy" select="(position() - 1) * $hauteurBloc"/>
        <xsl:variable name="couleur">
            <xsl:choose>
                <xsl:when test="position() mod 2 = 1">#e67e22</xsl:when>
                <xsl:otherwise>#2e86c1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <g transform="translate(0, {$dy})">
            <!-- Titre -->
            <text x="370" y="30" font-size="18" font-weight="bold" text-anchor="middle">
                Températures du <xsl:value-of select="@date"/>
            </text>

            <!-- Axes -->
            <line x1="40" y1="{$base}" x2="720" y2="{$base}" stroke="black"/>
            <line x1="40" y1="{$base}" x2="40" y2="{$base - 310}" stroke="black"/>
            <text x="35" y="{$base - 300}" font-size="11" text-anchor="end">30°</text>
            <text x="35" y="{$base - 150}" font-size="11" text-anchor="end">15°</text>
            <text x="35" y="{$base + 4}" font-size="11" text-anchor="end">0°</text>

            <!-- Barres -->
            <xsl:for-each select="ville">
                <xsl:variable name="x" select="60 + (position() - 1) * $pas"/>
                <xsl:variable name="h" select="@temperature * $echelle"/>
                <xsl:variable name="debut" select="concat((position() - 1) * 0.2, 's')"/>

                <rect x="{$x}" y="{$base}" width="{$largeurBarre}" height="0" fill="{$couleur}">
                    <!-- La barre monte depuis la ligne de base -->
                    <animate attributeName="height" from="0" to="{$h}"
                             begin="{$debut}" dur="1s" fill="freeze"/>
                    <animate attributeName="y" from="{$base}" to="{$base - $h}"
                             begin="{$debut}" dur="1s" fill="freeze"/>
                    <title><xsl:value-of select="@nom"/> : <xsl:value-of select="@temperature"/> °C</title>
                </rect>

                <!-- Valeur au-dessus de la barre (apparaît à la fin de l'animation) -->
                <text x="{$x + $largeurBarre div 2}" y="{$base - $h - 6}"
                      font-size="13" text-anchor="middle" opacity="0">
                    <xsl:value-of select="@temperature"/>°
                    <animate attributeName="opacity" from="0" to="1"
                             begin="{concat((position() - 1) * 0.2 + 1, 's')}" dur="0.4s" fill="freeze"/>
                </text>

                <!-- Nom de la ville -->
                <text x="{$x + $largeurBarre div 2}" y="{$base + 20}"
                      font-size="12" text-anchor="middle">
                    <xsl:value-of select="@nom"/>
                </text>
            </xsl:for-each>
        </g>
    </xsl:template>
</xsl:stylesheet>
