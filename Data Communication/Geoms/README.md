# AE-03: Practicing Geoms — Tompkins County Home Sales

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View HTML](ae-03-geoms.html)

---

## The Goal

Same dataset as AE-02 (Tompkins County home sales, 2022–2024), different question: which geom tells the story best? This exercise works through bar charts, boxplots, violin plots, and jitter strips to compare distributions and categorical relationships.

---

## Part 1: Bedrooms Distribution

Bar chart of bedroom counts — straightforward frequency distribution. Then stacked, dodged, and relative frequency versions broken out by construction decade, each revealing something different:

- **Stacked**: Good for total volume by decade
- **Dodged**: Better for comparing bedroom counts within a decade
- **Relative frequency**: Best for seeing proportional shifts — e.g., whether newer homes skew toward more bedrooms

---

## Part 2: Price Distribution by Decade

Four geoms applied to the same question (how do home prices vary by decade built?):

- **Bar chart** (mean price): Simple, but hides distribution shape
- **Boxplot**: Shows median, IQR, and outliers — better for skewed data
- **Violin plot**: Shows full distribution shape — the best option when you have enough data per group
- **Strip/jitter**: Shows individual points — useful for small groups where aggregate summaries can mislead

The key takeaway: there's no universal best geom. The right choice depends on sample size per group, whether you care about outliers, and whether distribution shape matters for the question being asked.
