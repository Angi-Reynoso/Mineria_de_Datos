## Instructions:  

**Develop the following problem with R and RStudio for the knowledge extraction that the problem requires**

* The World Bank was very impressed with your delivery on the previous assignment and have a new project for you.

* You must generate a scatter-plot that shows the life expectancy statistics (Y-axis) and fertility rate (X-axis) by country (Country).

* The scatterplot should also be classified by country (Country Regions).

* You have been provided with data for 2 years: 1960 and 2013 and are required to produce a visualization for each of these years.

* Some data has been provided in a CVS file, some in R vectors. The CVS file contains combined data for both years. All data manipulation must be done in R (not in Excel) because this project can be audited at a later stage.

* You have also been asked to provide information on how the two periods compare.


## Data:  

#### Set working directory and read data:  
~~~~
getwd()
#windows
setwd("C:/Users/user hp/Documents/GitHub/DataMining-master/DataMining-master/Datasets")
getwd()
stats <- read.csv("Test-Data.csv")
stats
~~~~
> To obtain the information to be processed, you must first load the file where they are located (_"Test-Data.csv"_).  
With the `getwd()` function you can know the route in which we are currently.  
With the `setwd()` function, the new path is established from which the file with the data can be extracted; depending 
on the operating system will be the way to enter the path to follow to reach the file directory.  
Finally, with the function `read.csv()` the file is loaded and the data is saved in a variable (_"stats"_).  

## Steps:  
### 1. Divide data by year (1960 and 2013):
~~~~
stats[stats$Year == "1960",]
~~~~
> We use a filter to obtain the total data corresponding to each year (1960 and 2013).

~~~~
df1960 <- stats[c(1:187),]
df1960

df2013 <- stats[c(188:374),]
df2013
~~~~
> In a new variable we keep the data separated by year, in the form of an array.  
`variable <- variable_dataframe[c(start:end),]`  

### 2. Convert arrays into dataframes:  
~~~~
mydf1960 <- data.frame(df1960)
mydf1960

mydf2013 <- data.frame(df2013)
mydf2013
~~~~
> A new variable is created to save the dataframe; the `data.frame()` function is used to create it, 
and then the name of the array from which the data will be taken is assigned.  

