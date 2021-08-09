#geospatial graphs code

#load libraries
library(tidyverse)
library(sf)
library(here)


# greenspace data ---------------------------------------------------------

#read in greenspace data
greenspace_council_names_only <- read_csv(here::here("data/clean_data/greenspace_council_names.csv")) %>% 
  filter(str_detect(area_code, "^S120"))

#read in spatial local authority data and simplify to 1km
la_zones <- st_read(here::here("data/raw_data/Local_Authority_Boundaries_-_Scotland/pub_las.shp")) %>% 
  st_simplify(preserveTopology = FALSE, dTolerance = 1000)

#use merge to merge health data to shape file
greenspace_council_names_only_zones <- la_zones %>% 
  merge(greenspace_council_names_only, by.x = "code", by.y = "area_code")

#plot geospatial graph with example filters
greenspace_council_names_only_zones %>% 
  filter(date_code == "2019",
         distance_to_nearest_green_or_blue_space == "A 5 minute walk or less",
         age == "All", 
         gender == "All",
         urban_rural_classification == "All",
         simd_quintiles == "All",
         type_of_tenure == "All",
         household_type == "All",
         ethnicity == "All") %>% 
  ggplot() +
  geom_sf(aes(fill = value_percent), colour = "black") +
  theme_minimal()



# health_survey_local data ------------------------------------------------

#read in scotland_health_survey_local_clean
scotland_health_survey_local_clean <- read_csv(
  here::here("data/clean_data/scotland_health_survey_local_clean.csv")) %>% 
  filter(str_detect(area_code, "^S120"))

head(scotland_health_survey_local_clean)

#use merge to merge health data to shape file
scotland_health_survey_local_clean_zones <- la_zones %>% 
  merge(scotland_health_survey_local_clean, by.x = "code", by.y = "area_code")

#only 12 area codes?!
scotland_health_survey_local_clean %>% 
  distinct(area_code)

#plot geospatial graph with example filters
scotland_health_survey_local_clean_zones %>% 
  filter(scottish_health_survey_indicator == "Life satisfaction: Mode (8)",
         sex == "All") %>% 
  ggplot() +
  geom_sf(aes(fill = percentage), colour = "black") +
  theme_minimal()
