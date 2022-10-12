# Recent, Nationwide, Census Tract-Level Mega Dataset

## About

This R code generates the **Recent, Nationwide, Census Tract-Level Mega Dataset** (`census_mega_data`) data resource. This dataset is a compilation of several census-based data products at the census tract level, including 

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

**CSV**

Data as a CSV file is stored on AWS S3 at [`s3://codec-data/census_mega_data/census_mega_data.csv`](https://codec-data.s3.amazonaws.com/census_mega_data/census_mega_data.csv). 

To read this CSV file into R directly from its online location, use: 

```
readr::read_csv("https://codec-data.s3.amazonaws.com/census_mega_data/census_mega_data.csv")
```

**CODEC tabular-data-resource**

Data as a CODEC tabular-data-resource are stored on AWS S3 (`s3://codec-data/census_mega_data/`). Use the following to read this data and its [metadata](https://geomarker.io/CODECtools/articles/codec-metadata.html) into R, downloading the tabular-data-resource to the working directory first, if necessary:

```
CODECtools::read_codec("census_mega_data")
```

## Data Details

- **Rounding:** All numeric variables are expressed using 3 significant digits.

- **Temporality:** All `census_tract_id`s correspond to the 2010 census tract vintage.

