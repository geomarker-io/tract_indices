library(tidyverse)

# feedingamerica.org Data have to be requested; not directly downloadable
food_ins <-
  readxl::read_excel("raw-data/source/fano_projections_march_2021_food_insecurity_v2.xlsx",
                     sheet = " County - 2020 Projections"
  ) %>%
  mutate(FIPS_char = as.character(FIPS)) %>%
  mutate(state_county_fips = ifelse(stringr::str_length(FIPS_char) == 4,
                                    stringr::str_c("0", FIPS_char, sep = ""),
                                    FIPS_char
  )) %>%
  select(state_county_fips, food_insecurity_pct = `2019 Food Insecurity %`)

tracts <- readRDS("tracts.rds")

food_ins <-
  left_join(tracts, food_ins, by = "state_county_fips") %>%
  select(-state_county_fips) %>%
  rename(census_tract_id = census_tract_fips)

saveRDS(food_ins, "data/food_insecurity.rds")
