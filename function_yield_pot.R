

cal_yld_pot_wheat <- function(evaporation) {
  
  #Evaporation set at 60
  yield_pot <- water_aval %>% 
    mutate(FS_yld_pot = (((Rain_GS_summer-evaporation)*22)*1.12)/1000) 
}

# Add function as above for cal_yld_pot_barley
# Add function as above for cal_yld_pot_canola
# Add function as above for cal_yld_pot_other?


