# Multiple Linear Regression - Backward Elimination Function
<br>

**1. Set Working Directory**  
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/MachineLearning/MultipleLinearRegression")
getwd()
~~~  

**2. Importing the dataset**  
~~~
dataset <- read.csv('50_Startups.csv')
~~~  

**3. Encoding categorical data**  
~~~
dataset$State = factor(dataset$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1,2,3))
~~~  
> The function `factor` is used to encode a vector as a factor.  
> In other words, the above code is used to transform the values of a text type category to the numeric type; for example, the values of the State category: New York, California and Florida, are changed by labels 1, 2 and 3.  

**4. Splitting the dataset into the Training set and Test set**  
~~~
library(caTools)
set.seed(123)
split <- sample.split(dataset$Profit, SplitRatio = 0.8)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
~~~  
> In this section a 'seed' is created to randomize the data when using the `split` function, which serves to separate the data in the training and test subsets according to the percentage assigned in SplitRatio (in this case 0.8 means that 80% of the data will be used for training and the remaining 20% will be used for testing).  

**5. Atomation BackwardElimination Function**  
~~~
backwardElimination <- function(x, sl) {
  numVars = length(x)
  for (i in c(1:numVars)){
    regressor = lm(formula = Profit ~ ., data = x)
    maxVar = max(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"])
    if (maxVar > sl){
      j = which(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"] == maxVar)
      x = x[, -j]
    }
    numVars = numVars - 1
  }
  return(summary(regressor))
}

SL = 0.05
training_set
backwardElimination(training_set, SL)
~~~  
> The `backwardElimination` function is created, which will receive two parameters:   
>   * x = dataset (training_set).  
>   * sl = significance level (5% is used in most cases).  
> The variable `numVars` is created where the total number of categories (columns) in the dataset will be saved.  

> A for loop is used to evaluate each of the categories.  
> The variable `regressor` specifies the variable to predict (Profit) based on the other categories[1] within the data set (x).  
> * [1] "." is used to indicate that all categories in the dataset will be taken into account.  

> In the variable `maxVar` the maximum value that exists between all the coefficients calculated within the summaries of the variable `regressor` is obtained, and this is stored in an array together with its P value.  
> Then an if conditional is used to evaluate if the value obtained in `maxVar` (P value) is greater than 5% assigned to the variable `sl`.  
> If the value is greater then it means that the category is not important enough to keep it, therefore it is removed from the dataset, and the total number of categories is reduced to start the cycle again.  
> The cycle ends when the most important categories for the entire dataset are obtained, and these are returned by summarizing the variable `regressor`.  

**Function Results**  
In this case, only one of the categories was obtained as the most important (R.D.Spend) for the entire data set; which is verified by the number of asterisks displayed on the right side of the value P (Pr) in the coefficient table.  
The greater the number of asterisks, the better the category, in this case, if the meaning of the codes is observed, we have that:  
  * Three asterisks are equal to 0 (the most important).  
  * Two asterisks are equal to 0.001.  
  * An asterisk is equal to 0.01.  
  * One point (.) is equal to the value assigned to the significance level (0.05).  
   * Higher values are represented by a blank space ('').  

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Practice3 - backwardElimination.png" width="75%"> 

