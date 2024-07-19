library(shiny)
library(ggplot2)

sp = read.csv("Advertising.csv")

ui <- fluidPage(
  titlePanel("Advertising Insights: Predicting Sales with Linear Regression"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Select Advertising Medium:",
                  choices = c("TV", "Radio", "Newspaper")),
      hr(),
      helpText("Explore the relationship between advertising spend and sales.")
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Scatter Plot", plotOutput("scatterPlot"))
      )
    )
  )
)


server <- function(input, output) {
  
  # Reactive expression to filter data based on selected variable
  filteredData <- reactive({
    sp[, c(input$variable, "Sales")]
  })
  
  # Scatter plot output
  output$scatterPlot <- renderPlot({
    data <- filteredData()
    ggplot(data, aes_string(x = input$variable, y = "Sales")) +
      geom_point(color = "blue") +
      labs(title = paste("Sales vs.", input$variable),
           x = input$variable,
           y = "Sales")
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

