library(DT)


summaryTabUI <- function(id) {
  ns <- NS(id)
  tabPanel(
    "Summary",
    radioButtons(ns("dataset"), "Select Dataset", choices = c("Iris", "Mtcars")),
    tabsetPanel(
      tabPanel("Table", dataTableOutput(ns("table"))),
      id = "summaryTabset"
    )
  )
}

summaryTabServer <- function(input, output, session) {

  data <- reactive({
    if (input$dataset == "Iris") {
      iris
    } else {
      mtcars
    }

  })
  
  observeEvent(input$dataset, {
    output$table <- renderDataTable({
      data()
    })
  })
  
  return(data)
}

