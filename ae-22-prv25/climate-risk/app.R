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

climate_risk <- read_rds(file = "data/climate-risk.rds")
state_sf <- st_read(dsn = "data/states.geojson")
county_sf <- st_read(dsn = "data/counties.geojson")
climate_sf <- left_join(
  x = county_sf,
  y = climate_risk,
  by = join_by(GEOID == state_county_fips_code)
) |>
  as_tibble() |>
  st_as_sf()

states <- unique(climate_sf$STATE_NAME)
states <- states[order(states)]
states <- c("All States", states)

ui <- page_fluid(
  
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    primary = "#2C3E50"
  ),
  
  layout_columns(
    col_widths = 12,
    card(
      card_header(
        class = "bg-primary text-white",
        h1("Climate Risk Visualization Dashboard", class = "text-center")
      ),
      card_body(
        p("This interactive dashboard visualizes climate risk data across counties in the United States. Use the controls below to explore different risk metrics, filter by states, and analyze patterns of climate vulnerability."),
        p("Data source: National Risk Index")
      )
    )
  ),
  
  layout_columns(
    col_widths = c(4, 8),
    
    card(
      card_header("Data Controls", class = "bg-secondary text-white"),
      card_body(
        selectInput(
          "risk_metric", 
          "Select Risk Metric:",
          choices = c(
            "Overall Risk Score" = "risk_score",
            "Expected Annual Loss ($)" = "expected_annual_loss",
            "Social Vulnerability" = "social_vulnerability",
            "Community Resilience" = "community_resilience",
            "Building Value" = "building_value",
            "Population" = "population",
            "Agriculture Value" = "agriculture_value"
          ),
          selected = "risk_score"
        ),
        
        selectInput(
          "state_filter",
          "Filter by State:",
          choices = states,
          selected = "All States"
        ),
        
        sliderInput(
          "percentile_filter",
          "Filter by Risk Percentile:",
          min = 0,
          max = 100,
          value = c(0, 100),
          step = 5
        ),
        
        radioButtons(
          "color_scheme",
          "Color Scheme:",
          choices = c(
            "Blue to Red" = "blue_red",
            "Green to Red" = "green_red",
            "Viridis" = "viridis",
            "Terrain" = "terrain"
          ),
          selected = "blue_red"
        ),
        
        hr(),
        
        h4("Data Analysis"),
        p("View statistics for selected data:"),
        
        actionButton(
          "show_stats", 
          "View Statistics", 
          icon = icon("chart-bar"),
          class = "btn-primary w-100"
        ),
        
        hr(),
        
        h4("Visualization Options"),
        
        checkboxInput(
          "show_state_boundaries",
          "Show State Boundaries",
          value = TRUE
        ),
        
        checkboxInput(
          "adjust_by_population",
          "Adjust by Population",
          value = FALSE
        )
      )
    ),
    
    card(
      card_header(
        textOutput("map_title"), 
        class = "bg-primary text-white"
      ),
      card_body(
        plotOutput("map_plot", height = "500px"),
        br(),
        textOutput("data_info")
      )
    )
  ),
  
  layout_columns(
    col_widths = 12,
    card(
      card_header("Data Insights", class = "bg-secondary text-white"),
      layout_columns(
        col_widths = c(6, 6),
        card_body(
          plotOutput("histogram_plot", height = "300px")
        ),
        card_body(
          gt_output("top_counties_table")
        )
      )
    )
  ),
  
  
  layout_columns(
    col_widths = 12,
    card(
      card_body(
        p(
          "INFO 3312/5312 - Climate Risk Visualization - Cornell University",
          class = "text-center text-muted"
        ),
        p(
          "Data visualization created for Applied Exercise 22",
          class = "text-center text-muted small"
        )
      )
    )
  )
)

