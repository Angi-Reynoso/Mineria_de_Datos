## Instrucciones  
Desarrolle el siguiente problema con R y RStudio para la extracción de conocimiento que el problema requiere.  
* Implementar el modelo de agrupación K-Means con el conjunto de datos Iris.csv que se encuentra en https://github.com/jcromerohdz/iris utilizando el método kmeans() en R.  
* Una vez que se obtenga el modelo de agrupamiento hacer el análisis de visualización de datos correspondiente.  
* Al finalizar el desarrollo explicar detalladamente en qué consiste el modelo de agrupación K-Means y cuáles fueron sus observaciones en el análisis de visualización de los datos.  

### K-Means Clustering  
K-Means es un método de agrupamiento o clustering. El clustering es una técnica para encontrar y clasificar "K" grupos de datos (clusters). Así, los elementos que comparten características semejantes estarán juntos en un mismo grupo, separados de los otros grupos con los que no comparten características.  

## Pasos  
**1. Establecer el directorio de trabajo**
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/Examen U4")
getwd()
~~~  
> Se utiliza `getwd()` para conocer la ruta actual. 
> Con `setwd()` se especifica la ruta en la cual se quiere trabajar.  
> Usamos nuevamente `getwd()` para comprobar el cambio correcto de la ruta actual.  

**2. Importar el dataset**  
~~~
dataset = read.csv('iris.csv')
dataset = dataset[3:4]
~~~  
> Se carga el archivo con el dataset: iris.csv.  
> Se especifican las columnas con las cuales se quiere trabajar, en este caso la 3 y la 4.  

