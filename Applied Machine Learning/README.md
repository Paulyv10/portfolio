# Applied Machine Learning — INFO 4940/5940 (Fall 2025)

Course work from Cornell's Applied Machine Learning course. Projects use R (tidymodels) and Python (scikit-learn) across supervised learning, model evaluation, and feature engineering.

---

## Homework

### HW-00: R & Python Prefresher
**Folder:** `Homework/Prefresher R/`

Warm-up exercises in both R and Python covering data wrangling, visualization, and basic statistical operations. Used datasets on commissary prices and eating habits.

[View PDF (R)](Homework/Prefresher%20R/hw-00-prefresher-r.pdf) | [View PDF (Python)](Homework/Prefresher%20R/hw-00-prefresher-py.pdf)

---

### HW-01: Make a Model
**Folder:** `Homework/Prefresher/`

Built a classification model on NYC squirrel census data. Explored logistic regression with tidymodels, handled class imbalance using SMOTE (themis), and evaluated model performance.

[View PDF](Homework/Prefresher/hw-01-make-a-model.pdf)

**Key Outputs:**

[![Squirrel Model Plot 1](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-6-1.png)](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-6-1.png)
[![Squirrel Model Plot 2](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-8-1.png)](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-8-1.png)
[![Squirrel Model Plot 3](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-9-1.png)](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-9-1.png)
[![Squirrel Model Plot 4](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-10-1.png)](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-10-1.png)
[![Squirrel Model Plot 5](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-11-1.png)](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-11-1.png)
[![Squirrel Model Plot 6](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-12-1.png)](Homework/Prefresher/hw-01-make-a-model_files/figure-html/unnamed-chunk-12-1.png)

---

### HW-02: Build Better Data
**Folder:** `Homework/Build Better Data/`

Feature engineering and data preprocessing on college scorecard data. Explored transformations, encoding strategies, and preprocessing pipelines in tidymodels to prepare data for downstream modeling.

[View HTML](Homework/Build%20Better%20Data/hw-02-build-better-data.html) | [View PDF](Homework/Build%20Better%20Data/hw-02-build-better-data.pdf)

**Key Outputs:**

[![Feature Distribution](Homework/Build%20Better%20Data/hw-02-build-better-data_files/figure-html/unnamed-chunk-9-1.png)](Homework/Build%20Better%20Data/hw-02-build-better-data_files/figure-html/unnamed-chunk-9-1.png)
[![Preprocessing Pipeline Output 1](Homework/Build%20Better%20Data/hw-02-build-better-data_files/figure-html/unnamed-chunk-17-1.png)](Homework/Build%20Better%20Data/hw-02-build-better-data_files/figure-html/unnamed-chunk-17-1.png)
[![Preprocessing Pipeline Output 2](Homework/Build%20Better%20Data/hw-02-build-better-data_files/figure-html/unnamed-chunk-17-2.png)](Homework/Build%20Better%20Data/hw-02-build-better-data_files/figure-html/unnamed-chunk-17-2.png)
[![Preprocessing Pipeline Output 3](Homework/Build%20Better%20Data/hw-02-build-better-data_files/figure-html/unnamed-chunk-17-3.png)](Homework/Build%20Better%20Data/hw-02-build-better-data_files/figure-html/unnamed-chunk-17-3.png)

---

### HW-03: Tune and Evaluate Models
**Folder:** `Homework/Tune and Evaluate Models/`

Hyperparameter tuning and model evaluation using cross-validation on GSS survey data. Compared multiple model families, tuned via grid search, and evaluated with ROC-AUC and other metrics.

[View PDF](Homework/Tune%20and%20Evaluate%20Models/hw-03-tune-eval-models.pdf)

**Key Outputs:**

[![Model Tuning Results](Homework/Tune%20and%20Evaluate%20Models/hw-03-tune-eval-models_files/figure-html/unnamed-chunk-28-1.png)](Homework/Tune%20and%20Evaluate%20Models/hw-03-tune-eval-models_files/figure-html/unnamed-chunk-28-1.png)
[![Model Evaluation](Homework/Tune%20and%20Evaluate%20Models/hw-03-tune-eval-models_files/figure-html/unnamed-chunk-45-1.png)](Homework/Tune%20and%20Evaluate%20Models/hw-03-tune-eval-models_files/figure-html/unnamed-chunk-45-1.png)

---

### HW-04: Predict Coffee Preferences
**Folder:** `Homework/Predict Coffee Trends/`

End-to-end classification pipeline predicting coffee preference outcomes from survey data. Applied ensemble methods and tuned hyperparameters, with emphasis on model interpretability and performance reporting.

[View HTML](Homework/Predict%20Coffee%20Trends/hw-04-predict-coffee.html) | [View PDF](Homework/Predict%20Coffee%20Trends/hw-04-predict-coffee.pdf)

---

## Application Exercises

### AE-09: Feature Engineering — Coffee EDA
**Folder:** `Application Exercises/Feature Engineering/`

Exploratory data analysis on the Great American Coffee Taste Test dataset. Investigated missingness patterns and outliers in both R and Python.

**Python (missingno + seaborn):**

[![Missingness Pattern 1](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/py-missingness-1-output-1.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/py-missingness-1-output-1.png)
[![Missingness Pattern 2](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/py-missingness-2-output-1.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/py-missingness-2-output-1.png)
[![Missingness Pattern 3](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/py-missingness-3-output-1.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/py-missingness-3-output-1.png)
[![Outlier Detection 1](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/num-outliers-output-1.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/num-outliers-output-1.png)
[![Outlier Detection 2](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/num-outliers-output-2.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-py_files/figure-html/num-outliers-output-2.png)

**R (naniar + ggplot2):**

[![R Missingness 1](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-r_files/figure-html/missingness-1.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-r_files/figure-html/missingness-1.png)
[![R Missingness 2](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-r_files/figure-html/missingness-2.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-r_files/figure-html/missingness-2.png)
[![R Missingness 3](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-r_files/figure-html/missingness-3.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-r_files/figure-html/missingness-3.png)
[![R Outliers](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-r_files/figure-html/num-outliers-1.png)](Application%20Exercises/Feature%20Engineering/ae-09-eda-coffee-r_files/figure-html/num-outliers-1.png)

---

## Stack

- **R:** tidymodels, tidyverse, themis, naniar, ggplot2
- **Python:** scikit-learn, pandas, missingno, seaborn, matplotlib
- **Tooling:** Quarto, R Markdown, VS Code
