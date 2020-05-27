getwd()
setwd("C:/Users/GitHub/DataMining/MachineLearning/SVM")
getwd()

dataset = read.csv('Social_Network_Ads.csv')
dataset = dataset[3: 5]

dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))

library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

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
