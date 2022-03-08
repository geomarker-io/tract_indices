library(tidyverse)

cw <- read_delim("2020_to_2010_tracts.txt", delim = "|")

cw <- cw %>%
  group_by(GEOID_TRACT_10) %>%
  mutate(weight = AREALAND_PART / sum(AREALAND_PART)) %>%
  select(census_tract_id_2010 = GEOID_TRACT_10,
         census_tract_id_2020 = GEOID_TRACT_20,
         weight) %>%
  filter(weight != 0)

saveRDS(cw, '2010_to_2020_tract_cw.rds')

### example
fake_data <- tibble(census_tract_id_2010 = c("39165032201",  # 1 2010 tract to 4 2020 tracts
                                             "39095003400", "39095003700"), # 2 2010 tracts to 1 2020 tract
                    population = c(1000, 50, 50))

fake_data %>%
  left_join(cw, by = "census_tract_id_2010") %>%
  mutate(new_pop = population * weight) %>%
  group_by(census_tract_id_2020) %>%
  summarize(new_pop = sum(new_pop))
