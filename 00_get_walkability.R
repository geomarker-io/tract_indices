library(tidyverse)
library(sf)

options(timeout=1000)
download.file('https://edg.epa.gov/EPADataCommons/public/OA/WalkabilityIndex.zip',
              destfile='data/walkability.zip')
unzip('data/walkability.zip', exdir = "data")
unlink('data/walkability.zip')

walkability <- st_read('data/Natl_WI.gdb/')

walkability <- walkability %>%
  sf::st_drop_geometry() %>%
  as_tibble() %>%
  select(block_group_id_2010 = GEOID10,
         walkability_index = NatWalkInd)

walkability <- walkability %>%
  mutate(census_tract_id = stringr::str_sub(block_group_id_2010, 1, 11)) %>%
  group_by(census_tract_id) %>%
  summarize(walkability_index = round(mean(walkability_index, na.rm = TRUE), 2))

saveRDS(walkability, 'data/walkability.rds')
