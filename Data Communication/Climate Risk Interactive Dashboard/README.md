# AE-23: Climate Risk Visualization Dashboard

**Course:** INFO 3312/5312 — Data Communication, Spring 2025

---

A full-featured multi-panel Shiny dashboard built on FEMA's National Risk Index, giving users interactive control over how they explore climate vulnerability across all U.S. counties.

## The Design Problem

Climate risk data is rich but hard to navigate raw. The NRI contains county-level scores for 18 hazard types plus composite metrics for overall risk, expected annual loss, social vulnerability, and community resilience. The goal was to make those dimensions queryable without overwhelming the user.

## App Architecture

The dashboard is organized into three panels via `page_fluid()` with a top-level header and a control sidebar:

**Map View** — A choropleth of all U.S. counties shaded by a user-selected risk metric. A `selectInput()` lets users pick from Overall Risk Score, Expected Annual Loss, Social Vulnerability, Community Resilience, Building Value, Population, or Agriculture Value. A `sliderInput()` filters by percentile range (0–100), and `radioButtons()` control the color scheme (blue-to-red, green-to-red, viridis, or terrain). State boundaries toggle on/off via a checkbox.

**Distribution + Top Counties** — Below the map, a `geom_histogram()` shows the distribution of the selected metric across all (filtered) counties, and a `gt` table ranks the top 10 counties by risk level with the highest-ranked row highlighted in light blue.

**Statistics Modal** — An `actionButton()` triggers a `showModal()` displaying mean, median, min, max, standard deviation, and NA count for the currently selected metric and filters.

## Statistical Design Choices

The percentile filter uses `ntile()` to compute ranks dynamically — it recalculates on every state or metric change, so "top 10%" always means the top decile within the current filter scope. The color scale uses `scale_fill_gradient2()` with `midpoint = median(metric)` so the center of the diverging scale tracks the actual data distribution rather than a fixed value.

## Technical Stack

- `sf` for spatial joins; county boundaries from `counties.geojson`, state boundaries from `states.geojson`
- `bslib` with `bs_theme(bootswatch = "flatly", primary = "#2C3E50")` for consistent styling
- `gt::opt_interactive()` for the sortable top-counties table
- `ggthemes::theme_map()` for the base map aesthetic
- `colorspace` for diverging continuous scales
- `janitor::make_clean_names()` for readable column display labels

---

[View the app source →](app.R)