### 3. Add new column for Life Expectancy data:
~~~~
Country_Code <- c("ABW","AFG","AGO","ALB","ARE","ARG","ARM","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BOL","BRA","BRB","BRN","BTN","BWA","CAF","CAN","CHE","CHL","CHN","CIV","CMR","COG","COL","COM","CPV","CRI","CUB","CYP","CZE","DEU","DJI","DNK","DOM","DZA","ECU","EGY","ERI","ESP","EST","ETH","FIN","FJI","FRA","FSM","GAB","GBR","GEO","GHA","GIN","GMB","GNB","GNQ","GRC","GRD","GTM","GUM","GUY","HKG","HND","HRV","HTI","HUN","IDN","IND","IRL","IRN","IRQ","ISL","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KOR","KWT","LAO","LBN","LBR","LBY","LCA","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MDA","MDG","MDV","MEX","MKD","MLI","MLT","MMR","MNE","MNG","MOZ","MRT","MUS","MWI","MYS","NAM","NCL","NER","NGA","NIC","NLD","NOR","NPL","NZL","OMN","PAK","PAN","PER","PHL","PNG","POL","PRI","PRT","PRY","PYF","QAT","ROU","RUS","RWA","SAU","SDN","SEN","SGP","SLB","SLE","SLV","SOM","SSD","STP","SUR","SVK","SVN","SWE","SWZ","SYR","TCD","TGO","THA","TJK","TKM","TLS","TON","TTO","TUN","TUR","TZA","UGA","UKR","URY","USA","UZB","VCT","VEN","VIR","VNM","VUT","WSM","YEM","ZAF","COD","ZMB","ZWE")
Life_Expectancy_At_Birth_1960 <- c(65.5693658536586,32.328512195122,32.9848292682927,62.2543658536585,52.2432195121951,65.2155365853659,65.8634634146342,61.7827317073171,70.8170731707317,68.5856097560976,60.836243902439,41.2360487804878,69.7019512195122,37.2782682926829,34.4779024390244,45.8293170731707,69.2475609756098,52.0893658536585,62.7290487804878,60.2762195121951,67.7080975609756,59.9613658536585,42.1183170731707,54.2054634146342,60.7380487804878,62.5003658536585,32.3593658536585,50.5477317073171,36.4826341463415,71.1331707317073,71.3134146341463,57.4582926829268,43.4658048780488,36.8724146341463,41.523756097561,48.5816341463415,56.716756097561,41.4424390243903,48.8564146341463,60.5761951219512,63.9046585365854,69.5939268292683,70.3487804878049,69.3129512195122,44.0212682926829,72.1765853658537,51.8452682926829,46.1351219512195,53.215,48.0137073170732,37.3629024390244,69.1092682926829,67.9059756097561,38.4057073170732,68.819756097561,55.9584878048781,69.8682926829268,57.5865853658537,39.5701219512195,71.1268292682927,63.4318536585366,45.8314634146342,34.8863902439024,32.0422195121951,37.8404390243902,36.7330487804878,68.1639024390244,59.8159268292683,45.5316341463415,61.2263414634146,60.2787317073171,66.9997073170732,46.2883170731707,64.6086585365854,42.1000975609756,68.0031707317073,48.6403170731707,41.1719512195122,69.691756097561,44.945512195122,48.0306829268293,73.4286585365854,69.1239024390244,64.1918292682927,52.6852682926829,67.6660975609756,58.3675853658537,46.3624146341463,56.1280731707317,41.2320243902439,49.2159756097561,53.0013170731707,60.3479512195122,43.2044634146342,63.2801219512195,34.7831707317073,42.6411951219512,57.303756097561,59.7471463414634,46.5107073170732,69.8473170731707,68.4463902439024,69.7868292682927,64.6609268292683,48.4466341463415,61.8127804878049,39.9746829268293,37.2686341463415,57.0656341463415,60.6228048780488,28.2116097560976,67.6017804878049,42.7363902439024,63.7056097560976,48.3688048780488,35.0037073170732,43.4830975609756,58.7452195121951,37.7736341463415,59.4753414634146,46.8803902439024,58.6390243902439,35.5150487804878,37.1829512195122,46.9988292682927,73.3926829268293,73.549756097561,35.1708292682927,71.2365853658537,42.6670731707317,45.2904634146342,60.8817073170732,47.6915853658537,57.8119268292683,38.462243902439,67.6804878048781,68.7196097560976,62.8089268292683,63.7937073170732,56.3570487804878,61.2060731707317,65.6424390243903,66.0552926829268,42.2492926829268,45.6662682926829,48.1876341463415,38.206,65.6598292682927,49.3817073170732,30.3315365853659,49.9479268292683,36.9658780487805,31.6767073170732,50.4513658536585,59.6801219512195,69.9759268292683,68.9780487804878,73.0056097560976,44.2337804878049,52.768243902439,38.0161219512195,40.2728292682927,54.6993170731707,56.1535365853659,54.4586829268293,33.7271219512195,61.3645365853659,62.6575853658537,42.009756097561,45.3844146341463,43.6538780487805,43.9835609756098,68.2995365853659,67.8963902439025,69.7707317073171,58.8855365853659,57.7238780487805,59.2851219512195,63.7302195121951,59.0670243902439,46.4874878048781,49.969512195122,34.3638048780488,49.0362926829268,41.0180487804878,45.1098048780488,51.5424634146342)
Life_Expectancy_At_Birth_2013 <- c(75.3286585365854,60.0282682926829,51.8661707317073,77.537243902439,77.1956341463415,75.9860975609756,74.5613658536585,75.7786585365854,82.1975609756098,80.890243902439,70.6931463414634,56.2516097560976,80.3853658536585,59.3120243902439,58.2406341463415,71.245243902439,74.4658536585366,76.5459512195122,75.0735365853659,76.2769268292683,72.4707317073171,69.9820487804878,67.9134390243903,74.1224390243903,75.3339512195122,78.5466585365854,69.1029268292683,64.3608048780488,49.8798780487805,81.4011219512195,82.7487804878049,81.1979268292683,75.3530243902439,51.2084634146342,55.0418048780488,61.6663902439024,73.8097317073171,62.9321707317073,72.9723658536585,79.2252195121951,79.2563902439025,79.9497804878049,78.2780487804878,81.0439024390244,61.6864634146342,80.3024390243903,73.3199024390244,74.5689512195122,75.648512195122,70.9257804878049,63.1778780487805,82.4268292682927,76.4243902439025,63.4421951219512,80.8317073170732,69.9179268292683,81.9682926829268,68.9733902439024,63.8435853658537,80.9560975609756,74.079512195122,61.1420731707317,58.216487804878,59.9992682926829,54.8384146341464,57.2908292682927,80.6341463414634,73.1935609756098,71.4863902439024,78.872512195122,66.3100243902439,83.8317073170732,72.9428536585366,77.1268292682927,62.4011463414634,75.2682926829268,68.7046097560976,67.6604146341463,81.0439024390244,75.1259756097561,69.4716829268293,83.1170731707317,82.290243902439,73.4689268292683,73.9014146341463,83.3319512195122,70.45,60.9537804878049,70.2024390243902,67.7720487804878,65.7665853658537,81.459756097561,74.462756097561,65.687243902439,80.1288780487805,60.5203902439024,71.6576829268293,74.9127073170732,74.2402926829268,49.3314634146342,74.1634146341464,81.7975609756098,73.9804878048781,80.3391463414634,73.7090487804878,68.811512195122,64.6739024390244,76.6026097560976,76.5326585365854,75.1870487804878,57.5351951219512,80.7463414634146,65.6540975609756,74.7583658536585,69.0618048780488,54.641512195122,62.8027073170732,74.46,61.466,74.567512195122,64.3438780487805,77.1219512195122,60.8281463414634,52.4421463414634,74.514756097561,81.1048780487805,81.4512195121951,69.222,81.4073170731707,76.8410487804878,65.9636829268293,77.4192195121951,74.2838536585366,68.1315609756097,62.4491707317073,76.8487804878049,78.7111951219512,80.3731707317073,72.7991707317073,76.3340731707317,78.4184878048781,74.4634146341463,71.0731707317073,63.3948292682927,74.1776341463415,63.1670487804878,65.878756097561,82.3463414634146,67.7189268292683,50.3631219512195,72.4981463414634,55.0230243902439,55.2209024390244,66.259512195122,70.99,76.2609756097561,80.2780487804878,81.7048780487805,48.9379268292683,74.7157804878049,51.1914878048781,59.1323658536585,74.2469268292683,69.4001707317073,65.4565609756098,67.5223658536585,72.6403414634147,70.3052926829268,73.6463414634147,75.1759512195122,64.2918292682927,57.7676829268293,71.159512195122,76.8361951219512,78.8414634146341,68.2275853658537,72.8108780487805,74.0744146341464,79.6243902439024,75.756487804878,71.669243902439,73.2503902439024,63.583512195122,56.7365853658537,58.2719268292683,59.2373658536585,55.633)
~~~~
> First we load the corresponding data in the form of arrays.

