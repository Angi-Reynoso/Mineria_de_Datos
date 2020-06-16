#Functions in R
#Numerical Functions  
#1. abs( ):  
?abs()
abs(-7)
abs(7)

#2. ceiling( ):  
?ceiling()
ceiling(5.9)
ceiling(2.9)

#3. floor( ): 
?floor()
floor(5.9)
floor(2.9)

#4. trunc( ):
?trunc()
trunc(5.9)
trunc(5.1)

#5. max( ):
?max()
vector = c(5,6,7,8,9)
max(vector)

#6. min( ):
?min()
vector = c(5,6,7,8,9)
min(vector)

#7. unique( ):
?unique()
v <- c(5,10,0,0,2) 
unique(v)

#8. round( ):  
?round()
round(.5 + -2:4)

#9. signif( ):
?signif()
x2 <- pi * 100^(-1:3)
signif(x2, 3)

#Character Functions  
#10. substr(x, start, stop):  
?substr()
string <- "Data Mining"
substr(string, start = 1, stop = 4)
substr(string, start = 6, stop = 11)

#11. toupper( ):  
?toupper()
toupper(string)  

#12. tolower( ):  
?tolower()
tolower(string)

#13. mean( ):  
?mean()
vector = c(5,6,7,8,9)
mean(vector)

#14. median( ):  
?median()
median(vector)

#15. sum( ):  
?sum()  
sum(vector)  

#Other Functions 
#16. all( ):  
?all()
range(x <- sort(round(stats::rnorm(10) - 1.2, 1)))
if(all(x < 0)) cat("all x values are negative\n")
all(logical(0))

#17. any( ):  
?any()
range(x <- sort(round(stats::rnorm(10) - 1.2, 1)))
if(any(x < 0)) cat("x contains negative values\n")

#18. apropos( ):  
?apropos()
apropos("GLM")                      
apropos("GLM", ignore.case = FALSE) 
apropos("lq")

#19. find( ):
?find()
cor <- 1:pi
find("cor")                       
find("cor", numeric = TRUE)                
find("cor", numeric = TRUE, mode = "function")  
rm(cor)

#20. diff( ):
?diff()
x <- cumsum(cumsum(1:10))
diff(x, lag = 2)
diff(x, differences = 2)
