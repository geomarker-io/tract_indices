library(tidyverse)

dep_index <- 'https://github.com/geomarker-io/dep_index/raw/master/2018_dep_index/ACS_deprivation_index_by_census_tracts.rds' %>%
  url() %>%
  gzcon() %>%
  readRDS() %>%
  as_tibble()

dep_index <-
  dep_index %>%
  rename(
    census_tract_id = census_tract_fips,
    dep_index_fraction_assisted_income = fraction_assisted_income,
    dep_index_fraction_high_school_edu = fraction_high_school_edu,
    dep_index_median_income = median_income,
    dep_index_fraction_no_health_ins = fraction_no_health_ins,
    dep_index_fraction_poverty = fraction_poverty,
    dep_index_fraction_vacant_housing = fraction_vacant_housing)

saveRDS(dep_index, 'data/dep_index.rds')
