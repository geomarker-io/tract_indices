library(tidyverse)
library(sf)

options(timeout = 1000)
download.file('https://data.hrsa.gov//DataDownload/DD_Files/HPSA_PLYMH_SHP.zip',
              destfile = 'raw-data/hpsa_mh.zip')
unzip('raw-data/hpsa_mh.zip', exdir = 'raw-data')
unlink('raw-data/hpsa_mh.zip')

download.file('https://data.hrsa.gov//DataDownload/DD_Files/HPSA_PNTPC_SHP.zip',
              destfile = 'raw-data/hpsa_pc.zip')
unzip('raw-data/hpsa_pc.zip', exdir = 'raw-data')
unlink('raw-data/hpsa_pc.zip')

d_mh <- sf::st_read('raw-data/HPSA_PLYMH_SHP_DET_CUR_VX.shp')
d_pc <- sf::st_read('raw-data/HPSA_PNTPC_SHP_DET_CUR_VX.shp')

d_mh <- d_mh %>%
  filter(HpsStatCD %in% c("P", "D"), # keep only designated and proposed for withdrawal
         HpsPpTypDe == "Geographic Population") %>%  # keep only geographic HPSAs
  select(HpsNM) %>%
  st_make_valid()

d_pc <- d_pc %>%
  filter(HpsStatCD %in% c("P", "D"), # keep only designated and proposed for withdrawal
         ) %>%
  select(HpsNM) %>%
  st_make_valid()

states <- tigris::states() %>%
  st_drop_geometry() %>%
  select(NAME) %>%
  filter(!NAME %in% c('Alaska', 'Hawaii', 'United States Virgin Islands',
                      'Commonwealth of the Northern Mariana Islands',
                      'Guam', 'American Samoa', 'Puerto Rico'))

all_tracts <- map(states$NAME, ~tigris::tracts(state = .x, year = 2010)) %>%
  bind_rows() %>%
  st_transform(st_crs(d_mh)) %>%
  select(census_tract_id = GEOID10) %>%
  st_make_valid()

tract_hpsa_mh <- st_join(all_tracts, d_mh, join = st_within) %>%
  st_drop_geometry() %>%
  filter(!duplicated(census_tract_id)) %>%
  mutate(hpsa_mh = ifelse(is.na(HpsNM), FALSE, TRUE)) %>%
  select(census_tract_id, hpsa_mh)

tract_hpsa_pc <- st_join(all_tracts, d_pc, join = st_intersects) %>%
  st_drop_geometry() %>%
  filter(!duplicated(census_tract_id)) %>%
  mutate(hpsa_pc = ifelse(is.na(HpsNM), FALSE, TRUE)) %>%
  select(census_tract_id, hpsa_pc)

tract_hpsa <- left_join(tract_hpsa_mh, tract_hpsa_pc, by = "census_tract_id") %>%
  as_tibble()

saveRDS(tract_hpsa, "data/hpsa.rds")
