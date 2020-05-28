getwd()
setwd("C:/Users/GitHub/DataMining/ExamenU2")
getwd()

movies <- read.csv("Project-Data.csv")
head(movies)
colnames(movies) <- c("DayWeek", "Director", "Genre", "MovieTitle", 
                      "ReleaseDate", "Studio", "AdjustedGross", 
                      "Budget_Millions", "Gross", "IMDb", "MovieLens", 
                      "Overseas", "OverseasPercentage", "Profit", 
                      "ProfitPercentage", "Runtime", "US", "GrossPercentageUS")
head(movies)


df.movies = movies[(movies$Genre == "action"|movies$Genre == "adventure"
                    |movies$Genre == "animation"|movies$Genre == "comedy"
                    |movies$Genre == "drama")&(movies$Studio == "Buena Vista Studios"
                    |movies$Studio == "Fox"|movies$Studio == "Paramount Pictures"
                    |movies$Studio == "Sony"|movies$Studio == "Universal"
                    |movies$Studio == "WB"),]
