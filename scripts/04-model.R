#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/epl_cleaned_data.csv")

# Fitting a Poisson regression model using a Bayesian approach
home_goals_bayesian_model <- stan_glm(FTHG ~ 1, 
                                      family = poisson(link = "log"), 
                                      data = epl_data,
                                      prior = normal(0, 2.5), # Setting a prior for the regression coefficients
                                      prior_intercept = normal(0, 2.5), # Setting a prior for the intercept
                                      chains = 4, iter = 2000)

saveRDS(home_goals_bayesian_model, "models/home_goals.rds")

# Predicting with the Bayesian model
# For a Bayesian model, predictions can also be drawn from the posterior distribution
predicted_goals_bayesian <- posterior_predict(home_goals_bayesian_model)

# Displaying predicted goals - Example of getting the mean of predicted values
mean_predicted_goals <- apply(predicted_goals_bayesian, 2, mean)

saveRDS(mean_predicted_goals, "models/predicted_goals.rds")
