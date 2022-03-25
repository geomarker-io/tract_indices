library(tidyverse)

options(timeout=1000)
download.file('https://gaftp.epa.gov/EJSCREEN/2020/EJSCREEN_2020_USPR.csv.zip',
              destfile='data/ejscreen.zip')
unzip('data/ejscreen.zip', exdir = 'data')
unlink('data/ejscreen.zip')

d <- read_csv('data/EJSCREEN_2020_USPR.csv')

d <- d %>%
  select(block_group_fips = ID,
         lead_paint = PRE1960PCT,
         diesel_pm = DSLPM,
         cancer_risk = CANCER,
         resp_hazard_ind = RESP,
         traffic_proximity = PTRAF,
         major_discharger_water = PWDIS,
         nat_priority_proximity = PNPL,
         risk_management_proximity = PRMP,
         disposal_proximity = PTSDF,
         ozone_conc = OZONE,
         pm_conc = PM25)

d <- d %>%
  mutate(census_tract_id = stringr::str_sub(block_group_fips, 1, 11)) %>%
  group_by(census_tract_id) %>%
  summarize_if(is.numeric, ~mean(.x))

saveRDS(d, 'data/ej_screen.rds')


