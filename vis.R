library(ggplot2)
library(plotly)

visualizationTabUI <- function(id) {
  ns <- NS(id)
  tabPanel(
    "Visualization",
    selectInput(ns("xVar"), "X-Axis Variable", choices = names(iris)),
    selectInput(ns("yVar"), "Y-Axis Variable", choices = names(iris)),
    selectInput(ns("colorVar"), "Color Variable", choices = names(iris)),  
    actionButton(ns("updatePlotBtn"), "Visualize"),
    plotlyOutput(ns("scatterPlot"))
  )
}

visualizationTabServer <- function(input, output, session, dataset_used) {
  
  data <- reactive({dataset_used()})

  observe({
    if(identical(data(), iris)){
      updateSelectInput(session, "xVar", choices = names(iris))
      updateSelectInput(session, "yVar", choices = names(iris),selected = names(iris)[3])
      updateSelectInput(session, "colorVar", choices = names(iris),selected = names(iris)[5]) 
    } else if(identical(data(), mtcars)){
      updateSelectInput(session, "xVar", choices = names(mtcars))
      updateSelectInput(session, "yVar", choices = names(mtcars),selected = names(mtcars)[5])
      updateSelectInput(session, "colorVar", choices = names(mtcars),selected = names(mtcars)[3]) 
    }
  })
  
  updatedPlot <- eventReactive(input$updatePlotBtn, {
    data <- dataset_used
    plot_ly(data=data(), x=~get(input$xVar), y=~get(input$yVar), color=~get(input$colorVar), colors='Set2', type='scatter', mode='markers') %>%
      layout(xaxis = list(title = input$xVar), yaxis = list(title = input$yVar)) %>% colorbar(title = input$colorVar)
  })
  
  output$scatterPlot <- renderPlotly({
    updatedPlot()
  })
  

}
