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

**5. Fitting Simple Linear Regression to the Training set**
~~~
regressor = lm(formula = Profit ~ R.D.Spend,
               data = dataset)
summary(regressor) 
~~~

**6. Predicting the Test set results**
~~~
y_pred = predict(regressor, newdata = test_set) 
~~~

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
