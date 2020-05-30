# Support Vector Machine (SVM)
<br>

**1. Set Workspace**  
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/MachineLearning/SVM")
getwd()
~~~  

**2. Importing the dataset**  
~~~
dataset = read.csv('data_banknote_authentication.csv')
head(dataset)
colnames(dataset) <- c("Variance", "Skewness", "Kurtosis", "Entropy", 
                      "Class")
head(dataset)

columns <- c('Variance', 'Entropy', 'Class')
dataset = dataset[columns]
~~~  
> We load the file with the dataset.  
> We use the `head` function to see the first rows.  
> We change the column titles with the `colnames` function, and check the changes with the` head` function.  
> We create the columns variable to save the names of the columns we want to work with, and assign them to the dataset.  

**3. Encoding the target feature as factor**  
~~~
dataset$Class = factor(dataset$Class, levels = c(0, 1))
~~~  
> With the help of the `factor` function we specify the column of the dataset to predict.  
> `factor` is used to encode a vector as a factor. `levels` is an optional vector of the unique values (as character strings) that x might have taken.   

**4. Splitting the dataset into the Training set and Test set**  
~~~
library(caTools)
set.seed(123) 
split = sample.split(dataset$Class, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
~~~  
> We load the caTools library, create the seed to randomize the data, divide the data 75% for training and 25% for testing, and create the training and testing subsets.  

**5. Feature Scaling**  
~~~
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])
~~~  
> `scale` is generic function whose default method centers and/or scales the columns of a numeric matrix.  
> It is used to transform, give scala meaning to data, and help make the algorithm lighter; in this case we indicate that we want to apply the changes to all the columns except the prediction column.  

**6. Fitting SVM to the Training set**  
~~~
install.packages('e1071')
library(e1071)
classifier = svm(formula = Class ~ .,
                 data = training_set,
                 type = 'C-classification',
                 kernel = 'linear')
~~~  
> First it is necessary to install and import the e1071 library in order to use the SVM function.  
> `svm` is used to train a support vector machine. It can be used to carry out general regression and classification, as well as density estimation. The following arguments are necessary:  
>   * _formula_: The variable to predict (Class), and the characteristics to take as the basis for the prediction ('.' means that they will all be used).  
>   * _data_: data set to use (training).  
>   * _type_: svm can be used as a classification machine, as a regression machine, or for novelty detection. Depending of whether 'y' is a factor or not, the default setting for type is C-classification or eps-regression, respectively, but may be overwritten by setting an explicit value.  
>   * _kernel_: The mathematical function used to do the data transformation in SVM is known as `kernel`, and there are 4 different types that can be applied, each with different algorithms and parameters: Linear, Polynomial, Radial Basis or Gaussian, and Sigmoid.  

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
      0   1
  0 178  12
  1  25 127
~~~  

**9. Visualising the Training set results**  
~~~
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Variance', 'Entropy')
~~~  
> We load the `ElemStatLearn` library to be able to visualize the training data.  
> With the `seq` function, variables X1 and X2 are created, adding the start (min), end (max), and increment (by) values.  
> A grid of all combinations of variables X1 and x2 is created using the `expand.grid` function, and its columns are named (Variance, Entropy).  

~~~
y_grid = predict(classifier, newdata = grid_set)
~~~  
> The `predict` function is used again to calculate the probability of the prediction, in this case taking the data from the grid created in the previous step (grid_set).  

~~~
plot(set[, -3],
     main = 'SVM (Training set)',
     xlab = 'Variance of Wavelet Transformed image', 
     ylab = 'Entropy of image',
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
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P6-Training.png" width="65%">  


**10. Visualising the Test set results**  
~~~
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Variance', 'Entropy')
y_grid = predict(classifier, newdata = grid_set)
plot(set[, -3], main = 'SVM (Test set)',
     xlab = 'Variance of Wavelet Transformed image', 
     ylab = 'Entropy of image',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The process carried out in the previous step is repeated, only this time the test data will be used.  

The following is the resulting graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P6-Test.png" width="65%">  
 
  
**Conclusion**  
In both graphs it can be seen that the number of erroneous predictions was minimal, which shows us that the level of accuracy of the model is quite good.  
If we look at the results obtained from the confusion matrix, we can see that, regarding the test data, the level of accuracy of the model was approximately 89%, that is, from 342 predictions, 305 were correct and only 37 were erroneous (25 false positives and 12 false negatives).  
