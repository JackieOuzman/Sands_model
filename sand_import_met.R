
install.packages("RCurl")
install.packages("XML")
library(XML)
library(RCurl)

library(readr)
#dataset <- read_csv(NULL)
#View(dataset)

getSiloMet_jax <- function(name = NULL) {
  stationID <- ifelse(name == 'Waikerie', 24018,
                ifelse(name == 'Carwarp', 76005,
                ifelse(name == 'Ouyen', 76047,
                ifelse(name == 'Karoonda', 25006,
                ifelse(name == 'Murlong', 18046,
                ifelse(name == 'Yenda', 75079,
                ifelse(name == 'Lameroo', 25509,
                ifelse(name == 'Bute', 21012,
                ifelse(name == 'Brimpton Lake', 18005,
                ifelse(name == 'Cadgee', 26099))))))))))
  
  #check my apiKey it is Kvsj6LwGthiRRUoxGazEDLikHvDxh5kOJDvbRZp4
  startDate <- paste('19600101',sep='')
  finishDate <- paste('20171231',sep='')
  
  
  siloUrl <- 'https://siloapi.longpaddock.qld.gov.au/pointdata'
  siloUrl <- paste(siloUrl, '?apikey=','Kvsj6LwGthiRRUoxGazEDLikHvDxh5kOJDvbRZp4', sep='')
  siloUrl <- paste(siloUrl,'&station=',sprintf('%05d', stationID), sep='')
  siloUrl <- paste(siloUrl,'&start=', startDate, sep='')
  siloUrl <- paste(siloUrl,'&finish=', finishDate, sep='')
  siloUrl <- paste(siloUrl,'&format=CSV', sep='')
  siloUrl <- paste(siloUrl,'&variables=daily_rain,max_temp,min_temp', sep='')
  
  print(siloUrl)
  
  #dataUrl <- getURL(siloUrl)
  
  #df <- read.csv(textConnection(dataUrl),stringsAsFactors=FALSE)
  #print(dataUrl)
  #return(csvDat)
  #df <- readHTMLTable(dataUrl, stringsAsFactors = FALSE)
  #again1 <- read_csv("https://siloapi.longpaddock.qld.gov.au/pointdata?apikey=Kvsj6LwGthiRRUoxGazEDLikHvDxh5kOJDvbRZp4&station=18005&start=19600101&finish=20171231&format=CSV&variables=daily_rain,max_temp,min_temp")
  again <- read_csv(siloUrl)
  return(again)
}



getSiloMet_jax("Brimpton Lake")



#This works outside the function to load data into R 

# print(siloUrl) returns this and it works to add data into r"https://siloapi.longpaddock.qld.gov.au/pointdata?apikey=Kvsj6LwGthiRRUoxGazEDLikHvDxh5kOJDvbRZp4&station=18005&start=19600101&finish=20171231&format=CSV&variables=daily_rain,max_temp,min_temp"

point_URL <- read_csv("https://siloapi.longpaddock.qld.gov.au/pointdata?apikey=Kvsj6LwGthiRRUoxGazEDLikHvDxh5kOJDvbRZp4&station=18005&start=19600101&finish=20171231&format=CSV&variables=daily_rain,max_temp,min_temp")

test_read_fun <- function(name) {
  test_pointdata <- read_csv(name)
  return(data.frame(test_pointdata))
}

test_read_fun("C:/Users/ouz001/Downloads/pointdata 1")  

pointdata_1 <- read_csv("C:/Users/ouz001/Downloads/pointdata 1")  
