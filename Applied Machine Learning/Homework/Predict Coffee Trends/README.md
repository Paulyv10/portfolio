# HW-04: Predict Coffee Preferences — Great American Coffee Taste Test

**Course:** INFO 4940/5940 — Applied Machine Learning, Fall 2025
[View PDF](hw-04-predict-coffee.pdf) | [View HTML](hw-04-predict-coffee.html)

---

## The Question

Can we predict whether someone will like Coffee D based on their demographics, general coffee habits, and how they rated Coffees A–C? The data comes from James Hoffmann's Great American Coffee Taste Test — a 2023 YouTube event where viewers ordered four coffees from Cometeer and rated them live.

The outcome: did the respondent rate Coffee D above 3 (liked) or not?

---

## Setting Up the Problem

A few deliberate choices upfront:

- **Binary outcome**: Converting the 1–5 preference rating to liked/not liked simplifies the problem and makes it more actionable — think of it as a recommendation engine for future customers.
- **Variable selection**: Kept only features available *before* tasting Coffee D — demographics, coffee habits, and ratings for Coffees A–C. Excluding Coffee D's own ratings prevents leakage.
- **Class distribution**: ~54.5% liked, ~45.5% didn't — nearly balanced, which is good news for standard accuracy as a metric.

75/25 stratified split, 10-fold cross-validation on the training set.

---

## Three Models, Very Different Results

**Null model:** Predicts the majority class ("liked") for everyone. Accuracy ~54.5%, ROC AUC ~0.5. A true baseline — meaningless on its own, but essential to beat.

**Plain logistic regression:** This one actually *underperformed* the null. Accuracy dropped ~7 points, Brier score got much worse (0.52 vs 0.25 for the null), and the ROC AUC showed the model was inverting the signal. The culprit: overfitting on sparse, high-dimensional categorical survey data without any regularization. A good reminder that adding a model isn't always better than guessing.

There was also a subtle bug worth noting — the first evaluation run showed ROC AUC ≈ 0.202, which looked catastrophic. Turned out the event level was flipped (same mistake as HW-02): the model was ranking *not_liked* as the positive class. One `event_level = "second"` argument fixed it. The underlying model was fine; the metric calculation wasn't.

**LASSO logistic regression (tuned):** This is where it came together. Regularization eliminated noisy predictors and penalized the overfitting that killed the plain logistic model. The improvement was substantial:

| Model | Accuracy | ROC AUC | Brier Score |
|---|---|---|---|
| Null | 0.545 | 0.50 | 0.248 |
| Logistic (plain) | ~0.48 | ~0.49 | 0.52 |
| **LASSO (tuned)** | **0.736** | **0.798** | ~0.20 |

---

## Final Evaluation

Fitting the best LASSO to the full training set and evaluating on the held-out 25% test:

- **Accuracy:** 73.6%
- **ROC AUC:** 0.798
- **Brier Score:** ~0.20

The model correctly classifies nearly 3 out of 4 respondents. More importantly, an AUC of ~0.80 shows it has real discriminative power — not just following the majority class. For a survey-based preference prediction with all the noise inherent in self-reported taste data, that's a solid result.

---

## Takeaway

The story of this assignment is really the story of regularization. Plain logistic regression on high-dimensional, sparse survey data is a trap — it fits the training noise hard. LASSO's job is to burn away the noise and keep only the predictors doing real work. The jump from ~0.49 to ~0.80 AUC is a vivid illustration of why penalized regression exists.
