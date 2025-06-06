library(tidyverse)

# downloaded from https://www.neighborhoodatlas.medicine.wisc.edu/download

d <- read_csv('data-raw/US_2023_ADI_Census_Block_Group_v4_0_1.csv')

d <- d |>
  select(
    block_group_id = FIPS,
    adi = ADI_NATRANK
  ) |>
  mutate(
    census_tract_id_2020 = stringr::str_sub(block_group_id, 1, 11),
    adi = as.numeric(adi)
  ) |>
  group_by(census_tract_id_2020) |>
  summarize(adi = round(mean(adi, na.rm = TRUE)))

saveRDS(d, 'data/adi.rds')
