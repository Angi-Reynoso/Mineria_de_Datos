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

windowsFonts("Comic Sans MS" = windowsFont("Comic Sans MS"))

library(ggplot2)
ggplot(df.movies, aes(x = Genre, y = GrossPercentageUS)) + 
  geom_jitter(aes(color = Studio, size = Budget_Millions)) + 
  geom_boxplot(alpha = 0.7) + 
  xlab("Genre") + ylab("Gross % US") + 
  ggtitle("Domestic Gross % by Genre") + 
  theme(axis.title.x = element_text(color = "blue",
                                    size = 17,
                                    family = "Comic Sans MS"),
        axis.title.y = element_text(color = "blue", 
                                    size = 17,
                                    family = "Comic Sans MS"),
        axis.text.x = element_text(family = "Comic Sans MS", 
                                   size = 12),
        axis.text.y = element_text(family = "Comic Sans MS", 
                                   size = 12),
        legend.title = element_text(family = "Comic Sans MS", 
                                    size = 14),
        legend.text = element_text(family = "Comic Sans MS"),
        plot.title = element_text(color = "black",
                                  size = 23,
                                  hjust = 0.5,
                                  family = "Comic Sans MS"))
