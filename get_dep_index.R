library(tidyverse)

dep_index <- 'https://github.com/geomarker-io/dep_index/raw/master/2018_dep_index/ACS_deprivation_index_by_census_tracts.rds' %>%
  url() %>%
  gzcon() %>%
  readRDS() %>%
  as_tibble()

dep_index <- rename(dep_index, census_tract_id = census_tract_fips)
saveRDS(dep_index, 'data/dep_index.rds')
