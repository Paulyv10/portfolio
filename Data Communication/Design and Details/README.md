# HW-04: Design + Details

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
[View PDF](hw-04-design.pdf)

---

## The Assignment

Four exercises on visual design principles — intentionally bad charts, deliberate redesigns, label collision solutions, and a complex timeline visualization of EGOT winners. The course framed this as: you have to understand how to break the rules to understand what the rules are doing.

---

## Exercise 1 — The Deliberately Bad Penguin Plot

The assignment asked for a chart that violated as many design principles as possible while still being technically correct. Using Palmer Station penguin data:

```r
p + theme(
  panel.background = element_rect(fill = "pink"),
  plot.background = element_rect(fill = "yellow"),
  panel.grid.major = element_line(color = "red", size = 2),
  panel.grid.minor = element_line(color = "blue", size = 1),
  axis.title.x = element_text(size = 20, family = "Comic Sans MS", color = "green"),
  axis.title.y = element_text(size = 20, family = "Papyrus", color = "purple"),
  plot.title = element_text(size = 30, family = "Impact", color = "orange"),
  plot.subtitle = element_text(size = 25, family = "Courier", color = "brown")
)
```

Every design failure here is intentional and instructive: the pink/yellow background contrast competes with the data; red and blue gridlines draw more attention than the points; Comic Sans, Papyrus, Impact, and Courier are four different font personalities fighting for attention; the oversize title at 30pt dwarfs the axis labels at 20pt.

---

## Exercise 2 — The Elegant Redesign

The same flipper length vs. body mass scatter plot, rebuilt with a `custom elegant_theme`:

- Font: `"Roboto"` throughout, `color = "#2b2b2b"` (dark charcoal, not pure black)
- Grid: major lines at `"#e0e0e0"` weight 0.2; minor lines removed entirely
- Axis ticks and lines in `"#757575"` at size 0.3 — present but unobtrusive
- Legend: white background with no border, right-positioned, smaller text

Species colors: `c("Adelie" = "#1b9e77", "Chinstrap" = "#d95f02", "Gentoo" = "#7570b3")` — ColorBrewer Dark2, perceptually distinct and colorblind-safe.

`geom_smooth(method = "lm", se = TRUE, alpha = 0.2)` adds confidence bands rather than just lines, acknowledging uncertainty. Two direct `annotate("text")` calls replace a legend entry for the key pattern:

> *"Gentoo penguins tend to be larger with longer flippers"* — annotated at the Gentoo cluster
> *"Positive correlation between flipper length and body mass across all species"* — annotated in the upper-left white space

Alt text was written explicitly as a required deliverable: describing the axes, species clusters, flipper length ranges (170–230mm), body mass ranges (3000–6000g), and the positive correlation pattern within and across species.

---

## Exercise 3 — Fixing Overlapping Labels: Four Solutions

A Lord of the Rings word count dataset — total words spoken by each Fellowship member across the trilogy. The problem: nine character names on a horizontal x-axis overlap badly.

**Solution 1 — Rotate 45°**
`theme(axis.text.x = element_text(angle = 45, hjust = 1))`. Quick and standard, but rotated text is harder to read than horizontal and doesn't fix the fundamental spacing problem.

**Solution 2 — Abbreviate Names**
`case_when(Character == "Gandalf" ~ "Gan", Character == "Aragorn" ~ "Ara", ...)`. Maintains horizontal text but forces readers to learn a lookup table — adds cognitive load without eliminating it.

**Solution 3 — Flip Coordinates**
`coord_flip()`. Horizontal bars with horizontal labels. The best solution: labels have unlimited horizontal space, the most important comparison (word count magnitude) maps to horizontal position, and no information is lost.

**Solution 4 — Facet by Race**
`facet_grid(. ~ Race, scales = "free_x")`. Splits Hobbits, Men, Wizard, Dwarf, and Elf into separate panels, giving each fewer labels per facet. Best if the comparison *within race* matters most, but weakens direct cross-character comparison.

The written critique for each solution evaluates advantages and disadvantages — Solution 3 (flip) is the cleanest general-purpose fix.

---

## Exercise 4 — EGOT Timeline

21 people have won an Emmy, Grammy, Oscar, and Tony award. The visualization tracks each winner's path to the EGOT using a connected dot timeline.

**Data structure**: One row per person, four year columns (emmy_year, grammy_year, oscar_year, tony_year). Pivoted to long format with `pivot_longer(cols = ends_with("_year"))` to get one row per award per person.

**Within-year jitter**: Awards in the same year are offset by fractions of a year to prevent overplotting:
```r
award_offset <- function(award, year) {
  offset <- case_when(
    award == "Emmy" ~ 9/12,
    award == "Grammy" ~ 1/12,
    award == "Oscar" ~ 2/12,
    award == "Tony" ~ 6/12
  )
  year + offset
}
```

**Visual encoding**:
- `geom_segment()` from `first_year` to `last_year` in gray — the span of each person's EGOT journey
- Colored dots for each award (Dark 2 palette via `qualitative_hcl(4, palette = "Dark 2")`)
- The final award for each person gets `shape = 21` with a black stroke border — distinguishing "completion" from intermediate milestones

**ggtext subtitle**: The award names in the subtitle are colored to match their dot colors using inline HTML spans:
```r
paste0(
  "Only 21 people have earned an ",
  "<span style='color:", award_colors["Emmy"], ";'>Emmy</span>, ..."
)
```
With `plot.subtitle = element_markdown()` rendering the HTML.

Richard Rodgers has the longest span in the dataset (1945 Oscar to 1962 Emmy — 17 years). Robert Lopez is the fastest modern EGOT (Tony 2004, Grammy 2012, Oscar 2014, Emmy 2008 — all within a decade).

---

## GenAI Reflection

Used Claude to explain aspects of the EGOT code when I didn't remember specific use cases — particularly `rowwise()` for computing per-person min/max across columns, and `left_join()` logic for attaching the "last award" flag. The ggtext HTML subtitle syntax was also Claude-explained.
