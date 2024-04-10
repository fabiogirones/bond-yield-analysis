########## adding libraries and working directory ##########
library("tidyverse")
library('dplyr') 
library('readxl')

setwd("/Users/fabiogirones/projects/bond-yield-analysis")
getwd()

########## adding data ##########
Inflation_data <- read_excel("excel/Inflation.xlsx")
Interest_data <- read_excel("excel/Interest_rates.xlsx")
GDP_data <- read_excel("excel/GDP_Government.xlsx")

########## data inspection ##########
str(GDP_data)
summary(GDP_data)

str(Inflation_data)
summary(Inflation_data)

str(Interest_data)
summary(Interest_data)

########## changing the data ##########
Inflation_data <- Inflation_data %>%
  group_by(Country, Year) %>%
  summarise(mean_inflation = mean(Inflation))

arrange(Interest_data, Country, Year)
Interest_data <- arrange(Interest_data, Country, Year)

GDP_data = rename(GDP_data, Year = Time)
GDP_data = rename(GDP_data, Country = Nation)
GDP_data <- arrange(GDP_data, Country, Year)

########## saving the raw data ##########
save(Inflation_data, file = "raw/Inflation.RData")
save(Interest_data, file = "raw/Interest.RData")
save(GDP_data, file = "raw/GDP.RData")

load("raw/Inflation.RData")
load("raw/Interest.RData")
load("raw/GDP.RData")

########## merging the data ##########
Temp = merge(GDP_data, Inflation_data, by = c('Country','Year'))
Final = merge(Temp, Interest_data, by = c('Country','Year'))
rm(GDP_data, Inflation_data, Interest_data, Temp)
Final$Year <- as.character(Final$Year)
str(Final)

save(Final, file = "final/Final.RData")
load("final/Final.RData")

