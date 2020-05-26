# Logistic Regression
<br>

**1. Set Working Directory**  
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/MachineLearning/LogisticRegression")
getwd()
~~~  

**2. Importing the dataset**  
~~~
dataset <- read.csv('Social_Network_Ads.csv')
dataset <- dataset[, 3:5] 
~~~  
> The file 'Social_Network_Ads.csv' is loaded, and then it is indicated what columns will be taken for the dataset, in this case they will be from columns 3 to 5 (`dataset[, 3:5]`).  

**3. Splitting the dataset into the Training set and Test set**  
~~~
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio = 0.75) 
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
~~~  
> A 'seed' is used to randomize data selection during data division (75% for training and 25% for testing).  

**4. Feature scaling**  
~~~
training_set[, 1:2] <- scale(training_set[, 1:2])
test_set[, 1:2] <- scale(test_set[, 1:2])
~~~  
> `scale` is generic function whose default method centers and/or scales the columns of a numeric matrix.  
> In other words, `scale` is used to transform (to base logarithm e) and give a scaled meaning to the data to be used, in this case we indicate that we only want to apply the changes to columns 1 and 2 (`[, 1:2]`).  

**5. Fitting Logistic Regression to Training set**  
~~~
classifier = glm(formula = Purchased ~ .,
                 family = binomial,
                 data = training_set)
~~~  
> `glm` is used to fit generalized linear models, specified by giving a symbolic description of the linear predictor and a description of the error distribution.  
> A classifier is created using the `glm` function, which specifies:  
>   * The _formula_ to be followed, that is, the variable to be predicted (Purchased) and the characteristics on which the prediction will be based ('.' means that all the characteristics remaining to that of the prediction will be taken as the basis).  
>   * The _family_ to use, which is a description of the error distribution and the link function to be used in the model. In this case the 'binomial' is used since the values to be obtained will be only 0's and 1's.  
>   * The _data_ to work with, in this case the training data: `training_set`.  

**6. Predicting the Test set results**  
~~~
prob_pred = predict(classifier, type = 'response', newdata = test_set[-3])
prob_pred

y_pred = ifelse(prob_pred > 0.5, 1, 0)
y_pred
~~~  
> `predict` is a generic function for predictions from the results of various model fitting functions.  
> To make the prediction we need to call the `classifier` created in the previous step, which contains the object for which we want to make the prediction.  
> The type of prediction, in this case `response`, is also specified so that the scale adjusts to that of the response variable.  
> And finally, it indicates where the variables will be obtained with which the prediction will be made, in this case all the `test_set` except column 3 (`test_set[-3]`).  
> In other words, `predict` calculates the probabilities of a prediction, in this case how likely is the result to be equal to 1 or 0.  

> `ifelse` returns a value with the same shape as test which is filled with elements selected from either yes or no depending on whether the element of test is TRUE or FALSE.  
> Once the probabilities of obtaining 0 or 1 have been calculated as a prediction, the `ifelse` function is used to save and print those whose probabilities are greater than 0.5, 1 or 0.  

**7. Making the Confusion Matrix**  
~~~
cm = table(test_set[, 3], y_pred)
cm
~~~  
> `table` uses the cross-classifying factors to build a contingency table of the counts at each combination of factor levels.  
> In this case we use the `table` function to perform the confusion matrix of the predictions made by the model, thus obtaining the total number of predictions that are really true, and how many are false; for this we will need the data from the third column of the test_set (`test_set[, 3]`) and the prediction data (`y_pred`).  

**8. Visualization using the ggplot2 library**  
* **8.1 Training Set**  
~~~
library(ggplot2)
ggplot(training_set, aes(x=EstimatedSalary, y=Purchased)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)

ggplot(training_set, aes(x=Age, y=Purchased)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)
~~~  
> We use the ggplot library to first graph the probability of purchase (y-axis = Purchased) with respect to the estimated salary (x-axis = EstimatedSalary), and then the probability of purchase (y-axis = Purchased) with respect to age (x-axis = Age).  
> Using `geom_point()` we can represent this data in the form of a scatter plot, and with `stat_smooth ()` we help make the patterns easier to recognize, despite being over-plotted.  

