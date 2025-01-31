library(shiny)
library(bslib)
library(plotly)
library(dplyr)
library(lubridate)
library(tbeptools)

# Create labels for parameters
param_labels <- c(
  "tn" = "Total Nitrogen",
  "chla" = "Chlorophyll-a",
  "sd_m" = "Secchi Depth (m)"
)

ui <- page_sidebar(
  title = "Time Series Explorer",
  sidebar = sidebar(
    selectInput("station", "Select Station:",
                choices = sort(unique(epcdata$epchc_station))
    ),
    selectInput("parameter", "Select Parameter:",
                choices = setNames(names(param_labels), param_labels)
    ),
    hr(),
    helpText("Select a station and parameter to view the time series plot.")
  ),
  card(
    card_header("Time Series Plot"),
    plotlyOutput("tsplot")
  )
)

server <- function(input, output, session) {
  
  # Create the plot
  output$tsplot <- renderPlotly({
    req(input$station, input$parameter)
    
    # Filter data
    plot_data <- epcdata %>%
      filter(epchc_station == input$station) %>%
      arrange(SampleTime)
    
    # Create plot
    p <- plot_ly(data = plot_data, 
                 x = ~SampleTime, 
                 y = as.formula(paste0("~", input$parameter)),
                 type = 'scatter',
                 mode = 'lines+markers',
                 name = param_labels[input$parameter]
    ) %>%
      layout(
        title = paste("Time Series for Station", input$station),
        xaxis = list(title = "Date"),
        yaxis = list(title = param_labels[input$parameter])
      )
    
    p
  })
}

shinyApp(ui, server)