library(readr)
library(dplyr)
library(tidyverse)
library(readxl)
#This function will bring in the data files that relate to the treatment selected
#these files will be updated by Therese, Rick and Lynne
df1_treat_zone_x <- function(treatment_selected) {
  treatment <-  ifelse(treatment_selected == 'wetting agent', "data_sets_ripping.xlsx",
                          ifelse(treatment_selected == 'sowing on edge of row', "data_sets_ripping.xlsx",
                          ifelse(treatment_selected == 'spading with no inputs', "data_sets_ripping.xlsx",
                          ifelse(treatment_selected == 'spading with shallow inputs organic', "data_sets_ripping.xlsx",
                          ifelse(treatment_selected == 'spading with shallow inputs fertiliser', "data_sets_ripping.xlsx",      
                          ifelse(treatment_selected == 'ripping with no inputs', "data_sets_ripping.xlsx",
                          ifelse(treatment_selected == 'ripping with shallow input organic', "data_sets_ripping.xlsx",
                          ifelse(treatment_selected == 'ripping with shallow input fertiliser', "data_sets_ripping.xlsx",       
                          ifelse(treatment_selected == 'ripping with deep inputs organic', "data_sets_ripping.xlsx",
                          ifelse(treatment_selected == 'ripping with deep inputs fetiliser', "data_sets_ripping.xlsx"))))))))))
  
#bring in file for treatmnet
treat <- read_excel(treatment, sheet = "treat")
yld_resp_crop_treat <- read_excel(treatment, sheet = "yld_resp_crop_treat")
crop_price <- read_excel(treatment, sheet = "crop_price")

#these would be user defined and will be removed when shiny is working
crop_seq <- read_excel(treatment, sheet = "crop_seq")
crop_yld <- read_excel(treatment, sheet = "crop_yld")
#create a df and join parameters related to the treatment selection
df1 <- data.frame(1:10)
colnames(df1) <- "year"
df1 <- left_join(crop_seq,df1, by = 'year')
df1 <- left_join(treat,df1, by = 'year')
#step3 cal to modify the yield response reflecting when the treatment was applied
df1 <- df1 %>% 
  mutate(code = case_when(cost > 0 ~ 1,
                          cost == 0 ~ 0)) 
df1$year <- as.integer(df1$year)
df1 <- df1 %>%
  mutate(
    code = as.logical(code),
    last_event = if_else(code, true = year, false = NA_integer_)) %>%
  fill(last_event) %>%
  mutate(yr_since_app = (year - last_event)+1) %>% 
  select(year, cost, yld_resp_perct_10yrs, crop, yr_since_app)

#making temp file for a join
treat_temp <- treat %>% 
  mutate(yr_since_app = year)

df1 <- left_join(df1, treat_temp, by = 'yr_since_app') %>% 
  select(year = year.x, crop, cost = cost.x, yld_resp_since_applied
         = yld_resp_perct_10yrs.y)
df1 <- left_join(df1, yld_resp_crop_treat, by = 'crop')

return(df1)
}

df1_treat_zone_x("sowing on edge of row")

#testing method

#test <- function(treatment_selected) {
#  treatment <-  ifelse(treatment_selected == 'wetting agent', "data_sets_ripping.xlsx",
#                       ifelse(treatment_selected == 'sowing on edge of row', "data_sets_ripping.xlsx"))
#treat <- read_excel(treatment, sheet = "treat")
#return(treat)
#}
#test("sowing on edge of row")
