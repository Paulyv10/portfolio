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
library(tidyverse)
library(tidymodels)

set.seed(123)

scorecard <- read_csv("data/scorecard.csv")

glimpse(scorecard)
#
#
#
#
#
#
# checking for missing values in outcome variable 'debt'

missing_debt <- sum(is.na(scorecard$debt))
cat("Missing values in 'debt' variable:", missing_debt, "\n")
#
#
#
# Removing rows with missing outcome variable :)

scorecard_clean <- scorecard |>
  filter(!is.na(debt))

cat("Rows after removing missing debt:", nrow(scorecard_clean), "\n")
cat("Rows removed", nrow(scorecard) - nrow(scorecard_clean), "\n")

summary(scorecard_clean$debt)
#
#
#
#
#
# particioning!

set.seed(123)

data_split <- initial_split(
  scorecard_clean,
  prop = 0.75,
  strata = debt
)
#
#
#
# extracting training and testing sets

scorecard_train <- training(data_split)
scorecard_test <- testing(data_split)
#
#
#
# Verifying the results

cat("\n=== Data Split Summary ===\n")
cat("Training set:", nrow(scorecard_train), "observations\n")
cat("Test set:", nrow(scorecard_test), "observations\n")
cat(
  "Training proportion:",
  round(nrow(scorecard_train) / nrow(scorecard_clean), 3),
  "\n"
)
#
#
#
#
#
# Verifying stratification worked

train_summary <- summary(scorecard_train$debt)
test_summary <- summary(scorecard_test$debt)

cat("\n=== Outcome Distribution Comparison ===\n")
cat("Training set debt summary:\n")
print(train_summary)
cat("\nTest set debt summary:\n")
print(test_summary)
#
#
#
#
cat("\nKey Statistics Comparison:\n")
cat(
  "Training - Mean:",
  round(mean(scorecard_train$debt), 0),
  ", Median:",
  round(median(scorecard_train$debt), 0),
  "\n"
)
cat(
  "Test - Mean:",
  round(mean(scorecard_test$debt), 0),
  ", Median:",
  round(median(scorecard_test$debt), 0),
  "\n"
)

#
#
#
#
# Visualization

debt_comparison <- bind_rows(
  scorecard_train |> select(debt) |> mutate(split = "Training"),
  scorecard_test |> select(debt) |> mutate(split = "Testing")
)

ggplot(debt_comparison, aes(x = debt)) +
  geom_histogram(bins = 30, alpha = 0.8, color = "white", fill = "blue") +
  facet_wrap(~split, ncol = 1) +
  labs(
    title = "Distribution of Student Debt by Data Split",
    subtitle = "Verifying stratification maintained similar distributions",
    x = "Median Student Debt ($)",
    y = "Number of Institutions"
  ) +
  scale_x_continuous(labels = scales::dollar_format()) +
  theme_minimal()

#
#
#
#
#
# The 75/25 split is shown in many examples from our readings, as it provides substantial training while preserving adqeuate test date for reliable performance estimation. In ISLR ch5, they emphasize the importance of sufficient test data for validation.

# Stratified sampling is recommeneded on the outcome variable because then the training and test sets have similar target distributions. It will prevent a biased performance that oculd occur if one set contained disproportionately high or low debt institutions

# For the missing value handling before we split, they mention in TMRW ch4 that decisions invilving an outcome variable should be made before data pslitting to avoid data leakage.

# set.seed(123) makes sure we have a consistent split across analysis

# For the sole purpose of this assignment, we are just using a simple train/test split rather than train/validation/test. Cross-validation will be used in subsequent exercises (I think) for model tuning and selection
#
#
#
#
#
library(tidyverse)
library(corrplot)
library(GGally)
#
#
#
# Using ONLY training data for Exploratory Analysis

exploratory_data <- scorecard_train
#
#
#
#
# Basic Summary Stats

cat("=== DEBT DISTRIBUTION ANALYSIS ===\n")
debt_summary <- summary(exploratory_data$debt)
print(debt_summary)

cat("\nAdditional Statistics:\n")
cat("Standard Deviation:", round(sd(exploratory_data$debt), 2), "\n")
cat("IQR:", round(IQR(exploratory_data$debt), 2), "\n")
cat(
  "Coefficient of Variation:",
  round(sd(exploratory_data$debt) / mean(exploratory_data$debt), 3),
  "\n"
)

#
#
#
#
# Distribution Viz

