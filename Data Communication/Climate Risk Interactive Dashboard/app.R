library(tidyverse)
library(scales)
library(shiny)
library(sf)
library(janitor)
library(ggthemes)
library(colorspace)
library(bslib)
library(bsicons)
library(gt)

# Import data ----------------------------------------------------------------
# climate risk
climate_risk <- read_rds(file = "data/climate-risk.rds")

# import state and county boundaries
state_sf <- st_read(dsn = "data/states.geojson")
county_sf <- st_read(dsn = "data/counties.geojson")

# combine climate risk with county_sf
climate_sf <- left_join(
  x = county_sf,
  y = climate_risk,
  by = join_by(GEOID == state_county_fips_code)
) |>
  as_tibble() |>
  st_as_sf()

# get county names
county_names <- climate_sf |>
  arrange(STATEFP) |>
  pull(county)

# define hazard types
hazard_types <- climate_risk |>
  select(contains("hazard")) |>
  colnames()

# create human-readable labels
hazard_types_labels <- hazard_types |>
  str_remove(pattern = "_hazard_type_risk_index_score") |>
  make_clean_names(case = "title")

# create a named character vector for the input
names(hazard_types) <- hazard_types_labels

# Define UI -----------------------------------------------------------------
ui <- page_navbar(
  title = "National Risk Index Counties",
  theme = bs_theme(version = 5, preset = "minty"),
  
  # National Risk Index page
  nav_panel(
    title = "National Risk Index",
    layout_sidebar(
      sidebar = sidebar(
        # select between the four risk ratings
        varSelectInput(
          inputId = "risk_var",
          label = "Risk index",
          # select specific columns of data to populate select options
          data = climate_risk |>
            select(`National Risk Index`, `Expected Annual Loss`, `Social Vulnerability`, `Community Resilience`)
        )
      ),
      # Main content
      card(
        card_header("National Risk Map"),
        plotOutput(outputId = "national_map")
      )
    )
  ),
  
  # County Details page
  nav_panel(
    title = "County Details",
    layout_sidebar(
      sidebar = sidebar(
        # extract county/state labels as character vector
        selectizeInput(
          inputId = "county",
          label = "Selected county",
          choices = county_names,
          selected = NULL,
          # custom selectize.js options
          options = list(
            # placeholder text
            placeholder = "Select a county",
            # limit to one county at a time
            maxItems = 1
          )
        ),
        
        # identify columns with hazard risks and extract column names
        checkboxGroupInput(
          inputId = "hazard_types",
          label = "Hazard types",
          # all possible choices
          choices = hazard_types,
          # initialize plot with all individual hazards
          selected = hazard_types
        )
      ),
      # Main content
      layout_column_wrap(
        width = "400px", # This width makes two columns when screen is > 800px, one column when narrower
        style = htmltools::css(gap = "10px", margin_bottom = "10px"),
        # Row 1 - Maps side by side on wider screens
        card(
          card_header("County Map"),
          plotOutput(outputId = "county_map")
        ),
        card(
          card_header("County Hazards"),
          plotOutput(outputId = "county_hazards")
        )
      ),
      layout_column_wrap(
        width = 1/4,
        height = "auto",
        style = htmltools::css(gap = "10px"),
        # Row 2 - Value boxes
        value_box(
          title = "Overall risk score",
          value = textOutput("county_risk"),
          showcase = bs_icon("radioactive")
        ),
        value_box(
          title = "Expected annual loss",
          value = textOutput("county_loss"),
          showcase = bs_icon("trash")
        ),
        value_box(
          title = "Social vulnerability",
          value = textOutput("county_vulnerability"),
          showcase = bs_icon("cone-striped")
        ),
        value_box(
          title = "Community resilience",
          value = textOutput("county_resilience"),
          showcase = bs_icon("emoji-sunglasses")
        )
      )
    )
  ),
  
  # Data page
  nav_panel(
    title = "Data",
    card(
      card_header("National Risk Index Data"),
      climate_risk |>
        gt() |>
        opt_interactive()
    )
  )
)

