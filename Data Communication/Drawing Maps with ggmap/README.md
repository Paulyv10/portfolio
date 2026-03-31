# AE-16: Drawing Maps with ggmap — NYC Food Poisoning Complaints

**Course:** INFO 3312/5312 — Data Communication, Spring 2025

---

## The Dataset

NYC 311 service requests filtered to food poisoning complaints at restaurants, 2010 onward. Focused on March–May for years 2018–2023 to isolate a consistent seasonal window.

---

## The Approach

This exercise compared map vs. non-map visualizations for the same question: where and when do food poisoning complaints cluster in NYC?

**Map approaches:**
- Point maps overlaid on Stadia Maps tiles (`get_stadiamap()` with bounding boxes)
- Faceted by year to show temporal change
- Density heatmap overlaid on base tiles

**Non-map alternatives:**
- Dodged bar charts by borough
- Line charts of complaint counts over time

---

## COVID-19 as a Natural Experiment

The most striking pattern in the data: a dramatic drop in food poisoning complaints in 2020–2021. Restaurant closures and reduced foot traffic during the pandemic created a natural experiment in the data — fewer people eating out meant fewer complaints. Complaints rebounded in 2022–2023 as restaurants reopened.

This pattern is much cleaner in a line chart than a map — the temporal signal doesn't have a strong geographic component.

---

## Maps vs. Non-Maps

The key lesson: maps are good for geographic distribution questions ("where are complaints concentrated?"). They're not always better than a bar chart or line chart for temporal questions ("how have complaints changed over time?"). Choosing the right format requires knowing what question you're actually trying to answer.
