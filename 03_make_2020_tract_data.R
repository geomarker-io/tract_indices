library(tidyverse)

mega_data <- readRDS('census_mega_data.rds')
cw <- readRDS('2010_to_2020_tract_cw.rds')

d <- mega_data %>%
  rename(census_tract_id_2010 = census_tract_id) %>%
  select(-census_tract_vintage) %>%
  left_join(cw, by = "census_tract_id_2010") %>%
  relocate(c(census_tract_id_2020, weight), .after = census_tract_id_2010) %>%
  mutate(low_food_access_flag = ifelse(low_food_access_flag == 'yes', 1, 0),
         hpsa = ifelse(hpsa == 'yes', 1, 0)) # make bivariates numeric for now...

# if 2010 tract splits to mulitple 2020 tracts
    ## all 2020 tracts will have same value as 2010 tract
# if multiple 2010 tracts are combined to 1 2020 tract
    ## use area-weighted average of 2010 tract values

d <- d %>%
  group_by(census_tract_id_2020) %>%
  mutate(weight_inverse = weight/sum(weight),
         across(adi:walkability_index, ~ .x * weight_inverse)) %>%
  group_by(census_tract_id_2020) %>%
  summarize(across(adi:walkability_index, ~ sum(.x)))

### turn numeric bivariates back to y/n
summary(d$low_food_access_flag)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
#  0.0000  0.0000  0.0000  0.3993  1.0000  1.0000    1277
# 378 2020 tracts between 0.1 and 0.9
# if < 0.5 then no, if >= 0.5 then yes

d <- d %>%
  mutate(low_food_access_flag = ifelse(low_food_access_flag < 0.5 , "no", "yes"))

summary(d$hpsa)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
#  0.0000  0.0000  0.0000  0.2643  1.0000  1.0000    1552
# 28 tracts between 0.1 and 0.9

d %>%
  select(census_tract_id_2020, hpsa) %>%
  filter(hpsa > 0 & hpsa < 1) %>%
  mutate(hpsa = ifelse(hpsa <= 0.1 , 0, hpsa),
         hpsa = ifelse(hpsa >= 0.9 , 1, hpsa)) %>%
  filter(hpsa > 0 & hpsa < 1) %>%
  ggplot() +
  geom_histogram(aes(x = hpsa))

d <- d %>%
  mutate(hpsa = ifelse(hpsa < 0.5 , "no", "yes"))

# clean up and combine with 2010 tract data
d <- d %>%
  rename (census_tract_id = census_tract_id_2020) %>%
  mutate(census_tract_vintage = 2020) %>%
  relocate(census_tract_vintage, .after = census_tract_id)

mega_data <- mega_data %>%
  bind_rows(d) %>%
  arrange(census_tract_id)

saveRDS(mega_data, 'census_mega_data.rds')
write_csv(mega_data, 'census_mega_data.csv')

