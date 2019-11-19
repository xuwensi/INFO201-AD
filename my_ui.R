library("dplyr")
library("knitr")
library("ggplot2")
library("leaflet")
library("shiny")

my_ui <- navbarPage(
  title = "Formula One Safety",
  tabPanel(
    "Introduction",
    img(src = "https://specials-images.forbesimg.com/imageserve/1023761676/960x0.jpg?fit=scale"),
    h3("This project is aiming to analyze how safety has improved every decade for Formula 1 races. We think this is an important issue because Formula 1 is one of the top racing shows in the country; which means that there are thousands of viewers. People watch these shows but seldom think about the risks associated with racing going hundreds of miles per hour. Every piece of the car and passing every protocol counts. It is extremely distressing to see a racer lose their life on live television, therefore having a website that condenses and presents all of the previous data and trends to hopefully help the direct stakeholders understand how to continuously prevent accidents from occuring."), 
    h3("We will be addressing the problem by visualizing the trends of car accidents throughout the decades of F1. By showcasing the trend and providing a universal point for all of the data, the direct workers for F1 can look into this data and see where their new measures were effective and ineffective for increasing safety for drivers. We will also be data wrangling the different dataset from each decade of F1 and join them by their ID column to compare the data."),
  ),
  
  tabPanel(
    "Background & Research Questions",
    h3("Our direct stakeholders are the F1 drivers, the workers on their teams, their companies, and manufacturers of the cars and the parts. The indirect stakeholders are the viewers and families of racers. The policy and ethical elements bear on the problem Is that whether sacrificing safety worth the financial costs and program aesthetics."),
    h3("Research questions:"),
    h3("- How many lives were impacted or sacrificed purely for the sake of aesthetics and/or money?"),
    h3("- How has the number of crashes and deaths decreased throughout the decades?"),
    h3("- What caused the increase or decrease in deaths and risk in the F1 races?")
  ),
  
  tabPanel(
    "Vis1: Geographic Map",
    titlePanel("Number of accidents happened by location on map"),
    mainPanel(
      leafletOutput(outputId = "geo_map")
    )
  ),
  
  tabPanel(
    "Vis2: Bar Chart",
    titlePanel("Collision, Injuries, and fatality year over year comparison"),
    mainPanel(
      plotOutput(outputId = "bar_chart")
    )
  ),
  
  tabPanel(
    "Conclusion",
    h3("#Conclusion")
  ),
  
  tabPanel(
    "About the Tech",
    h3("tech used")
  ),
  
  tabPanel(
    "About us"
    # something about project team
  )
)


