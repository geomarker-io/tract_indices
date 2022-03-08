library(tidyverse)
library(sf)

mega_data <- readRDS('census_mega_data.rds')

ex1_2010 <- mega_data %>%
  filter(census_tract_id == 39165032201 & census_tract_vintage == 2010) %>%
  select(census_tract_id, census_tract_vintage, dep_index)

ex1_2020 <- mega_data %>%
  filter(census_tract_id %in% 39165032203:39165032206 & census_tract_vintage == 2020) %>%
  select(census_tract_id, census_tract_vintage, dep_index)

ex2_2010 <- mega_data %>%
  filter(census_tract_id %in% c(39095003400, 39095003700) & census_tract_vintage == 2010) %>%
  select(census_tract_id, census_tract_vintage, dep_index)

ex2_2020 <- mega_data %>%
  filter(census_tract_id == 39095010600 & census_tract_vintage == 2020) %>%
  select(census_tract_id, census_tract_vintage, dep_index)

tracts <- s3::s3_get('s3://geomarker/geometries/census_tracts_1970_to_2020_valid.rds') %>%
  readRDS()

tracts10 <- tracts[['2010']] %>%
  filter(str_sub(census_tract_id, 1, 2) == '39')

tracts20 <- tracts[['2020']] %>%
  filter(str_sub(census_tract_id, 1, 2) == '39')

rm(tracts)

ex1_2010 <- left_join(ex1_2010, tracts10, by = 'census_tract_id') %>% st_as_sf()
ex1_2020 <- left_join(ex1_2020, tracts20, by = 'census_tract_id') %>% st_as_sf()

ex2_2010 <- left_join(ex2_2010, tracts10, by = 'census_tract_id') %>% st_as_sf()
ex2_2020 <- left_join(ex2_2020, tracts20, by = 'census_tract_id') %>% st_as_sf()

ex1 <- bind_rows(ex1_2010, ex1_2020)
ex2 <- bind_rows(ex2_2010, ex2_2020)



p_e1 <-
  ggplot() +
  geom_sf(data = ex1, aes(fill = dep_index)) +
  ggsflabel::geom_sf_label(data = ex1, aes(label = round(dep_index, 3))) +
  facet_grid(~ census_tract_vintage) +
  ggthemes::theme_map() +
  theme(legend.position = "none")

p_e2 <-
  ggplot() +
  geom_sf(data = ex2, aes(fill = dep_index)) +
  ggsflabel::geom_sf_label(data = ex2, aes(label = round(dep_index, 3))) +
  facet_grid(~ census_tract_vintage) +
  scale_fill_gradient(low = "#fdbb84", high = "#e34a33") +
  ggthemes::theme_map() +
  theme(legend.position = "none")

cowplot::plot_grid(p_e1, p_e2, nrow = 2, align = "h")
ggsave('example_plots.png')