server <- function(input, output, session) {
  
  filtered_data <- reactive({
    data <- climate_sf
    
    if (input$state_filter != "All States") {
      data <- data %>% filter(STATE_NAME == input$state_filter)
    }
    
    metric <- input$risk_metric
    
    if (!metric %in% names(data)) {
      # If not, return the data as is without filtering by metric
      return(data)
    }
    
    if (sum(!is.na(data[[metric]])) == 0) {
      return(data)
    }
    
    data <- data %>%
      mutate(
        metric_value = .data[[metric]],
        percentile = ntile(replace_na(metric_value, min(metric_value, na.rm = TRUE)), 100)
      )
    
    data <- data %>%
      filter(percentile >= input$percentile_filter[1],
             percentile <= input$percentile_filter[2])
    
    return(data)
  })
  
  metric_name <- reactive({
    metric <- input$risk_metric
    
    choices <- c(
      "Overall Risk Score" = "risk_score",
      "Expected Annual Loss ($)" = "expected_annual_loss",
      "Social Vulnerability" = "social_vulnerability",
      "Community Resilience" = "community_resilience",
      "Building Value" = "building_value",
      "Population" = "population",
      "Agriculture Value" = "agriculture_value"
    )
    
    metric_label <- names(choices)[choices == metric]
    
    if (length(metric_label) == 0) {
      return(metric)
    }
    
    return(metric_label)
  })
  
  output$map_plot <- renderPlot({
    data <- filtered_data()
    
    if (nrow(data) == 0) {
      return(ggplot() + 
               geom_text(aes(x = 0, y = 0), label = "No data available for the selected filters") +
               theme_void())
    }
    
    metric <- input$risk_metric
    
    if (!metric %in% names(data)) {
      return(ggplot() + 
               geom_text(aes(x = 0, y = 0), label = paste("Metric", metric, "not found in data")) +
               theme_void())
    }
    
    if (sum(!is.na(data[[metric]])) == 0) {
      return(ggplot() + 
               geom_text(aes(x = 0, y = 0), label = "No non-NA values for selected metric") +
               theme_void())
    }
    
    tryCatch({
      color_scheme <- switch(input$color_scheme,
                             "blue_red" = scale_fill_gradient2(low = "blue", mid = "white", high = "red", 
                                                               midpoint = median(data[[metric]], na.rm = TRUE)),
                             "green_red" = scale_fill_gradient2(low = "green", mid = "yellow", high = "red", 
                                                                midpoint = median(data[[metric]], na.rm = TRUE)),
                             "viridis" = scale_fill_viridis_c(na.value = "grey80"),
                             "terrain" = scale_fill_distiller(palette = "Terrain", na.value = "grey80"),
                             scale_fill_viridis_c(na.value = "grey80")) # Default if none match
      
      p <- ggplot() +
        geom_sf(data = data, aes(fill = .data[[metric]]), color = NA) +
        color_scheme +
        theme_map() +
        labs(fill = metric_name()) +
        theme(legend.position = "bottom",
              legend.key.width = unit(2, "cm"))
      
      if (input$show_state_boundaries) {
        p <- p + geom_sf(data = state_sf, fill = NA, color = "black", size = 0.5)
      }
      
      return(p)
      
    }, error = function(e) {
      return(ggplot() + 
               geom_text(aes(x = 0, y = 0), 
                         label = paste("Error creating map:", e$message)) +
               theme_void())
    })
  })
  
  output$histogram_plot <- renderPlot({
    tryCatch({
      data <- filtered_data()
      
      if (nrow(data) == 0) {
        return(ggplot() + 
                 geom_text(aes(x = 0, y = 0), label = "No data available for the selected filters") +
                 theme_void())
      }
      
      metric <- input$risk_metric
      
      if (!metric %in% names(data)) {
        return(ggplot() + 
                 geom_text(aes(x = 0, y = 0), label = paste("Metric", metric, "not found in data")) +
                 theme_void())
      }
      
      if (sum(!is.na(data[[metric]])) == 0) {
        return(ggplot() + 
                 geom_text(aes(x = 0, y = 0), label = "No non-NA values for selected metric") +
                 theme_void())
      }
      
      ggplot(data, aes(x = .data[[metric]])) +
        geom_histogram(fill = "steelblue", color = "white", bins = 30) +
        theme_minimal() +
        labs(
          title = paste("Distribution of", metric_name()),
          x = metric_name(),
          y = "Count"
        )
    }, error = function(e) {
      return(ggplot() + 
               geom_text(aes(x = 0, y = 0), 
                         label = paste("Error creating histogram:", e$message)) +
               theme_void())
    })
  })
  
  output$top_counties_table <- render_gt({
    tryCatch({
      data <- filtered_data()
      
      if (nrow(data) == 0) {
        return(gt(tibble(Message = "No data available for the selected filters")))
      }
      
      metric <- input$risk_metric
      
      if (!metric %in% names(data)) {
        return(gt(tibble(Message = paste("Metric", metric, "not found in data"))))
      }
      
      if (sum(!is.na(data[[metric]])) == 0) {
        return(gt(tibble(Message = "No non-NA values for selected metric")))
      }
      
      top_counties <- data %>%
        as_tibble() %>%
        select(NAME, STATE_NAME, !!sym(metric)) %>%
        filter(!is.na(!!sym(metric))) %>%
        arrange(desc(!!sym(metric))) %>%
        head(10)
      
      if (nrow(top_counties) == 0) {
        return(gt(tibble(Message = "No counties with data for this metric")))
      }
      
      metric_col_name <- metric_name()
      
      gt(top_counties) %>%
        cols_label(
          NAME = "County",
          STATE_NAME = "State",
          !!sym(metric) := metric_col_name
        ) %>%
        tab_header(
          title = "Top 10 Counties by Risk Level",
          subtitle = paste("Based on", metric_name())
        ) %>%
        fmt_number(
          columns = vars(!!sym(metric)),
          decimals = 2
        ) %>%
        tab_style(
          style = list(
            cell_fill(color = "lightblue"),
            cell_text(weight = "bold")
          ),
          locations = cells_body(
            rows = 1
          )
        )
    }, error = function(e) {
      return(gt(tibble(Message = paste("Error creating table:", e$message))))
    })
  })
  
  output$map_title <- renderText({
    tryCatch({
      state_label <- if(input$state_filter == "All States") {
        "United States"
      } else {
        input$state_filter
      }
      
      paste(metric_name(), "by County:", state_label)
    }, error = function(e) {
      "Climate Risk Visualization"
    })
  })
  
  output$data_info <- renderText({
    tryCatch({
      data <- filtered_data()
      n_counties <- nrow(data)
      
      paste("Showing", n_counties, "counties based on current filters")
    }, error = function(e) {
      "Data loading error. Please check console for details."
    })
  })
  
  observeEvent(input$show_stats, {
    data <- filtered_data()
    metric <- input$risk_metric
    
    if (nrow(data) == 0 || !metric %in% names(data) || sum(!is.na(data[[metric]])) == 0) {
      showModal(modalDialog(
        title = "No Data Available",
        "There is no data available for the current selection.",
        easyClose = TRUE
      ))
      return()
    }
    
    stats <- data %>%
      as_tibble() %>%
      summarise(
        Mean = mean(!!sym(metric), na.rm = TRUE),
        Median = median(!!sym(metric), na.rm = TRUE),
        Min = min(!!sym(metric), na.rm = TRUE),
        Max = max(!!sym(metric), na.rm = TRUE),
        SD = sd(!!sym(metric), na.rm = TRUE),
        Count = sum(!is.na(!!sym(metric))),
        NA_Count = sum(is.na(!!sym(metric)))
      )
    
    stats_table <- gt(stats) %>%
      fmt_number(
        columns = everything(),
        decimals = 2
      )
    
    showModal(modalDialog(
      title = paste("Statistics for", metric_name()),
      gt_output("stats_table"),
      easyClose = TRUE,
      size = "l"
    ))
    
    output$stats_table <- render_gt({
      stats_table
    })
  })
}

shiny::shinyApp(ui = ui, server = server)