# HW-02: Grammar of Graphics + Layers

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View PDF](hw-02-layers.pdf)

---

## The Assignment

Five exercises working through the grammar of graphics framework and multi-layer visualizations in ggplot2 — from deconstructing an existing published chart to rebuilding Minard's famous Napoleonic campaign map.

---

## Exercise 1 — Deconstructing a COVID-19 Visualization

A written grammar-of-graphics breakdown of a New York Times visualization showing state-by-state COVID testing and case rates from June–July 2020.

- **Data**: State-level testing and positive case rates, June–July 2020, expressed as percentage changes from baseline
- **Algebra**: Raw daily counts transformed into percentage change; 7-day rolling averages smooth out reporting noise and weekend filing effects — the core statistical transformation
- **Scales**: Each state's small-multiple uses its own y-axis scale. This is the most defensible choice when absolute magnitudes differ enormously across states but the shape of the trend is what matters
- **Statistics**: 7-day moving averages are the primary transformation. Percentage change from baseline recodes raw counts into a comparable unit across states with different population sizes
- **Geometry**: Simple line geometry — cleanest encoding for temporal trend data
- **Facets**: Two-level faceting: states are separated into their own panels, then those panels are grouped by whether testing outpaced cases or vice versa — a facet-within-facet structure that communicates both the individual state story and the aggregate pattern

---

## Exercise 2 — NYC Crash Density by Time of Day

NYC OpenData motor vehicle collision records (`nyc-crashes.csv`), parsed with `mdy_hms(paste(crash_date, crash_time))` and classified by severity (Deadly / Injured / No injuries) and day type (Weekday / Weekend via `wday()`).

The visualization stacks three `geom_density()` layers — one per severity level — with `alpha = 0.5` so distributions show through each other. Custom colors:

```r
severity_colors <- c(
  "Deadly" = "#B19CD9",      # muted purple
  "Injured" = "#86E3EB",     # teal
  "No injuries" = "#FFE5A0"  # soft yellow
)
```

Faceted by `day_type` in two stacked panels. X-axis is a time-of-day scale with `scale_x_time()` and labeled at 00:00, 10:00, and 20:00.

Key patterns: deadly crashes distribute more evenly across the day than injury crashes, which spike sharply during morning and evening commute hours. Weekend panels show the morning commute spike disappearing entirely, with nighttime crashes becoming proportionally larger — consistent with social and recreational traffic patterns.

---

## Exercise 3 — Written Critique

Strengths of the density chart:
- Faceting separates the weekday/weekend comparison cleanly without requiring the reader to mentally overlay two charts
- Overlapping semi-transparent distributions show the true shape of each severity class, which a stacked area chart would obscure
- Subdued color palette avoids visual fatigue

Weaknesses:
- Y-axis scientific notation (`1.5e-05`) is inaccessible — density values require understanding that most readers don't have
- Overlapping transparency makes precise value extraction difficult
- Grid lines are slightly too prominent relative to the data

---

## Exercise 4 — Perfume Ratings Across Three Centuries

A dataset of perfume ratings (0–10) and release years (1700–2020), used to explore eight different smoothing and color encoding choices on the same scatter plot. All plots share `coord_cartesian(xlim = c(1700, 2020), ylim = c(0, 10))` and a consistent `base_theme`.

The eight variations (A–H) systematically test:
- **A**: Raw points, no smoothing — shows the cloud
- **B**: Default `geom_smooth()` (GAM) — shows the global trend
- **C**: LOESS `span = 0.2` with orange confidence band — more local, shows era-specific swings
- **D**: LOESS `span = 0.2` without confidence band — cleaner, same sensitivity
- **E**: Separate LOESS lines per `is_fruity` group, different line types (`solid` vs `dashed`) — shows divergence between fruity and non-fruity fragrances over time
- **F**: `geom_smooth(se = FALSE)` inheriting group colors from `is_fruity` — simpler version of E
- **G**: Points colored by `is_fruity` with a single global LOESS trend in dark blue — best separation of "what's in the data" (points) from "what's the direction" (one line)
- **H**: Points only, colored by `is_fruity`, no smoothing — distribution without trend

Plot G best balances showing the within-group distribution and the overall trend without forcing two crossing regression lines into a single panel.

---

## Exercise 5 — Minard's Napoleon Map Reconstruction

The 1869 Minard map of Napoleon's 1812 Russian campaign — often cited as the best data visualization ever made — combines army movement, troop losses, geography, and temperature into a single figure. The reconstruction uses three data frames: `troops` (positions + survivors + direction), `cities` (coordinates + labels), and `temperatures` (longitude + temperature + date).

**Main map panel (`p1`)**:
- `geom_path()` with `size = survivors` (scaled 0.5–20) and `color = direction` — tan/beige (`"#DBC391"`) for advance, black for retreat — the army literally shrinks as it marches
- `geom_text()` for city labels, offset above or below the troop path depending on direction of travel
- `geom_segment()` extending vertical connectors from the retreat path downward to align with the temperature panel
- `coord_fixed(ratio = 1)` prevents geographic distortion; `theme_void()` removes all non-data ink

**Temperature panel (`p2`)**:
- `geom_line()` and `geom_point()` tracing temperatures from 0°C at Moscow in October to -30°C at Moiodexno in December
- `geom_text()` with `sprintf("%d° %s", temp, date)` at each measurement waypoint
- Temperature aligns horizontally with the retreat path above it — every degree drop corresponds to thousands of soldiers lost

The two panels are combined with `gridExtra::arrangeGrob(heights = c(0.7, 0.3))` with negative padding (`unit(-1, "line")`) to eliminate the gap and make the alignment visible.

---

## GenAI Reflection

Used Claude for guidance on exercises 4 and 5. The main confusion in Exercise 4 was why the same `color` aesthetic behaved differently when set globally in `ggplot()` vs. locally in `geom_smooth()` — Claude's explanation of aesthetic inheritance clarified it. The Minard alignment between panels was also Claude-assisted debugging when the segment connectors weren't lining up.
