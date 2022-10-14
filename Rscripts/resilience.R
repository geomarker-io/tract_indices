library(tidyverse)

download.file('https://www2.census.gov/programs-surveys/demo/datasets/community-resilience/2019/CRE_19_Tract.csv',
              destfile = 'raw-data/resilience.csv')

d <- read_csv('raw-data/resilience.csv')

d %>%
  transmute(census_tract_id = glue::glue('{STATE}{COUNTY}{TRACT}'),
         total = round(PRED0_PE + PRED12_PE + PRED3_PE)) %>%
  filter(total != 100)

d <- d %>%
  mutate(census_tract_id = glue::glue('{STATE}{COUNTY}{TRACT}')) %>%
  select(census_tract_id,
         pct_1or2_risk_factors = PRED12_PE,
         pct_3ormore_risk_factors = PRED3_PE)

saveRDS(d, 'data/resilience.rds')
