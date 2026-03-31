# HW-06: Using Interactivity for Data Communication

**Course:** INFO 3312/5312 — Data Communication, Spring 2025

---

## The Assignment

Three exercises building interactive and animated data communication outputs in Quarto: an animated chart, a scrollytelling article, and a data dashboard. Each was a separate `.qmd` file rendered to HTML.

---

## Exercise 1 — Animated Chart (`animate.qmd`)

An `html`-format Quarto document intended for `gganimate` or similar animation output. The course context (AE-18) covered `gganimate::transition_states()`, `ease_aes("sine-in-out")`, and distributional animations with `geom_quasirandom()` — the tools this exercise would have applied to a new dataset.

---

## Exercise 2 — Scrollytelling Article (`scrollytell.qmd`)

A `closeread-html`-format Quarto document — the Closeread extension for Quarto enables scroll-driven narratives where visualizations update as the reader scrolls through text. The format is designed for long-form data journalism: a reader progresses through a written argument while charts respond to their position.

---

## Exercise 3 — Dashboard (`dashboard.qmd`)

A `dashboard`-format Quarto document using Quarto's built-in dashboard layout system. Dashboards in Quarto use column/row layout syntax with cards containing plots, tables, or text, without requiring Shiny or a server.

---

## Deployment

The completed exercises were intended to be deployed to Cornell's GitHub Pages infrastructure at `pages.github.coecis.cornell.edu/info3312-sp25/`, with each component linked from the main `hw-06-interaction.qmd` submission document via dynamically generated URLs using `stringr::str_glue()`.

---

## Note

This homework was not completed. The three component files (`animate.qmd`, `scrollytell.qmd`, `dashboard.qmd`) are empty stubs beyond the YAML headers.
