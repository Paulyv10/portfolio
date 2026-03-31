# AE-17: Visualizing Household Income in New York

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View HTML](ae-17-ny-income.html)

---

## The Dataset

Median household income by census tract in New York State (2023), joined with county boundary GeoJSON for geographic context. Spatial data processed with `sf`, projected using EPSG:2261 (NY State Plane — optimized for New York).

---

## The Progression

A step-by-step refinement of a choropleth map:

**Basic choropleth**: Default continuous color scale. Works, but the default palette doesn't communicate well — low and high values blend together.

**Viridis choropleth**: `scale_fill_viridis_c()` improves perceptual uniformity and colorblind accessibility. The gradient from dark purple to yellow is easier to read.

**With county borders**: Adding county boundaries as a separate `geom_sf()` layer gives geographic context. Readers can orient themselves by county without the tract-level detail becoming overwhelming.

**Discrete palette (6 levels)**: Cutting income into discrete bins (`cut_interval()` or `cut_number()`) and using a qualitative palette makes the class boundaries explicit. More opinionated than a continuous scale, but often more readable for a general audience.

---

## Key Patterns

The income geography of New York State follows familiar patterns: high-income suburban counties around NYC (Westchester, Nassau, Putnam), the wealthy suburbs of Long Island, and lower-income rural areas in the North Country and Southern Tier. NYC itself shows intense within-borough variation at the tract level — wealthy Manhattan tracts immediately adjacent to low-income tracts a few blocks away.

---

## Projection Matters

Using EPSG:2261 (NY State Plane East) rather than WGS84 reduces distortion for a New York-focused map. The state looks right — Long Island doesn't appear squeezed, and upstate geography is proportionally accurate.
