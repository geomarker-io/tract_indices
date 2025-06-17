library(tidyverse)
library(tidycensus)
library(sf)

# v23 <- load_variables(2023, "acs5")

states <- tigris::states() |>
       st_drop_geometry() |>
       select(NAME) |>
       filter(
              !NAME %in%
                     c(
                            'Alaska',
                            'Hawaii',
                            'United States Virgin Islands',
                            'Commonwealth of the Northern Mariana Islands',
                            'Guam',
                            'American Samoa',
                            'Puerto Rico'
                     )
       )

d <-
       get_acs(
              geography = 'tract',
              state = states$NAME,
              year = 2023,
              variables = c(
                     'B19001_001', # ice denom
                     # high income (> 100k) white non hispanic households
                     'B19001H_014', # white non hispanic hh, income $100,000 to $124,999
                     'B19001H_015', # white non hispanic hh, income $125,000 to $149,999
                     'B19001H_016', # white non hispanic hh, income $150,000 to $199,999
                     'B19001H_017', # white non hispanic hh, income $200,000 or more
                     # low income (< 25k) all race households
                     'B19001_002', # all race hh, income less than $10,000
                     'B19001_003', # all race hh, income $10,000 to $14,999
                     'B19001_004', # all race hh, income $15,000 to $19,999
                     'B19001_005', # all race hh, income $20,000 to $24,999
                     # low income (< 25k) white non hispanic households
                     'B19001H_002', # white non hispanic hh, income less than $10,000
                     'B19001H_003', # white non hispanic hh, income $10,000 to $14,999
                     'B19001H_004', # white non hispanic hh, income $15,000 to $19,999
                     'B19001H_005' # white non hispanic hh, income $20,000 to $24,999
              )
       ) |>
       select(-NAME, -moe) |>
       pivot_wider(names_from = variable, values_from = estimate) |>
       mutate(
              high_inc_wnh = B19001H_014 +
                     B19001H_015 +
                     B19001H_016 +
                     B19001H_017,
              low_inc_all = B19001_002 + B19001_003 + B19001_004 + B19001_005,
              low_inc_wnh = B19001H_002 +
                     B19001H_003 +
                     B19001H_004 +
                     B19001H_005,
              low_inc_poc = low_inc_all - low_inc_wnh,
              ice = (high_inc_wnh - low_inc_poc) / B19001_001 |> round(3)
       ) |>
       select(census_tract_id_2020 = GEOID, ice)

saveRDS(d, 'data/kreiger_ice.rds')
