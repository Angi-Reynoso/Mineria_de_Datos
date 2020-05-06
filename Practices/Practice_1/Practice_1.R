getwd()
setwd("C:/Users/GitHub/DataMining/MachineLearning/SimpleLinearRegression")
getwd()

# Importing the dataset
dataset <- read.csv('Sea_Ice.csv')

# Splitting the dataset into the Training set and Test set
# Install.packages('caTools)
library(caTools)
set.seed(123)
split <- sample.split(dataset$Extent, SplitRatio = 2/3) 
training_set <- subset(dataset, split == TRUE) 
test_set <- subset(dataset, split == FALSE) 

# Fitting Simple Linear Regression to the Training set
regressor = lm(formula = Extent ~ Year,
               data = dataset) 
summary(regressor) 

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set) 

# Visualising the Training set results
library(ggplot2)
ggplot() +
  geom_point(aes(x=training_set$Year, y=training_set$Extent),
             color = 'green') +
  geom_line(aes(x = training_set$Year, y = predict(regressor, newdata = training_set)),
            color = 'red') +
  ggtitle('Extent vs Year (Training Set)') +
  xlab('Year') +
  ylab('Extent') 

# Visualising the Test set results (datos reales)
ggplot() +
  geom_point(aes(x=test_set$Year, y=test_set$Extent),
             color = 'blue') +
  geom_line(aes(x = training_set$Year, y = predict(regressor, newdata = training_set)),
            color = 'red') +
  ggtitle('Extent vs Year (Test Set)') +
  xlab('Year') +
  ylab('Extent')
