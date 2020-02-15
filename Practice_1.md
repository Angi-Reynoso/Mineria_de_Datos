Package installation:
install.packages("gganimate")
library(gganimate)
This package extends the ggplot2 package (already installed) by adding a ‘frame’ aesthetic that provides a time factor 
to geoms, allowing them to be animated.

install.packages("gifski")
library(gifski)
This package allows gif output.


Law Of Large Numbers
The Law  of  Large  Numbers  states  that  as  the  size  of  a  sample  drawn  from  a  random  variable increases,
the  mean  of  more  samples gets  closer  and  closer  to  the  true  population  mean  μ.

Data:
mean = 0
stdev = 1 (standard deviation)

Steps:
1. Generate random samples from a normal distribution:
set.seed(124)
The set.seed function is used to call a random number generator.

2. Initialize sample size: 
sample <- rnorm(N)
To generate a sample of size N from a standard normal distribution the rnorm function is used. Only the argument n 
(sample size) has to be provided since the mean 0 and the standard deviation 1 are the default values for the mean and 
stdev arguments.

3. Initialize counter
counter <- 0

4. 
