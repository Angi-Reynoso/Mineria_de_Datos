## Instructions
Develop the following problem with R and RStudio for the knowledge extraction that the problem requires.
Implement the Naive Bayes classification model with the Social_Network_Ads.csv dataset and using the e1071 library with the naiveBayes () function.
Once the classifier is obtained, make the corresponding data visualization analysis.
At the end of the development, explain in detail what the Naive Bayes classification model consists of and also the detailed explanation corresponding to data visualization.

** Naive Bayes **
Naive Bayes is a supervised machine learning algorithm based on Bayes' theorem that is used to solve classification problems using a probabilistic approach. It is based on the idea that the predictor variables of a Machine Learning model are independent of each other. Which means that the result of a model depends on a set of independent variables that have nothing to do with each other.

<br>

## Solution
**1. Set working directory**  
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/Examen U3")
getwd()
~~~  

**2. Importar el dataset**  
~~~
dataset = read.csv('Social_Network_Ads.csv')
dataset = dataset[3:5]
~~~  
> The file was loaded with the dataset and we indicate that we only want to work with columns from 3 to 5.

**3. Coding the target characteristic as a factor** 
~~~
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))
~~~  
> With the factor function, we specify the column of the dataset that we want to predict.
> `factor` is used to encode a vector as a factor.
> * `levels` is an optional vector of the unique values (such as strings) that x could have taken.  

**4. Divide the dataset into Training set and Test set** 
~~~
install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
~~~  
> We install and load the caTools library.
> We create a seed to randomize the data.
> We divided the data into 75% for training and 25% for testing, and created the training and testing subsets.

**5. Features scaling**  
~~~
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])
~~~  
> `scale` is a generic function whose default method centers and / or scales the columns of a numeric array.
>  It is used to transform, give meaning to data in Scala, and help clarify the algorithm; In this case, we indicate that we want to apply the changes to all columns except the prediction column.

**6. Fit Naive Bayes to Training set**  
~~~
install.packages('e1071')
library(e1071)
classifier = naiveBayes(formula = Purchased ~ .,
                 data = training_set)
~~~  
> First you need to install and import the `e1071` library to use the` naiveBayes () `function.
> `naiveBayes` calculates the conditional posterior probabilities of a variable of categorical class given independent predictor variables using Bayes' rule. The following arguments are necessary:
> * _formula_: The variable to predict (Purchased) and the characteristics to take as the basis for the prediction ('.' means that they will all be used).
> * _data_: It is the data set to use (training_set). 

**7. Predict Test Set Results**  
~~~
y_pred = predict(classifier, newdata = test_set[-3])
y_pred
~~~  
> Using the `predict` function, the probabilities of the predictions that the model will make are calculated, taking as a reference the data of the classifier created in the previous step and indicating the data to be used (test_set minus column 3).

** 8. Make the Confusion Matrix **
~~~
cm = table(test_set[, 3], y_pred)
cm
~~~  
> Using the `table` function, a confusion matrix is created for the predictions made in the previous step.
> These are the results:
~~~
y_pred
     0  1
  0 57  7
  1  7 29
~~~

**9. View the results of the Training Set**
~~~
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
~~~  
> We load the `ElemStatLearn` library to view the training data.
> With the `seq` function, variables X1 and X2 are created, adding the start (min), end (max) and increment (by) values.
> A grid of all combinations of variables X1 and X2 is created using the `expand.grid` function, and their columns are named.
~~~
y_grid = predict(classifier, grid_set)
~~~  
> The `predict` function is used again to calculate the probability of the prediction, in this case taking the data from the grid created in the previous step (grid_set).

~~~
plot(set[, -3],
     main = 'Naive Bayes (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The `plot` function is used to graph based on the data in the first two columns of the set; the name of the graph (main) and the names and limits of the axes (xlab, xlim) are assigned.
> The `contour` function is used to add a contour line to the already created graph.
> The `points` function is used to add a figure to the graph, in this case a rectangle of 0.01 inches per side, colored 'green' if the specified condition is met, and if not, colored 'red'.
> Again the `points` function is used; in this case to add the training data as filled points on the graph. Given a condition, if this is true, the filling of these points will be 'green', and if not, it will be 'red'.

The following is the resulting graph:

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/ExamU3 - Training.png" width="65%">  

**10. View the results of the Test Set**
~~~
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, grid_set)
plot(set[, -3], main = 'Naive Bayes (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The process carried out in the previous step is repeated, only this time the test data will be used.

The following is the resulting graph:

<img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/ExamU3 - Test.png" width = "65%">

**Conclusion**
In both graphs it can be seen that the number of erroneous predictions was minimal, which shows us that the level of accuracy of the model is quite good.
If we look at the results obtained from the confusion matrix, we can see that, with respect to the test data, the level of accuracy of the model was approximately 86%, that is, out of 100 predictions, 86 were correct and only 14 were wrong (7 false positives and 7 false negatives).