~~~~
Life60 <- data.frame(Code= Country_Code, Life.Expectancy= Life_Expectancy_At_Birth_1960)
Life13 <- data.frame(Code= Country_Code, Life.Expectancy= Life_Expectancy_At_Birth_2013)
~~~~
> Once the arrays have been created, we will create the dataframes using them.  
In this case, since the data does not have column names, we will assign them during the same creation 
of each dataframe.  
`variable <- data.frame(column_name= array_name)`

### 4. Merging Dataframes  
~~~~
DF60 <- merge(mydf1960, Life60, by.x = "Country.Code", by.y = "Code")
DF13 <- merge(mydf2013, Life13, by.x = "Country.Code", by.y = "Code")
~~~~
> The next step is to join the created dataframes, so that only one is left for each year.  
The `merge()` function allows us to join two dataframes, specifying the names of the columns by which 
the union can be made.  
`variable <- merge(dataframe1, dataframe2, by.x = "column_dataframe1", by.y = "column_dataframe2")`  

~~~~
head(DF60)
head(DF13)
~~~~
> We use the `head()` function to verify that the dataframes have joined correctly.  
This function is used to display the first lines of the dataframe, as well as the names of the columns.  

~~~~
rm(df1960, df2013, Life13, Life60, mydf1960, mydf2013, Country_Code, Life_Expectancy_At_Birth_1960, Life_Expectancy_At_Birth_2013)
~~~~
> Now that we have created the dataframes, we can eliminate the ones we will no longer use, as well 
as the declared arrays.  

