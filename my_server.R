library("dplyr")
library("knitr")
library("ggplot2")
library("leaflet")
library("shiny")
source("my_ui.R")

my_server <- function(input, output) {
  output$geo_map <- renderLeaflet({
    circuit_df <- read.csv("data/circuits.csv", stringsAsFactors = FALSE)
    result_df <- read.csv("data/results.csv", stringsAsFactors = FALSE)
    status_df <- read.csv("data/status.csv", stringsAsFactors = FALSE)
    race_df <- read.csv("data/races.csv", stringsAsFactors = FALSE)
    
    geo_df <- result_df %>%
      left_join(race_df, by = "raceId") %>%
      left_join(circuit_df, by = "circuitId") %>%
      left_join(status_df, by = "statusId") %>%
      filter(
        status != "Finished",
        !grepl("Lap", status),
        status != "Did not qualify"
      ) %>%
      select(
        location,
        status
      ) %>%
      group_by(location) %>%
      summarise(num_accident = n()) %>%
      left_join(circuit_df, by = "location") %>%
      select(
        circuitRef,
        location,
        country,
        lat,
        lng,
        num_accident
      )
    
    leaflet(data = geo_df) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addCircles(
        lat = ~lat,
        lng = ~lng,
        radius = ~sqrt(num_accident) * 7000,
        color = "red",
        popup = ~ paste(
          "Circuit name: ", circuitRef, "<br>",
          "Country: ", country, "<br>", 
          "Location: ", location, "<br>",
          "Number of accidents happened: ", num_accident
        ),
        stroke = FALSE
      )
  })
  
  output$bar_chart <- renderPlot({
    status <- read.csv("data/status.csv", stringsAsFactors = FALSE)
    races <- read.csv("data/races.csv", stringsAsFactors = FALSE)
    results <- read.csv("data/results.csv", stringsAsFactors = FALSE)
    
    analysis <- results %>%
      inner_join(status, by = "statusId") %>%
      inner_join(races, by = "raceId") %>%
      filter(status == "Injury" | status == "Injured" | status == "Fatal accident" | status == "Eye injury" | status == "Collision" | status == "Accident") %>%
      group_by(year) %>%
      count(.) %>%
      filter(year >= 1970)
    
    ggplot(data = analysis) +
      geom_col(
        mapping = aes(x = year, y = n, fill = year)
      ) + ylab("total number of injury and collision")
  })
}

shinyApp(ui = my_ui, server = my_server)