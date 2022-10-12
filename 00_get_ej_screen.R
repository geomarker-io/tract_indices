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

d$lead_paint <- round(d$lead_paint, 2)
d$diesel_pm <- round(d$diesel_pm, 3)
d$cancer_risk <- round(d$cancer_risk, 1)
d$resp_hazard_ind <- round(d$resp_hazard_ind, 2)
d$traffic_proximity <- round(d$traffic_proximity, 1)
d$major_discharger_water <- round(d$major_discharger_water, 5)
d$nat_priority_proximity <- round(d$nat_priority_proximity, 3)
d$risk_management_proximity <- round(d$risk_management_proximity, 3)
d$disposal_proximity <- round(d$disposal_proximity, 3)
d$ozone_conc <- round(d$ozone_conc, 2)
d$pm_conc <- round(d$pm_conc, 2)

saveRDS(d, 'data/ej_screen.rds')