p1 <- ggplot(exploratory_data, aes(x = debt)) +
  geom_histogram(bins = 30, fill = "steelblue", alpha = 0.7, color = "white") +
  geom_vline(
    aes(xintercept = mean(debt)),
    color = "red",
    linetype = "dashed",
    size = 1
  ) +
  geom_vline(
    aes(xintercept = median(debt)),
    color = "orange",
    linetype = "dashed",
    size = 1
  ) +
  labs(
    title = "Distribution of Student Debt (Training Data)",
    subtitle = "Red = Mean, Orange = Median",
    x = "Median Student Debt ($)",
    y = "Count"
  ) +
  scale_x_continuous(labels = scales::dollar_format()) +
  theme_minimal()


#
# Box plot

p2 <- ggplot(exploratory_data, aes(y = debt)) +
  geom_boxplot(fill = "lightblue", alpha = 0.7) +
  labs(
    title = "Box Plot of Student Debt",
    y = "Median Student Debt ($)"
  ) +
  scale_y_continuous(labels = scales::dollar_format()) +
  theme_minimal()
#
#
#
# QQ plot!

p3 <- ggplot(exploratory_data, aes(sample = debt)) +
  geom_qq() +
  geom_qq_line(color = "red") +
  labs(
    title = "Q-Q Plot: Debt Distribution vs Normal",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()
#
#
#
# Actual Visualizations

print(p1)
print(p2)
print(p3)
#
#
#
#
#
## Image 1 - Histogram:
# The roughly normal distribution (slight right skew) is excellent for linear regression, since it meets the normality assumption without requiring transformation. Our models should predict well for typical institutions, but the extended right tail indicates some high debt cases that may be harder to predict accurately.

## Image 2 - Box Plot
# The clear outliers above $30,000 will likely influence our model fit and may require hardcore regression methods or outlier investigation during model diagnostics. Feature engineering around debt ranges/categories could be valuable

## Image 3 - Q-Q Plot
# EXCELLENT normality in the middle quartiles! That confirms that OLS regression assumptions are met for most institutions, which means we can trust standard linear model inference and diagnostics. The upper tail deviations indicate that we should monitor residual plots for those high-debt institutions in model eval.

## Overall:
# There are patterns in distribution that support starting with linear regression as our baseline. Although, we should prepare to handle outliers through more complex methods and consider the slight skew when we interpret model/prediction intervals.

#
#
#
#
#
# Training Data Assessment

set.seed(123)

nrow(scorecard_train)

cv_folds <- vfold_cv(
  scorecard_train,
  v = 10, #standard in ISL/R for bias-variance tradeoff
  strata = debt
)
#
#
#
# Verifying it worked

fold_summary <- map_dfr(cv_folds$splits, function(split) {
  tibble(
    train_mean = mean(analysis(split)$debt),
    test_mean = mean(assessment(split)$debt)
  )
})

summary(fold_summary)
#
#
#
#
# Null model

null_spec <- null_model() |>
  set_engine("parsnip") |>
  set_mode("regression")

null_workflow <- workflow() |>
  add_model(null_spec) |>
  add_variables(outcomes = debt, predictors = c())

set.seed(123)
null_cv_results <- fit_resamples(
  null_workflow,
  resamples = cv_folds,
  metrics = metric_set(rmse, mae, rsq),
  control = control_resamples(save_pred = TRUE)
)
#
#
#
# Collect and show metrics

null_metrics <- collect_metrics(null_cv_results)
null_metrics
#
#
#
# baseline comparison of mean

null_rmse <- null_metrics |>
  filter(.metric == "rmse") |>
  pull(mean)

null_mae <- null_metrics |>
  filter(.metric == "mae") |>
  pull(mean)

null_rsq <- null_metrics |>
  filter(.metric == "rsq") |>
  pull(mean)

#
#
#
# What does the null model predict?

training_mean <- mean(scorecard_train$debt)
training_mean
#
#
#
#
#
# Baseline metrics

null_rmse

null_mae

sd(scorecard_train$debt)

null_rmse / sd(scorecard_train$debt)
#
#
#
#
#
# The null model shows a clear baseline for comparison. It has an RMSE of $4,873 and a MAE of $3,884, by simply predicting the training mean ($15,077) for all institutions. The RMSE to standard deviation ratio of 0.999 confrims that this is functioning as a legitimate null model. The undefined R^2 (NaN) is expeted since all predictions are identical.

# The baseline represents the 'worst acceptable performance'; any meaningful predictive model must substantially beat these metrics! Given that the average prediction error is $4,000, there's a lot of room for improvement, and our exploratory analysis suggests strong relationships between debt and institutional characteristics, like costs and earnings. This indicates that linear models should achieve meaninfdul reductions in prediction error.
#
#
#
#
#
#
library(tidymodels)
#
#
#
#establish

set.seed(123)

lm_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")
#
#
#
# preprocessing recipe

basic_recipe <- recipe(debt ~ ., data = scorecard_train) |>
  step_rm(unit_id, name) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_zv(all_predictors()) |>
  step_corr(all_numeric_predictors(), threshold = 0.9)
#
#
#
# workflow

basic_lm_workflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(basic_recipe)
#
#
#
# fit for cross-val

set.seed(123)
basic_lm_cv_results <- fit_resamples(
  basic_lm_workflow,
  resamples = cv_folds,
  metrics = metric_set(rmse, mae, rsq),
  control = control_resamples(save_pred = TRUE)
)

#
#
#
# metrics

basic_lm_metrics <- collect_metrics(basic_lm_cv_results)
basic_lm_metrics
#
#
#
lm_rmse <- basic_lm_metrics |>
  filter(.metric == "rmse") |>
  pull(mean)

lm_mae <- basic_lm_metrics |>
  filter(.metric == "mae") |>
  pull(mean)

lm_rsq <- basic_lm_metrics |>
  filter(.metric == "rsq") |>
  pull(mean)
#
#
#
# compare to null model

lm_rmse
lm_mae
lm_rsq
#
#
#
# improvements calculated

rmse_improvement <- (null_rmse - lm_rmse) / null_rmse * 100
mae_improvement <- (null_mae - lm_mae) / null_mae * 100

rmse_improvement
mae_improvement
#
#
#
# null model baseline (reference)

null_rmse
null_mae
#
#
#

#
#
#
#
#
# Feature Engineering

set.seed(123)

lm_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

#
#
#
#
#
# base recipe

base_recipe <- recipe(debt ~ ., data = scorecard_train) |>
  step_rm(unit_id, name) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_zv(all_predictors()) |>
  step_corr(all_numeric_predictors(), threshold = 0.9)

#
#
#
# test 1: cost to earnings ratio
test1_recipe <- base_recipe |>
  step_mutate(cost_earnings_ratio = cost_net / earnings_med) |>
  step_mutate(cost_earnings_ratio = pmin(cost_earnings_ratio, 5, na.rm = TRUE))

test1_workflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(test1_recipe)

set.seed(123)
test1_results <- fit_resamples(
  test1_workflow,
  resamples = cv_folds,
  metrics = metric_set(rmse, mae, rsq)
)

test1_metrics <- collect_metrics(test1_results)
test1_rmse <- test1_metrics |> filter(.metric == "rmse") |> pull(mean)
test1_mae <- test1_metrics |> filter(.metric == "mae") |> pull(mean)

#
#
#
# test1 results:
test1_rmse
test1_mae
cat(
  "Test 1 improvement - RMSE:",
  round((lm_rmse - test1_rmse) / lm_rmse * 100, 2),
  "%\n"
)
#
#
#
test2_recipe <- base_recipe |>
  step_mutate(affordability_ratio = median_hh_inc / cost_net) |>
  step_mutate(affordability_ratio = pmin(affordability_ratio, 10, na.rm = TRUE))

test2_workflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(test2_recipe)

set.seed(123)
test2_results <- fit_resamples(
  test2_workflow,
  resamples = cv_folds,
  metrics = metric_set(rmse, mae, rsq)
)

test2_metrics <- collect_metrics(test2_results)
test2_rmse <- test2_metrics |> filter(.metric == "rmse") |> pull(mean)
test2_mae <- test2_metrics |> filter(.metric == "mae") |> pull(mean)

# Test 2 results
test2_rmse
test2_mae
cat(
  "Test 2 improvement - RMSE:",
  round((lm_rmse - test2_rmse) / lm_rmse * 100, 2),
  "%\n"
)
#
#
#
#
test3_recipe <- base_recipe |>
  step_mutate(academic_success = comp_rate * retention_rate)

test3_workflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(test3_recipe)

set.seed(123)
test3_results <- fit_resamples(
  test3_workflow,
  resamples = cv_folds,
  metrics = metric_set(rmse, mae, rsq)
)

test3_metrics <- collect_metrics(test3_results)
test3_rmse <- test3_metrics |> filter(.metric == "rmse") |> pull(mean)
test3_mae <- test3_metrics |> filter(.metric == "mae") |> pull(mean)

# Test 3 results
test3_rmse
test3_mae
cat(
  "Test 3 improvement - RMSE:",
  round((lm_rmse - test3_rmse) / lm_rmse * 100, 2),
  "%\n"
)

#
#
#
# Test 4: Economic need indicator (Pell + first generation)
test4_recipe <- base_recipe |>
  step_mutate(economic_need = pell_pct + first_gen)

test4_workflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(test4_recipe)

set.seed(123)
test4_results <- fit_resamples(
  test4_workflow,
  resamples = cv_folds,
  metrics = metric_set(rmse, mae, rsq)
)

test4_metrics <- collect_metrics(test4_results)
test4_rmse <- test4_metrics |> filter(.metric == "rmse") |> pull(mean)
test4_mae <- test4_metrics |> filter(.metric == "mae") |> pull(mean)

# Test 4 results
test4_rmse
test4_mae
cat(
  "Test 4 improvement - RMSE:",
  round((lm_rmse - test4_rmse) / lm_rmse * 100, 2),
  "%\n"
)
#
#
#
#
#
test5_recipe <- base_recipe |>
  step_mutate(cost_net_sq = cost_net^2) |>
  step_normalize(cost_net_sq)

test5_workflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(test5_recipe)

set.seed(123)
test5_results <- fit_resamples(
  test5_workflow,
  resamples = cv_folds,
  metrics = metric_set(rmse, mae, rsq)
)

test5_metrics <- collect_metrics(test5_results)
test5_rmse <- test5_metrics |> filter(.metric == "rmse") |> pull(mean)
test5_mae <- test5_metrics |> filter(.metric == "mae") |> pull(mean)

# Test 5 results
test5_rmse
test5_mae
cat(
  "Test 5 improvement - RMSE:",
  round((lm_rmse - test5_rmse) / lm_rmse * 100, 2),
  "%\n"
)
#
#
#
final_enhanced_recipe <- base_recipe |>
  step_mutate(
    cost_net_sq = cost_net^2,
    academic_success = comp_rate * retention_rate
  ) |>
  step_normalize(cost_net_sq)
#
#
#
#
final_enhanced_workflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(final_enhanced_recipe)
#
#
#
#
# Fit final enhanced model using cross-validation
set.seed(123)
final_enhanced_results <- fit_resamples(
  final_enhanced_workflow,
  resamples = cv_folds,
  metrics = metric_set(rmse, mae, rsq),
  control = control_resamples(save_pred = TRUE)
)
#
#
#
# Collect final results
final_enhanced_metrics <- collect_metrics(final_enhanced_results)
final_enhanced_metrics
#
#
#
final_rmse <- final_enhanced_metrics |> filter(.metric == "rmse") |> pull(mean)
final_mae <- final_enhanced_metrics |> filter(.metric == "mae") |> pull(mean)
final_rsq <- final_enhanced_metrics |> filter(.metric == "rsq") |> pull(mean)


final_rmse
final_mae
final_rsq
#
#
#
#
final_rmse_improvement <- (lm_rmse - final_rmse) / lm_rmse * 100
final_mae_improvement <- (lm_mae - final_mae) / lm_mae * 100
#
#
#
#
#
# Feature Engineering Justification!

# 1. Cost ratios capture debt burden relative to benefits
# 2. Academic metrics indicate insitutional quality or value
# 3. Socioeconomic factors reflect ability to pay
# 4. Geographic variables account for regional cost differences
# 5. Ratio capping prevents EXTREME outliers from dominating the entire model
#
#
#
#
#
#
#
#
#
# Random Forest Baseline

set.seed(123)

rf_spec <- rand_forest(
  trees = 1000,
  mtry = tune(),
  min_n = tune()
) |>
  set_engine("ranger", importance = "impurity") |>
  set_mode("regression")
#
#
#
#
#
# Processing trees

rf_recipe <- recipe(debt ~ ., data = scorecard_train) |>
  step_rm(unit_id, name) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(all_nominal_predictors())

rf_wf <- workflow() |>
  add_model(rf_spec) |>
  add_recipe(rf_recipe)

#
#
#
# Tuning grid

rf_grid <- grid_regular(
  finalize(mtry(), scorecard_train |> select(-debt)), # mtry range based on predictors
  min_n(range = c(2L, 20L)),
  levels = 5
)

set.seed(123)
rf_tuned <- tune_grid(
  rf_wf,
  resamples = cv_folds,
  grid = rf_grid,
  metrics = metric_set(rmse, mae, rsq),
  control = control_grid(save_pred = TRUE)
)

rf_metrics <- collect_metrics(rf_tuned)
rf_metrics

#
#
#
glimpse(rf_metrics)

#
#
#
#
#
#
#
#
best_rf <- select_best(rf_tuned, metric = "rmse")
rf_final_wf <- finalize_workflow(rf_wf, best_rf)
#
#
#
set.seed(123)
rf_test_fit <- last_fit(
  rf_final_wf,
  split = data_split,
  metrics = metric_set(rmse, mae, rsq)
)
collect_metrics(rf_test_fit)
#
