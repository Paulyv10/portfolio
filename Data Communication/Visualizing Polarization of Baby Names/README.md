# AE-18: Visualizing Polarization of Baby Names

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View HTML](ae-18-partisan-names.html)

---

## The Dataset

SSA baby name data (1983–2023) matched to 2024 presidential election results by state — red states (Trump) vs. blue states (Harris). Each name gets a partisanship score based on whether it's more common in red or blue states.

---

## The Visualization

An animated beeswarm chart showing the distribution of name partisanship over time, using `gganimate` to transition across decades:

- **X-axis**: Partisanship score (red end = more common in Trump states; blue end = more common in Harris states)
- **Color**: Red for names associated with Trump states, blue for Harris states
- **`geom_quasirandom()`**: Prevents point overlap while maintaining the distribution shape — cleaner than pure jitter

Animation via `transition_states()` across decades, with `ease_aes("sine-in-out")` for smooth transitions.

---

## What It Shows

Baby name choices have become more geographically polarized over time. Names that were evenly distributed across states in the 1980s now cluster more strongly by political geography. This mirrors broader cultural sorting — red and blue America are increasingly choosing different names for their children, not just different politicians.

The beeswarm animation format works here because the story is about distributional change over time — you want to see the whole spread shift, not just a summary statistic. A static line chart of the mean would miss the widening of the distribution.

---

## Animation as a Tool

This exercise argues for animation when:
1. The temporal change is continuous and smooth (not a discrete before/after)
2. The distribution shape matters, not just the average
3. The audience has the patience to watch a few seconds of transition

It argues against animation when the key comparison is between two specific moments — a static small-multiples panel would often serve better for side-by-side comparison.
