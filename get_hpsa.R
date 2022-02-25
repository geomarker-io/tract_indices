library(tidyverse)
library(sf)

options(timeout = 1000)
download.file('https://data.hrsa.gov//DataDownload/DD_Files/HPSA_PLYMH_SHP.zip',
              destfile = 'data/hpsa.zip')
unzip('data/hpsa.zip', exdir = 'data')
unlink('data/hpsa.zip')

d <- sf::st_read('data/HPSA_PLYMH_SHP_DET_CUR_VX.shp')

d <- d %>%
  filter(HpsStatCD %in% c("P", "D"), # keep only designated and proposed for withdrawal
         HpsPpTypDe == "Geographic Population") %>%  # keep only geographic HPSAs
  select(HpsNM) %>%
  st_make_valid()

states <- tigris::states() %>%
  st_drop_geometry() %>%
  select(NAME) %>%
  filter(!NAME %in% c('Alaska', 'Hawaii', 'United States Virgin Islands',
                      'Commonwealth of the Northern Mariana Islands',
                      'Guam', 'American Samoa', 'Puerto Rico'))

all_tracts <- map(states$NAME, ~tigris::tracts(state = .x)) %>%
  bind_rows() %>%
  st_transform(st_crs(d)) %>%
  select(census_tract_id = GEOID) %>%
  st_make_valid()

tract_hpsa <- st_join(all_tracts, d, join = st_within) %>%
  st_drop_geometry() %>%
  filter(!duplicated(census_tract_id)) %>%
  mutate(hpsa = ifelse(is.na(HpsNM), "no", "yes")) %>%
  select(census_tract_id, hpsa)

saveRDS(tract_hpsa, "data/hpsa.rds")
