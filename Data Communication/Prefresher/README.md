# HW-01: Prefresher — Data Communication

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View PDF](hw-01-prefresher.pdf)

---

## The Assignment

Six exercises in R covering Google Sheets integration, messy date parsing, factor manipulation, stacked bar charts, grouped summaries, and counting with `distinct()`. Datasets include romance novel cover art trends, YouGov attitudes toward eating animals, and U.S. prison commissary prices.

---

## Exercise 1 — Romance Novel Cover Trends (2010–Present)

The data lived in a class-maintained Google Sheet, pulled with `googlesheets4::read_sheet()` after `gs4_auth()`. After `janitor::clean_names()` normalized the column names, the date field needed serious repair — it mixed `mdy`, `ymd`, and `dmy` formats with stray characters and whitespace. A three-pass parsing pipeline handled it:

```r
mutate(
  date = str_trim(date),
  date = str_remove_all(date, "[^0-9/-]"),
  date = if_else(str_detect(date, "/"),
    suppressWarnings(as.character(mdy(date))),
    suppressWarnings(as.character(ymd(date)))
  ),
  date = if_else(is.na(date),
    suppressWarnings(as.character(dmy(date))),
    date
  )
)
```

With clean dates, the analysis computed three annual percentages from 2010 onward:
- **Raunchiness**: `mean(man_partially_unclothed == TRUE | woman_partially_unclothed == TRUE)` — any cover featuring a partially unclothed person
- **Illustrated style**: `mean(style == "Illustrated")` — drawn rather than photographic
- **Racial diversity**: `mean(has_poc == TRUE)` — presence of a person of color

After `pivot_longer()` to stack the three metrics into one column, `facet_wrap(~ category)` splits them into side-by-side panels. The y-axis uses `percent_format(scale = 1)` and the x-axis is anchored at 2010 with `limits = c(2010, max(...))`.

---

## Exercise 3 — Attitudes Toward Eating Animals

The YouGov eating animals survey revisited, this time from a CSV. The ordering approach was more direct: `fct_reorder(Animal, Acceptable_num)` inside the `mutate()` rather than computing a separate vector. The harder part was getting the legend order right — ggplot2 reads legend ordering from factor levels, not from `fill` mapping, which required:

```r
fct_rev(factor(response, levels = c("Acceptable", "Not sure", "Unacceptable"), ordered = TRUE))
```

This makes "Acceptable" appear first in the legend even though bars stack left-to-right as Unacceptable → Not sure → Acceptable. Manual colors: `"#90EE90"` (light green) for Acceptable, `"#87CEEB"` (sky blue) for Not sure, `"#9370DB"` (medium purple) for Unacceptable.

---

## Exercise 4 — Top 10 States for Ramen Prices

Commissary filter via `str_detect(tolower(product_type), "ramen")` — simpler than the HW-00 regex because this dataset's product type column was more consistent. Price cleaned with `str_remove(price, "\\$")` (double-escaped: `$` is a special character in R regex), then `as.numeric()`. Top 10 by `desc(avg_price)` via `slice_head(n = 10)`.

---

## Exercise 5 — Cheapest Deodorant by State

Same commissary data, filter on `product_type` for deodorant, then `min_price` per state (not average — looking for the floor price available in each state, not the typical price). `slice_head(n = 10)` after `arrange(min_price)` pulls the 10 cheapest.

---

## Exercise 6 — Lady Speed Stick State Count

A counting question with no visualization: how many distinct states sell Lady Speed Stick products?

```r
commissary_data |>
  filter(str_detect(tolower(description), "lady speed stick")) |>
  distinct(state) |>
  nrow()
```

The exercise practices piping and `distinct()` in a minimal but concrete context.

---

## GenAI Reflection

Used Claude to understand why the legend showed the wrong order. Visualizations in R are an area where small details (like factor level ordering affecting the legend rather than the bars) aren't obvious from documentation alone. The bigger takeaway: ggplot2's behavior with ordered factors in legends is distinct from its behavior with ordered factors on axes — they're controlled differently and worth understanding explicitly rather than guessing.
