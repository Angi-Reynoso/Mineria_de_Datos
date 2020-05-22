# Multiple Linear Regression  
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

**Note:**  
Before proceeding to the next step, it is necessary to install the caTools library, for which it is also necessary to have version 3.6 of R.  
~~~
Install.packages('caTools)
library(caTools)
~~~  

**4. Splitting the dataset into the Training set and Test set**  
~~~
set.seed(123)
split <- sample.split(dataset$Profit, SplitRatio = 0.8)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
~~~  
> `set.seed()` allows us to create a 'seed' for generating random data during tests with the data set.    
> `sample.split()` is used to split the data set into training and test subsets.  

**5. Fitting Multiple Linear Regression to the Training set**  
~~~
regressor = lm(formula = Profit ~ R.D.Spend,
               data = dataset)
summary(regressor)  
~~~  
> We will make a multiple linear regression model that will fit our training dataset. `lm()` function is used to do so.  
> `lm()` is used to fit linear models. It can be used to carry out regression, single stratum analysis of variance and analysis of covariance.  
> `summary()` is a generic function used to produce result summaries of the results of various model fitting functions.  

**6. Predicting the Test set results**  
~~~
y_pred = predict(regressor, newdata = test_set) 
~~~  
> `predict()` is a generic function for predictions from the results of various model fitting functions.  
> The second argument `newdata` specifies which dataset we want to implement our trained model on and predict the results of the new dataset. Here, we have taken the `test_set` on which we want to implement our model.  

**7. Visualising the Training set results**  
~~~
library(ggplot2)
ggplot() +
  geom_point(aes(x=training_set$R.D.Spend, y=training_set$Profit),
             color = 'limegreen', size=2) +
  geom_line(aes(x = training_set$R.D.Spend, y = predict(regressor, newdata = training_set)),
            color = 'black') +
  ggtitle('Profit vs R.D.Spend (Training Set)') +
  xlab('R.D.Spend') +
  ylab('Profit')
~~~  
> `ggplot()` initializes a ggplot object. It can be used to declare the input data frame for a graphic and to specify the set of plot aesthetics intended to be common throughout all subsequent layers unless specifically overridden.  
> `geom_point` is used to create scatterplots. The scatterplot is most useful for displaying the relationship between two continuous variables.  
> `aes()` describe how variables in the data are mapped to visual properties (aesthetics) of geoms.  

This is the result of the graph:  

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Practice2-Training.png" width="65%">  

**8. Visualising the Test set results**
~~~
ggplot() +
  geom_point(aes(x=test_set$R.D.Spend, y=test_set$Profit),
             color = 'forestgreen', size=2) +
  geom_line(aes(x = training_set$R.D.Spend, y = predict(regressor, newdata = training_set)),
            color = 'black') +
  ggtitle('Profit vs R.D.Spend (Test Set)') +
  xlab('R.D.Spend') +
  ylab('Profit')
~~~
> The previous step is repeated, only in this case the data used to make the predictions comes from the test set.  

This is the result of the graph:  

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Practice2-Test.png" width="65%">  

**Conclusion:**  
When comparing the prediction results versus the true data, it can be seen that the variations between them are not very large, which indicates that the model works correctly and with a not very high margin of error.  
This can also be seen in both graphs, since if we pay attention to the second (Test Set), we can see that the values obtained are quite close to the regression line, and we even have a result that is just above the line.  
Next we have the real data and those obtained from the prediction, to demonstrate again the comparison between these.  

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Conclusion.png" width="100%">  
