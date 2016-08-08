
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
    output$shownuminput <- renderPlot({
      getendpoint = input$numinput
      plot(1:getendpoint)
    })
    
    output$showtext <-renderText({
      htmltext = "<font color='red' size='15'>"
      htmltext = paste(htmltext, input$textinput, sep="")
      htmltext = paste(htmltext, "</font>", sep="")
      print(htmltext)
  })

})
