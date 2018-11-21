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

#this is the list of all tabs in the app
sidebar <-  dashboardSidebar(
            sidebarMenu(
              menuItem("Tell me more",
              tabName = "tell_me"),
              menuItem("Set up farm",
              tabName = "set_up_farm"),
              menuItem("Costs",
              tabName = "costs"),
              menuItem("Extra modifications",
              tabName = "extra"),
              menuItem("Results",
              tabName = "results")
              
              
  )
)


body <- dashboardBody(
        
  tabItems(
    
    
    
#the first tab    
    
    tabItem(
      tabName = "tell_me",
      selectInput("stationID", 
                  label = h3("Where is your farm?"),
                  choices = c("Waikerie", "Carwarp","Ouyen", "Karoonda", "Murlong", "Yenda", "Lameroo", "Bute", "Brimpton Lake", "Cadgee"), 
                  selected = "Waikerie"),
      numericInput(
        "total_size_farm",
        label = h3("Total size of yor farm ha"),
        value = 2500,
        min = 100,
        max = 6000,
        step =100),
      radioButtons(
        "numb_zones",
        label = h3("How many zones?"),
        choices = list("1 zone" = 1, "2 zones" = 2, "3 zones" = 3),
        selected = 1),
      wellPanel(
      checkboxGroupInput(
        "mangement_options",
        label = h3("What are you considering?"),
        choices = list("Wetting agents" = "wetter", 
                       "Sowing on edge of row" = "sow_edge", 
                       "Spading with no inputs" = "spade_no_inputs", 
                       "Spading with shallow organic inputs" = "spade_organic",
                       "Spading with shallow fertiliser as inputs" = "spade_fert",
                       "Ripping with no inputs" = "rip_no_inputs",
                       "Ripping with shallow organic inputs"= "rip_shallow_organic",
                       "Ripping with shallow fertiliser as inputs" = "rip_shallow_fert",
                       "Ripping with deep organic inputs"= "rip_deep_organic",
                       "Ripping with deep fertiliser as inputs" = "rip_deep_fert"), 
        selected = "sow_edge"),
        radioButtons(
        "depth",
        label = h4("Depth of ripping?"),
        choices = list("Ripping to 30 cm" = "30",
                       "Ripping to 50 cm" = "50",
                       "Ripping to 60 cm" = "60",
                       "Ripping to 70 cm" = "70"),
        selected ="30")
      ) #well pannel
    ),   
    
    
    
#The second tab
    tabItem(
      tabName = "set_up_farm",
      
        
        tabsetPanel(
          tabPanel(h3("Zone1"),width=12), #width not working
          numericInput(
            "size_zone1",
            label = h4("Size of zone 1 (ha)"),
            value = 2500, #this needs to be total area of farm /3
            min = 2500,
            max = 6000, #can't be larger than total farm area
            step =100),
          
          wellPanel(
            h4("Crop sequence for 10 years"),
            #numericInput("year_seq_zone1", "Year:", 1),
            selectizeInput("crop_seq_zone1", 
                           label = "Crop type:",
                           choices = list("wheat", "barley", "canola", 
                                          "grain legume", "pasture"),
                           options = list(maxItems = 10,hideSelected = TRUE),
                           multiple = TRUE),
           # https://stackoverflow.com/questions/48932543/shiny-multiple-select-input-select-choice-many-times
                           
            actionButton("addButton", "update"),
            actionButton("reset", "clear"),
            #h4("create a table that gets updated with above inputs"),
            tableOutput("table")
          ),
          
          tabPanel(h3("Zone2")),
          
          tabPanel(h3("Zone3"))
        
      )),
    
    
    
    
    
    

#the thrid tab


tabItem(
  tabName = "costs",
  h3("Upfront costs for treatments selected:"),
  h6("(Annual cost $/ha)"),
  numericInput("costs on treatment", 
             label = h4("For xxx with XX inputs and depth of XX"),
              value = 80, 
              min = 0,
              max = 2000,
              step = 10),
  
  selectizeInput("year_for_treatment", 
             label = h4("Treaments applied in which year?"),
             choices = list('before analysis'= "0",
                             'year 1' = "1",
                             'year 2' = "2",
                             'year 3' = "3",
                             'year 4' = "4",
                             'year 5' = "5",
                             'year 6' = "6",
                             'year 7' = "7",
                             'year 8' = "8",
                             'year 9' = "9",
                             'year 10' = "10"),
             multiple = TRUE),
 
  h6("Note we suggets assigning ripping cost at year 0"),
  h6("Note costs for wetting agents applied and ... applied every year"),
  
  
  h3("Inseason costs for treatments selected:"),
  h6("(Average annual change in costs $/ha)"),
  numericInput("inseason_cost", 
               label = h4("For xxx with XX inputs and depth of XX"),
               value = 80, 
               min = 0,
               max = 2000,
               step = 10),
  
  h6("Note: inseason costs are likey to change with some treatment,"),
  h6("for example we fertiliser, seeding rates and other costs may change if ripping with inputs was implmented"),
  h6("this 'Average annual change in costs $/ha)' is an overall estimate how of variable costs will change.")
  
), #this is the tabItem bracket



#the fourth tab   
        tabItem(
        tabName = "results",
        selectInput("Results for", 
              label = h3("Over how many years?"),
              choices = c("5 years" = "5yrs", "10 years" ="10yrs"), 
              selected = "5 years"),
        checkboxGroupInput("analysis", 
                    label = h3("What analysis?"),
                    choices = c("Undiscounted annual cash flow" = "cashflow_no_disc",
                                "discounted annual net cash flow" ="cashflow_disc_ann",
                                "Cummulative discounted cash flow" ="cashflow_cum_disc",
                                "Cummulative ROI not discounted" ="ROI_cum_no_disc",
                                "Cummulative ROI discounted" ="ROI_cum_disc",
                                "Benefit:Cost Ratio (discounted)" ="benefit_cost_ratio_disc",
                                "Net Present Value" ="NPV",
                                "Modified Internal Rate Return" ="MIRR"),
                                selected = "cashflow_disc_ann")
        ),


    
    
    
    
#the fifth tab
     tabItem(
        tabName = "extra",
        selectInput("modify", 
                  label = h3("what do you want to modify?"),
                  choices = c("crop prices", "cost of wetting agents","cost of ripping", "cost of spading"), 
                  selected = "crop prices")  )




#brackets for the tabItems dashboard    
)
)

          



#Display of the Ui



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

