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
classifier1 = svm(formula = Purchased ~ .,
                 data = training_set,
                 type = 'C-classification',
                 kernel = 'linear')

classifier2 = svm(formula = Purchased ~ .,
                 data = training_set,
                 type = 'C-classification',
                 kernel = 'polynomial')

classifier3 = svm(formula = Purchased ~ .,
                  data = training_set,
                  type = 'C-classification',
                  kernel = 'radial')

classifier4 = svm(formula = Purchased ~ .,
                  data = training_set,
                  type = 'C-classification',
                  kernel = 'sigmoid')
~~~  
> First it is necessary to install and import the e1071 library in order to use the SVM function.  
> `svm` is used to train a support vector machine. It can be used to carry out general regression and classification, as well as density estimation. The following arguments are necessary:  
>   * _formula_: The variable to predict (Purchased), and the characteristics to take as the basis for the prediction ('.' means that they will all be used).  
>   * _data_: data set to use (training).  
>   * _type_: svm can be used as a classification machine, as a regression machine, or for novelty detection. Depending of whether 'y' is a factor or not, the default setting for type is C-classification or eps-regression, respectively, but may be overwritten by setting an explicit value.  
>   * _kernel_: The mathematical function used to do the data transformation in SVM is known as `kernel`, and there are 4 different types that can be applied, each with different algorithms and parameters:  
>      * _Linear_: This is recommended when the linear separation of the data is easy.  
>      * _Polynomial_.  
>      * _Radial Basis or Gaussian_.  
>      * _Sigmoid_.  

**7. Predicting the Test set results**  
~~~
y_pred1 = predict(classifier1, newdata = test_set[-3])
y_pred2 = predict(classifier2, newdata = test_set[-3])
y_pred3 = predict(classifier3, newdata = test_set[-3])
y_pred4 = predict(classifier4, newdata = test_set[-3])
~~~  
> Using the `predict` function, the probabilities of the predictions to be made by the model are calculated, taking as reference the data of the classifiers created in the previous step, and indicating the data to be used (test_set minus column 3).  

**8. Making the Confusion Matrix**  
~~~
cm1 = table(test_set[, 3], y_pred1)
cm2 = table(test_set[, 3], y_pred2)
cm3 = table(test_set[, 3], y_pred3)
cm4 = table(test_set[, 3], y_pred4)
cm1
cm2
cm3
cm4
~~~  
> Using the `table` function, confusion matrices are created for each of the predictions made in the previous step.  

The following are the results of the confusion matrices:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-ConfusionMatrix.png" width="65%">  

> Analyzing the results obtained from the matrices, it can be seen that when using the radial type kernel (cm3) is when the least amount of errors is obtained, that is, the percentage of accuracy is greater, this is followed by the linear type kernel (cm1), the polynomial (cm2) and finally the sigmoid (cm4).  

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
> A grid of all combinations of variables X1 and x2 is created using the `expand.grid` function, and its columns are named.  

~~~
y_grid1 = predict(classifier1, newdata = grid_set)
y_grid2 = predict(classifier2, newdata = grid_set)
y_grid3 = predict(classifier3, newdata = grid_set)
y_grid4 = predict(classifier4, newdata = grid_set)
~~~  
> The `predict` function is used again to calculate the probabilities of the predictions, in this case taking the data from the grid created in the previous step (grid_set).  

~~~
plot(set[, -3],
     main = 'SVM (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid1), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid1 == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The `plot` function is used to graph based on the data in the first two columns of the set; the name of the graph is assigned and the names and limits of the axes.  
> The `contour` function is used to add a contour line to the already created graph.  
> The `points` function is used to add a figure to the graph, in this case a 0.01-inch rectangle per side colored 'green' if the specified condition is met, and if not, colored 'red'.  
> Again the `points` function is used; in this case to add the training data as filled points on the graph. Given a condition, if this is true, the filling of said points will be 'green', and if not, it will be 'red'.  

The following is the resulting graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-Kernel1-Training.png" width="65%">  

> This first graph corresponds to the type of linear kernel, in which it can be seen that the predictions are quite accurate, however there are still some errors. Compared with the results obtained from the rest of the kernels, and as it could be seen previously in the results of the confusion matrices, this type of kernel would come in second place due to its level of accuracy.  

~~~
contour(X1, X2, matrix(as.numeric(y_grid2), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid2 == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The previous process is repeated, only in this case the predictions obtained with the polynomial kernel type are used.  

The following is the resulting graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-Kernel2-Training.png" width="65%">  

> This second graph corresponds to the type of polynomial kernel, in which it can be seen that the number of erroneous predictions increased a little, so, again, comparing with the rest, this type of kernel would be in third place for level of accuracy.  

~~~
contour(X1, X2, matrix(as.numeric(y_grid3), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid3 == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> Again, the previous process is repeated, in this case the predictions obtained with the radial basis kernel type are used.

The following is the resulting graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-Kernel3-Training.png" width="65%">  

> This graph corresponds to the type of radial basis or Gaussian kernel, in which a considerable difference can be noticed, compared to the two previous graphs, and also, in this case the number of errors has decreased for the most part, so this kernel would be the best option to use, of all kernels, thanks to its high level of accuracy.  

~~~
contour(X1, X2, matrix(as.numeric(y_grid4), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid4 == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> For the last time, the previous process is repeated, in this case the predictions obtained with the sigmoid kernel type are used.

The following is the resulting graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-Kernel4-Training.png" width="65%">  

> This graph corresponds to the type of sigmoid kernel, which is totally different from the distributions observed during the previous graphs (comparison of the colors at the bottom of the graph); in addition, the number of erroneous predictions was increased, therefore, this type of kernel would be in fourth and last place for its level of accuracy (compared to previous ones).  

**10. Visualising the Test set results**  
~~~
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')

y_grid1 = predict(classifier1, newdata = grid_set)
y_grid2 = predict(classifier2, newdata = grid_set)
y_grid3 = predict(classifier3, newdata = grid_set)
y_grid4 = predict(classifier4, newdata = grid_set)

plot(set[, -3], main = 'SVM (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid1), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid1 == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

contour(X1, X2, matrix(as.numeric(y_grid2), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid2 == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

contour(X1, X2, matrix(as.numeric(y_grid3), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid3 == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

contour(X1, X2, matrix(as.numeric(y_grid4), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid4 == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> The process carried out in the previous step is repeated, only this time the test data will be used.  

The following are the resulting graphs:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-Kernel1-Test.png" width="65%">  

> This graph corresponds to the type of linear kernel, as with the training data, the level of accuracy for the predictions was quite good, but not the best.  
 
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-Kernel2-Test.png" width="65%">  
 
> This graph corresponds to the type of polynomial kernel, which is also good, however its level of accuracy is below that of the previous case.  

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-Kernel3-Test.png" width="65%">  

> This graph corresponds to the type of radial basis kernel (Gaussian), which, as in the case with the training data, proved to be the best due to its high level of accuracy.

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/P5-Kernel4-Test.png" width="65%">  

> This graph corresponds to the type of sigmoid kernel, which proved to be good however, still the worst of all options, this due to its low level of accuracy compared to the rest.  

**Conclusion**  
The type of kernel to use will depend on the type of information and data to be processed, since each one has its own algorithm and parameters to work with; in this case, the results showed that the radial base type kernel would be the best option to use in order to obtain the highest percentage of accuracy in the model, that is, less erroneous predictions.  
From what was observed in the graphs, it could be said that of the four types of kernel used, the simplest would be the linear type and the most complicated would be the sigmoid type.  
