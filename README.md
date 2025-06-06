# Census Tract-Level Neighborhood Indices

## About

This R code generates the **Census Tract-Level Neighborhood Indices** (`tract_indices`) data resource. This dataset is a compilation of several open data products at the census tract-level, including 

- **Socioeconomic Indices**
  
    + 2022 [Neighborhood Atlas Area Deprivation Index](https://www.neighborhoodatlas.medicine.wisc.edu/) aggregated to 2020 census tract geographic boundaries
    + [Childhood Opportunity Index 3.0 overall index and three domains](https://data.diversitydatakids.org/dataset/coi30-2010-tracts-child-opportunity-index-3-0-database--2010-census-tracts/resource/0c292d45-8a97-494a-908a-3f937516da3a#dictionary_anchor) interpolated from 2010 to 2020 census tract boundaries
    + 2023 [Community Material Deprivation Index](https://geomarker.io/dep_index/)
    + [Kreiger Racial and Socioeconomic Index of Concentration at the Extremes](https://www.hsph.harvard.edu/thegeocodingproject/covid-19-resources/) calculated using 2023 ACS data from the [hh_acs_measures](https://geomarker.io/hh_acs_measures/) data resource
    
- **Environmental Indices**

    + 2024 [EJI](https://www.atsdr.cdc.gov/place-health/php/eji/?CDC_AAref_Val=https://www.atsdr.cdc.gov/placeandhealth/eji/index.html)
    
See [metadata.md](./metadata.md) for detailed metadata and schema information.

## Accessing Data

Read the {[dpkg](https://github.com/cole-brokamp/dpkg)} directly into R with:

```
dpkg::stow("https://github.com/geomarker-io/tract_indices/releases/download/2025/tract_indices.parquet") |>
	dpkg::read_dpkg()
```

Read this CSV file into R directly from the [release](https://github.com/geomarker-io/tract_indices/releases) with: 

```
readr::read_csv("https://github.com/geomarker-io/tract_indices/releases/download/2025/tract_indices.csv")
```

## Data Details

- **Rounding:** All numeric variables are expressed using 3 significant digits.
- **Temporality:** All `census_tract_id`s correspond to the 2020 census tract vintage.

