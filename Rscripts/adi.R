library(tidyverse)

# downloaded from https://www.neighborhoodatlas.medicine.wisc.edu/download

adi_2019 <- read_csv('raw-data/US_2019_ADI_Census Block Group_v3.1.txt')

adi_2019 <- adi_2019 %>%
  select(block_group_id = FIPS,
         adi = ADI_NATRANK)

adi <- adi_2019 %>%
  mutate(census_tract_id = stringr::str_sub(block_group_id, 1, 11),
         adi = as.numeric(adi)) %>%
  group_by(census_tract_id) %>%
  summarize(adi = round(mean(adi, na.rm = TRUE)))

adi %>%
  filter(is.na(adi)) %>%
  nrow(.) / nrow(adi)

# about 2% missing due to missing adi ranks (lack of data)

saveRDS(adi, 'data/adi.rds')
