#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(readxl)
#empty dashboard
header <-   dashboardHeader()


sidebar <-  dashboardSidebar(
            sidebarMenu(
              menuItem("Tell me more",
              tabName = "tell_me"),
              menuItem("Set up Farm",
              tabName = "set_up_farm"),
              menuItem("Results",
              tabName = "results"),
              menuItem("Extra modifications",
              tabName = "extra")
  )
)


body <- dashboardBody(
        tabItems(
        tabItem(
          tabName = "set_up_farm",
          tabBox(
            title = "Set up farm",
            tabsetPanel(
            tabPanel(h3("Zone1"),width=12), #width not working
            numericInput(
              "size_zone1",
              label = h3("Size of zone 1 (ha)"),
              value = 2500, #this needs to be total area of farm /3
              min = 100,
              max = 6000, #can't be larger than total farm area
              step =100),
            
            wellPanel(
            h3("Crop sequence for 10 years"),
            numericInput("year_seq_zone1", "Year:", 1),
            selectInput("crop_seq_zone1", "Crop type:",
                        choices = c("wheat", "barley", "canola", "grain legume", "pasture")),
            actionButton("addButton", "update"),
            #h4("create a table that gets updated with above inputs"),
            tableOutput("table")
            ),
            tabPanel(h3("Zone2", "test")),
            
            tabPanel(h3("Zone3"))
                )
    )),
    
        tabItem(
          tabName = "tell_me",
          selectInput("stationID", 
                      label = h3("Where is your farm?"),
                      choices = c("Waikerie", "Carwarp","Ouyen", "Karoonda", "Murlong", "Yenda", "Lameroo", "Bute", "Brimpton Lake", "Cadgee"), 
                      selected = "Waikerie"),
          numericInput(
            "num",
            label = h3("Total size of yor farm ha"),
            value = 2500,
            min = 100,
            max = 6000,
            step =100),
          selectInput(
            "numb_zones",
            label = h3("How many zones?"),
            choices = list("1 zone" = 1, "2 zones" = 2, "3 zones" = 3),
            selected = 1),
          checkboxGroupInput(
            "mangement_options",
            label = h3("What are you considering?"),
            choices = list("Wetting agents" = 1, "Sowing on edge of row" = 2, 
                           "Spading with no inputs" = 3, "Spading with shallow inputs" = 4,
                           "Ripping with no inputs" = 5, "Ripping with shallow inputs" = 6,
                           "Ripping with deep inputs" = 7),
            selected = 1),
          checkboxGroupInput(
            "depth",
            label = h3("Depth of ripping?"),
            choices = list("Ripping to 30 cm" = 1,"Ripping to 50 cm" = 2,
                           "Ripping to 60 cm" = 3,"Ripping to 70 cm" = 4),
            selected = 1)
                    ),
       
    
        tabItem(
        tabName = "results",
        selectInput("Results", 
              label = h3("what type of analysis are yo interested in?"),
              choices = c("cash flow for 5 years", "cash flow for 10 years","NPV", "IRR", "payback"), 
              selected = "cash flow for 5 years")  
        ),
        tabItem(
        tabName = "extra",
        selectInput("modify", 
                  label = h3("what do you want to modify?"),
                  choices = c("crop prices", "cost of wetting agents","cost of ripping", "cost of spading"), 
                  selected = "crop prices")  )
    
)
)
          







ui <- dashboardPage(header =dashboardHeader(), 
                    sidebar = sidebar, 
                    body = body
                    )


server <- function(input, output) {

  crop_rotation <- read_excel("C:/Users/ouz001/DATASCHOOL/SythProject/Progress/data_sets_as_input/data_sets.xlsx", sheet = "rotation2")
  values <- reactiveValues()
  values$df <- crop_rotation
  addData <- observe({
    
    # your action button condition
    if(input$addButton > 0) {
      # create the new line to be added from your inputs
      newclm <- isolate(c(input$crop_seq_zone1))
      # update your data
      # note the unlist of newLine, this prevents a bothersome warning message that the rbind will return regarding rownames because of using isolate.
      isolate(values$df <- rbind(as.matrix(values$df), unlist(newclm)))
      }
  })
  output$table <- renderTable({values$df}, include.rownames=F)
}

shinyApp(ui, server)

