library(tidyverse)

if (!file.exists("raw-data/mRFEI.xls")) {
  download.file(
    url = "https://stacks.cdc.gov/view/cdc/61367/cdc_61367_DS2.xls",
    destfile = "raw-data/mRFEI.xls",
    mode = "wb"
  )
}

cw <- readRDS("2000_to_2010_tract_cw.rds")
tracts <- readRDS("tracts.rds")

mrfei <-
  readxl::read_excel("raw-data/mRFEI.xls") %>%
  select(
    census_tract_id_2000 = fips,
    mrfei2000 = mrfei
  ) %>%
  left_join(cw, by = "census_tract_id_2000") %>%
  mutate(mrfei2010 = mrfei2000 * weight_inverse) %>%
  group_by(census_tract_id_2010) %>%
  summarize(mrfei = sum(mrfei2010)) %>%
  rename(census_tract_id = census_tract_id_2010)

saveRDS(mrfei, "data/mrfei.rds")
