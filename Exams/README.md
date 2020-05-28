## Instructions  
Develop the following problem with R and RStudio for the knowledge extraction that the problem requires.  

**Description**  
The directors of the movie review website are very happy with their previous delivery and now they have a new requirement for you.  
The previous consultant had created a chart for them that is illustrated in the following image.  

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Exam_OriginalGraphic.png" width="65%">  

However, the R code used to create the graph has been lost and cannot be recovered.  
Your task is to create the code that will recreate the same table making it look as close to the original as possible.  
You will be provided with a new data set.  

**Hint**  
Please keep in mind that not all Genres and Studio are used.  
You will need to filter your dataframe after importing the csv file.  
<br>

## Solution  
**1. Set working directory**  
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/ExamenU2")
getwd()
~~~  

**2. Load the dataset**  
~~~
movies <- read.csv("Project-Data.csv")
head(movies)
~~~  
> The dataset to be used is stored inside the variable movies, and the function `head` is used to display the data of the first rows of it.  

**3. Rename dataset columns**  
~~~
colnames(movies) <- c("DayWeek", "Director", "Genre", "MovieTitle", 
                      "ReleaseDate", "Studio", "AdjustedGross", 
                      "Budget_Millions", "Gross", "IMDb", "MovieLens", 
                      "Overseas", "OverseasPercentage", "Profit", 
                      "ProfitPercentage", "Runtime", "US", 
                      "GrossPercentageUS")
head(movies)
~~~  
> The `colnames` function is used to rename all the columns within the dataset, this serves to eliminate spaces and special characters that could come in the original dataset, and that could cause conflicts in later steps.  
> The `head` function is used again to check that the titles have been changed correctly.  

**4. Filter the dataset**  
~~~
df.movies = movies[(movies$Genre == "action"|movies$Genre == "adventure"
                    |movies$Genre == "animation"|movies$Genre == "comedy"
                    |movies$Genre == "drama")&(movies$Studio == "Buena Vista Studios"
                    |movies$Studio == "Fox"|movies$Studio == "Paramount Pictures"
                    |movies$Studio == "Sony"|movies$Studio == "Universal"
                    |movies$Studio == "WB"),]
~~~  
> For graphics only the genres of action, adventure, animation, comedy and drama are needed, as well as Buena Vista, Fox, Paramount Pictures, Sony, Universal and WB studios.  
> To take only those data that match these characteristics, conditions are used, where if these are met, the data is saved in the `df.movies` dataset.  

**NOTE: Font Family (Typeface)**  
~~~
windowsFonts("Comic Sans MS" = windowsFont("Comic Sans MS"))
~~~  
> In the case of windows, it is necessary to use the `windowsFonts` function to be able to use within R the different fonts that the operating system has (for example Comic Sans MS).  

**6. Data visualization (Generation of the graph)**  
~~~
library(ggplot2)
ggplot(df.movies, aes(x = Genre, y = GrossPercentageUS)) + 
  geom_jitter(aes(color = Studio, size = Budget_Millions)) + 
  geom_boxplot(alpha = 0.7) + 
  geom_smooth(method = "loess", formula = y ~ x) + 
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
~~~  
> We load the `ggplot2` library in order to generate the graph.  
> We use the `ggplot` function to indicate the origin of the data to be plotted, as well as the data corresponding to each axis (x = Genre, y = GrossPercentageUS).  

> We use the `geom_jitter` function to graph the data as points, however, unlike other functions, it helps us better manage over-exploitation caused by discretion in small data sets, by adding a small amount of random variation to the location of each point.  
As arguments, color and size are specified; in this case the first will be assigned according to the study, and the second according to the budget in millions.  

> The `geom_boxplot` function is in charge of creating the box or candle graphs, and the` alpha` argument is used to assign the level of transparency that the figure will have within the graph; This helps us so that the points generated by the `geom_jitter` can still be seen.  

> `xlab` and` ylab` serve to specify the names of each axis in the graph.  
> The `ggtitle` function allows us to add a name to the graph.  

> The `theme` function is used to specify values such as labels, headings, and font styles.  
> `axis.title` allows us to modify aesthetic characteristics for the titles of the x and y axes, however, it is also necessary to use the` element_text` function to specify the values of the characteristics to modify, for example:  
> * Color: `color`  
> * The font size: `size`  
> * Typeface: `family`  
> * The horizontal position of the text: `hjust`  
> * The vertical position of the text: `vjust`  
> * The font type (bold, italic): `face`  

> `axis.text` allows us to modify the aesthetic characteristics of the text displayed on the x and y axes; As in the previous case, you need to use the `element_text` function.  
> `legend.title` allows us to modify aesthetic characteristics for the titles of the information boxes used within the graph; you need to use the `element_text` function, just like in the previous cases.  
> `legend.text` allows us to modify the aesthetic characteristics of the text found within the information boxes used in the graph; you also need to use the `element_text` function.  
> `plot.title` allows us to modify the aesthetic characteristics belonging to the title of the entire graph; you also need to use the `element_text` function.  

The following is the resulting graph:  

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Exam_Boxplot.png" width="85%">  

**Conclusion**  
The action genre is the one with the largest number of films, as well as the highest budgets, however, according to what is seen in the graph, the comedy genre is the one that has (on average), the higher gross percentage.  
On the other hand, drama and adventure genres have the lowest amounts of movies, and of all, adventure is the genre with the lowest gross percentage (on average).  
Regarding studies:  
* Paramount Pictures is the one with the fewest movies.  
* WB and Buena Vista Studios have the highest budgets.  
* Buena Vista Studios produces mostly movies from the animation and action genres.  
* Fox produces mostly movies in the action, animation, and adventure genres.  
* Paramount Pictures produces mostly movies in the action and drama genres.  
* Sony produces mostly movies in the action and comedy genres.  
* Universal produces mostly movies in the action and comedy genres.  
* WB Pictures produces mostly movies of the action and adventure genres.  

