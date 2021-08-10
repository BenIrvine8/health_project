
# read in packages
library(tidyverse)
library(janitor)
library(here)
library(ggthemes)

# read in survey data
scottish_survey <- read.csv(here("data/clean_data/scotland_health_survey_clean.csv"))
scottish_survey_local <- read_csv(here("data/clean_data/scotland_health_survey_local_clean.csv"))
greenspace <- read_csv(here("data/clean_data/greenspace_council_names.csv"))
