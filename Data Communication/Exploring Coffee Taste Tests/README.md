# AE-09: Exploring Coffee Taste Tests

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View HTML (R)](ae-09-eda-coffee-r.html) | [View HTML (Python)](ae-09-eda-coffee-py.html)

---

## The Goal

Exploratory data analysis on the Great American Coffee Taste Test — a 2023 YouTube event where James Hoffmann and Cometeer sent four coffees to viewers who rated them live. The goal here was to understand the structure and data quality before any modeling.

Done in parallel in R and Python.

---

## Missingness Analysis

A significant chunk of the survey is missing — mostly optional follow-up questions (brew_other, purchase_other, "specify" fields) that most respondents skipped.

**R (visdat) — column order, sorted by % missing, clustered by pattern:**

[![Missingness by column order (R)](ae-09-eda-coffee-r_files/figure-html/missingness-1.png)](ae-09-eda-coffee-r_files/figure-html/missingness-1.png)

[![Missingness sorted by proportion missing (R)](ae-09-eda-coffee-r_files/figure-html/missingness-2.png)](ae-09-eda-coffee-r_files/figure-html/missingness-2.png)

[![Missingness clustered by pattern (R)](ae-09-eda-coffee-r_files/figure-html/missingness-3.png)](ae-09-eda-coffee-r_files/figure-html/missingness-3.png)

**Python (missingno) — same three views:**

[![Missingness by column order (Python)](ae-09-eda-coffee-py_files/figure-html/py-missingness-1-output-1.png)](ae-09-eda-coffee-py_files/figure-html/py-missingness-1-output-1.png)

[![Missingness sorted by proportion missing (Python)](ae-09-eda-coffee-py_files/figure-html/py-missingness-2-output-1.png)](ae-09-eda-coffee-py_files/figure-html/py-missingness-2-output-1.png)

[![Missingness clustered by pattern (Python)](ae-09-eda-coffee-py_files/figure-html/py-missingness-3-output-1.png)](ae-09-eda-coffee-py_files/figure-html/py-missingness-3-output-1.png)

---

## Outlier Detection

Scatterplot matrices across all numeric variables — bitterness, acidity, and personal preference ratings for each of four coffees, plus self-reported expertise. The variables are all rating scales, so extreme outliers aren't present. The more interesting finding is the correlation structure between bitterness and personal preference within coffees.

[![Scatterplot matrix — numeric variables (Python)](ae-09-eda-coffee-py_files/figure-html/num-outliers-output-1.png)](ae-09-eda-coffee-py_files/figure-html/num-outliers-output-1.png)

[![Scatterplot matrix detail (Python)](ae-09-eda-coffee-py_files/figure-html/num-outliers-output-2.png)](ae-09-eda-coffee-py_files/figure-html/num-outliers-output-2.png)

[![Scatterplot matrix — numeric variables (R)](ae-09-eda-coffee-r_files/figure-html/num-outliers-1.png)](ae-09-eda-coffee-r_files/figure-html/num-outliers-1.png)

---

## Connection to Modeling

The missingness patterns here directly shaped the preprocessing recipe in HW-04: `step_unknown()` for categoricals with missing values, `step_impute_median()` for numerics, and `step_other(threshold = 0.005)` to collapse the many sparse "other" category levels.
