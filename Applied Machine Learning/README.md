# Applied Machine Learning — INFO 4940/5940 (Fall 2025)

Course work from Cornell's Applied Machine Learning course. Projects use R (tidymodels) and Python (scikit-learn) across supervised learning, model evaluation, and feature engineering.

---

## Homework

### HW-00: R & Python Prefresher
**Folder:** `Homework/Prefresher R/`

Warm-up exercises in both R and Python covering data wrangling, visualization, and basic statistical operations. Used datasets on commissary prices and eating habits.

[View PDF (R)](Homework/Prefresher%20R/hw-00-prefresher-r.pdf) | [View PDF (Python)](Homework/Prefresher%20R/hw-00-prefresher-py.pdf)

---

### HW-01: Make a Model — NYC Squirrel Census
**Folder:** `Homework/Prefresher/`

Can you predict whether a yard will have squirrels based on tree coverage, pet ownership, and nearby feeders? EDA, logistic regression, decision tree, and random forest — the random forest won with 65% accuracy and ROC AUC of 0.712.

[Read the full writeup →](Homework/Prefresher/README.md) | [View PDF](Homework/Prefresher/hw-01-make-a-model.pdf) | [View HTML](Homework/Prefresher/hw-01-make-a-model.html)

---

### HW-02: Build Better Data — College Scorecard
**Folder:** `Homework/Build Better Data/`

Predicting median student debt at U.S. colleges. Tested five feature engineering candidates one at a time — only a quadratic cost term helped. Tuned random forest achieved a 34% RMSE reduction over the null baseline.

[Read the full writeup →](Homework/Build%20Better%20Data/README.md) | [View PDF](Homework/Build%20Better%20Data/hw-02-build-better-data.pdf) | [View HTML](Homework/Build%20Better%20Data/hw-02-build-better-data.html)

---

### HW-03: Tune and Evaluate Models — GSS Marijuana Legalization
**Folder:** `Homework/Tune and Evaluate Models/`

Classifying public opinion on marijuana legalization from GSS survey data. Class imbalance (70/30) made metric selection the most important decision. Downsampled elastic net logistic regression won on balanced accuracy, with age and party ID doing most of the heavy lifting.

[Read the full writeup →](Homework/Tune%20and%20Evaluate%20Models/README.md) | [View PDF](Homework/Tune%20and%20Evaluate%20Models/hw-03-tune-eval-models.pdf)

---

### HW-04: Predict Coffee Preferences
**Folder:** `Homework/Predict Coffee Trends/`

End-to-end classification pipeline predicting coffee preference outcomes from the Great American Coffee Taste Test survey. Applied ensemble methods and tuned hyperparameters, with emphasis on model interpretability and performance reporting.

[View PDF](Homework/Predict%20Coffee%20Trends/hw-04-predict-coffee.pdf) | [View HTML](Homework/Predict%20Coffee%20Trends/hw-04-predict-coffee.html)

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
