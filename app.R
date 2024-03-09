library(shiny)
library(shinythemes)
source("vis.R")
source("dataset.R")


ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Visualisation in Shiny"),
  sidebarPanel(
    h3("App Introduction"),
    p("This is a modularized Shiny app."),
    p("Select a dataset to view summary and visualization.")
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Summary", summaryTabUI("summary")),
      tabPanel("Visualization", visualizationTabUI("visualization"))
    )
  )
)

server <- function(input, output, session) {
  dataset <- callModule(summaryTabServer, "summary")
  callModule(visualizationTabServer, "visualization", dataset_used=dataset)
}

shinyApp(ui, server)
