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

**4. Splitting the dataset into the Training set and Test set**
### Install.packages('caTools)
~~~
library(caTools)
set.seed(123)
split <- sample.split(dataset$Profit, SplitRatio = 0.8)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
~~~
**Note:**  
Before proceeding to the next step, it is necessary to install the caTools library, for which it is also necessary to have version 3.6 of R.  

> What `set.seed()`does is that when we will split the whole dataset into the training dataset and the test dataset than this seed will enable us to make the same partitions in the datasets.  
> `sample.split()` is used to split the data used during classification into train and test subsets.

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
> The second argument is `newdata` that specifies which dataset we want to implement our trained model on and predict the results of the new dataset. Here, we have taken the `test_set` on which we want to implement our model.

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
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Training Set.png" width="65%">  

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
> The previous step is repeated, only in this case the data used to make the predictions comes from the training set.  

This is the result of the graph: 

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/Test Set.png" width="65%">  

**Conclusion:**  
