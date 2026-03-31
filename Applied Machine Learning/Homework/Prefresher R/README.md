# HW-00: R & Python Prefresher

**Course:** INFO 4940/5940 — Applied Machine Learning, Fall 2025
[View PDF (R)](hw-00-prefresher-r.pdf) | [View PDF (Python)](hw-00-prefresher-py.pdf)

---

## The Goal

Warm-up exercises in both R and Python to shake off the rust before the real modeling work began. Two datasets: public opinion on eating animals, and commissary prices across U.S. states.

---

## Exercise 1: Which Animals Are Morally Acceptable to Eat?

The first dataset came from a YouGov survey asking Americans whether eating different animals is morally acceptable, unacceptable, or they're not sure. After cleaning the percentages and pivoting the data long, I built a stacked bar chart ordered by acceptability — making it easy to read from "most accepted" to "most contested" at a glance.

The result: fish and chicken are at the top with little controversy. Dogs and cats are at the bottom (obviously). The middle tier — pigs, cows, horses — shows genuinely mixed public opinion.

---

## Exercise 2: Ramen Prices by State (Commissary Data)

The second dataset covered prices across prison commissary systems by state. I filtered for ramen/noodle products using regex (word boundaries and brand names — the raw filter wasn't working on its own), computed average prices by state, and plotted the top 10 most expensive states as a horizontal bar chart.

One takeaway: there's meaningful price variation across states for what should be a commodity product, which hints at differences in commissary contracting or regional markups.

---

## Exercise 3: Cheapest Deodorant States

Same commissary dataset, different product — deodorant. Filtered with a simpler regex (just `"deodorant"` matched fine without the word boundary workarounds needed for ramen), computed the cheapest average price by state, and plotted the top 10 cheapest.

---

## Tooling Notes

Both exercises were done in R using `tidyverse`. The Python prefresher covered equivalent operations in pandas and matplotlib. The regex parsing challenge in Exercise 2 was a good early reminder that real data is messier than it looks — and that `str_detect` with a carefully crafted pattern beats `filter(description == "ramen")` every time.
