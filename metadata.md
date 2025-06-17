# Census Tract-Level Neighborhood Indices

- **Socioeconomic Indices**
  
    + 2022 [Neighborhood Atlas Area Deprivation Index](https://www.neighborhoodatlas.medicine.wisc.edu/) aggregated to 2020 census tract geographic boundaries

            - `adi`: national percentile ranking at block group level from 1 to 100 averaged for each tract; higher adi indicates higher disadvantage

    + 2021 [Childhood Opportunity Index 3.0 overall index and three domains](https://data.diversitydatakids.org/dataset/coi30-2010-tracts-child-opportunity-index-3-0-database--2010-census-tracts/resource/
    0c292d45-8a97-494a-908a-3f937516da3a#dictionary_anchor) interpolated from 2010 to 2020 census tract boundaries

            - `coi_education`: weighted average of education domain component indicator z-scores, nationally normed 
            - `coi_health_env`: weighted average of health and environment domain component indicator z-scores, nationally normed 
            - `coi_social_econ`: weighted average of social and economic domain component indicator z-scores, nationally normed 
            - `coi`: weighted average of three domain averaged z-scores, nationally normed

    + 2023 [Community Material Deprivation Index](https://geomarker.io/dep_index/)

            - `dep_index_fraction_snap`: fraction of households receiving public assistance income or food stamps or SNAP in the past 12 months
            - `dep_index_fraction_hs`: fraction of population 25 and older with educational attainment of at least high school graduation (includes GED equivalency)
            - `dep_index_median_income`: median household income in the past 12 months in 2023 inflation-adjusted dollars
            - `dep_index_fraction_insured`: fraction of poulation with health insurance coverage
            - `dep_index_fraction_poverty`: fraction of households with income in past 12 months below poverty level
            - `dep_index_fraction_vacant`: fraction of houses that are vacant
            - `dep_index`: composite index of 6 variables above characterizing community material deprivation; range 0 to 1, with higher values indicating higher deprivation

    + [Kreiger Racial and Socioeconomic Index of Concentration at the Extremes](https://www.hsph.harvard.edu/thegeocodingproject/covid-19-resources/) calculated using 2023 ACS data

            - `ice`: high income white non-Hispanic households versus low income people of color (not white non-Hispanic) households; -1 to 1 where 1 indicates all high income white households and -1 indicates all low income people of color households

- **Environmental Indices**

    + 2024 [EJI](https://www.atsdr.cdc.gov/place-health/php/eji/?CDC_AAref_Val=https://www.atsdr.cdc.gov/placeandhealth/eji/index.html)

            - `high_ozone_days`: The annual mean number of days above the regulatory standard for Ozone (O3), averaged over 3-years 
            - `high_pm_days`: The annual mean number of days above the regulatory standard for Particulate Matter 2.5 (PM2.5), averaged over 3-years  
            - `diesel_pm_conc`: Ambient concentrations of diesel particulate matter 
            - `air_toxics_cancer_risk`: The likelihood of developing cancer from air toxics over the course of a lifetime, assuming continuous exposure 
            - `prop_near_parks`: The proportion the census tract that is within a 1-mi buffer of a park or greenspace
            - `walkability`: The National Walkability Index (NWI) rank, which ranks block groups according to their relative walkability, aggregated to the census tract level 
            - `prop_near_railway`: The proportion of the census tract within a 1-mi buffer of a railway 
            - `prop_near_airport`: The proportion of the census tract that is within a 1-mi buffer of an airport    
