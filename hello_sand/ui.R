#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#library(shinydashboard)
#library(shinyWidgets)
#library(readxl)

#this is not using the shiny dashbaord - but the layout is better
#how to get this fluid page layout with dashboard??

ui <- fluidPage(
  titlePanel("Tell me more about your farm"),
  sidebarLayout(
    sidebarPanel(
    hr(),
  
    selectInput("stationID", 
              label = h4("Where is your farm?"),
              choices = c("Waikerie", "Carwarp","Ouyen", "Karoonda", 
                          "Murlong", "Yenda", "Lameroo", "Bute", "Brimpton Lake", "Cadgee"), 
              selected = "Waikerie"),
    
    checkboxGroupInput(
      "mangement_options",
      label = h3("What are you considering?"),
      choices = list("Wetting agents" = "wetting_agent", "Sowing on edge of row" = "sow_edge", 
                     "Spading with no inputs" = "spade_no_input", 
                     "Spading with shallow inputs" = "spade_shallow_input",
                     "Ripping with no inputs" = "rip_no_input", 
                     "Ripping with shallow inputs" = "rip_shallow_input",
                     "Ripping with deep inputs" = "rip_deep_input"),
                      selected = "wetting_agent"),
    
    checkboxGroupInput(
      "depth",
      label = h3("Depth of ripping?"),
      choices = list("Ripping to 30 cm" = "to30","Ripping to 50 cm" = "to50",
                     "Ripping to 60 cm" = "to60","Ripping to 70 cm" = "to70"),
                      selected = "to30"),
    
    h3("Crop sequence for 10 years"),
    
    
    selectInput("crop_seq_zone1", "Crop type:",
                choices = c("wheat", "barley", "canola", "grain legume", "pasture")),
    actionButton("add_crop", "add"),
    actionButton("reset", "clear"),
    textOutput("table_crop")
    ),
    
    
  
    mainPanel(
      tableOutput("table1"), #site
      tableOutput("table2"), #list of treatmnets
      tableOutput("table3")  #ripping depth
      
      )
    ))
 