**3. Método del Codo (Elbow Method)**  
El _método del codo_ nos sirve para encontrar el número óptimo de clusters (grupos) a utilizar.  
~~~
set.seed(6)
wcss = vector()
for (i in 1:10) wcss[i] = sum(kmeans(dataset, i)$withinss)
plot(1:10,
     wcss,
     type = 'b',
     main = paste('The Elbow Method'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')
~~~  
> Damos aleatoriedad a los datos con la función `seed()`.  
> Se crea un vector vacío para ir almacenando los resultados obtenidos de cada número de cluster puesto a prueba.  
> Utilizando un ciclo for, y mediante la función `kmeans()`, se calcula la suma de cuadrados dentro de cada cluster, y los resultados se almacenan dentro del vector creado anteriormente (wcss).  
> Una vez finalizados los cálculos, se utiliza la función `plot()` para visualizar los resultados en forma de gráfica lineal:  
> * _1:10_ = Número de resultados a desplegar.  
> * _wcss_ = Vector con los resultados.  
> * _type 'b'_ = Gráfica de líneas y puntos.  
> * _main_ = Nombre de la gráfica.  
> * _xlab_ = Nombre del eje x.  
> * _ylab_ = Nombre del eje y.  

La gráfica resultante es la siguiente:  
<img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_3/Images/ExamU4 - Elbow Method.png" width = "65%">  
> Como resultado se obtiene que el número de cluster óptimo es el 3; esto se puede apreciar en la gráfica mediante la pequeña "fluctuación" que existe sobre este punto, en comparación de la dirección que posee el resto de la línea.  

**4. Ajustar K-Means al dataset**  
~~~
set.seed(29)
kmeans = kmeans(x = dataset, centers = 3)
y_kmeans = kmeans$cluster
~~~  
> Nuevamente, se da aleatoriedad a los datos con la función `seed()`.  
> Se utiliza la función `kmeans()` para crear el modelo:  
> * _x_ = datos a utilizar (dataset).  
> * _centers_ = número de k, clusters o grupos (se toma el valor obtenido en el paso anterior).  

> Una vez creado el modelo, este se utiliza para hacer la clasificación de los datos mediante `kmeans$cluster`.  
> El resultado que se obtiene del paso anterior es un vector de enteros (de 1 hasta k) que indica el grupo al que se asigna cada punto (datos del dataset).  
> Al imprimirse la variable donde se almacena la clasificación, obtendríamos algo como lo siguiente:  
~~~
> y_kmeans
  [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
 [39] 3 3 3 3 3 3 3 3 3 3 3 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 [77] 1 2 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 1 2 2 2 2 2 2 2
[115] 2 2 2 2 2 1 2 2 2 1 2 2 1 1 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2
~~~  
> En este caso, si los resultados de la clasificación se comparan con los del dataset original, se obtiene que 9 puntos fueron clasificados de manera errónea, lo cual corresponde a un 94% de nivel de exactitud del modelo.  

**5. Visualización de los clusters (grupos)**  
~~~
install.packages('cluster')
library(cluster)
clusplot(dataset,
         y_kmeans,
         lines = 0, 
         shade = TRUE, 
         color = TRUE, 
         labels = 2,
         plotchar = FALSE, 
         span = TRUE, 
         main = paste('Clusters of Iris'), 
         xlab = 'Petal Length',
         ylab = 'Petal Width')
~~~  
> Primero instalamos e importamos la librería `cluster` para poder visualizar de manera gráfica los resultados de la clasificación del modelo.  
> Utilizamos la función `clusplot`, la cual sirve para dibujar un "clusplot" bidimensional o diagrama de clustering, en el dispositivo gráfico actual.  
> * _dataset_ = Datos a utilizar (dataset).  
> * _y_kmeans_ = Clasificación de los datos.  
> * _lines_ = Opción para dibujar líneas entre los centros de los grupos de la gráfica.  
>   * "0" = desactivado.  
>   * "1" = dibujar por encima.  
>   * "2" = dibujar por debajo.  
> * _shade_ = Poner sombreado dentro de las figuras de los grupos (líneas diagonales).  
> * _color_ = Utilizar diferentes colores para cada grupo.  
> * _labels_ = Tipo de etiquetas a utilizar para los grupos.  
>   * "2" = Números de dato y de grupo.  
>   * "3" = Sólo números de dato.  
>   * "4" = Sólo números de grupo.  
> * _plotchar_ = Utilizar figuras diferentes para los datos dentro de los grupos.  
> * _span_ = Crear separaciones entre los grupos.  
> * _main_ = Título del gráfico (`paste` sirve para concatenar cadenas tipo string).  
> * _xlab_ = Título del eje x.  
> * _ylab_ = Título del eje y.  

La gráfica resultante es la siguiente:  
<img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_3/Images/ExamU4 - Petal.png" width = "65%">  

### Conclusión  
Con la gráfica anterior podemos comprobar los errores que se identificaron durante el paso 4, ya que a diferencia del grupo número 3 (en color rosa), los grupos 1 (en color azul) y 2 (en color rojo) presentan una intersección, dentro de la cual pudieran encontrarse los datos que fueron mal clasificados.  
No obstante, el porcentaje de error obtenido es mínimo, por lo cual, se puede decir que el modelo funciona bastante bien en su mayoría.  

<br>

---

### Observaciones Extra  
Para la aplicación del modelo únicamente se pedían 2 variables, una para el eje x y otra para el eje y, sin embargo dentro del dataset original se contaba con 4 columnas (sin incluir la de las clasificaciones de los datos), entonces se optó por separar las variables en conjuntos de 2, y hacer pruebas con cada conjunto para comprobar cuál era el que obtenía mejores resultados.  
Por la gráfica anterior y los datos ya presentados, se conoce que la mejor opción fue aquella donde se utilizaron las variables: petal_length y petal_width, no obstante, como evidencia adicional, a continuación se muestran los resultados de las clasificaciones hechas por el modelo para para el segundo conjunto: sepal_lenght y sepal_width.  

Resultados de clasificación en y_kmeans: _27 datos erróneos, 82% de nivel de exactitud_.  
~~~
> y_kmeans
  [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
 [39] 3 3 3 3 3 3 3 3 3 3 3 3 2 2 2 1 2 1 2 1 2 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 2 2
 [77] 2 2 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 2 2 2 1 2 2 2 2 2 2 1
[115] 1 2 2 2 2 1 2 1 2 1 2 2 1 1 2 2 2 2 2 1 1 2 2 2 1 2 2 2 1 2 2 2 1 2 2 1
~~~  

Gráficas resultantes:  
<img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_3/Images/ExamU4 - Elbow Method2.png" width = "65%">  

<img src = "https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_3/Images/ExamU4 - Sepal.png" width = "65%">  

> En este caso la gráfica para el método del codo no varía mucho de la anterior, obteniendo también el 3 como número de clusters óptimo. No obstante, la gráfica que corresponde a la clasificación de los datos, si varía bastante, comenzando por el hecho de que con este conjunto de datos los 3 grupos poseen una intersección con algún otro:  
> * El grupo 3 (en color azul) intersecta con el grupo 1 (en color rosa).  
> * El grupo 1 (en color rosa) intersecta con el grupo 2 (en color rojo).  

> Esto demuestra el por qué del aumento en el número de errores, quedando así, muy por debajo a los resultados obtenidos con el conjunto anterior (petal_length y petal_width).  
