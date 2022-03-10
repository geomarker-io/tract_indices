library(tidyverse)

download.file('https://www.ers.usda.gov/webdocs/DataFiles/80591/FoodAccessResearchAtlasData2019.xlsx?v=5255',
              destfile='data/food_atlas.xlsx')

d <- readxl::read_excel('data/food_atlas.xlsx', sheet = 3, na = c("NULL"))

d <- d %>%
  select(census_tract_id = CensusTract,
         low_food_access_flag = LA1and10,
         low_food_access_pop = LAPOP1_10,
         total_pop = Pop2010) %>%
  mutate(low_food_access_flag = ifelse(low_food_access_flag == 1, "yes", "no"),
         low_food_access_pct = round(low_food_access_pop/total_pop * 100),
         low_food_access_pop = round(low_food_access_pop)) %>%
  select(census_tract_id, low_food_access_flag, low_food_access_pop, low_food_access_pct)

saveRDS(d, 'data/food_atlas.rds')
