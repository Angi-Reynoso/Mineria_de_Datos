# Functions in R

### Numerical Functions  
1. `abs( )`: Computes the absolute value of x.  
2. `ceiling( )`: Takes a single numeric argument x and returns a numeric vector containing the smallest integers not less than the corresponding elements of x.  
3. `floor( )`: Takes a single numeric argument x and returns a numeric vector containing the largest integers not greater than the corresponding elements of x.  
4. `trunc( )`: Takes a single numeric argument x and returns a numeric vector containing the integers formed by truncating the values in x toward 0.  
5. `max( )`: Returns the (regular or parallel) maxima of the input values.pmax*() take one or more vectors as arguments,recycle them to common length and return a single vector giving the ‘parallel’ maxima.  
6. `min( )`: Returns the (regular or parallel) minima of the input values.  
7. `unique( )`: Unique returns a vector, data frame or array like x but with duplicate elements/rows removed.  
8. `round( )`: Rounds the values in its first argument to the specified number of decimal places (default 0). See ‘Details’ about “round to even” when rounding off a 5.
9. `signif( )`: Signif rounds the values in its first argument to the specified number of significant digits.  

### Character Functions  
10. `substr(x, start, stop)`: Extract or replace substrings in a character vector.  
  x, text	= a character vector.  
  start, first = integer. The first element to be replaced.  
  stop, last = integer. The last element to be replaced.  
11. `toupper( )`: Translate characters in character vectors, in particular from upper to lower case or vice versa.   
12. `tolower( )`: Translate characters in character vectors, in particular from upper to lower case or vice versa.  
13. `mean( )`: Generic function for the (trimmed) arithmetic mean.  
14. `median( )`: Compute the sample median.  
15. `sum( )`: Returns the sum of all the values present in its arguments.  

### Other Functions  
16. `all( )`: Given a set of logical vectors, are all of the values true?  
17. `any( )`: Given a set of logical vectors, is at least one of the values true?
18. `apropos( )`: Returns a character vector giving the names of objects in the search list matching (as a regular expression) what.  
19. `find( )`: Returns where objects of a given name can be found.
20. `diff( )`: Returns suitably lagged and iterated differences.