### 5. Visualizing data  
~~~~
library(ggplot2)
~~~~
> Before proceeding to make representations of the data by means of graphing, it is necessary to 
load the library "ggplot2".  

#### 5.1 Year 1960  
~~~~
qplot(data = DF60, x = Fertility.Rate, y = Life.Expectancy,
      color = Country.Name, size=I(3), shape=I(19), alpha =I(.4), 
      main = "Life Expectancy vs Fertility Rate")
~~~~
> The `qplot()` function allows us to represent certain information in the form of a scatter plot, 
specifying:  
> * Dataframe from where the data will be obtained: `data = DF60`.  
> * Columns for the "x" and "y" axes: `x = Fertility.Rate, y = Life.Expectancy`.    
> * Classification for the information to be displayed by colors or a single color in specific: `color = Country.Name`.  
> * Size, shape and opacity of the figures to be used: `size=I(3), shape=I(19), alpha =I(.4)`.
>   * In the case of the shape the values can go from 0 to 25.  
>   * In the case of opacity (alpha) the values can go from 0 to 1 (decimal numbers).  
> * Graphic title: `main = "Life Expectancy vs Fertility Rate"`.  

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/LE vs FR 1960.png" 
alt="Life Expectancy vs Fertility Rate 1960" width="100%">

~~~~
qplot(data = DF60, x = Fertility.Rate, y = Life.Expectancy,
      color = Region, size=I(3), shape=I(19), alpha =I(.4), 
      main = "Life Expectancy vs Fertility Rate by Region (1960)")
~~~~

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/LE vs FR Region 1960.png" 
alt="Life Expectancy vs Fertility Rate by Region (1960)" width="55%">


#### 5.2 Year 2013 
~~~~
qplot(data = DF13, x = Fertility.Rate, y = Life.Expectancy,
      color = Country.Name, size=I(3), shape=I(19), alpha =I(.4), 
      main = "Life Expectancy vs Fertility Rate")
~~~~

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/LE vs FR 2013.png" 
alt="Life Expectancy vs Fertility Rate 2013" width="100%">

~~~~
qplot(data = DF13, x = Fertility.Rate, y = Life.Expectancy,
      color = Region, size=I(3), shape=I(19), alpha =I(.4), 
      main = "Life Expectancy vs Fertility Rate by Region (2013)")
~~~~

<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/LE vs FR Region 2013.png" 
alt="Life Expectancy vs Fertility Rate by Region (2013)" width="55%">

### 6. Results analysis  

**Life Expectancy vs Fertility Rate 1960**
* Analyzing the results, it was found that Europe has life expectancy (Approx 70 years) and low fertility rate and Africa with high fertility rate but with low life expectancies Approx (50 years).

**Life Expectancy vs Fertility Rate 2013**
* In 2013 Asia reached Europe in terms of life expectancy (Approx 80 years, 10 years more than in 1960), but with low fertility rate. Africa remains the opposite, having low life expectancy, however, from 1960 to 2013, its life expectancy increased approximately 10-15 and its fertility rate is still high, which means that measures are not being taken to decrease the birth seeing the situation regarding life expectancy.
