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

#stats for whole of scotland

#Greenspace stats scotland
greenspace_stats_2016_2019 <- greenspace_council_names %>% 
  group_by(distance_to_nearest_green_or_blue_space) %>% 
  filter(
    date_code >= 2016,
    str_detect(area_code, "^S92"),
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

# Summary stats Scottish Health Survey by Local Area
raw_scotland_health_survey_local <- read_csv("data/raw_data/scotland health survey local level.csv") %>% 
  clean_names()

summary_stat_scottish_health_survey_local_area <- raw_scotland_health_survey_local %>% 
  filter(
    date_code == "2016-2019",
    str_detect(feature_code, "^S92"),
    filter(scottish_health_survey_indicator %in% c(
      "Any cardiovascular condition: Has a cardiovascular condition",
      "Any cardiovascular condition: No cardiovascular condition",
      "Life satisfaction: Above the mode (9 to 10-Extremely satisfied)",
      "Life satisfaction: Below the mode (0-Extremely dissatisfied to 7)",
      "Life satisfaction: Mode (8)", "Obesity: Not obese", "Obesity: Obese",
      "Overweight: Not overweight or obese", "Overweight: Overweight (including obese)",
      "Overweight: Overweight (including obese)", "Summary activity levels: Low activity",
      "Summary activity levels: Meets recommendations", "Summary activity levels: Some activity",
      "Summary activity levels: Very low activity"),
  measurement == "Mean" | 
    measurement == "95% Lower Confidence Limit" | 
    measurement == "95% Upper Confidence Limit"
  )
    




