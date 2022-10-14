library(tidyverse)

# https://www.graham-center.org/maps-data-tools/social-deprivation-index.html

sdi <-
  readxl::read_excel("raw-data/sdi.xlsx", col_types = "text") %>%
  mutate(sdi = as.numeric(sdi_score),
         nchar = nchar(CT)) %>%
  mutate(census_tract_id = ifelse(nchar == 10,
                                    paste0("0", CT),
                                    CT)) %>%
  select(census_tract_id, sdi)

saveRDS(sdi, "data/sdi.rds")
