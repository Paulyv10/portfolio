# HW-01: Make a Model — NYC Squirrel Census

**Course:** INFO 4940/5940 — Applied Machine Learning, Fall 2025
[View PDF](hw-01-make-a-model.pdf) | [View HTML](hw-01-make-a-model.html)

---

## The Question

Can we predict whether a yard will have squirrels based on environmental features like tree coverage, pet ownership, and nearby feeders? Using the NYC Squirrel Census dataset, I built a classification model to find out.

---

## Exploring the Data

The first thing to check: is the outcome balanced? The class distribution came out nearly 50/50 between yards with and without squirrels — good news for modeling.

[![Class distribution in training data](hw-01-make-a-model_files/figure-html/unnamed-chunk-6-1.png)](hw-01-make-a-model_files/figure-html/unnamed-chunk-6-1.png)

Then I went feature by feature to see what actually predicts squirrel presence.

**Cats and dogs:** Both turned out to be essentially useless. Cats showed no difference at all (p = 0.835) — probably because most cats are indoor cats. Dogs had a tiny negative association but nothing meaningful (p = 0.153).

[![Squirrel presence by cat ownership](hw-01-make-a-model_files/figure-html/unnamed-chunk-8-1.png)](hw-01-make-a-model_files/figure-html/unnamed-chunk-8-1.png)

[![Squirrel presence by dog ownership](hw-01-make-a-model_files/figure-html/unnamed-chunk-9-1.png)](hw-01-make-a-model_files/figure-html/unnamed-chunk-9-1.png)

**Nearby feeders:** Here's where it gets interesting. Having feeders nearby shows a clear association with squirrel presence (p < 0.001) — having a feeder increases the odds of squirrels by about 63%.

[![Squirrel presence by nearby feeders](hw-01-make-a-model_files/figure-html/unnamed-chunk-10-1.png)](hw-01-make-a-model_files/figure-html/unnamed-chunk-10-1.png)

**Deciduous tree cover:** Probably the most intuitive finding — more deciduous trees, more squirrels. Strong association (p < 0.001) and each unit of tree coverage increased the odds of squirrels by 12%.

[![Deciduous tree cover by squirrel presence](hw-01-make-a-model_files/figure-html/unnamed-chunk-11-1.png)](hw-01-make-a-model_files/figure-html/unnamed-chunk-11-1.png)

**Housing density:** Nothing particularly noteworthy here. Proximity to other homes isn't a strong standalone signal, though I kept it in case it interacts with other features (like dogs only mattering in dense housing areas).

[![Housing density by squirrel presence](hw-01-make-a-model_files/figure-html/unnamed-chunk-12-1.png)](hw-01-make-a-model_files/figure-html/unnamed-chunk-12-1.png)

---

## Comparing Models

I ran four models through 5×5 stratified cross-validation and compared accuracy and ROC AUC:

| Model | Accuracy | ROC AUC |
|---|---|---|
| Null (baseline) | 50.1% | 0.50 |
| Simple Logistic | ~57% | ~0.61 |
| Decision Tree | ~61% | 0.621 |
| **Random Forest** | **~67%** | **0.732** |

The random forest clearly won — both in accuracy and in its ability to separate squirrel/no-squirrel yards.

---

## Final Evaluation

Fitting the random forest to the full training set and evaluating on the held-out 20% test set:

- **Accuracy:** 65%
- **ROC AUC:** 0.712

The model classifies correctly about 2 out of 3 times. It's meaningfully useful for ranking yards by squirrel likelihood — an AUC > 0.70 is a solid result given how noisy ecological data tends to be. There's clearly still unexplained variance (tricky little squirrels), but the random forest's ability to capture nonlinear interactions between tree cover, feeders, and housing density gave it a real edge over the simpler models.
