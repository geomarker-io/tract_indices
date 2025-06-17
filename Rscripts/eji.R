library(tidyverse)

# data downloaded from https://www.atsdr.cdc.gov/place-health/php/eji/eji-data-download.html

d <- read_csv("data-raw/EJI_2024_United_States.csv") |>
  select(
    census_tract_id_2020 = GEOID_2020,
    high_ozone_days = E_OZONE,
    high_pm_days = E_PM,
    diesel_pm_conc = E_DSLPM,
    air_toxics_cancer_risk = E_TOTCR,
    prop_near_parks = E_PARK,
    walkability = E_WLKIND,
    prop_near_railway = E_RAIL,
    prop_near_airport = E_AIRPRT,
  )

saveRDS(d, 'data/eji.rds')
