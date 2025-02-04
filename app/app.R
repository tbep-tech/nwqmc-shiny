library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("My awesome histogram app"),
  
  # Sidebar with a numeric input for sample size 
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = 'n', label = 'Sample size', value = 50), 
      selectInput(inputId = 'col', label = 'Choose color', choices = c('red', 'blue', 'green'))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({

    # generate random sample of size n
    x <- rnorm(input$n)
    
    # draw the histogram
    hist(x, col = input$col)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)