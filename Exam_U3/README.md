## Instrucciones 
Desarrolle el siguiente problema con R y RStudio para la extracción de conocimiento que el problema requiere.  
Implementar el modelo de clasificación Naive Bayes con el conjunto de datos Social_Network_Ads.csv y utilizando la librería e1071 con la función naiveBayes().  
Una vez que se obtenga el clasificador hacer el análisis de visualización de datos correspondiente.  
Al finalizar el desarrollo explicar detalladamente en que consiste el modelo de clasificación Naive Bayes y también la explicación detallada correspondiente a visualización de datos.  

**Naive Bayes**  
Naive Bayes es un algoritmo de aprendizaje automático supervisado basado en el teorema de Bayes que se utiliza para resolver problemas de clasificación siguiendo un enfoque probabilístico. Se basa en la idea de que las variables predictoras de un modelo de Machine Learning son independientes entre sí. Lo que significa que el resultado de un modelo depende de un conjunto de variables independientes que no tienen nada que ver entre sí.  

<br>

## Solución  
**1. Establecer el directorio de trabajo**  
~~~
getwd()
setwd("C:/Users/GitHub/DataMining/Examen U3")
getwd()
~~~  

**2. Importar el dataset**  
~~~
dataset = read.csv('Social_Network_Ads.csv')
dataset = dataset[3:5]
~~~  
> Cargamos el archivo con el dataset e indicamos que solo queremos trabajar con las columnas de la 3 a la 5.

**3. Codificar la característica de destino como factor**  
~~~
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))
~~~  
> Con la función factor, especificamos la columna del dataset que queremos predecir.  
> `factor` se usa para codificar un vector como factor.  
>   * `levels` es un vector opcional de los valores únicos (como cadenas de caracteres) que x podría haber tomado.  

**4. Dividir el dataset en Training set y Test set**  
~~~
install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
~~~  
> Instalamos y cargamos la librería caTools.  
> Creamos una semilla para aleatorizar los datos.  
> Dividimos los datos en un 75% para capacitación y un 25% para pruebas, y creamos los subconjuntos de entrenamiento y pruebas.  

**5. Escalado de características**  
~~~
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])
~~~  
> `scale` es una función genérica cuyo método predeterminado centra y/o escala las columnas de una matriz numérica.  
> Se utiliza para transformar, dar significado a los datos en Scala y ayudar a aclarar el algoritmo; en este caso, indicamos que queremos aplicar los cambios a todas las columnas excepto la de predicción.  

**6. Ajustar Naive Bayes al Training set**  
~~~
install.packages('e1071')
library(e1071)
classifier = naiveBayes(formula = Purchased ~ .,
                 data = training_set)
~~~  
> Primero es necesario instalar e importar la librería `e1071` para usar la función `naiveBayes()`.  
> `naiveBayes` calcula las probabilidades a-posteriores condicionales de una variable de clase categórica dadas variables predictoras independientes usando la regla de Bayes. Los siguientes argumentos son necesarios:  
>   * _formula_: La variable a predecir (Purchased) y las características a tomar como base para la predicción ('.' significa que todas serán utilizadas).  
>   * _data_: Es el conjunto de datos a utilizar (training_set).  

**7. Predecir los resultados del Test Set**  
~~~
y_pred = predict(classifier, newdata = test_set[-3])
y_pred
~~~  
> Usando la función `predict`, se calculan las probabilidades de las predicciones que realizará el modelo, tomando como referencia los datos del clasificador creado en el paso anterior e indicando los datos que se utilizarán (test_set menos la columna 3).  

**8. Hacer la Matriz de Confusión**  
~~~
cm = table(test_set[, 3], y_pred)
cm
~~~  
> Usando la función `table`, se crea una matriz de confusión para las predicciones hechas en el paso anterior.  
> Estos son los resultados:  
~~~
y_pred
     0  1
  0 57  7
  1  7 29
~~~

**9. Visualizar los resultados del Training Set**  
~~~
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
~~~  
> Cargamos la librería `ElemStatLearn` para poder visualizar los datos de entrenamiento.  
> Con la función `seq`, se crean las variables X1 y X2, agregando los valores de inicio (min), final (max) e incremento (by).  
> Se crea una cuadrícula de todas las combinaciones de las variables X1 y X2 utilizando la función `expand.grid`, y se nombran sus columnas.  

~~~
y_grid = predict(classifier, grid_set)
~~~  
> La función `predict` se usa nuevamente para calcular la probabilidad de la predicción, en este caso tomando los datos de la cuadrícula creada en el paso anterior (grid_set).  

~~~
plot(set[, -3],
     main = 'Naive Bayes (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> La función `plot` se usa para graficar en función de los datos en las dos primeras columnas del conjunto; se asigna el nombre del gráfico (main) y, los nombres y límites de los ejes (xlab, xlim).  
> La función `contour` se usa para agregar una línea de contorno al gráfico ya creado.  
> La función `points` se usa para agregar una figura al gráfico, en este caso un rectángulo de 0.01 pulgadas por lado, de color 'verde' si se cumple la condición especificada, y si no, de color 'rojo'.  
> Nuevamente se usa la función `points`; en este caso para agregar los datos de entrenamiento como puntos rellenos en el gráfico. Dada una condición, si esto es cierto, el llenado de dichos puntos será 'verde', y si no, será 'rojo'.  

El siguiente es el gráfico resultante:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/ExamU3 - Training.png" width="65%">  

**10. Visualizar los resultados del Test Set**
~~~
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, grid_set)
plot(set[, -3], main = 'Naive Bayes (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
~~~  
> El proceso realizado en el paso anterior se repite, solo que esta vez se utilizarán los datos de prueba.  

El siguiente es el gráfico resultante:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_2/Images/ExamU3 - Test.png" width="65%">  

**Conclusión**  
En ambas gráficas se puede ver que el número de predicciones erróneas fue mínimo, lo que nos muestra que el nivel de exactitud del modelo es bastante bueno.  
Si observamos los resultados obtenidos de la matriz de confusión, podemos ver que, con respecto a los datos de la prueba, el nivel de exactitud del modelo fue aproximadamente del 86%, es decir, de 100 predicciones, 86 fueron correctas y solo 14 fueron erróneas (7 falsos positivos y 7 falsos negativos).
