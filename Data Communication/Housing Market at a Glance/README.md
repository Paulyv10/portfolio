# AE-21: Housing Market at a Glance

**Course:** INFO 3312/5312 — Data Communication, Spring 2025

---

A Quarto dashboard that puts the U.S. housing market crisis in context — mortgage rates, price-to-income ratios, and origination patterns by state, all in one place.

## The Story in the Data

Three datasets tell three parts of the same story:

**Weekly mortgage rates** (NAHB, 15- and 30-year fixed) show the dramatic spike starting in 2022 — from historic lows near 3% to peaks above 7%. The line chart uses `scale_y_continuous(labels = label_percent())` and encodes both loan terms in `scale_color_viridis_d()`, reversed so the 30-year (higher rate) maps to the darker color.

**Price-to-income ratio** (FRED) tracks median home sale price against median household income since the 1980s. A `geom_ribbon()` shades the gap between the two lines — the widening gulf is the clearest visual signal in the dashboard. By the latest observation the gap has never been larger: median home prices have climbed far beyond what median incomes can support.

**Mortgage origination by state** captures mortgages originated per 1,000 residents across all 50 states. Two visualizations serve different questions:
- A `geofacet` small-multiple line chart (one panel per state, 2000–present) reveals geographic patterns — Nevada and Florida show boom/bust cycles while Midwestern states stay flat
- A `plotly` animated choropleth lets users scrub through years interactively, watching origination intensity shift across the country in real time

## Dashboard Layout

Built with Quarto's `format: dashboard` using the `litera` Bootswatch theme with custom SCSS. Three columns:

- **Stats (20%):** Three value boxes — current 30-year rate, current 15-year rate, national median home price — all computed dynamically with `slice_tail()` and `label_percent()` / `label_dollar(scale_cut = cut_short_scale())` so values update with the data
- **Center:** The `geofacet` origination chart (height 50%) and an interactive `gt` table of weekly mortgage rates with `opt_interactive(use_search = TRUE, pagination_type = "jump")` stacked below
- **Right:** The interest rate line chart and the price-to-income ribbon chart stacked vertically

## Key Design Decision

Showing the price-to-income gap as a `geom_ribbon()` rather than two separate lines makes the affordability crisis immediately legible. A viewer doesn't need to mentally compute the difference — the shaded area does it for them.

---

[View the full dashboard →](docs/index.html)
