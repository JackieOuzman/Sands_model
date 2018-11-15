install.packages("lubridate")
install.packages("stringr")
install.packages('DT') 
library(ggplot2)
library(readr)
library(dplyr)
library(lubridate)
library(stringr)
library(tidyverse)
library(DT)

setwd("C:/Users/ouz001/DATASCHOOL/SythProject/Progress/output_met")


cal_water_avail <- function(met_file) {

rainfall <- read_table2("met_file_template24018.txt", 
                        skip = 35)
#remove second line select clm and set date 
rainfall_1 <- slice(rainfall,-1:-1)
rainfall_1 <- select(rainfall_1, Date, Day, Rain, Date2)
rainfall_1$Date3 <- as.Date(rainfall_1$Date2, "%d/%m/%Y")
rainfall_1$Rain <- as.double(rainfall_1$Rain)
#Create new clm month and year
rainfall_1$Month <- as.Date(rainfall_1$Date2, "%d/%m/%Y")
rainfall_1$Year <- as.Date(rainfall_1$Date2, "%d/%m/%Y")

rainfall_1$Month <- months.Date(rainfall_1$Month)
rainfall_1$Year <- year(rainfall_1$Year)
#create new clm that is month and year
rainfall_1$Month_Yr <- as.character(rainfall_1$Date3, format="%b-%Y")
#recode the months into summer rainfall or GS rainfall
rainfall_1$rain_season <- recode(rainfall_1$Month , "January" = "summer", 
                                 "February" = "summer",
                                 "March" = "summer",
                                 "April" = "GS",
                                 "May" = "GS",
                                 "June" = "GS",
                                 "July" = "GS",
                                 "August" = "GS",
                                 "September" = "GS",
                                 "October" = "GS",
                                 "November" = "summer",
                                 "December" = "summer")

#use aggreate function to sum the rain clm by year and rain season making a new df
sum_yr_rain_season <- aggregate(Rain~ Year+rain_season , data = rainfall_1, FUN= sum)


#cal new clm with summer rainfall to be *0.25
sum_yr_rain_season$Rain_GS_summer <- 
  with(sum_yr_rain_season, 
       ifelse(rain_season == 'summer', Rain*0.25,Rain))

#use aggreate function to sum the summer_rain0.25 clm by year making a new df
water_aval <- aggregate(Rain_GS_summer~ Year, sum_yr_rain_season, FUN= sum)
return(water_aval)
}


#use this one - its loaded already  "met_file_template24018.txt"
#Agian still not returning what I am expecting...will if you assign it to variable
try <- cal_water_avail("met_file_template24018.txt")





