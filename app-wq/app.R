# Goal: Create an app to show a time series by station and indicator

# global.R ----

# * load libraries ----
library(tidyverse)
library(plotly)
library(tbeptools)

# * prep data ----
d <- epcdata |>
  select(
    station                 = epchc_station,
    SampleTime,
    lat                     = Latitude,
    lon                     = Longitude,
    `Total Nitrogen (mg/L)` = tn,
    `Chlorophyll-a (ug/L)`  = chla,
    `Secchi depth (m)`      = sd_m) |>
  pivot_longer(
    names_to  = "indicator",
    values_to = "value",
    `Total Nitrogen (mg/L)`:`Secchi depth (m)`)

# * data for select ----
stations   <- unique(d$station)
indicators <- unique(d$indicator)

#  ui.R ----
ui <- fluidPage(
  wellPanel(
    h2("Water Quality"),
    selectInput("sel_sta", "Station",   choices = stations),
    selectInput("sel_ind", "Indicator", choices = indicators),
    plotlyOutput("tsplot")
  )
)

#  server.R ----
server <- function(input, output, session) {
  
  # * get_data(): reactive to inputs ----
  get_data <- reactive({
    d |>
      filter(
        station   == input$sel_sta,
        indicator == input$sel_ind)
  })
  
  # * tsplot: time series plot ----
  output$tsplot <- renderPlotly({
    g <- ggplot(
      get_data(),
      aes(
        x = SampleTime,
        y = value) ) +
      geom_line() +
      labs(y = input$sel_ind)
    ggplotly(g)
  })
  
}

# run ----
shinyApp(ui, server)