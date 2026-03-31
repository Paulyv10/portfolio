# AE-06: Take a Sad Plot and Make It Better — AAUP Faculty Employment

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View HTML](ae-06-sad-plot.html)

---

## The Dataset

AAUP instructional staff employment trends, 1975–2011. Tracks the share of faculty employed in different categories: tenured, tenure-track, non-tenure-track full-time, part-time, and graduate students.

---

## The Transformation

The starting point was a wide-format dataset with one column per faculty type — difficult to plot directly. The first step was `pivot_longer()` to reshape it into a long format with one row per year per faculty type.

From there, a progression of chart attempts:

**Bar chart (initial)**: Stacked by year — shows total headcount but makes category comparisons nearly impossible.

**Relative frequency bar**: Converts to proportions so all years sum to 100% — now comparable across time, but still hard to track individual categories.

**Line chart (final)**: One line per faculty type over time. Categories ordered by their final-year percentage so the legend matches the visual order of the lines. Viridis plasma palette — perceptually uniform, colorblind-accessible.

---

## What the Data Shows

Part-time faculty and graduate student employment have grown substantially since 1975. The share of full-time tenured faculty has declined. This trend — the casualization of academic labor — is one of the most discussed structural shifts in US higher education, and it's visible clearly in a well-constructed line chart.

The "sad plot" version buried this story in stacked bars. The fixed version puts it front and center.

[![Faculty employment trends 1975–2011](images/staff-employment.png)](images/staff-employment.png)
