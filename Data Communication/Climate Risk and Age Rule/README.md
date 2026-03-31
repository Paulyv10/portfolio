# AE-22: Building Interactive Shiny Apps

**Course:** INFO 3312/5312 — Data Communication, Spring 2025

---

Two independent Shiny apps built in the same exercise — one playful, one policy-relevant — both sharing the same design principle: let users drive the data.

## App 1: The Half-Plus-Seven Rule

The "half your age plus seven" rule is a social heuristic for acceptable dating age ranges. This app makes it interactive: enter your age and a partner's age, and the app instantly calculates whether the pairing falls inside or outside the zone of permissibility.

**How it works:**
- Minimum date-able age: `(your age / 2) + 7`
- Maximum date-able age: `2 × (your age − 7)`
- A ribbon plot shades the acceptable zone; a blue dot marks the specific pair
- A dynamic value box renders green ("Yes, this is permissible") or red ("No, you are too old/young") based on live input
- Built with `bslib::page_sidebar()` and `bs_theme(bootswatch = "flatly")`

The visualization zooms dynamically to keep the plotted point centered — so the range adjusts as you change ages rather than showing the full 14–123 scale every time.

## App 2: National Climate Risk Index

The second app is a full multi-tab dashboard visualizing FEMA's National Risk Index across all U.S. counties.

**Tab 1 — National Risk Map:** A choropleth of all ~3,000 counties shaded by a user-selected risk metric (Overall Risk Score, Expected Annual Loss, Social Vulnerability, or Community Resilience). State boundaries are drawn in white over the county layer to aid geographic orientation.

**Tab 2 — County Details:** Select any county from a searchable dropdown and the app renders:
- A state-level map highlighting the selected county in orange
- A lollipop chart of that county's percentile scores across 18 individual hazard types (earthquake, hurricane, tornado, wildfire, etc.), colored on a diverging scale around the 50th percentile
- Four value boxes displaying the county's composite risk score, expected annual loss in dollars, social vulnerability score, and community resilience score

**Tab 3 — Data:** The full NRI dataset as an interactive `gt` table with sortable columns.

**Technical highlights:**
- Spatial join between `counties.geojson` and the NRI `.rds` file via `GEOID == state_county_fips_code`
- `colorspace::scale_fill_discrete_diverging()` for the national map; `scale_color_continuous_diverging(mid = 50)` for the hazard lollipops
- `bslib::value_box()` with `bsicons` icons for the county summary panel
- Reactive expressions separate data filtering from rendering for clean server logic

---

[View the full writeup →](ae-22.html)
