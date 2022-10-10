library(tidyverse)
library(tidycensus)
library(sf)

# v19 <- load_variables(2019, "acs5")

states <- tigris::states() %>%
  st_drop_geometry() %>%
  select(NAME) %>%
  filter(!NAME %in% c('Alaska', 'Hawaii', 'United States Virgin Islands',
                      'Commonwealth of the Northern Mariana Islands',
                      'Guam', 'American Samoa', 'Puerto Rico'))

d <- get_acs(geography = 'tract',
        state = states$NAME,
        year = 2019,
        variables = c('B01003_001', # total population
                      'B01001H_001', # white nonhispanic population
                      'B17001_001', 'B17001_002', # poverty denom, population below poverty
                      'B19001A_014','B19001A_015', 'B19001A_016','B19001A_017', # white hh, income > $100k
                      'B19001B_002', 'B19001B_003', 'B19001B_004', 'B19001B_005', # black hh, income < $25k
                      'B19001_001', # ice denom
                      'B19001H_014', 'B19001H_015', 'B19001H_016', 'B19001H_017', # white non hispanic hh, income > $100k
                      'B19001_002', 'B19001_003', 'B19001_004', 'B19001_005', # all race hh, income < $25k
                      'B19001H_002', 'B19001H_003', 'B19001H_004', 'B19001H_005', # white non hispanic hh, income < $25k
                      'B25014_005', 'B25014_006', 'B25014_007', # owner occupied, > 1 person/room
                      'B25014_011', 'B25014_012', 'B25014_013', # renter occupied, > 1 person/room
                      'B25014_001' # crowding denom
        ))

d_kreiger <- d %>%
  select(-NAME, -moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  mutate(total_population = B01003_001,
         white_nh_population = B01001H_001,
         pct_below_poverty = B17001_002 / B17001_001 * 100,
         ice_white_black = ((B19001A_014 + B19001A_015 + B19001A_016 + B19001A_017) -
                              (B19001B_002 + B19001B_003 + B19001B_004 + B19001B_005)) / B19001_001,
         ice_white_nh_poc = ((B19001H_014 + B19001H_015 + B19001H_016 + B19001H_017) -
           ((B19001_002 + B19001_003 + B19001_004 + B19001_005) -
              (B19001H_002 + B19001H_003 + B19001H_004 + B19001H_005))) / B19001_001,
         pct_crowding = (B25014_005 + B25014_006 + B25014_007 +
                           B25014_011 + B25014_012 + B25014_013) / B25014_001 * 100,
         pct_poc = white_nh_population / total_population * 100) %>%
  select(census_tract_id = GEOID,
         total_population:pct_poc)

d_ice_crowd <- d_kreiger %>%
  select(census_tract_id,
         ice = ice_white_nh_poc,
         pct_crowding)

saveRDS(d_ice_crowd, 'data/kreiger_ice.rds')



