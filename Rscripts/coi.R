library(tidyverse)

# downloaded from https://data.diversitydatakids.org/dataset/coi30-2010-tracts-child-opportunity-index-3-0-database--2010-census-tracts/resource/0c292d45-8a97-494a-908a-3f937516da3a#dictionary_anchor

download.file(
  "https://www2.census.gov/geo/docs/maps-data/data/rel2020/tract/tab20_tract20_tract10_natl.txt",
  destfile = "data-raw/tract_10_20_cw.txt"
)
tract_10_20_cw <-
  read_delim("data-raw/tract_10_20_cw.txt") |>
  select(
    census_tract_id_2020 = GEOID_TRACT_20,
    tract_area_2020 = AREALAND_TRACT_20,
    census_tract_id_2010 = GEOID_TRACT_10,
    tract_area_2010 = AREALAND_TRACT_10,
    AREALAND_PART
  ) |>
  mutate(area_ratio = AREALAND_PART / tract_area_2010) |>
  filter(area_ratio > 0)

d <-
  read_csv('data-raw/1_index.csv') |>
  filter(year == 2021) |>
  select(
    census_tract_id_2010 = geoid10,
    coi_education = z_ED_nat,
    coi_health_env = z_HE_nat,
    coi_social_econ = z_SE_nat,
    coi = z_COI_nat
  ) |>
  left_join(tract_10_20_cw, by = "census_tract_id_2010") |>
  mutate(
    across(
      c(coi_education, coi_health_env, coi_social_econ, coi),
      \(x) x * area_ratio
    )
  ) |>
  group_by(census_tract_id_2020) %>%
  summarise(
    across(
      c(coi_education, coi_health_env, coi_social_econ, coi),
      \(x) sum(x, na.rm = TRUE)
    )
  )

saveRDS(d, 'data/coi.rds')
