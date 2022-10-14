library(tidyverse)

download.file('https://data.diversitydatakids.org/datastore/zip/080cfe52-90aa-4925-beaa-90efb04ab7fb?format=csv',
              destfile = 'raw-data/coi.zip')
unzip('raw-data/coi.zip', exdir = 'raw-data')
unlink('raw-data/coi.zip')

d <- read_csv('raw-data/index.csv')

d <- d %>%
  filter(year == 2015) %>%
  select(census_tract_id = geoid,
         coi_education = z_ED_nat,
         coi_health_env = z_HE_nat,
         coi_social_econ = z_SE_nat,
         coi = z_COI_nat)

saveRDS(d, 'data/coi.rds')

