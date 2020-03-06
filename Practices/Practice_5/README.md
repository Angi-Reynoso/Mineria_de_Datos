# Practice 5 - Demographic Analysis  

<br>

**1. Select and load file with data**  
There are two methods to select and load the file in which the data to be used is located:  
<br>
**1.1 Method 1:** Select the file manually
~~~~
stats <- read.csv(file.choose())
stats
~~~~
> This method consists in declaring a variable (_stats_) to which the file will be assigned using the 
function `read.csv()`.  
What the `read.csv(file.choose)` function does is open a new window, in which we will look for 
the file to load and simply select it and click Open.  
You can check the correct file load by running the variable, where it was saved.  

_**Select file in new window**_  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/Method1-1.png" 
alt="Practice5" width="85%">

_**Data loaded successfully**_  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/Method1-2.png" 
alt="Practice5" width="85%">

<br>

**1.2 Method 2:** Set Working Directory and Read Data
~~~~
getwd()
#windows
setwd("C:/Users/user hp/Documents/GitHub/DataMining/DataMining-master/Dataframes")
#Mac
setwd("/home/chris/Documents/itt/Enero_Junio_2020/Mineria_de_datos/DataMining/Dataframes")
getwd()
stats <- read.csv("Demographic-Data.csv")
stats
~~~~
> The second method consist in to establish a working directory and from there, load the data.  
For this, we first need to know the current route, the `getwd()` function allows us to know it.  
Depending on the operating system, the next step is to set the path to the working directory using
the `setwd()` function:  
> * In the case of Windows it would be something similar to: `setwd("C:/Users/user/Documents/Dataframes")`  
> * In the case of Mac or Linux it would be something like this: `setwd("/home/user/Documents/Dataframes)`  

> To check that the route has been set correctly you can use the `getwd()` function again.  
Finally, to load the file with the data, use the function `read.csv()`, however, unlike the previous method, 
in this case we will write the name of the file to be loaded between the parentheses (for example, 
_"Demographic-Data.csv"_), and we will run the name of the variable to verify the correct loading of the data.  

_**Check current path, set path to working directory, check path again and upload file**_  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/Method2-1.png" 
alt="Practice5" width="85%">

_**Data loaded successfully**_  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/Method2-2.png" 
alt="Practice5" width="85%"> 

<br>

**2. Exercises** 

**2.1 Filter countries by Low income**  
~~~~
stats[stats$Income.Group == "Low income",]
~~~~
> `stats` Is the variable where the data is located.
The `$` is used as a select, to then indicate the column from which you want to obtain certain data

**2.2 Filter countries by Lower middle income**  
~~~~
stats[stats$Income.Group == "Lower middle income",]
~~~~
**2.3 Filter countries by Upper middle income**  
~~~~
stats[stats$Income.Group == "Upper middle income",]
~~~~
**2.4 Filter by countrie Malta**  
~~~~
stats[stats$Country.Name == "Malta",]
~~~~
**2.5 Filter by countrie Qatar**  
~~~~
stats[stats$Country.Name == "Qatar",]
~~~~
**2.6 Filter by countrie Netherlands**  
~~~~
stats[stats$Country.Name == "Netherlands",]
~~~~
**2.7 Filter by countrie Norway**  
~~~~
stats[stats$Country.Name == "Norway",]
~~~~
