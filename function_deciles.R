####DECILE YEARS#####

decile <- function(yield_pot) {
  yield_pot1 <- yield_pot %>% 
    mutate(test_name = percent_rank(Rain_GS_summer))
  yield_pot1$test_name <- round(yield_pot$test_name,2)
  
  #Assign label to df for decile
  yield_pot1 <- yield_pot1 %>% 
    mutate(Decile = ifelse(test_name < 0.1, "Decile1",
                    ifelse(test_name >= 0.1 & test_name <= 0.2, "Decile2",
                    ifelse(test_name >= 0.2 & test_name <= 0.3, "Decile3",
                    ifelse(test_name >= 0.3 & test_name <= 0.4, "Decile4",                         
                    ifelse(test_name >= 0.4 & test_name <= 0.5, "Decile5",                         
                    ifelse(test_name >= 0.5 & test_name <= 0.6, "Decile6",                         
                    ifelse(test_name >= 0.6 & test_name <= 0.7, "Decile7",                        
                    ifelse(test_name >= 0.7 & test_name <= 0.8, "Decile8",      
                    ifelse(test_name >= 0.8 & test_name <= 0.9, "Decile9","Decile10"))))))))))      
  
  count(yield_pot,Decile)
  str(yield_pot)
  
  Analogue_yrs <- yield_pot1 %>% 
    group_by(Decile) %>% 
    summarize(Year = paste(sort(unique(Year)),collapse=", "))
  
  Analogue_yrs$Decile <- factor(Analogue_yrs$Decile, c("Decile1", 
                                                       "Decile2", 
                                                       "Decile3", 
                                                       "Decile4", 
                                                       "Decile5",
                                                       "Decile6",
                                                       "Decile7",
                                                       "Decile8",
                                                       "Decile9",
                                                       "Decile10"))
  
  
  Analogue_yrs <- arrange(Analogue_yrs, xtfrm(Decile))
  
  ###mess about with tables####
  
  return(datatable(Analogue_yrs))
}

