library(tidyverse)

# data downloaded from https://www.atsdr.cdc.gov/place-health/php/eji/eji-data-download.html

d <- read_csv("data-raw/EJI_2024_United_States.csv") |>
  select(
    census_tract_id_2020 = GEOID_2020,
    high_ozone_days = E_OZONE,
    high_ozone_rank = EPL_OZONE,
    high_pm_days = E_PM,
    high_pm_rank = EPL_PM,
    diesel_pm_conc = E_DSLPM,
    diesel_pm_rank = EPL_DSLPM,
    air_toxics_cancer_risk = E_TOTCR,
    air_toxics_cancer_risk_rank = EPL_TOTCR,
    prop_near_parks = E_PARK,
    lack_of_parks = EPL_PARK,
    walkability = E_WLKIND,
    lack_of_walkability = EPL_WLKIND,
    prop_near_railway = E_RAIL,
    railway_proximity_rank = EPL_RAIL,
    prop_near_airport = E_AIRPRT,
    airport_proximity_rank = EPL_AIRPRT
  )

saveRDS(d, 'data/eji.rds')