# Server function for the National Risk Index Counties Shiny app
server <- function(input, output) {
  
  # Reactive expression for selected county
  selected_county <- reactive({
    # Validate that a county is selected
    validate(
      need(input$county, "Please select a county to view detailed information.")
    )
    
    # Filter the data for the selected county
    climate_risk |>
      filter(county == input$county)
  })
  
  # National map
  output$national_map <- renderPlot({
    # Print a message for debugging
    message("Rendering national map with risk variable: ", input$risk_var)
    
    # Create the national map
    ggplot(data = climate_sf) +
      # Layer for each county's risk
      geom_sf(mapping = aes(fill = !!input$risk_var)) +
      # Layer for state boundaries to better locate regions
      geom_sf(data = state_sf, fill = NA, color = "white") +
      # Appropriate color palette
      scale_fill_discrete_diverging(rev = TRUE) +
      # Don't label the legend
      labs(
        fill = NULL
      ) +
      # Map theme
      theme_map(base_size = 18) +
      # Position the legend on the right
      theme(legend.position = "right")
  })
  
  # County map
  output$county_map <- renderPlot({
    # Validate that a county is selected
    validate(
      need(input$county, "Please select a county to view its location.")
    )
    
    # Print a message for debugging
    message("Rendering county map for: ", input$county)
    
    # Get selected county's state
    county_state <- climate_sf |>
      filter(county == input$county) |>
      pull(STATE_NAME)
    
    # Create the county map
    climate_sf |>
      # Filter for counties in specific state
      filter(STATE_NAME == county_state) |>
      # Variable to highlight selected county
      mutate(selected = county == input$county) |>
      # Draw the map
      ggplot() +
      geom_sf(mapping = aes(fill = selected, color = selected)) +
      scale_fill_manual(values = c(NA, "orange")) +
      scale_color_manual(values = c("white", "orange")) +
      theme_map() +
      theme(legend.position = "none")
  })
  
  # County risk score for value box
  output$county_risk <- renderText({
    # Get selected county's overall risk score
    val <- selected_county() |>
      pull(national_risk_index_score_composite)
    
    # Format using scales function
    label_number(accuracy = 1)(val)
  })
  
  # Expected annual loss for value box
  output$county_loss <- renderText({
    val <- selected_county() |>
      pull(expected_annual_loss_dollars_score)
    
    # Format as currency with no decimal places
    label_dollar(accuracy = 1)(val)
  })
  
  # Social vulnerability for value box
  output$county_vulnerability <- renderText({
    val <- selected_county() |>
      pull(social_vulnerability_score)
    
    # Format as number with one decimal place
    label_number(accuracy = 0.1)(val)
  })
  
  # Community resilience for value box
  output$county_resilience <- renderText({
    val <- selected_county() |>
      pull(community_resilience_score)
    
    # Format as number with one decimal place
    label_number(accuracy = 0.1)(val)
  })
  
  # Individual hazard percentiles plot
  output$county_hazards <- renderPlot({
    # Validate that a county is selected and hazard types are selected
    validate(
      need(input$county, "Please select a county to view hazard data."),
      need(length(input$hazard_types) > 0, "Please select at least one hazard type.")
    )
    
    # Print a message for debugging
    message("Rendering hazard plot for: ", input$county, 
            " with hazards: ", paste(input$hazard_types, collapse = ", "))
    
    # Get selected county's hazard percentiles
    selected_county_hazards <- climate_risk |>
      filter(county == input$county)
    
    # Plot hazard percentiles
    selected_county_hazards |>
      # Reshape to long format for visualizing
      pivot_longer(
        cols = contains("hazard"),
        names_to = "hazard",
        values_to = "percentile"
      ) |>
      # Only visualize selected hazard types
      filter(hazard %in% input$hazard_types) |>
      # Order alphabetically
      mutate(hazard = str_remove(hazard, "_hazard_type_risk_index_score") |>
               make_clean_names(case = "title") |>
               fct_rev()) |>
      ggplot(mapping = aes(y = hazard)) +
      # All hazards range between 0 and 100
      geom_linerange(mapping = aes(xmin = 0, xmax = 100)) +
      # Draw specific county
      geom_point(
        mapping = aes(x = percentile, color = percentile),
        size = 4
      ) +
      # Optimized color palette
      scale_color_continuous_diverging(mid = 50, rev = TRUE, guide = "none") +
      # Appropriate labels
      labs(
        x = "Percentile",
        y = NULL
      ) +
      # Clean up the theme
      theme_minimal(base_size = 18) +
      theme(
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_blank()
      )
  })
  
}

# Run the app
shinyApp(ui = ui, server = server)
            
      