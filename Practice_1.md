# Law Of Large Numbers  
The Law  of  Large  Numbers  states  that  as  the  size  of  a  sample  drawn  from  a  random  variable increases,
the  mean  of  more  samples gets  closer  and  closer  to  the  true  population  mean  μ.  

### Data:  
mean = 0  
stdev = 1 (standard deviation)  

### Steps:  
1. Generate random samples from a normal distribution:  
`set.seed(124)`  
The set.seed function is used to call a random number generator.  

2. Initialize sample size:  
`N <- 100`  
To create a variable, in this case N, the name of the variable is used followed by "<-" and the initial value.  
`sample <- rnorm(N)`  
To generate a sample of size N from a standard normal distribution the rnorm function is used. Only the argument n 
(sample size) has to be provided since the mean 0 and the standard deviation 1 are the default values for the mean and 
stdev arguments.  

3. Initialize counter:  
`counter <- 0`  

4. Loop for(i in rnorm(size)):  
`for(i in rnorm(100)){`  
-description-  
  
5. Check if the iterated variable falls between -1 and 1:  
  `if(i >= -1 && i <= 1){`    
    `print(i)`  
-description-  

6. Increase counter if the condition is true:  
    `counter <- counter+1`  
-description-  

7. Return a result <- counter / N:  
    `result <- counter / N`  
  `}`  
`}`  
`print(result)`  
-description-