The following graphs are obtained:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/ggplot2_Training.png" width="100%">  
> From the first graph (left) we can infer that the salary does affect the probability of purchase, since as it increases, the greater the number of points with probability equal to 1, and as it decreases, the greater the number of points close to the probability of 0.  
> From the second graph (right) we can infer that age may not be a factor with much influence on the decision to buy or not, since just as the probability of buying increases with age, there is also evidence that young people could choose in case to buy, and older people could choose the opposite (not to buy).  

* **8.2 Test Set**  
~~~
ggplot(test_set, aes(x=EstimatedSalary, y=Purchased)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)

ggplot(test_set, aes(x=Age, y=Purchased)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)
~~~  
>  We repeat the procedure from the previous step, only in this case the test_set is used.  

The following graphs are obtained:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/ggplot2_Test.png" width="100%">  
> From the first graph (left) we can infer that the lower the estimated salary, the lower the probability that the person decides to buy, although there are some exceptions shown in the graph.  
> From the second graph (right) we can infer (as in the previous case with the training_set), that age might not be an important factor in a person's decision to buy or not, since apparently the data indicates that in mostly, despite age, users decided not to buy (probability 0).  

**9. Visualization using the ElemStatLearn library**  

#### NOTE:  
The `ElemStatLearn` library is no longer available directly in RStudio (`install.packages ('ElemStatLearn')`), so it will be necessary to go to the following page: https://cran.r-project.org/src/contrib/Archive/ElemStatLearn/, download the file with the most updated date: _2019-08-12 09:20 12M_, and then install it manually.  
For more information on the steps to follow for this procedure, you can consult the following page: https://riptutorial.com/r/example/5556/install-package-from-local-source.  

* **9.1 Visualization the Training Set results**   
~~~
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
prob_set = predict(classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Logistic Regression (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The variable set is created to save the training data.  
> Variables X1 and X2 are created using the `seq` function.  
>    * `seq` is a standard generic with a default method for generating regular sequences.  
>    * The start (min) and end (max) values are placed, as well as the sequence increment number (by).  

> Create a grid using `expand.grid`; this function is used to create a data frame from all the combinations of the vectors or factors provided (X1, X2).  
> Names are assigned to the columns of the grid (Age and EstimatedSalary).  
> The probabilities of the predictions are calculated using the `predict` function again with the same classifier, and only changing the data by the grid (grid_set).  
> The `ifelse` function is used again to save and print the predictions whose probabilities are greater than 0.5, 1 and 0.  
> `Plot` is used, a generic function of R to plot/graph, which specifies:  
>    * The data to use (columns 1 and 2 of the set).  
>    * The title of the graph (main).  
>    * The titles of the axes (xlab, ylab).  
>    * The limits of the axes (xlim, ylim).  

> The `contour` function is used to add a contour line to the previous diagram / graph; it specifies:  
>    * The positions of the line (X1, X2).  
>    * The values to be graphed, in this case the `matrix` function was used with the `y_grid` data, which is used to create a matrix from the given data.  
>    * The limits for the values of the graph, in this case using the `length` function of X1 and X2.  
>    * `add`, a logical function to add to the graph those values that are TRUE.  

> `Points`, a generic function, is used to draw a sequence of points at the specified coordinates. The following arguments are specified for this:  
>    * The data (grid_set).  
>    * `pch` the symbol or character to use, for example '.' corresponds to a 0.01 inch rectangle per side.  
>    * The colors to use (`col`); in this case, if the ifelse conditional is true (`y_grid == 1`), the color is equal to springgreen3 and if not equal to tomato.  

> Again, `points` is used, but in this case it is to graph the training data in the form of points (`pch = 21`), on the rectangle graphed previously; for this type of figure you can specify a background/fill color (`bg`), which is given according to the conditional (`set[, 3] == 1`) where if this is true the color will be green4 and if no, it will be red3.  

The following graph is obtained:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Practice4_Training.png" width="65%">  
> From the graph it can be inferred that the older and higher the estimated salary, the greater the probability that users will choose the decision to buy, which is represented by the section and green points of the graph.  

* **9.2 Visualising the Test Set results**
~~~
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
prob_set = predict(classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Logistic Regression (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
>  At this point the steps from the previous point are repeated again, only this time the data corresponds to the test_set.  

The following graph is obtained:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Practice4_Test.png" width="65%">  
> From the graph it can be inferred that, in fact, the older the person is and the better the estimated salary, the greater the probability that users will decide to buy, however, there are some exceptions in which, despite a low salary, the purchase decision was positive; this may be due to cases where there were false positives within the confusion matrix, that is, erroneous predictions.  
