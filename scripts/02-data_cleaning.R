#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

# Load necessary library
library(tidyverse)

# Load the dataset
epl_data <- read.csv("data/raw_data/raw_22-23_epl.csv")

# Selecting relevant columns and handling missing data
epl_data_clean <- epl_data %>%
  select(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) %>%
  # Convert Date to proper Date format
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
  # Replace NA with "N/A" for categorical columns
  mutate_at(vars(HomeTeam, AwayTeam, FTR), ~replace_na(., "N/A"))

# Saving the cleaned data
write_csv(epl_data_clean, "data/analysis_data/epl_cleaned_data.csv")

