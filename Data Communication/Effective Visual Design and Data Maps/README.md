# HW-05: Effective Visual Design + Making Data Maps

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View PDF](hw-05-design-maps.pdf)

---

## The Assignment

Three exercises on visual design principles and spatial data visualization in R, using `tigris`, `sf`, `tidycensus`, and `colorspace`. Packages were loaded and the exercises scaffolded, but this submission was incomplete.

---

## Packages and Context

The setup loaded:
- `tidyverse` — data wrangling and ggplot2
- `tigris` — U.S. census boundary shapefiles (counties, states, tracts)
- `sf` — simple features for spatial data manipulation and projection
- `tidycensus` — Census Bureau ACS data accessed via API
- `colorspace` — perceptually uniform color spaces for choropleth maps
- `ggthemes` — additional ggplot2 themes

These packages cover the core workflow for Census-based choropleth mapping in R: pull boundary data with `tigris`, pull demographic data with `tidycensus`, join them, and map with `geom_sf()`.

---

## What This Course Module Covered

The surrounding course material (AE-17) built choropleth maps of household income by census tract in New York State, progressing from a default continuous scale to `scale_fill_viridis_c()` to county boundary overlays to discrete 6-bin palettes. HW-05 was designed to apply those techniques to a new dataset and design context.

---

## Note

This homework was not completed. The exercises are empty stubs.
