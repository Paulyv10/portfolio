# Project 1 — Olympic Participation: Global North vs. South

**Course:** INFO 3312/5312 — Data Communication, Spring 2025
**Team:** Giving-Clapback — Israel Davidson, Emma Chase, Paul Vermette, Catherine Liu

---

The Olympics is the world's largest athletic stage — but who gets to be on it? This project uses 120 years of Olympic history (Athens 1896 through Rio 2016) to examine whether the Games have ever truly been global, and what physical attributes actually predict a medal in contact sports.

## Question 1: Global North vs. Global South Participation Over Time

Country classification drew on the Worldwide Bureaucracy Indicator (WWBI) region column, with manual corrections for countries no longer in existence: the Soviet Union was remapped to Russia (`URS → RUS`), Czechoslovakia to Czech Republic, Yugoslavia to Serbia, and West Germany to Germany. NORRAG's Global South definition served as a second check for edge cases in the "Europe and Central Asia" WWBI region.

**Line chart:** Raw athlete counts for Global North and Global South competitors, faceted by Summer and Winter games. The raw scale matters here — the Winter Games have always had far fewer total athletes. Using `geom_point()` on top of `geom_line()` marks each quadrennial event clearly.

The Global South has grown substantially in absolute numbers through the Summer Games — but the Winter Games tell a starker story. Arctic sports, expensive equipment, and limited training infrastructure mean the Winter field remains heavily Northern.

**Proportional bar chart:** By plotting share rather than counts, the seasonal comparison becomes clean. The Summer Games have converged toward a ~40% Global South share over the past 40 years. The Winter Games have barely moved. Color choices (green/yellow for Summer, two blues for Winter) were verified against colorblindness simulators — high value contrast makes them readable for all viewers.

## Question 2: Does Height and Weight Predict Medals in Contact Sports?

The second question narrows to contact sports and asks whether physical size — height and weight — correlates with podium outcomes, and whether those relationships differ by sex.

Contact sports were filtered from the events column. Logistic regression framing (medal vs. no medal) informed the visualization choices: rather than scatterplots (which overplot badly at this scale), the team used density overlays and violin plots to show the full shape of the medalists vs. non-medalists distributions.

Height showed a modest positive association with medals across contact sports, stronger for men than women. Weight effects were more event-specific — wrestling and judo weight classes mean the relationship is non-linear within those sports but meaningful between them.

---

[Read the full analysis →](docs/index.html)
