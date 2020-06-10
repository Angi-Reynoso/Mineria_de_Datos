## Instructions
Develop the following problem with R and RStudio for the knowledge extraction that the problem requires.
* Implement the K-Means grouping model with the Iris.csv dataset found at https://github.com/jcromerohdz/iris using the kmeans () method in R.
* Once the grouping model is obtained, make the corresponding data visualization analysis.
* At the end of the development, explain in detail what the K-Means grouping model consists of and what your observations were in the data visualization analysis.

 

### K-Means Clustering
K-Means is a method of grouping or clustering. Clustering is a technique for finding and classifying "K" data groups (clusters). Thus, the elements that share similar characteristics will be together in the same group, separated from the other groups with which they do not share characteristics.

## Steps
**1. Set working directory**
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/Examen U4")
getwd()
~~~  
> Use `getwd ()` to find out the current path.
> With `setwd ()` you specify the path on which you want to work.
> We use `getwd ()` again to check the correct change of the current path.

**2. Import the dataset**
~~~
dataset = read.csv('iris.csv')
dataset = dataset[3:4]
~~~  
> The file is loaded with the dataset: iris.csv.
> The columns with which you want to work are specified, in this case 3 and 4.

**3. Elbow Method**  
The _elbow method_ helps us to find the optimal number of clusters (groups) to use. 
~~~
set.seed(6)
wcss = vector()
for (i in 1:10) wcss[i] = sum(kmeans(dataset, i)$withinss)
plot(1:10,
     wcss,
     type = 'b',
     main = paste('The Elbow Method'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')
~~~  

> We randomize the data with the `seed ()` function.
> An empty vector is created to store the results obtained from each cluster number tested.
> Using a for loop, and using the `kmeans ()` function, the sum of squares within each cluster is calculated, and the results are stored within the previously created vector (wcss).
> After calculations are complete, the `plot ()` function is used to display the results in the form of a line graph:
> * _1: 10_ = Number of results to display.
> * _wcss_ = Vector with the results.
> * _type 'b'_ = Line and point graph.
> * _main_ = Name of the graph.
> * _xlab_ = Name of the x axis.
> * _ylab_ = Name of the y axis.

The resulting graph is as follows:
 
 <img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_3/Images/ExamU4 - Elbow Method.png" width = "65%">  
> As a result, it is obtained that the optimal cluster number is 3; This can be seen in the graph through the small "fluctuation" that exists on this point, compared to the direction that the rest of the line has.

**4. Fit K-Means to the dataset**
~~~
set.seed(29)
kmeans = kmeans(x = dataset, centers = 3)
y_kmeans = kmeans$cluster
~~~  
> Again, data is randomized with the `seed ()` function.
> Use the `kmeans ()` function to create the model:
> * _x_ = data to use (dataset).
> * _centers_ = number of k, clusters or groups (the value obtained in the previous step is taken).

> Once the model is created, it is used to classify the data using `kmeans $ cluster`.
> The result obtained from the previous step is a vector of integers (from 1 to k) that indicates the group to which each point is assigned (dataset data).
> When printing the variable where the classification is stored, we would obtain something like the following:
~~~
> y_kmeans
  [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
 [39] 3 3 3 3 3 3 3 3 3 3 3 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 [77] 1 2 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 1 2 2 2 2 2 2 2
[115] 2 2 2 2 2 1 2 2 2 1 2 2 1 1 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2
~~~  
> In this case, if the results of the classification are compared with those of the original dataset, it is obtained that 9 points were classified erroneously, which corresponds to a 94% level of accuracy of the model.

**5. Visualization of clusters (groups)**  
~~~
install.packages('cluster')
library(cluster)
clusplot(dataset,
         y_kmeans,
         lines = 0, 
         shade = TRUE, 
         color = TRUE, 
         labels = 2,
         plotchar = FALSE, 
         span = TRUE, 
         main = paste('Clusters of Iris'), 
         xlab = 'Petal Length',
         ylab = 'Petal Width')
~~~  

> First we install and import the `cluster` library to be able to graphically view the results of the model classification.
> We use the `clusplot` function, which is used to draw a two-dimensional" clusplot "or clustering diagram, on the current graphics device.
> * _dataset_ = Data to use (dataset).
> * _y_kmeans_ = Classification of the data.
> * _lines_ = Option to draw lines between the centers of the groups in the graph.
> * "0" = disabled.
> * "1" = draw on top.
> * "2" = draw below.
> * _shade_ = Put ​​shading inside the group figures (diagonal lines).
> * _color_ = Use different colors for each group.
> * _labels_ = Type of labels to use for groups.
> * "2" = Data and group numbers.
> * "3" = Only data numbers.
> * "4" = Group numbers only.
> * _plotchar_ = Use different figures for data within groups.
> * _span_ = Create gaps between groups.
> * _main_ = Graph title (`paste` is used to concatenate string type strings).
> * _xlab_ = Title of the x axis.
> * _ylab_ = Title of the y axis.

The resulting graph is as follows:
<img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_3/Images/ExamU4 - Petal.png" width = "65%">

### Conclusion
With the previous graph we can check the errors that were identified during step 4, since unlike group number 3 (in pink), groups 1 (in blue) and 2 (in red) have an intersection, inside from which the data that were misclassified could be found.
However, the percentage of error obtained is minimal, therefore, it can be said that the model works quite well for the most part.

<br>

---

### Extra Observations
For the application of the model, only 2 variables were requested, one for the x-axis and the other for the y-axis, however within the original dataset there were 4 columns (not including the data classifications), so we chose to separate the variables in sets of 2, and do tests with each set to verify which was the one that obtained better results.
From the previous graph and the data already presented, it is known that the best option was the one where the variables were used: petal_length and petal_width, however, as additional evidence, the results of the classifications made by the model for the second set: sepal_lenght and sepal_width.

Classification results in y_kmeans: _27 erroneous data, 82% level of accuracy_.
~~~
> y_kmeans
  [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
 [39] 3 3 3 3 3 3 3 3 3 3 3 3 2 2 2 1 2 1 2 1 2 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 2 2
 [77] 2 2 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 2 2 2 1 2 2 2 2 2 2 1
[115] 1 2 2 2 2 1 2 1 2 1 2 2 1 1 2 2 2 2 2 1 1 2 2 2 1 2 2 2 1 2 2 2 1 2 2 1
~~~  

Resulting graphs:

<img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_3/Images/ExamU4 - Elbow Method2.png" width = "65%">

<img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_3/Images/ExamU4 - Sepal.png" width = "65%">

> In this case, the graph for the elbow method does not vary much from the previous one, also obtaining 3 as the optimal number of clusters. However, the graph that corresponds to the classification of the data, if it varies enough, starting from the fact that with this data set the 3 groups have an intersection with some other:
> * Group 3 (in blue color) intersects with group 1 (in pink color).
> * Group 1 (in pink) intersects with group 2 (in red).

> This demonstrates the reason for the increase in the number of errors, thus remaining well below the results obtained with the previous set (petal_length and petal_width).
