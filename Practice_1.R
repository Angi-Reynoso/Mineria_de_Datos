#Test the Law Of Large Numbers for N random normally distributed numbers 
#with mean = 0, stdev=1:
set.seed(124)

#Create an R script that will count how many of these numbers fall between 
#-1 and 1 and divide by the total quantity of N

#You know that E(X) = 68.2%
#Check that Mean(Xn)->E(X) as you rerun your script while increasing N

#Hint:
#1. Initialize sample size
N <- 100
sample <- rnorm(N)

#2. Initialize counter
counter <- 0

#3. loop for(i in rnorm(size))
for(i in rnorm(100)){
  
  #4. Check if the iterated variable falls
  if(i >= -1 && i <= 1){
    print(i)
    #5. Increase counter if the condition is true
    counter <- counter+1
    
    #6. return a result <- counter / N
    result <- counter / N
  }
}
print(result)
