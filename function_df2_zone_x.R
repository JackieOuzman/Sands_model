library(readr)
library(dplyr)
library(tidyverse)
library(readxl)
#This function will bring in the data files that relate to the zone selected from shiny
#for now its just pulling in data from excel file with the parameters I want
#How to go about assigning name of the file to reflects the inputs
#I think I want a file name that is df2_zone_2 ... 
#or should I have it in the file itself eg clm with the zone?
df2_zone_x <- function(zone_selected) {
  zone <-  ifelse(zone_selected == 'zone1', "data_sets_ripping.xlsx",
                ifelse(zone_selected == 'zone2', "data_sets_ripping.xlsx",
                ifelse(zone_selected == 'zone3', "data_sets_ripping.xlsx")))
  
  #these would be user defined and will be removed when shiny is working
crop_price <- read_excel(zone, sheet = "crop_price")
crop_seq <- read_excel(zone, sheet = "crop_seq")
crop_yld <- read_excel(zone, sheet = "crop_yld")  
df2 <- crop_seq
df2 <- left_join(df2, crop_yld, by = 'crop')
df2 <- left_join(df2, crop_price, by = 'crop')
  return(df2)
}

df2_zone_x <- df2_zone_x("zone1")
