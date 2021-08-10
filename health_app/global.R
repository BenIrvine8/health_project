
# read in packages
library(tidyverse)
library(janitor)
library(here)
library(sf)
library(DT)

# read in survey data
scottish_survey <- read.csv(here("data/clean_data/scotland_health_survey_clean.csv"))
scottish_survey_local <- read_csv(here("data/clean_data/scotland_health_survey_local_clean.csv"))
scottish_survey_local_stats <- read_csv(here("data/clean_data/summary_stat_scotland_health_2016_2019.csv"))
greenspace <- read_csv(here("data/clean_data/greenspace_council_names.csv"))

#read in geospatial data for greenspace
greenspace_la <- greenspace %>% 
  filter(str_detect(area_code, "^S120"))

#read in spatial local authority data and simplify to 1km
la_zones <- st_read(here("data/raw_data/Local_Authority_Boundaries_-_Scotland/pub_las.shp")) %>% 
  st_simplify(preserveTopology = FALSE, dTolerance = 1000)

#merge health data to shape files
greenspace_la_geo <- la_zones %>% 
  merge(greenspace_la, by.x = "code", by.y = "area_code", all = TRUE)

scottish_survey_la_geo <- la_zones %>% 
  merge(scottish_survey_local, by.x = "code", by.y = "area_code", all = TRUE)