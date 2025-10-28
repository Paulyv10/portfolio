# app.R

library(shiny)
library(bslib)
library(lubridate)
library(readr)
if (!require(plotly)) install.packages("plotly")
library(plotly)
library(dplyr)
library(tidyr)
library(countrycode) # Added for ISO code to country name conversion
library(ggplot2)

# Define UI
ui <- fluidPage(
  theme = bslib::bs_theme(version = 5, bootswatch = "cosmo"),
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"), # Links to www/custom.css
    tags$script(src = "sliding-tabs.js")
  ),
  
  # Use navbarPage for top-level tab navigation
  navbarPage(
    title = tagList(
      tags$img(src = "spotify-icon.png", height = "30px", style = "margin-top: -4px; margin-right: 2px;"),
      "Spotify Global Trends"
    ),
    id = "main_nav",
    collapsible = TRUE,
    
    # Tab 1: Global Overview
    tabPanel(
      title = "Global Overview",
      value = "global",
      sidebarLayout(
        sidebarPanel(
          width = 3,
          h4("Global Filters"),
          radioButtons("global_entity_type", "View By:",
                       choices = c("Top Artists" = "artist", "Top Tracks" = "track"),
                       selected = "artist"
          ),
          dateRangeInput("global_date_range",
                         "Select Date Range:",
                         start = "2025-01-01", 
                         end = "2025-04-09",   
                         min = "2024-10-17", # modify as needed 
                         max = "2025-04-09"   
          ),
          tags$p(
            "The Spotify popularity score is a number between 0 and 100 that indicates an artist's or track's popularity on Spotify, based on recent stream counts, save rates, and playlist inclusion.",
            class = "text-muted"
          )
        ),
        mainPanel(
          width = 9,
          h3("Global Top Artists or Tracks"),
          plotlyOutput("global_top_artists_chart"),
          br(),
          h3("Global Map View"),
          plotlyOutput("global_map_view", height = "500px"),
        )
      )
    ),
    
    # Tab 2: Regional Deep Dive
    tabPanel(
      title = "Regional Deep Dive",
      value = "regional",
      sidebarLayout(
        sidebarPanel(
          width = 3,
          h4("Regional Filters"),
          radioButtons("regional_entity_type", "View By:",
                       choices = c("Top Artists" = "artist", "Top Tracks" = "track"),
                       selected = "artist"),
          tags$head(
            tags$style(HTML("
          /* Target the dropdown options for the specific selectInput */
          #regional_country + .selectize-control .selectize-dropdown-content .option {
            color: black !important; /* Set text color to black */
          }
          /* You might also want to style the selected item's text if it's not black by default */
          #regional_country + .selectize-control .selectize-input .item {
            color: black !important; /* Set selected item text color to black */
          }
        "))
          ),
          selectInput("regional_country", "Select Country:",
                      choices = list("Loading..." = ""), # Placeholder, will be updated by server
                      selected = ""
          ),
          dateRangeInput("regional_date_range",
                         "Select Date Range:",
                         start = floor_date(Sys.Date() - months(6), "month"), 
                         end = Sys.Date(),                                   
                         min = "2018-01-01", 
                         max = Sys.Date()    
          ),
          tags$p(
            "The Spotify popularity score is a number between 0 and 100 that indicates an artist's or track's popularity on Spotify, based on recent stream counts, save rates, and playlist inclusion.",
            class = "text-muted"
          )
        ),
        mainPanel(
          width = 9,
          h3("Regional Top Artists or Tracks"),
          plotlyOutput("regional_top_artists_chart"),
          br(),
          h3("Regional Time Series Trend"),
          plotlyOutput("regional_time_series_chart")
        )
      )
    ),
    
    # Tab 3: Audio Feature Explorer
    tabPanel(
      title = "Audio Feature Explorer",
      value = "features",
      sidebarLayout(
        sidebarPanel(
          width = 3,
          h4("Feature Filters"),
          tags$head(
            tags$style(HTML("
          /* Target the dropdown options for the specific selectInput */
          #feature_country + .selectize-control .selectize-dropdown-content .option {
            color: black !important; /* Set text color to black */
          }
          /* You might also want to style the selected item's text if it's not black by default */
          #feature_country + .selectize-control .selectize-input .item {
            color: black !important; /* Set selected item text color to black */
          }
        "))
          ),
          selectInput("feature_country", "Select Country/Region:",
                      choices = list("Global" = "Global", "Loading..." = ""), # Placeholder
                      selected = "Global",
                      multiple = FALSE 
          ),
          dateRangeInput("feature_date_range",
                         "Select Date Range:",
                         start = floor_date(Sys.Date() - years(1), "year"),
                         end = ceiling_date(Sys.Date(), "month") - days(1), 
                         min = "2018-01-01", 
                         max = Sys.Date()    
          ),
          tags$head(
            tags$style(HTML("
          /* Target the dropdown options for the specific selectInput */
          #feature_select + .selectize-control .selectize-dropdown-content .option {
            color: black !important; /* Set text color to black */
          }
          /* You might also want to style the selected item's text if it's not black by default */
          #feature_select + .selectize-control .selectize-input .item {
            color: black !important; /* Set selected item text color to black */
          }
        "))
          ),
          selectizeInput("feature_select", "Select Up to 4 Audio Features:",
                         choices = list(),  # server will populate
                         selected = NULL,
                         multiple = TRUE,
                         options = list(maxItems = 4)
          ),
          tags$p("Compare audio features for a region or globally over time.", class = "text-muted")
        ),
        mainPanel(
          width = 9,
          h3("Audio Feature Trends Over Time"),
          plotlyOutput("audio_feature_plot"),
          br(),
          h3("Average Audio Features (Radar Summary)"),
          div(style = "margin-bottom: 40px;"),  # spacing between charts
          plotlyOutput("audio_feature_radar")
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
    spotify_df <- reactive({
   
    df <- read_csv("data/truncated.csv.gz", show_col_types = FALSE)
    
    df$snapshot_date <- as.Date(df$snapshot_date, format = "%Y-%m-%d")
    
    min_date <- min(df$snapshot_date, na.rm = TRUE)
    max_date <- max(df$snapshot_date, na.rm = TRUE)
    
    updateDateRangeInput(session, "global_date_range",  
                         min = min_date, max = max_date,
                         start = max(min_date, as.Date("2025-01-01")),
                         end = min(max_date, as.Date("2025-04-09")))
    
    updateDateRangeInput(session, "regional_date_range",  
                         min = min_date, max = max_date,
                         start = max(min_date, as.Date("2025-01-01")),
                         end = min(max_date, as.Date("2025-04-09")))
    
    updateDateRangeInput(session, "feature_date_range",  
                         min = min_date, max = max_date,
                         start = max(min_date, as.Date("2025-01-01")),
                         end = min(max_date, as.Date("2025-04-09")))
    
    # --- Update country choices with names ---
    raw_iso_codes <- sort(unique(na.omit(df$country)))
    
    country_choices_for_regional <- list()
    country_choices_for_feature <- list("Global" = "Global") # Initialize with Global option
    
    if (length(raw_iso_codes) > 0) {
      country_names_display <- countrycode(
        raw_iso_codes, # CORRECTED: Pass raw_iso_codes as the first argument (sourcevar)
        origin = "iso2c", 
        destination = "country.name", 
        nomatch = raw_iso_codes # If no match, display the ISO code itself
      )
      
      # Ensure no NAs in displayed names (should be handled by nomatch, but as a safeguard)
      country_names_display[is.na(country_names_display)] <- raw_iso_codes[is.na(country_names_display)]
      
      # Create named list: DisplayName = ISO_Code_Value
      country_choices_map <- setNames(raw_iso_codes, country_names_display)
      
      country_choices_for_regional <- country_choices_map
      # Add country choices to the feature tab, ensuring "Global" isn't overwritten if a country is named "Global"
      country_choices_for_feature <- c(country_choices_for_feature, country_choices_map[!names(country_choices_map) %in% "Global"])
      
      
      updateSelectInput(session, "regional_country", 
                        choices = country_choices_for_regional, 
                        selected = if(length(raw_iso_codes) > 0) raw_iso_codes[1] else NULL)
    } else {
      # No countries found after na.omit
      updateSelectInput(session, "regional_country", choices = list("No countries available" = ""), selected = "")
    }
    
    updateSelectInput(session, "feature_country", 
                      choices = country_choices_for_feature, 
                      selected = "Global")
    # --- End of country choices update ---
    
    audio_features <- c("danceability", "energy", "loudness", "speechiness",  
                        "acousticness", "instrumentalness", "liveness", "valence", "tempo")
    actual_features <- audio_features[audio_features %in% names(df)]
    
    if (length(actual_features) > 0) {
      updateSelectInput(session, "feature_select", choices = actual_features, selected = actual_features[1])
    } else {
      updateSelectInput(session, "feature_select", choices = list("N/A" = ""), selected = "")
    }
    
    return(df)
  })
  
  
  # --- Global Overview Tab Reactives and Outputs ---
  global_data_filtered <- reactive({
    req(spotify_df(), input$global_date_range, input$global_date_range[1], input$global_date_range[2])
    
    start_date <- input$global_date_range[1]
    end_date <- input$global_date_range[2]
    
    spotify_df() %>%
      filter(
        is.na(country), 
        snapshot_date >= start_date,
        snapshot_date <= end_date
      )
  })
  
  output$global_top_artists_chart <- renderPlotly({
    req(global_data_filtered())
    
    top_data <- {
      df <- global_data_filtered() %>%
        filter(!is.na(name) & name != "")
      
      if (input$global_entity_type == "artist") {
        df %>%
          filter(!is.na(artists) & artists != "") %>%
          separate_rows(artists, sep = ",\\s*") %>%
          mutate(artists = trimws(artists)) %>%
          count(artists, name = "value", sort = TRUE) %>%
          rename(entity = artists)
      } else {
        df %>%
          filter(!is.na(popularity)) %>%
          group_by(name) %>%
          summarise(value = mean(popularity, na.rm = TRUE), .groups = "drop") %>%
          rename(entity = name)
      }
    } %>%
      slice_head(n = 15)
    
    validate(
      need(nrow(top_data) > 0, "No data available for the selected date range.")
    )
    
    y_title <- ifelse(input$global_entity_type == "artist", "Number of Appearances in Top 50", "Average Popularity (0–100)")
    chart_title <- ifelse(input$global_entity_type == "artist", "Top 15 Artists by Number of Appearances", "Top 15 Tracks by Average Popularity")
    
    p <- ggplot(top_data, aes(x = reorder(entity, value), y = value,
                              text = paste0(ifelse(input$global_entity_type == "artist", "Artist: ", "Track: "),
                                            entity, "<br>Value: ", round(value, 1)))) +
      geom_col(fill = "#1DB954") +
      coord_flip() +
      labs(x = NULL, y = y_title) +
      theme_minimal(base_size = 12)
    
    ggplotly(p, tooltip = "text") %>%
      layout(
        title = list(
          text = paste0("<b>", chart_title, "</b><br><sup>",
                        "Date Range: ", format(input$global_date_range[1], "%Y-%m-%d"),
                        " to ", format(input$global_date_range[2], "%Y-%m-%d"), "</sup>"),
          x = 0.5,
          xanchor = "center"
        ),
        yaxis = list(title = ""),
        xaxis = list(title = y_title),
        margin = list(l = 100, r = 20, b = 50, t = 100)
      )
  })
  
  output$global_map_view <- renderPlotly({
    req(spotify_df(), input$global_date_range, input$global_entity_type)
    
    df <- spotify_df() %>%
      filter(snapshot_date >= input$global_date_range[1],
             snapshot_date <= input$global_date_range[2])
    
    if (input$global_entity_type == "track") {
      # --- Popularity map ---
      pop_df <- df %>%
        filter(!is.na(country), !is.na(popularity)) %>%
        group_by(country) %>%
        summarise(avg_popularity = mean(popularity, na.rm = TRUE), .groups = "drop") %>%
        mutate(iso3 = countrycode(country, "iso2c", "iso3c"))
      
      plot_geo(pop_df) %>%
        add_trace(
          locations = ~iso3,
          locationmode = 'ISO-3',
          z = ~avg_popularity,
          colorscale = 'Viridis',
          colorbar = list(title = "Avg Popularity"),
          text = ~paste("Country:", country, "<br>Average Popularity:", round(avg_popularity, 1)),
          hoverinfo = "text"
        ) %>%
        layout(
          title = list(
            text = paste("Average Track Popularity by Country<br><sup>",
                         format(input$global_date_range[1], "%Y-%m-%d"), " to ",
                         format(input$global_date_range[2], "%Y-%m-%d"), "</sup>"),
            x = 0.5,
            xanchor = "center"
          ),
          geo = list(showframe = FALSE, showcoastlines = FALSE, projection = list(type = 'equirectangular')),
          margin = list(t = 80)
        )
      
    } else {
      # --- Artist overlap map ---
      df <- df %>%
        filter(!is.na(artists), artists != "") %>%
        separate_rows(artists, sep = ",\\s*") %>%
        mutate(artists = trimws(artists))
      
      global_artists <- df %>%
        filter(is.na(country)) %>%
        count(artists, sort = TRUE) %>%
        slice_head(n = 50) %>%
        pull(artists)
      
      overlap_df <- df %>%
        filter(!is.na(country)) %>%
        group_by(country, artists) %>%
        summarise(appearances = n(), .groups = "drop") %>%
        group_by(country) %>%
        summarise(
          local_top = list(artists[order(-appearances)][1:50]),
          .groups = "drop"
        ) %>%
        rowwise() %>%
        mutate(
          overlap_count = sum(local_top %in% global_artists),
          overlap_percent = round(overlap_count / 50 * 100, 1)
        ) %>%
        ungroup() %>%
        mutate(iso3 = countrycode(country, "iso2c", "iso3c"))
      
      plot_geo(overlap_df) %>%
        add_trace(
          locations = ~iso3,
          locationmode = 'ISO-3',
          z = ~overlap_percent,
          colorscale = 'Viridis',
          colorbar = list(title = "Artist Overlap (%)"),
          text = ~paste("Country:", country, "<br>Artist Overlap with Global Top 50:", overlap_percent, "%"),
          hoverinfo = "text"
        ) %>%
        layout(
          title = list(
            text = paste("Top Artist Overlap with Global Top 50<br><sup>",
                         format(input$global_date_range[1], "%Y-%m-%d"), " to ",
                         format(input$global_date_range[2], "%Y-%m-%d"), "</sup>"),
            x = 0.5,
            xanchor = "center"
          ),
          geo = list(showframe = FALSE, showcoastlines = FALSE, projection = list(type = 'equirectangular')),
          margin = list(t = 80)
        )
    }
  })
  
  
  
  # --- Regional Deep Dive Tab Reactives and Outputs ---
  regional_data_filtered <- reactive({
    req(spotify_df(), input$regional_country, input$regional_date_range)
    spotify_df() %>%
      filter(
        country == input$regional_country,
        snapshot_date >= input$regional_date_range[1],
        snapshot_date <= input$regional_date_range[2]
      )
  })
  
  output$regional_top_artists_chart <- renderPlotly({
    req(regional_data_filtered())
    
    top_data <- {
      df <- regional_data_filtered() %>%
        filter(!is.na(name) & name != "")
      
      if (input$regional_entity_type == "artist") {
        df %>%
          filter(!is.na(artists), artists != "") %>%
          separate_rows(artists, sep = ",\\s*") %>%
          mutate(artists = trimws(artists)) %>%
          count(artists, name = "value", sort = TRUE) %>%
          rename(entity = artists)
      } else {
        df %>%
          filter(!is.na(popularity)) %>%
          group_by(name) %>%
          summarise(value = mean(popularity, na.rm = TRUE), .groups = "drop") %>%
          rename(entity = name)
      }
    } %>%
      slice_head(n = 10)
    
    validate(
      need(nrow(top_data) > 0, "No data available for the selected country and date range.")
    )
    
    y_title <- ifelse(input$regional_entity_type == "artist", "Number of Appearances", "Average Popularity (0–100)")
    chart_title <- ifelse(input$regional_entity_type == "artist", "Top 10 Artists by Number of Appearances", "Top 10 Tracks by Average Popularity")
    region_name <- countrycode(input$regional_country, "iso2c", "country.name", nomatch = input$regional_country)
    
    plot_ly(top_data, x = ~value, y = ~reorder(entity, value),
            type = 'bar', orientation = 'h', marker = list(color = '#1DB954'),
            hoverinfo = "x+y") %>%
      layout(
        title = list(
          text = paste(chart_title, "in", region_name),
          x = 0.5,
          xanchor = "center"
        ),
        xaxis = list(title = y_title),
        yaxis = list(title = ""),
        margin = list(l = 100, t = 80)
      )
  })
  
  output$regional_time_series_chart <- renderPlotly({
    req(regional_data_filtered(), input$regional_entity_type)
    
    df <- regional_data_filtered()
    region_code <- input$regional_country
    region_name <- countrycode(region_code, "iso2c", "country.name", nomatch = region_code)
    
    if (input$regional_entity_type == "track") {
      # ---- Show average track popularity over time ----
      time_series <- df %>%
        filter(!is.na(popularity)) %>%
        group_by(snapshot_date) %>%
        summarise(avg_popularity = mean(popularity, na.rm = TRUE), .groups = "drop")
      
      plot_ly(time_series, x = ~snapshot_date, y = ~avg_popularity,
              type = 'scatter', mode = 'lines+markers',
              line = list(color = '#1DB954')) %>%
        layout(
          title = paste("Average Track Popularity Over Time in", region_name),
          xaxis = list(title = "Date"),
          yaxis = list(title = "Average Popularity"),
          margin = list(t = 80)
        )
      
    } else {
      # ---- Show artist overlap with global top 50 over time ----
      df_all <- spotify_df() %>%
        filter(snapshot_date >= input$regional_date_range[1],
               snapshot_date <= input$regional_date_range[2],
               !is.na(artists), artists != "") %>%
        separate_rows(artists, sep = ",\\s*") %>%
        mutate(artists = trimws(artists))
      
      df_global <- df_all %>%
        filter(is.na(country)) %>%
        group_by(snapshot_date, artists) %>%
        summarise(n = n(), .groups = "drop") %>%
        group_by(snapshot_date) %>%
        slice_max(n, n = 50) %>%
        summarise(global_top_artists = list(artists), .groups = "drop")
      
      df_local <- df_all %>%
        filter(country == region_code) %>%
        group_by(snapshot_date, artists) %>%
        summarise(n = n(), .groups = "drop") %>%
        group_by(snapshot_date) %>%
        slice_max(n, n = 50) %>%
        summarise(local_top_artists = list(artists), .groups = "drop")
      
      df_overlap <- inner_join(df_local, df_global, by = "snapshot_date") %>%
        rowwise() %>%
        mutate(
          overlap_count = sum(local_top_artists %in% global_top_artists),
          overlap_percent = round(overlap_count / 50 * 100, 1)
        ) %>%
        select(snapshot_date, overlap_percent)
      
      plot_ly(df_overlap, x = ~snapshot_date, y = ~overlap_percent,
              type = 'scatter', mode = 'lines+markers',
              line = list(color = '#1DB954')) %>%
        layout(
          title = paste("Artist Overlap with Global Top 50 Over Time in", region_name),
          xaxis = list(title = "Date"),
          yaxis = list(title = "Overlap (%)"),
          margin = list(t = 80)
        )
    }
  })
  
  
  
  # --- Audio Feature Explorer Tab Reactives and Outputs ---
  # Line chart data (time series)
  feature_data_long <- reactive({
    req(spotify_df(), input$feature_date_range, input$feature_country, input$feature_select)
    
    df <- spotify_df() %>%
      filter(snapshot_date >= input$feature_date_range[1],
             snapshot_date <= input$feature_date_range[2])
    
    if (input$feature_country != "Global") {
      df <- df %>% filter(country == input$feature_country)
    } else {
      df <- df %>% filter(is.na(country))
    }
    
    df %>%
      select(snapshot_date, all_of(input$feature_select)) %>%
      pivot_longer(-snapshot_date, names_to = "feature", values_to = "value") %>%
      group_by(snapshot_date, feature) %>%
      summarise(avg_value = mean(value, na.rm = TRUE), .groups = "drop")
  })
  
  # Radar chart data (averaged over date range)
  feature_snapshot_data <- reactive({
    req(spotify_df(), input$feature_date_range, input$feature_country, input$feature_select)
    
    df <- spotify_df() %>%
      filter(snapshot_date >= input$feature_date_range[1],
             snapshot_date <= input$feature_date_range[2])
    
    if (input$feature_country != "Global") {
      df <- df %>% filter(country == input$feature_country)
    } else {
      df <- df %>% filter(is.na(country))
    }
    
    df %>%
      select(all_of(input$feature_select)) %>%
      summarise(across(everything(), ~mean(.x, na.rm = TRUE))) %>%
      pivot_longer(everything(), names_to = "feature", values_to = "avg_value")
  })
  
  # Output: Line Chart
  output$audio_feature_plot <- renderPlotly({
    req(feature_data_long())
    df <- feature_data_long()
    
    plot_ly(df, x = ~snapshot_date, y = ~avg_value, color = ~feature,
            type = 'scatter', mode = 'lines+markers',
            text = ~paste("Date:", snapshot_date, "<br>Feature:", feature, "<br>Avg:", round(avg_value, 3)),
            hoverinfo = 'text') %>%
      layout(
        title = list(
          text = paste("Audio Feature Trends in", input$feature_country),
          x = 0.5,
          xanchor = "center"
        ),
        xaxis = list(title = "Date"),
        yaxis = list(title = "Average Value"),
        legend = list(title = list(text = "Feature")),
        margin = list(t = 80, b = 60, l = 60, r = 30)  # more top space for title
      )
  })
  
  # Output: Radar Chart
  output$audio_feature_radar <- renderPlotly({
    req(feature_snapshot_data())
    df <- feature_snapshot_data()
    df <- rbind(df, df[1,])  # close the radar loop
    
    plot_ly(
      type = 'scatterpolar',
      mode = 'lines+markers',
      r = df$avg_value,
      theta = df$feature,
      fill = 'toself',
      line = list(color = "#1DB954"),
      marker = list(size = 6)
    ) %>%
      layout(
        title = list(
          text = paste("Average Audio Features from", 
                       format(input$feature_date_range[1], "%Y-%m-%d"), "to", 
                       format(input$feature_date_range[2], "%Y-%m-%d"), 
                       "in", input$feature_country),
          x = 0.5,
          xanchor = "center"
        ),
        polar = list(
          radialaxis = list(visible = TRUE, range = c(0, 1))
        ),
        margin = list(t = 100, b = 40, l = 40, r = 40)
      )
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)