library(tidyverse)

dep_index <- 'https://github.com/geomarker-io/dep_index/raw/master/2023/data/ACS_deprivation_index_by_census_tracts.rds' |>
  url() |>
  gzcon() |>
  readRDS() |>
  as_tibble()

dep_index <-
  dep_index |>
  rename(
    dep_index_fraction_snap = fraction_snap,
    dep_index_fraction_hs = fraction_hs,
    dep_index_median_income = median_income,
    dep_index_fraction_insured = fraction_insured,
    dep_index_fraction_poverty = fraction_poverty,
    dep_index_fraction_vacant = fraction_vacant
  )

saveRDS(dep_index, 'data/dep_index.rds')
