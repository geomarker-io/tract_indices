library(tidyverse)

# data downloaded from https://www.atsdr.cdc.gov/place-health/php/eji/eji-data-download.html

d <- read_csv("data-raw/EJI_2024_United_States.csv") |>
  select(
    census_tract_id_2020 = GEOID_2020,
    E_OZONE,
    EPL_OZONE,
    E_PM,
    EPL_PM,
    E_DSLPM,
    EPL_DSLPM,
    E_TOTCR,
    EPL_TOTCR,
    E_PARK,
    EPL_PARK,
    E_WLKIND,
    EPL_WLKIND,
    E_RAIL,
    EPL_RAIL,
    E_AIRPRT,
    EPL_AIRPRT
  )

#ozone, pm25, diesel_pm, air_toxics_cancer_risk, lack_of_parks, lack_of_walkability, railways, airports

d_dict <- read_csv("data-raw/EJI_DATADICTIONARY_2024.csv", skip = 1) |>
  filter(`2024 VARIABLE NAME` %in% names(d)) |>
  select(
    variable_name = `2024 VARIABLE NAME`,
    description = `2024 VARIABLE DESCRIPTION`
  )

saveRDS(d, 'data/eji.rds')
