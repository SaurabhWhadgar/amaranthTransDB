#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("global.r")
library(ggplot2)
library(reshape2)
library(dplyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  queryres <- eventReactive(input$searchbutton,{
    data %>% filter(grepl(input$querysearch, Ahkp_id,fixed = FALSE,ignore.case = T) | 
                      grepl(input$querysearch,Function,fixed = FALSE,ignore.case = T) |
                      grepl(input$querysearch, AT_id,fixed = FALSE,ignore.case = T))
    })

  output$queryresult <- DT::renderDataTable(queryres(),server = TRUE,filter = 'top',escape=FALSE,extension='Buttons', options=list(dom='Bfrtip',buttons=list('copy','pdf','csv'),scrollX = TRUE))
  
  
  plotdata <- eventReactive(input$plotsubmit,{
    if (is.null(input$query)) {
      return(NULL)
    } 
   melt_df<- melt(transdata[transdata$Gene_ID==input$query,])
  return(melt_df)
  })
  output$transtable <-  DT::renderDataTable(plotdata(),server = TRUE,
                                            extension='Buttons', options=list(dom='Bfrtip',buttons=list('copy','pdf','csv')))
  
  output$lineplot <- renderPlot({
    if (is.null(plotdata()))
      return(NULL) 
   p <- ggplot(plotdata(),aes(x=variable, y=value,group=1))+ geom_line(aes(color=variable))+labs(y="Normalises Read Count", x = "Developmental Stages") +geom_point(aes(color=variable))  
   plot(p)
   
  })
 

   

  
   
})
