library(tidyverse)

if (!file.exists("raw-data/SVI2018.csv")) {
  download.file(
    url = "https://svi.cdc.gov/Documents/Data/2018_SVI_Data/CSV/SVI2018_US.csv",
    destfile = "raw-data/SVI2018.csv",
    mode = "wb"
  )
}

svi <-
  readr::read_csv("raw-data/SVI2018.csv", na = c("-999", "-999.0")) %>%
  select(
    census_tract_id = FIPS,
    svi_socioeconomic = RPL_THEME1,
    svi_household_comp = RPL_THEME2,
    svi_minority = RPL_THEME3,
    svi_housing_transportation = RPL_THEME4,
    svi = RPL_THEMES
  )

saveRDS(svi, "data/svi.rds")
