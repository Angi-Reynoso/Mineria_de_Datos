# Practice 1 - Simple Linear Regression   

<br>

**1. Set Working Directory**  
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/MachineLearning/SimpleLinearRegression")
getwd()
~~~  

**2. Importing the dataset**  
~~~
dataset <- read.csv('Sea_Ice.csv')
~~~  

**Note:**  
Before proceeding to the next step, it is necessary to install the caTools library, for which it is also necessary to have version 3.6 of R.  
~~~
Install.packages('caTools)
library(caTools)
~~~  

**3. Splitting the dataset into the Training set and Test set**  
~~~
set.seed(123)
split <- sample.split(dataset$Extent, SplitRatio = 2/3)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
~~~  
> `set.seed()` is a random number generator, which is useful for creating simulations or random objects that can be reproduced.  
> `sample.split()` is used to split the data used during classification into train and test subsets. The following arguments are used:
>  1. Variable with the dataset (dataset) + $ + name of the column to predict (Extent).
>  2. SplitRatio = ratio for dividing the data.
>      * For example in SplitRatio = 2/3, it means 1/3 of the data will be used for tests and 2/3 for training.  

> `subset()` its a function that allows to select variables and observations. The following arguments are used:  
>   1. Variable with the dataset (dataset).
>   2. Condition to be met (split == TRUE).
>      * In this case, this is where the data that was separated with the previous function will be assigned to the training set.  

**4. Fitting Simple Linear Regression to the Training set**  
~~~
regressor = lm(formula = Extent ~ Year,
               data = dataset)
summary(regressor)
~~~  
> `lm()` is used to fit linear models. It can be used to carry out regression, single stratum analysis of variance and analysis of covariance. The following arguments are used:
>   1. _formula_: a symbolic description of the model to be fitted (Extent ~ Year).  
>   2. _data_: an optional data frame, list or environment containing the variables in the model (dataset).  

> `summary()` is a generic function used to produce result summaries of the results of various model fitting functions. For example, these are the results obtained from this case:  
~~~
Call:
lm(formula = Extent ~ Year, data = dataset)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.40910 -0.34356  0.03251  0.35840  1.47376 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) 180.728966  17.396966   10.39 3.10e-12 ***
Year         -0.087321   0.008711  -10.02 7.97e-12 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.5658 on 35 degrees of freedom
Multiple R-squared:  0.7417,	Adjusted R-squared:  0.7343 
F-statistic: 100.5 on 1 and 35 DF,  p-value: 7.968e-12
~~~  
> * **Note:** Specifically in the part where the coefficients are shown, some asterisks are observed on the right side; the number of these varies according to the correlation that exists between the variables of the model, and therefore helps us to know how likely it is that the model will work itself.  

**5. Predicting the Test set results**  
~~~
y_pred = predict(regressor, newdata = test_set)
~~~
> `predict()` is a generic function for predictions from the results of various model fitting functions. The following arguments are used:
>   1. _object_: a model object for which prediction is desired (regressor).  
>   2. _..._: additional arguments affecting the predictions produced. In this case the test variables are sent to make the predictions (`newdata = test_set`).  

**Note:**  
Before proceeding to the next step, it is necessary to have the ggplot2 library already installed.
~~~
library(ggplot2)
~~~  

**6. Visualising the Training set results**  
~~~
ggplot() +
  geom_point(aes(x = training_set$Year, y = training_set$Extent),
             color = 'green') +
  geom_line(aes(x = training_set$Year, y = predict(regressor, newdata = training_set)),
            color = 'red') +
  ggtitle('Extent vs Year (Training Set)') +
  xlab('Year') +
  ylab('Extent') 
~~~
> `ggplot()` initializes a ggplot object. It can be used to declare the input data frame for a graphic and to specify the set of plot aesthetics intended to be common throughout all subsequent layers unless specifically overridden.  
> `geom_point` is used to create scatterplots. The scatterplot is most useful for displaying the relationship between two continuous variables.  
> `aes()` describe how variables in the data are mapped to visual properties (aesthetics) of geoms. The following arguments are used:  
>   1. _x_: assigning values to the x axis (training_set$Year).  
>   2. _y_: assigning values to the y axis (training_set$Extent).  
>   3. _color_: assign color to the figures on the graph.  

> `geom_line` connects the observations in order of the variable on the x axis.  
> `gg_title` is used to assign the name of the graphic ('Extent vs Year (Training Set)').  
> `xlab` is used to name the data represented on the x axis ('Year').  
> `ylab` is used to name the data represented on the y axis ('Extent').  

This is the result of the graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Extent_vs_Year(Training_Set).png" 
alt="Practice1" width="65%">  

**7. Visualising the Test set results**  
~~~
ggplot() +
  geom_point(aes(x=test_set$Year, y=test_set$Extent),
             color = 'blue') +
  geom_line(aes(x = training_set$Year, y = predict(regressor, newdata = training_set)),
            color = 'red') +
  ggtitle('Extent vs Year (Test Set)') +
  xlab('Year') +
  ylab('Extent')
~~~
> The previous step is repeated, only in this case the data used to make the predictions comes from the training set.  

This is the result of the graph:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Extent_vs_Year(Test_Set).png" 
alt="Practice1" width="65%">  

**Conclusion:**  
From the graphs it can be inferred that the extent of the glaciers has definitely been decreasing steadily as the years go by, despite the fact that there were occasions when it seemed to be recovering. 
