sidebarModuleUI <- function(id) {
  ns <- NS(id)
  sidebarPanel(
    h3("App Introduction"),
    p("This is a modularized Shiny app."),
    p("Select a dataset to view summary and visualization.")
  )
}

sidebarModule <- function(input, output, session) {
  
}
