library(tidyverse)
library(dpkg)

# read in and join all data
fls <- list.files(path = 'data', pattern = '*.rds')
d <- map(glue::glue('data/{fls}'), readRDS)

d <- purrr::reduce(d, .f = left_join, by = 'census_tract_id_2020')

# round all variables to 3 signif digits
d <- d |>
  mutate(across(where(is.numeric), \(x) signif(x, 3)))

# create dataset attrs
d_dpkg <-
  d |>
  dpkg::as_dpkg(
    name = "tract_indices",
    title = "Census Tract-Level Neighborhood Indices",
    version = "1.0.0",
    homepage = "https://geomarker.io/tract_indices",
    description = paste(readLines(fs::path("metadata.md")), collapse = "\n")
  )

# write tdr and csv
write_csv(d_dpkg, "data-raw/tract_indices_2025.csv")
dpkg::dpkg_gh_release(d_dpkg, draft = FALSE)
