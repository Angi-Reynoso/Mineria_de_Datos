# Method 1: Select the file manually
stats <- read.csv(file.choose())
stats

# Method 2: Set Working Directory and Read Data
getwd()
#windows
setwd("C:/Users/user hp/Documents/GitHub/DataMining/DataMining-master/Dataframes")
#Mac
setwd()
setwd("/home/chris/Documents/itt/Enero_Junio_2020/Mineria_de_datos/DataMining/Dataframes")
getwd()
rm(stats)
stats <- read.csv("Demographic-Data.csv")
stats

#Practice 5
#Filter countries by Low income
stats[stats$Income.Group == "Low income",]

#Filter countries by Lower middle income
stats[stats$Income.Group == "Lower middle income",]

#Filter countries by Upper middle income
stats[stats$Income.Group == "Upper middle income",]

#Filter by countrie Malta
stats[stats$Country.Name == "Malta",]

#Filter by countrie Qatar
stats[stats$Country.Name == "Qatar",]

#Filter by countrie Netherlands
stats[stats$Country.Name == "Netherlands",]

#Filter by countrie Norway
stats[stats$Country.Name == "Norway",]
