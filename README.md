
# # Partie 4 : Météo — Technologie XML -> Mesures des températures de différentes villes à une date donnée.

| Fichier | Rôle |
|---|---|
| `meteo.dtd` | DTD décrivant la structure du document |
| `meteo.xml` | Document valide par rapport à la DTD (affiché avec `meteo.xsl`) |
| `meteo.xsd` | Schéma XML du document |
| `meteo_xsd.xml` | Document valide par rapport au schéma (affiché avec `meteo_svg.xsl`) |
| `meteo.xsl` | Transforme le XML en HTML : un tableau par date + température moyenne |
| `meteo_svg.xsl` | Transforme le XML en histogramme SVG animé |
| `meteo.svg` | Résultat généré par `meteo_svg.xsl` |

## Arbre XML

```
meteo
└── mesure +  (@date)
    └── ville +  (@nom, @temperature)
```

## Histogramme SVG animé

![Histogramme des températures](meteo.svg)
