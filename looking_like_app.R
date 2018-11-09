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
            tabPanel(h3("Zone1")),
            numericInput(
              "size_zone1",
              label = h3("Size of zone 1 (ha)"),
              value = 2500, #this needs to be total area of farm /3
              min = 100,
              max = 6000, #can't be larger than total farm area
              step =100),
            selectInput(
              "crop_sequ_wheat",
              label = h5("Years for wheat:"),
                               choices = c("Year 1", "Year 2", "Year 3", "Year 4", "Year 5",
                                           "Year 6", "Year 7", "Year 8", "Year 9", "Year 10"),
                               selected = 1,
                               multiple = TRUE),
            selectInput(
              "crop_sequ_barley",
              label = h5("Years for barley:"),
              choices = c("Year 1", "Year 2", "Year 3", "Year 4", "Year 5",
                          "Year 6", "Year 7", "Year 8", "Year 9", "Year 10"),
              selected = 1,
              multiple = TRUE), 
            selectInput(
              "crop_sequ_canola",
              label = h5("Years for canola:"),
              choices = c("Year 1", "Year 2", "Year 3", "Year 4", "Year 5",
                          "Year 6", "Year 7", "Year 8", "Year 9", "Year 10"),
              selected = 1,
              multiple = TRUE),
            selectInput(
              "crop_sequ_legume",
              label = h5("Years for legume:"),
              choices = c("Year 1", "Year 2", "Year 3", "Year 4", "Year 5",
                          "Year 6", "Year 7", "Year 8", "Year 9", "Year 10"),
              selected = 1,
              multiple = TRUE),
            tabPanel(h3("Zone2")),
            tabPanel(h3("Zone3"))
                )
    ),
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
            label = h3("Depth for spading or ripping?"),
            choices = list("Spading to 10 cm" = 1, "Spading to 20 cm" = 2, 
                           "Spading to 30 cm" = 3, "Spading to 50 cm" = 4,
                           "Spading to 60 cm" = 5, "Spading to 70 cm" = 6,
                           "Ripping between 30 cm" = 7,"Ripping between 50-70 cm" = 8),
            selected = 1)
                    )
        )
)
        
        



ui <- dashboardPage(header =dashboardHeader(), 
                    sidebar = sidebar, 
                    body = body
                    )


server <- function(input, output) { }

shinyApp(ui, server)

