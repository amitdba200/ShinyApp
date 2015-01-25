library(shiny)

shinyServer(function(input, output, session) {
  
  observe({
    
    if (input$browse == 0) return()
    
    updateTextInput(session, "path",  value = file.choose())
  })
  
  contentInput <- reactive({ 
    
    if(input$upload == 0) return()
    isolate({
    data<-read.csv(input$path)
    ##data<-data.frame((paste(readLines(input$path), collapse = "\n")))
    data<-transform(data, Year = as.numeric(Year), 
              Price = as.numeric(Price))
    plot(data, type="o", col="blue")    
    # Create a title with a red, bold/italic font
    title(main="Stock Price Trend", col.main="black", font.main=4)
    })
  })
  
  output$content <- renderPlot({
    contentInput()
  })
  
})
