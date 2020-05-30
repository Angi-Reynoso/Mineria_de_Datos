# Random Forest Classification
<br>

**1. Set Workspace**  
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/MachineLearning/RandomForest")
getwd()
~~~  

**2. Importing the dataset**  
~~~
dataset = read.csv('Social_Network_Ads.csv')
dataset = dataset[3:5]
~~~  
> We load the file with the dataset and we indicate that we only want to work with columns from 3 to 5.   

**3. Encoding the target feature as factor**  
~~~
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))
~~~  
> With the help of the `factor` function we specify the column of the dataset to predict.  
> `factor` is used to encode a vector as a factor. `levels` is an optional vector of the unique values (as character strings) that x might have taken.   

**4. Splitting the dataset into the Training set and Test set**  
~~~
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
~~~  
> We load the caTools library, create the seed to randomize the data, divide the data 75% for training and 25% for testing, and create the training and testing subsets.  

**5. Feature Scaling (Data transformation)**  
~~~
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])
~~~  
> `scale` is generic function whose default method centers and/or scales the columns of a numeric matrix.  
> It is used to transform, give scala meaning to data, and help make the algorithm lighter; in this case we indicate that we want to apply the changes to all the columns except the prediction column.  

**6. Fitting Random Forest Classification to the Training set**  #######
~~~
install.packages('randomForest')
library(randomForest)
set.seed(123)
classifier = randomForest(x = training_set[-3],
                          y = training_set$Purchased,
                          ntree = 10)
~~~  
> 
First it is necessary to install and import the randomForest library, which helps us to use the function of the same name (randomForest).  
> `randomForest` is used to fit recursive partitioning models and regression trees. To use it the following arguments are needed:  
>   * _formula_: The variable to predict (Class), and the characteristics to take as the basis for the prediction ('.' means that they will all be used).  
>   * _data_: data set to use (training).   

**7. Predicting the Test set results**  
~~~
y_pred = predict(classifier, newdata = test_set[-3])
y_pred
~~~  
> Using the `predict` function, the probabilities of the predictions to be made by the model are calculated, taking as reference the data of the classifier created in the previous step, and indicating the data to be used (test_set minus column 3).  

**8. Making the Confusion Matrix**  
~~~
cm = table(test_set[, 3], y_pred)
cm
~~~  
> Using the `table` function, confusion matrix is created for the predictions made in the previous step.   
These are the results:  
~~~
 y_pred
     0  1
  0 55  9
  1  8 28
~~~  

**9. Visualising the Training set results**  
~~~
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
~~~  
> We load the `ElemStatLearn` library to be able to visualize the training data.  
> With the `seq` function, variables X1 and X2 are created, adding the start (min), end (max), and increment (by) values.  
> A grid of all combinations of variables X1 and x2 is created using the `expand.grid` function, and its columns are named (Age, EstimatedSalary).  

~~~
y_grid = predict(classifier, grid_set)
~~~  
> The `predict` function is used again to calculate the probability of the prediction, in this case taking the data from the grid created in the previous step (grid_set).  

~~~
plot(set[, -3],
     main = 'Random Forest Classification (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The `plot` function is used to graph based on the data in the first two columns of the set; the name of the graph is assigned and the names and limits of the axes.  
> The `contour` function is used to add a contour line to the already created graph.  
> The `points` function is used to add a figure to the graph, in this case a 0.01-inch rectangle per side colored 'green' if the specified condition is met, and if not, colored 'red'.  
> Again the `points` function is used; in this case to add the training data as filled points on the graph. Given a condition, if this is true, the filling of said points will be 'green', and if not, it will be 'red'.  

The following is the resulting graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P8-Training.png" width="65%">  


**10. Visualising the Test set results**  
~~~
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, grid_set)
plot(set[, -3], main = 'Random Forest Classification (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The process carried out in the previous step is repeated, only this time the test data will be used.  

The following is the resulting graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P8-Test.png" width="65%">  

**11. Plotting the tree**  
~~~
plot(classifier)
text(classifier, cex=0.75)
~~~  
> We use the `plot` function again to graph the tree created by the model, and the `text` function to add the conditions used as well as the results of each branch (`cex` is used to indicate the font size).  
> **Note:** in order for the tree to be well graphed, it is necessary to run the code again, but omitting the part for data transformation (Feature Scaling).  

The following is the resulting graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P8-Tree.png" width="65%">  

**Conclusion**  
Observing the results of the confusion matrix, we can obtain the level of accuracy of the model's predictions; in this case of 100 predictions, we have that 83 were correct and 17 erroneous, this gives us approximately 83% effectiveness, which is quite good.  
Also if the obtained graphs are observed, it can be seen in the separation of the points by colors, that indeed the predictions were made in a correct way almost in their majority.  
Regarding the tree graph generated by the model, we can see that the variance with a value greater than or equal to 0.3116 was taken as the main condition, and based on the answer, if this was negative, the final prediction was equal to 0, and if it was positive, the evaluation continued with the entropy condition less than -3,269; hence, if the answer was positive, the final prediction was equal to 1, and if it was negative, it was evaluated again with the condition of variance, this time greater than or equal to -2,802; hence, new conditions no longer followed, only the response was evaluated, if it was positive, the final prediction would be equal to 1, and if it was negative, it would be equal to 0.  

