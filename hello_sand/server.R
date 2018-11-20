library(shiny)
library(dplyr)
shinyServer(function(input, output) {
### Reactive data frames #####
  
    df <- reactive({
    data.frame(year = 1:10,site = input$stationID)
    })
  
  df_treat <- reactive({
    (data.frame(treat = input$mangement_options))
    })
  df_depth <- reactive({
     (data.frame(depth = input$depth)) 
    })
  
  v <- reactiveValues(data=NULL)
  observeEvent(input$add_crop, {
  v$data <- add_crop("wheat")})
  
  observeEvent(input$rest, {
  v$data <- NULL})
      
  


####Display outputs####  
###Some reactive df  
    output$table1 <- renderTable({
    df()
    })
    output$table2 <- renderTable({
    df_treat()
    })
    output$table3 <- renderTable({
    df_depth()
    })
    
    
    output$table_crop <- renderText({
      if(is.null(v$data))return()
    paste0(v$data)
    })

    
    
}) #these brackets are for shiny serve at the top
  



###This was working###
#values <- reactiveValues()
#values$df <- data.frame(crop = 1)
#addData <- observe({
#  if(input$addButton>0){
#    newclm <- isolate(c(input$crop_seq_zone1))
#    isolate(values$df <- rbind(as.matrix(values$df), unlist(newclm)))
#  }
#})