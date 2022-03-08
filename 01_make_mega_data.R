library(tidyverse)

fls <- list.files(path = 'data', pattern = '*.rds')
d <- map(glue::glue('data/{fls}'), readRDS)

mega_data <- purrr::reduce(d, .f = left_join, by = 'census_tract_id')

mega_data <- mega_data %>%
  mutate(census_tract_vintage = 2010) %>%
  relocate(census_tract_vintage, .after = census_tract_id)

# download.file('https://www2.census.gov/geo/docs/maps-data/data/rel2020/tract/tab20_tract20_tract10_natl.txt',
#               destfile = '2020_to_2010_tracts.txt')
#
# cw <- read_delim('2020_to_2010_tracts.txt', delim = "|") %>%
#   select(GEOID_TRACT_20, GEOID_TRACT_10)

saveRDS(mega_data, 'census_mega_data.rds')
write_csv(mega_data, 'census_mega_data.csv')
