# proj-01

# Olympic Analysis

## Project Overview

This repository contains an analysis of Olympic participation patterns and the physical attributes of medal winners. The project is developed using R and Quarto, focusing on two main research questions:

1. How does Global South participation in the Olympics compare to the Global North, and how does participation change during the Summer versus Winter games?
2. How do height and weight influence the likelihood of winning an Olympic medal in contact sports, and do these factors differ between male and female athletes?

## Repository Structure

- `/data/`: Contains the Olympic athletes dataset and documentation
  - `olympic_athletes.csv`: Main dataset file
  - `README.md`: Metadata and codebook for the dataset
- `index.qmd`: Main project report Quarto document
- `proposal.qmd`: Project proposal document
- `presentation.qmd`: Presentation slides for the project
- `_quarto.yml`: Configuration file for the Quarto website
- `styles.css`: Custom CSS styling for the website
- `/docs/`: Generated website files (created when rendering the project)

## Dataset

This analysis uses the "120 years of Olympic history: athletes and results" dataset compiled by rgriffin, which includes data from the Athens 1896 Summer Olympics to the Rio 2016 Summer Olympics, as well as Winter Olympics data.

### Codebook

| Variable | Description | Data Type |

| ID | Unique identifier for each athlete | Integer |
| Name | Athlete's name | String |
| Sex | Athlete's sex (M or F) | String |
| Age | Athlete's age at the time of the Olympics | Integer |
| Height | Athlete's height in centimeters | Float |
| Weight | Athlete's weight in pounds | Float |
| Team | Team/Country represented | String |
| NOC | National Olympic Committee code | String |
| Games | Olympic Games year and season | String |
| Year | Year of the Olympic Games | Integer |
| Season | Season of Games (Summer or Winter) | String |
| City | Host city of the Olympic Games | String |
| Sport | Sport competed in | String |
| Event | Specific event competed in | String |
| Medal | Medal won (Gold, Silver, Bronze, or NA) | String |

For our analysis, countries were classified into Global North and Global South categories based on the Worldwide Bureaucracy Indicator.

Worldwide Bureaucracy Indicator

|country_code | 3-letter ISO_3166-1 code 	| String|
|region | region |String 	

## R Dependencies

This project uses the following R packages:
- tidyverse
- ggplot2
- dplyr
- readr
- knitr
- quarto

## How to Run

1. Clone this repository
2. Ensure R and the dependencies are installed
3. Open the project in RStudio
4. Use Quarto to render the documents:
   ```r
   quarto render
   ```

## Team Members

- Israel Davidson
- Emma Chase
- Paul Vermette
- Catherine Liu

## Project Date

March 6, 2025