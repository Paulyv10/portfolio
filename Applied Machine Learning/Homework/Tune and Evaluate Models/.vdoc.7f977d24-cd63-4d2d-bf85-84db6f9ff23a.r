#
#
#
#
#
#
#
#
#
#
#
#
#
#
library(yaml)
library(tidyverse)
library(tidymodels)
library(arrow)
library(themis)

set.seed(123)

#
#
#
#
#
#
#
# Metrics Identified for Performance

# Since this is a classification problem predicting marijuana legalization attitudes, we need metrics that

# a) Handle class imbalances appropriately
# b) Evaluate performance on BOTH classes equally
# c) Are interpretable for potential outside stakeholders
#
#
#
# 1. Sensitivity (Recall/True Positive Rate)
# Reason: The proportion of 'shoudld not be legal' responses correctly identified, plus it's important for understanding pro-legalization sentiment(s)

# 2. Specificity (True Negative Rate)
# Reason: The proportion of 'should not be legal' responses correctly identified & it is important for understanding opposition sentiment

# 3. Balanced Accuracy (Sensitivity + Specificty) / 2
# Reason: Addresses class imbalance by weighing both classes equally. It also is a single metric that balance performanceo n BOTH classes.

# 4. ROC AUC (Area under ROC Curve)
# Reason: It measures discriminative ability across all probability thresholds and it is less sensitive to class imbalances than a regular accuracy

# 5. J-Index (also known as Youden's Index): Sensitivity + Specificity - 1
# Reason: It maximizes the difference between true positive rate and false positive rate and it dirrectly related to balanced accuracy (same ranking)

# 6. Brier Score
# Reason: It measures calibration (how well predicted probabilities match actual outcomes) and will usually offer lower scores. Lower scores indicate better probability estimates.
#
#
#
#
#
gss_data <- read_feather("data/gss.feather")

glimpse(gss_data)
#
#
#
#
# Checking outcome variable distro
gss_data |> 
  count(grass) |> 
  mutate(proportion = n / sum(n))
#
#
#
summary(gss_data)
#
#
#
# checking missing patterns

gss_data |> 
  summarise(across(everything(), ~ sum(is.na(.)))) |> 
  pivot_longer(everything(), names_to = "variable", values_to = "missing_count") |> 
  mutate(missing_prop = missing_count / nrow(gss_data)) |> 
  arrange(desc(missing_count))
#
#
#
gss_data |> 
  select(grass, gunlaw, partyid, region, sex, fear) |> 
  summary()
#
#
#
# Class imbalance? 

gss_data |> 
  count(grass) |> 
  mutate(proportion = n / sum(n)) |> 
  mutate(ratio = paste0(round(proportion * 100, 1), "%"))

# 69.5% favor (1105 respondents)
# 30.5% oppose (486 respondents)
# That is ~2.3:1 in favor 
#
#
#
# Missing Data? 

gss_data |> 
  summarise(across(everything(), ~ sum(is.na(.)))) |> 
  pivot_longer(everything(), names_to = "variable", values_to = "missing_count") |> 
  mutate(missing_prop = missing_count / nrow(gss_data)) |> 
  arrange(desc(missing_count)) |> 
  filter(missing_prop > 0) |>  # Only show variables with missing data
  print(n = 15)
#
#
#
#
#
#
#
#
#
# gunlaw vs grass 

if(sum(!is.na(gss_data$gunlaw)) > 0) {
  gss_data |> 
    filter(!is.na(gunlaw)) |> 
    count(grass, gunlaw) |> 
    group_by(gunlaw) |> 
    mutate(prop = n / sum(n)) |> 
    print()
}
#
#
#
#
#
#
#
# partyid vs. grass 

gss_data |> 
  filter(!is.na(partyid)) |> 
  count(grass, partyid) |> 
  group_by(partyid) |> 
  mutate(prop = round(n / sum(n), 3)) |> 
  arrange(partyid) |> 
  print(n = 20)
#
#
#
# region vs grass

gss_data |> 
  count(grass, region) |> 
  group_by(region) |> 
  mutate(prop = round(n / sum(n), 3)) |> 
  arrange(desc(prop)) |> 
  print(n = 20)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
