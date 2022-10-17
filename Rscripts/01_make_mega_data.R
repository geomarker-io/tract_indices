library(tidyverse)
library(cincy)
library(CODECtools)

# read in and join all data
fls <- list.files(path = 'data', pattern = '*.rds')
d <- map(glue::glue('data/{fls}'), readRDS)

d <- purrr::reduce(d, .f = left_join, by = 'census_tract_id')

# round all variables to 3 signif digits
d <- d |>
  mutate(across(where(is.numeric), signif, 3))

# create dataset attrs
d <- d |>
  add_attrs(
    name = "tract_indices",
    path = "tract_indices.csv",
    title = "Census Tract-Level Neighborhood Indices",
    version = "0.3.0",
    homepage = "https://geomarker.io/tract_indices"
  )

# create column attrs
d <-
  d |>
  add_col_attrs(census_tract_id,
                title = "Census Tract Identifier") |>
  add_col_attrs(adi,
                title = "Neighborhood Atlas Area Deprivation Index",
                description = "national percentile ranking at block group level from 1 to 100 averaged for each tract; higher adi indicates higher disadvantage (2019)") |>
  add_col_attrs(coi_education,
                title = "Child Opportunity Index Education Domain",
                description = "weighted average of education domain component indicator z-scores, nationally normed (2015)") |>
  add_col_attrs(coi_health_env,
                title = "Child Opportunity Index Health and Environment Domain",
                description = "weighted average of health and environment domain component indicator z-scores, nationally normed (2015)") |>
  add_col_attrs(coi_social_econ,
                title = "Child Opportunity Index Social and Economic Domain",
                description = "weighted average of social and economic domain component indicator z-scores, nationally normed (2015)") |>
  add_col_attrs(coi,
                title = "Child Opportunity Index",
                description = "weighted average of three domain averaged z-scores, nationally normed (2015)") |>
  add_col_attrs(dep_index_fraction_assisted_income,
                title = "Fraction Assisted Income",
                description = "fraction of households receiving public assistance income or food stamps or SNAP in the past 12 months (2018)") |>
  add_col_attrs(dep_index_fraction_high_school_edu,
                title = "Fraction High School Education",
                description = "fraction of population 25 and older with educational attainment of at least high school graduation (includes GED equivalency) (2018)") |>
  add_col_attrs(dep_index_median_income,
                title = "Median Household Income",
                description = "median household income in the past 12 months in 2018 inflation-adjusted dollars (2018)") |>
  add_col_attrs(dep_index_fraction_no_health_ins,
                title = "Fraction No Health Insurance",
                description = "fraction of poulation with no health insurance coverage (2018)") |>
  add_col_attrs(dep_index_fraction_poverty,
                title = "Fraction Poverty",
                description = "fraction of population with income in past 12 months below poverty level (2018)") |>
  add_col_attrs(dep_index_fraction_vacant_housing,
                title = "Fraction Vacant Housing",
                description = "fraction of houses that are vacant (2018)") |>
  add_col_attrs(dep_index,
                title = "Material Deprivation Index",
                description = "composite index of 6 variables above characterizing community material deprivation; range 0 to 1, with higher values indicating higher deprivation (2018)") |>
  add_col_attrs(lead_paint,
                title = "Lead Paint Indicator",
                description = "percent of housing units built pre-1960 (2019)") |>
  add_col_attrs(diesel_pm,
                title = "Diesel PM Concentration",
                description = "concentration of diesel particulate matter in air (ug/m3) (2017)") |>
  add_col_attrs(cancer_risk,
                title = "Cancer Risk",
                description = "lifetime cancer risk from inhalation of air toxics (2017)") |>
  add_col_attrs(resp_hazard_ind,
                title = "Respiratory Hazard Index",
                description = "air toxics respiratory hazard index; ratio of exposure concentration to health-based reference concentration (2017)") |>
  add_col_attrs(traffic_proximity,
                title = "Traffic Proximity and Volume",
                description = "Count of vehicles (AADT, avg. annual daily traffic) at major roads within 500 meters, divided by distance in meters (2019)") |>
  add_col_attrs(major_discharger_water,
                title = "Major Direct Dischargers to Water Indicator",
                description = " RSEI modeled toxic concentrations at stream segments within 500 m divided by distance in km (2021)") |>
  add_col_attrs(nat_priority_proximity,
                title = "Proximity to NPL Sites",
                description = "count of proposed or listed National Priority List (a.k.a. superfund) sites within 5 km (or nearest one beyond 5 km) (2021)") |>
  add_col_attrs(risk_management_proximity,
                title = "Proximity to RMP Facilities",
                description = "count of Risk Management Plan (potential chemical accident management plan) facilities within 5 km (or nearest one beyond 5 km), each divided by distance in km (2021)") |>
  add_col_attrs(disposal_proximity,
                title = "Proximity to TSDF Facilities",
                description = "count of hazardous waste facilities (Treatment Storage and Disposal Facilities and LQGs) within 5 km (or nearest beyond 5 km), each divided by distance in km (2021)") |>
  add_col_attrs(ozone_conc,
                title = "Ozone Cocentration",
                description = "ozone seasonal average of daily maximum 8-hour concentration (ppb) (2018)") |>
  add_col_attrs(pm_conc,
                title = "PM Concentration",
                description = "annual average PM2.5 level in air (ug/m3) (2018)") |>
  add_col_attrs(low_food_access_flag,
                title = "Low Food Access Flag",
                description = "TRUE if tract has at least 500 people or at least 33% of the tract population living more than 1 mile from nearest food store in urban areas, or more than 10 miles in rural areas (2019)") |>
  add_col_attrs(low_food_access_pct,
                title = "Low Food Access Percentage",
                description = "percent of tract population living more than 1 mile from nearest food store in urban areas, or more than 10 miles in rural areas (2019)") |>
  add_col_attrs(hpsa_mh,
                title = "Mental Health Professional Shortage Area") |>
  add_col_attrs(hpsa_pc,
                title = "Primary Care Professional Shortage Area") |>
  add_col_attrs(mua,
                title = "Medically Underserved Area") |>
  add_col_attrs(ice,
                title = "Racial Economic Index of Concentration at the Extremes",
                description = "high income white non-Hispanic households versus  low income people of color (not white non-Hispanic) households; -1 to 1 where 1 indicates all high income white households and -1 indicates all low income people of color households (2019)") |>
  add_col_attrs(pct_crowding,
                title = "Percent Crowding",
                description = "percent of households with greater than 1 person per room (2019)") |>
  add_col_attrs(pct_1or2_risk_factors,
                title = "Percent 1 or 2 Community Resilience Risk Factors",
                description = "Rate of individuals with one to two community resilience risk factors (2019)") |>
  add_col_attrs(pct_3ormore_risk_factors,
                title = "Percent 3 or More Community Resilience Risk Factors",
                description = "Rate of individuals with three or more community resilience risk factors (2019)") |>
  add_col_attrs(walkability_index,
                title = "Walkability Index",
                description = "national percentile rankings at the block group level from 1 to 20 averaged for each tract; 1 is least walkable, 20 is most walkable; accounts for intersection density, proximity to transit stops, employment mix, and employment/household mix (2021)") |>
  add_col_attrs(sdi,
                title = "Social Deprivation Index",
                description = "Social Deprivation Index Score 1-100 (2015)") |>
  add_col_attrs(svi_socioeconomic,
                title = "Social Vulnerability Index Socioeconomic Theme",
                description = "percentile ranking 0 to 1 for socioeconomic theme (2018)") |>
  add_col_attrs(svi_minority,
                title = "Social Vulnerability Index Minority Theme",
                description = "percentile ranking 0 to 1 for minority status/language theme (2018)") |>
  add_col_attrs(svi_household_comp,
                title = "Social Vulnerability Index Household Composition Theme",
                description = "percentile ranking 0 to 1 for household composition theme (2018)") |>
  add_col_attrs(svi_housing_transportation,
                title = "Social Vulnerability Index Housing and Transportation Theme",
                description = "percentile ranking 0 to 1 for housing type/transportation theme (2018)") |>
  add_col_attrs(svi,
                title = "Social Vulnerability Index",
                description = "overall social vulnerability percentile ranking 0 to 1 (2018)") |>
  add_col_attrs(mrfei,
                title = "Modified Retail Food Environment Index",
                description = "percentage of healthy food retailers (2011)") |>
  add_col_attrs(food_insecurity_pct,
                title = "Food Insecurity Percentage",
                description = "estimated percentage of population in food insecure households (2019)")

# add type attrs
d <- add_type_attrs(d)

# write metadata.md
cat("#### Metadata\n\n", file = "metadata.md", append = FALSE)
CODECtools::glimpse_attr(d) |>
  knitr::kable() |>
  cat(file = "metadata.md", sep = "\n", append = TRUE)

cat("\n#### Schema\n\n", file = "metadata.md", append = TRUE)
d |>
  CODECtools::glimpse_schema() |>
  knitr::kable() |>
  cat(file = "metadata.md", sep = "\n", append = TRUE)

# write tdr
write_tdr_csv(d)
