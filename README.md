# census_mega_dataset

| dataset       |  variable_name             | variable_description  | temporal       | spatial     |
|---------------|----------------------------|-----------------------|----------------|----------------|
| [community deprivation index](https://geomarker.io/dep_index/)   | fraction_poverty | fraction of population with income in past 12 months below poverty level   | 2018 5-year ACS   | 2010 tract  |
| | median_income   | median household income in the past 12 months in 2018 inflation-adjusted dollars | 2018 5-year ACS | 2010 tract | 
| | fraction_high_school_edu  | fraction of population 25 and older with educational attainment of at least high school graduation (includes GED equivalency) | 2018 5-year ACS | 2010 tract  |
| | fraction_no_health_ins  | fraction of poulation with no health insurance coverage | 2018 5-year ACS | 2010 tract|
| | fraction_assisted_income  | fraction of households receiving public assistance income or food stamps or SNAP in the past 12 months | 2018 5-year ACS | 2010 tract |
| | fraction_vacant_housing   | fraction of houses that are vacant | 2018 5-year ACS | 2010 tract  |
| | dep_index  | composite index of 6 variables above characterizing community material deprivation; range 0 to 1, with higher values indicating higher deprivation  | 2018 5-year ACS  | 2010 tract |
| [Neighborhood Atlas](https://www.neighborhoodatlas.medicine.wisc.edu/) | adi | national percentile rankings at the block group level from 1 to 100 averaged for each tract; higher adi indicated higher disadvantage | 2019 5-year ACS  | 2010 block group average |
| [National Walkability Index](https://www.epa.gov/smartgrowth/national-walkability-index-user-guide-and-methodology) | walkability_index | national percentile rankings at the block group level from 1 to 20 averaged for each tract; 1 is least walkable, 20 is most walkable; accounts for intersection density, proximity to transit stops, employment mix, and employment/household mi | 2021 (2018 HERE Maps NAVSTREETS, 2020 GTFS, 2020 CTOD, 2018 LODES: WAC, LEHD) | 2010 block group average |
| [Kreiger ICE](https://www.hsph.harvard.edu/thegeocodingproject/covid-19-resources/) | ice | high income white non-Hispanic households versus  low income people of color (not white non-Hispanic) households; -1 to 1 where 1 indicates all high income white households and -1 indicates all low income people of color households     | 2019 5-year ACS | 2010 tract |
|  | pct_crowding | percent of households with greater than 1 person per room | 2019 5-year ACS| 2010 tract |
| [EJScreen](https://www.epa.gov/ejscreen/overview-environmental-indicators-ejscreen) | lead_paint | lead paint indicator; percent of housing units built pre-1960   | 2019 5-year ACS | 2010 block group average|
| | diesel_pm | concentration of diesel particulate matter in air (ug/m3)  | 2017 EPA Hazardous Air Pollutants | 2010 block group average |
| | cancer_risk | lifetime cancer risk from inhalation of air toxics | 2017 EPA Hazardous Air Pollutants | 2010 block group average |
| | resp_hazard_ind  | air toxics respiratory hazard index; ratio of exposure concentration to health-based reference concentration | 2017 EPA Hazardous Air Pollutants | 2010 block group average |
| | traffix_proximity | traffic proximity and volume; Count of vehicles (AADT, avg. annual daily traffic) at major roads within 500 meters, divided by distance in meters | 2019 U.S. Department of Transportation | 2010 block group average |
| | major_discharger_water  | indicator for major direct dischargers to water; RSEI modeled toxic concentrations at stream segments within 500 m divided by distance in km  | 2021 RSEI | 2010 block group average |
| | nat_priority_proximity | proximity to National Priorities List (NPL) sites; count of proposed or listed NPL (a.k.a. superfund) sites within 5 km (or nearest one beyond 5 km) | 2021 EPA CERCLIS database | 2010 block group average |
| | risk_management_proximity | proximity to Risk Management Plan (RMP) facilities; count of RMP (potential chemical accident management plan) facilities within 5 km (or nearest one beyond 5 km), each divided by distance in km | 2021 EPA RMP database | 2010 block group average |
| | disposal_proximity  | proximity to Treatment Storage and Disposal (TSDF) facilities; count of hazardous waste facilities (TSDFs and LQGs) within 5 km (or nearest beyond 5 km), each divided by distance in km  | 2021 EPA RCRAInfo database | 2010 block group average |
| | ozone_conc | ozone seasonal average of daily maximum 8-hour concentration (ppb) | 2018 EPA OAR | 2010 block group average |
| | pm_conc | annual average PM2.5 level in air (ug/m3) | 2018 EPA OAR  | 2010 block group average |
| [USDA Food Access Research Atlas](https://www.ers.usda.gov/data-products/food-access-research-atlas/state-level-estimates-of-low-income-and-low-access-populations/) | low_food_access_flag  | "yes" if tract has at least 500 people or at least 33% of the tract population living more than 1 mile from nearest food store in urban areas, or more than 10 miles in rural areas | 2019  | 2010 tract |
| | low_food_acess_pct | percent of tract population living more than 1 mile from nearest food store in urban areas, or more than 10 miles in rural areas            | 2019 | 2010 tract |
| [Mental Health Professional Shortage Areas](https://bhw.hrsa.gov/workforce-shortage-areas/shortage-designation) | hpsa | mental health professional shortage area yes/no  | continuous? | 2010 tract or county down-aggregated to tract   |
| [Child Opportunity Index](https://data.diversitydatakids.org/dataset/coi20-child-opportunity-index-2-0-database/resource/080cfe52-90aa-4925-beaa-90efb04ab7fb#dictionary_anchor) | coi_education | Weighted average of education domain component indicator z-scores, nationally normed  | 2015                       | 2010 tract |
| | coi_health_env | Weighted average of health and environment domain component indicator z-scores, nationally normed  | 2015 | 2010 tract |
| | coi_social_econ | Weighted average of social and economic domain component indicator z-scores, nationally normed | 2015  | 2010 tract |
| | coi | Weighted average of three domain averaged z-scores, nationally normed  | 2015  | 2010 tract  |
| [Community Resilience](https://www2.census.gov/programs-surveys/demo/technical-documentation/community-resilience/2019/cre_file_layout_2019.pdf)                   | pct_1or2_risk_factors     | Rate of individuals with one-two risk factors  | 2019  | 2010 tract |
| | pct_3ormore_risk_factors  | Rate of individuals with three plus risk factors | 2019  | 2010 tract |
| Crime  | |  |  | |
| Social Capital Index (from ORNL?)  |  |   |   | |


## tract cross walk

2020 tract data were calculated using area-weighted averages of 2010 tract data: 

- if 1 2010 tract was split to multiple 2020 tracts, 2010 values were propagated to all 2020 tracts

- if multiple 2010 tracts were combined to 1 2020 tract, 2010 values were area-weighted and averaged

![](example_plots.png)

yes/no variables were converted to 1/0 before averaging, then assigned "yes" if >= 0.5 or "no" otherwise.
