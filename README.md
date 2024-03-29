# Census Tract-Level Neighborhood Indices

## About

This R code generates the **Census Tract-Level Neighborhood Indices** (`tract_indices`) data resource. This dataset is a compilation of several open data products at the census tract-level, including 

- **Socioeconomic Indices**
  
    + [Neighborhood Atlas Area Deprivation Index](https://www.neighborhoodatlas.medicine.wisc.edu/)
    + [Childhood Opportunity Index](https://data.diversitydatakids.org/dataset/coi20-child-opportunity-index-2-0-database/resource/080cfe52-90aa-4925-beaa-90efb04ab7fb#dictionary_anchor)
    + [Community Material Deprivation Index](https://geomarker.io/dep_index/)
    + [Community Resilience](https://www2.census.gov/programs-surveys/demo/technical-documentation/community-resilience/2019/cre_file_layout_2019.pdf)
    + [Social Deprivation Index](https://www.graham-center.org/rgc/maps-data-tools/sdi/social-deprivation-index.html)
    + [Social Vulnerability Index](https://www.atsdr.cdc.gov/placeandhealth/svi/index.html)
    + [Kreiger Racial and Socioeconomic Index of Concentration at the Extremes](https://www.hsph.harvard.edu/thegeocodingproject/covid-19-resources/)
    
- **Environmental Indices**

    + [EJ Screen](https://www.epa.gov/ejscreen/overview-environmental-indicators-ejscreen)

- **Food and Medical Care Access Indices**

    + [USDA Food Access Research Atlas](https://www.ers.usda.gov/data-products/food-access-research-atlas/state-level-estimates-of-low-income-and-low-access-populations/)
    + [Modified Retail Food Environment Index](https://www.cdc.gov/obesity/downloads/census-tract-level-state-maps-mrfei_TAG508.pdf)
    + [feedingamerica.org Food Insecurity Percentage](feedingamerica.org)
    + [Healthcare Professional Shortage and Medically Underserved Areas](https://bhw.hrsa.gov/workforce-shortage-areas/shortage-designation)
    + [Walkability Index](https://www.epa.gov/smartgrowth/national-walkability-index-user-guide-and-methodology)
    
See [metadata.md](./metadata.md) for detailed metadata and schema information.

## Accessing Data

Read this CSV file into R directly from the [release](https://github.com/geomarker-io/tract_indices/releases) with: 

```
readr::read_csv("https://github.com/geomarker-io/tract_indices/releases/download/v0.3.0/tract_indices.csv")
```

Metadata can be imported from the accompanying `tabular-data-resource.yaml` file by using [{CODECtools}](https://geomarker.io/CODECtools/).

## Data Details

- **Rounding:** All numeric variables are expressed using 3 significant digits.
- **Temporality:** All `census_tract_id`s correspond to the 2010 census tract vintage.

