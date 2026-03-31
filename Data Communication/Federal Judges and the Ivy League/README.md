# AE-07: Federal Judges and the Ivy League

**Course:** INFO 3312/5312 — Data Communication, Spring 2025

---

## The Dataset

Federal Judicial Center relational data — demographics, education, service records, and appointments for federal judges appointed after 1945. Multiple tables joined to connect judge biographies with their educational backgrounds and appointing presidents.

---

## The Question

What proportion of federal judicial appointments went to Ivy League graduates, broken down by president and court type?

---

## The Approach

1. Filtered to District Courts and Courts of Appeals (the two busiest federal court tiers)
2. Identified Ivy League graduates by matching school names against the eight Ivy institutions
3. Computed the proportion of Ivy League appointments for each president
4. Ordered presidents chronologically by their average commission date
5. Faceted by court type, horizontal bar orientation

---

## What It Shows

There's a clear ideological pattern in Ivy League representation — Democratic and Republican presidents show meaningfully different appointment patterns. The Ivy League's share of federal judicial appointments has been neither uniform across administrations nor steadily trending in one direction.

Horizontal bars work better here than vertical: president names are long, and the horizontal axis gives more room to read them without rotation.

---

## Implementation Notes

This exercise involved non-trivial data wrangling — joining multiple relational tables from the FJC, handling inconsistent school name spellings, and deciding how to handle judges with multiple educational records. The data work was as important as the visualization work.
