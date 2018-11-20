#For my app this is what my dataset look like

df1 <- data.frame(year = 1:10, site = "site")

##? I think I want a list of treatmnet that the user has selected
## then look at making a loop? to generate data tables for each treatment??
# would this be the best method??


df2_treat <- data.frame(treat = c('wetting_agent', 'sow_edge,spade_no_input', 'spade_shallow_input',
           'rip_no_input', 'rip_shallow_input', 'rip_deep_input'))

#This flips the treatment list but removes the column headings
df2_treat_t <- t(data.frame(treat = c('wetting_agent', 'sow_edge,spade_no_input', 'spade_shallow_input',
                                  'rip_no_input', 'rip_shallow_input', 'rip_deep_input')))


library(dplyr)

crop_seq <- data.frame(crop = c("wheat", "barley", "canola", "grain legume", "pasture", 
                       "wheat","barley","canola","grain legume","pasture"))

value <- data.frame(crop="a")
glimpse(value)
value <- bind_rows(value, crop_seq)
glimpse(value)
#remove the first row
value <- slice(value,2:11)
 

                     
                     
values <- data.frame(crop = 1:10)
print(crop_seq_test)
#addData <- 
  newclm <- (c(crop_seq))
  print(newclm)
  test <- unlist(newclm)
  print(test)
  #values$df <- rbind(as.matrix(values$df), unlist(newclm)))
  values <- rbind(as.matrix(values), unlist(newclm)))




 ## what is working in app
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