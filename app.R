library(shiny)

ui <- fluidPage(
  titlePanel("Deux histogrammes interactifs"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("nb",
                  "Nombre de classes :",
                  min = 1,
                  max = 50,
                  value = 10)  # Le curseur contrôle le nombre de classes
    ),
    
    mainPanel(
      plotOutput("hist1"),  # Premier histogramme
      plotOutput("hist2")   # Deuxième histogramme
    )
  )
)

server <- function(input, output) {
  
  # Premier histogramme
  output$hist1 <- renderPlot({
    hist(
      mtcars$mpg,
      breaks = input$nb,
      main = "Histogramme A",
      xlab = "mpg",
      col = "skyblue",
      border = "white"
    )
  })
  
  # Deuxième histogramme
  output$hist2 <- renderPlot({
    hist(
      mtcars$hp,
      breaks = input$nb,
      main = "Histogramme B",
      xlab = "hp",
      col = "salmon",
      border = "white"
    )
  })
}

shinyApp(ui = ui, server = server)

