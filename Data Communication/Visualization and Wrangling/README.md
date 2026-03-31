# HW-03: Visualization + Wrangling

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View PDF](hw-03-wrangle.pdf)

---

## The Assignment

Five exercises in data wrangling and visualization — congressional polarization, ideology measurement, disease geography, and federal judicial appointments. The centerpiece is working with multiple joined datasets and building charts that communicate political and institutional patterns clearly.

---

## Exercise 1 — Congressional Polarization Since 1945

Using the Voteview NOMINATE dataset (`HSall_members.csv`), which assigns every member of Congress a 1D ideology score from -1 (most liberal) to +1 (most conservative) based on their voting record.

The analysis filters to the 79th Congress onward (1945+) and to House and Senate only. Congress numbers are converted to year labels with:

```r
mutate(
  start_year = 1789 + (congress - 1) * 2,
  congress_label = paste0(start_year, "-", end_year)
)
```

A ridgeline chart (`geom_density_ridges()`) stacks one distribution per Congress on the y-axis, ordered chronologically, faceted into separate panels for House and Senate. The y-axis only labels the first and last Congress to avoid overplotting:

```r
scale_y_discrete(breaks = function(x) c(x[1], x[length(x)]))
```

The result makes polarization visible as a physical shape change: early Congresses show one broad, overlapping distribution; modern ones show two sharp, separated peaks. The House polarized earlier and more severely than the Senate.

---

## Exercise 2 — NOMINATE vs. CFScore: Two Ways to Measure Ideology

A join between the NOMINATE dataset and the DIME campaign finance dataset, which assigns ideology scores based on *who politicians accept donations from* rather than how they vote.

The join key required careful handling — DIME ICPSR codes have a 4-digit suffix appended to the base ICPSR identifier used by NOMINATE:

```r
dime_prepared <- dime_data |>
  mutate(icpsr_base = as.numeric(substr(icpsr, 1, nchar(icpsr) - 4)))
combined_data <- inner_join(nominate_filtered, dime_prepared, by = c("icpsr" = "icpsr_base"))
```

The scatter plot maps `nominate_dim1` (voting-based) on the x-axis against `recipient.cfscore` (donation-based) on the y-axis, colored purple for Democrats and orange for Republicans, faceted by Congress from the 100th onward. A dashed OLS line shows the correlation within each Congress.

The key finding: voting ideology and fundraising ideology are strongly correlated, but the correlation has strengthened over time. In earlier Congresses there's more scatter — moderate Republicans could raise money from liberal donors and vice versa. In recent Congresses the relationship is nearly linear, especially for Republicans, suggesting the donor networks and voting records have converged.

---

## Exercise 3 — Lyme Disease Geography: Pie Chart vs. Bar Chart

A hardcoded dataset of 2018 CDC Lyme disease cases for the 15 most-affected states plus a catch-all "Remaining States + DC" category (33,666 total U.S. cases).

The exercise builds both a pie chart and a bar chart from the same data, then compares them:

**Pie chart**: `geom_bar(stat = "identity") + coord_polar("y")` with 16-color fill legend. Pennsylvania at 30.3% occupies nearly a third of the wheel. New Jersey (11.9%) and New York (10.8%) are visible but difficult to compare precisely.

**Bar chart**: Same data, `geom_bar(stat = "identity")` with states on the x-axis, angled labels at 45°. New York highlighted in `"darkred"` vs. `"gray"` for all other states via `aes(fill = state == "New York")`. Direct `geom_text()` labels show exact percentages above each bar.

The bar chart wins decisively for comparison tasks — Pennsylvania's 30.3% vs. New Jersey's 11.9% is immediately readable. The pie chart is appropriate only for emphasizing Pennsylvania's dominant share as a single takeaway.

---

## Exercise 4 — Federal Judges and the Ivy League, by President

The Federal Judicial Center dataset, with two tables joined: `education` (judge + school attended) and `service_fjs` (judge + court + appointing president + party).

The `ivy_league` vector covers 30+ institution name variants — schools that changed names, law schools as separate entries from parent universities, and historical names:

```r
ivy_league <- c(
  "Harvard Law School", "Harvard University", "Harvard College",
  "Yale Law School", "Yale University", "Yale College",
  "Columbia University", "Columbia Law School", "King's College (now Columbia University)",
  "Cornell University", "Cornell Law School",
  # ... 25 more entries
)
```

After flagging each judge with `any(school %in% ivy_league)`, the tables are joined and filtered to District and Appeals courts, post-1945, Democratic and Republican appointing presidents only. Presidents are ordered chronologically by their average commission date.

The bar chart shows the proportion of Ivy League appointments per president, colored by party (blue = Democrat, red = Republican), faceted by court type. FDR is excluded because his commission dates span the filter boundary. The pattern: Ivy representation is high across both parties but varies by president, with no clean partisan split.

---

## Exercise 5 — Regional Ivy League Representation Over Time

An extension of Exercise 4 adding two dimensions: geography (5 regions derived from circuit assignments) and time (20-year periods from 1940 onward).

Circuit-to-region mapping via `case_when()`:
```r
region = case_when(
  circuit %in% c("1st Circuit", "2nd Circuit") ~ "Northeast",
  circuit %in% c("3rd Circuit", "D.C. Circuit") ~ "Mid-Atlantic",
  circuit %in% c("4th Circuit", "5th Circuit", "11th Circuit") ~ "South",
  circuit %in% c("6th Circuit", "7th Circuit", "8th Circuit") ~ "Midwest",
  circuit %in% c("9th Circuit", "10th Circuit") ~ "West",
  ...
)
```

**Cross-sectional view**: Dodged bar chart by region, with bars split by court type (District vs. Appeals). The Northeast consistently shows the highest Ivy representation; the South the lowest.

**Time series view**: Line chart tracking regional Ivy representation across four 20-year intervals. The Northeast has been high throughout but has not grown monotonically — Mid-Atlantic and West courts show increasing Ivy representation post-1980, while the South remains persistently below average.

---

## GenAI Reflection

Used Claude for guidance on Exercise 5's structure — specifically for thinking through the regional groupings and the time-period binning logic. The key question was whether to use 20-year intervals or decade intervals; Claude's suggestion to use 20-year periods was about having enough appointments per cell for the proportions to be stable.
