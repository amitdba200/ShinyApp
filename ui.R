library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Stock Price Trend App"),
  
  sidebarPanel(
    textInput("path", "File Path:"),
    actionButton("browse", "Browse"),
    actionButton("upload", "Upload Data")
  ),
  
  mainPanel(
    plotOutput('content')
  )
  
))
