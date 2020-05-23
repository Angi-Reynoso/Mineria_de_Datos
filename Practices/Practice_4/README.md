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

**3. Splitting the dataset into the Training set and Test set**  
~~~
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio = 0.75) 
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
~~~  

**4. Feature scaling**  
~~~
training_set[, 1:2] <- scale(training_set[, 1:2])
test_set[, 1:2] <- scale(test_set[, 1:2])
~~~  

**5. Fitting Logistic Regression to Training set**  
~~~
classifier = glm(formula = Purchased ~ .,
                 family = binomial,
                 data = training_set)
~~~  

**6. Predicting the Test set results**  
~~~
prob_pred = predict(classifier, type = 'response', newdata = test_set[-3])
prob_pred

y_pred = ifelse(prob_pred > 0.5, 1, 0)
y_pred
~~~  

**7. Making the Confusion Matrix**  
~~~
cm = table(test_set[, 3], y_pred)
cm
~~~  

**8. Visualization using the ggplot2 library**  
* **8.1 Training Set**  
~~~
library(ggplot2)
ggplot(training_set, aes(x=EstimatedSalary, y=Purchased)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)

ggplot(training_set, aes(x=Age, y=Purchased)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)
~~~  
>  

The following graphs are obtained:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/ggplot2_Training.png" width="100%"> 

* **8.2 Test Set**  
~~~
ggplot(test_set, aes(x=EstimatedSalary, y=Purchased)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)

ggplot(test_set, aes(x=Age, y=Purchased)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)
~~~  
>  

The following graphs are obtained:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/ggplot2_Test.png" width="100%"> 

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
y_grid = ifelse(prob_set > 0.5, 1, 0) #Regiones de la poblacion que comprara y que no
plot(set[, -3],
     main = 'Logistic Regression (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
>  

The following graph is obtained:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Practice4_Training.png" width="65%"> 

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
>  

The following graph is obtained:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Practice4_Test.png" width="65%"> 

