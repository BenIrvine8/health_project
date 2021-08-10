#load libraries
library(tidyverse)

greenspace_council_names <- read_csv("data/clean_data/greenspace_council_names.csv")
scotland_health_survey_local <- read_csv("data/clean_data/scotland_health_survey_local_clean.csv")

greenspace_council_stats <- greenspace_council_names %>% 
  group_by(distance_to_nearest_green_or_blue_space, date_code) %>% 
  filter(
    str_detect(area_code, "^S12"),
    age == "All", 
    gender == "All",
    urban_rural_classification == "All",
    simd_quintiles == "All",
    type_of_tenure == "All",
    household_type == "All",
    ethnicity == "All") %>% 
  summarise(mean_percent = mean(value_percent),
            median_percent = median(value_percent),
            sd_percent = sd(value_percent))

greenspace_histogram <- greenspace_council_names %>% 
  group_by(distance_to_nearest_green_or_blue_space, date_code) %>% 
  filter(
    str_detect(area_code, "^S12"),
    age == "All", 
    gender == "All",
    urban_rural_classification == "All",
    simd_quintiles == "All",
    type_of_tenure == "All",
    household_type == "All",
    ethnicity == "All") %>% 
  ggplot() +
  geom_histogram() +
  aes(x = value_percent)


greenspace_council_stats <- greenspace_council_names %>% 
  group_by(distance_to_nearest_green_or_blue_space, date_code) %>% 
  filter(
    str_detect(area_code, "^S12"),
    age == "All", 
    gender == "All",
    urban_rural_classification == "All",
    simd_quintiles == "All",
    type_of_tenure == "All",
    household_type == "All",
    ethnicity == "All") %>% 
  summarise(mean_percent = mean(value_percent),
            median_percent = median(value_percent),
            sd_percent = sd(value_percent))

greenspace_histogram <- greenspace_council_names %>% 
  group_by(distance_to_nearest_green_or_blue_space, date_code) %>% 
  filter(
    str_detect(area_code, "^S12"),
    age == "All", 
    gender == "All",
    urban_rural_classification == "All",
    simd_quintiles == "All",
    type_of_tenure == "All",
    household_type == "All",
    ethnicity == "All") %>% 
  ggplot() +
  geom_histogram() +
  aes(x = value_percent)


