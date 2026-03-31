# HW-00: Prefresher — R & Python

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View PDF (R)](hw-00-prefresher-r.pdf) | [View PDF (Python)](hw-00-prefresher-py.pdf)

---

## The Assignment

A three-exercise warm-up in both R and Python covering data cleaning, filtering, aggregation, and visualization. All three exercises use real-world datasets: a YouGov survey on eating animals and a commissary pricing dataset from U.S. state prison systems.

---

## Exercise 1 — Attitudes Toward Eating Animals

The YouGov survey asked respondents whether it was morally acceptable, unacceptable, or unsure to eat each of several animals. The raw data came in as percentage strings ("72%") rather than numbers — requiring `str_remove(.x, "%")` across the three response columns before any math was possible.

Key wrangling steps:
- `mutate(across(c(Acceptable, Unacceptable, "Not sure"), ~ as.numeric(str_remove(.x, "%"))))` to convert all three columns at once
- `pivot_longer()` to reshape from wide (one column per response type) to long (one row per animal-response pair)
- A separate `arrange(Acceptable)` pass to derive the correct factor level ordering so the bar chart reads meaningfully from least to most acceptable animal

The final stacked bar chart uses `scale_fill_viridis_d()` with `coord_flip()`, ordered so "chicken" and "fish" appear at the top (most accepted) and "dog" and "cat" at the bottom (least accepted). Ordering by acceptability makes the gradient informative — you're reading a ranking, not an alphabet.

---

## Exercise 2 — Ramen Prices by State

The commissary dataset covers prison store prices across all U.S. states. Filtering for ramen was harder than expected — product descriptions, types, and categories encode ramen differently across facilities. A multi-column `if_any()` with regex solved it:

```r
str_detect(.x, regex("\\bramen\\b|\\bnoodles?\\b|top ramen|maruchan|cup noodles?", ignore_case = TRUE))
```

After filtering, the pipeline groups by state, computes `mean(price, na.rm = TRUE)`, and uses `slice_max(order_by = avg_price, n = 10)` to pull the 10 most expensive states. The resulting horizontal bar chart ranks states by average ramen price.

---

## Exercise 3 — Cheapest Deodorant by State

Same commissary dataset, simpler filter — `str_detect(description, regex("deodorant", ignore_case = TRUE))` was enough since "deodorant" appears consistently in the description field. After `parse_number(price)`, the pipeline groups by state, takes the average price, sorts ascending, and `slice_min()` pulls the 10 cheapest.

---

## What the Data Shows

Prison commissary prices vary meaningfully by state, even for commodity items like ramen. The ramen results revealed a multi-dollar spread between the cheapest and most expensive states — a significant difference for people with limited commissary budgets. The deodorant analysis showed similar geographic dispersion without an obvious explanatory pattern.

---

## GenAI Reflection

Used ChatGPT to debug the ramen filter — a plain `filter(str_detect(product_type, "ramen"))` returned fewer than 10 results because ramen appears under multiple field names across different state systems. The regex workaround was ChatGPT's suggestion. The deodorant filter worked fine with a single column check, which made the asymmetry obvious in hindsight.
