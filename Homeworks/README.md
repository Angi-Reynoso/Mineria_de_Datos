# Index #  
* [Homework 1: Grammar of Graphics](#homework-1)  
* [Homework 2: Geom_Jitter()](#homework-2)  

<br>

---

<br>

# HOMEWORK 1
### Grammar of Graphics
A grammar of graphics is a tool that enables us to concisely describe the components of a graphic. Such a grammar allows us to move beyond named graphics (e.g., the “scatterplot”) and gain insight into the deep structure that underlies statistical graphics.  

The layered grammar defines the components of a plot as:  
* a default dataset and set of mappings from variables to aesthetics,  
* one or more layers, with each layer having one geometric object, one statistical trans-formation, one position adjustment, and optionally, one dataset and set of aesthetic mappings,  
* one scale for each aesthetic mapping used,  
* a coordinate system,  
* the facet specification.  
These components are independent, meaning that we can generally change a single component in isolation.  
  
The layer component is particularly important as it determines the physical representation of the data, with the combination of stat and geom defining many familiar named graphics: the scatterplot, histogram, contourplot, and so on. In practice, many plots have(at least) three layers: the data, context for the data, and a statistical summary of the data. For example, to visualize a spatial point process, we might display the points themselves, amap giving some spatial context, and the contours of a two-dimensional density estimate.  
  
This grammar is useful for both the user and the developer of statistical graphics. For the user, it makes it easier to iteratively update a plot, changing a single feature at a time. The grammar is also useful because it suggests the high-level aspects of a plot that can be changed, giving us a framework to think about graphics, and hopefully shortening the distance from mind to paper. It also encourages the use of graphics customized to a particular problem rather than relying on generic named graphics.  
  
For the developer, it makes it much easier to create new capabilities. You only need to add the one component that you need, and you can continue to use all the other existing components. For example, you can add a new statistical transformation, and continue to use the existing scales and geoms. It is also useful for discovering new types of graphics,as the grammar defines the parameter space of statistical graphics.  
  
#### I. LAYERS  
Layers are responsible for creating the objects that we perceive on the plot. A layer is composed of four parts:  
1. **Data and aesthetic mapping**  
Data are obviously a critical part of the plot, but it is important to remember that they are independent from the other components: we can construct a graphic that can be applied to multiple datasets. Data are what turns an abstract graphic into a concrete graphic. Along with the data, we need a specification of which variables are mapped to which aesthetics. For example, we might map weight to  x position, height to y position, and age to size. The details of the mapping are described by the scales.  
  
2. **A statistical transformation (stat)**  
A statistical transformation, or stat, transforms the data, typically by summarizing them in some manner. For example, a useful stat is the smoother, which calculates the mean of y, conditional on x, subject to some restriction that ensures smoothness.  
A stat takes a dataset as input and returns a dataset as output, and so a stat can add new variables to the original dataset. It is possible to map aesthetics to these new variables.  
The statistical method used by a stat should be conditional on the coordinate system.  
  
3. **A geometric object (geom)**  
Geometric  objects,  or geoms  for  short,  control  the  type  of  plot  that  you  create.  For example,  using  a  point  geom  will  create  a  scatter plot,  whereas  using  a  line  geom  will create a line plot. We can classify geoms by their dimensionality:  
    * 0d: point, text,  
    * 1d: path, line (ordered path),  
    * 2d: polygon, interval.  

    Geometric objects are an abstract component and can be rendered in different ways.  
Geoms are mostly general purpose, but do require certain outputs from a statistic.  
Every  geom  has  a  default  statistic,  and  every  statistic  a  default  geom.  For  example, the bin statistic defaults to using the bar geom to produce a histogram. Overriding these defaults will still produce a valid plot, but it may violate graphical conventions. Each geom can only display certain aesthetics. For example, a point geom has position, color, shape, and size aesthetics. A bar geom has position, height, width, and fill color. Different parameterizations may be useful.  
  
4. **A position adjustment**  
Sometimes we need to tweak the position of the geometric elements on the plot, when otherwise they would obscure each other.   This is most common in bar plots, where we stack or dodge (place side-by-side) the bars to avoid overlaps. In scatter plots with  few unique x and y values, we sometimes randomly jitter the points to reduce overplotting. Wilkinson called these collision modifiers.  
  
#### II. SCALES  
A scale controls the mapping from data to aesthetic attributes, and so we need one scale for each aesthetic property used in a layer. Scales are common across layers to ensure a consistent mapping from data to aesthetics. A scale is a function, and its inverse, along with a set of parameters.  
  
The inverse function is used to draw a guide so that you can read values from the graph. Guides are either axes (for position scales) or legends (for everything else). Most mappings have a unique inverse (i.e., the mapping function is one-to-one), but many do not. A unique inverse makes it possible to recover the original data, but this is not always desirable if we want to focus attention on a single aspect.  
  
Scales typically map from a single variable to a single aesthetic, but there are exceptions. For example, we can map one variable to hue and another to saturation, to create a single aesthetic, color. We can also create redundant mappings, mapping the same variable to multiple aesthetics. This is particularly useful when producing a graphic that works in both color and black and white.  
  
There are two types of guides: scale guides and annotation guides. In the layered grammar, the scale guides (axes and legends) are largely drawn automatically based on options supplied to the relative scales. Annotation guides, used to highlight important data points, are not needed because they can be constructed with creative use of geoms if data dependent, or if not, the underlying drawing system can be used directly. Scales are also computed somewhat differently as it is possible to map a variable produced by a statistic to an aesthetic. This requires two passes of scaling, before and after the statistical transformation.  
  
#### III. COORDINATE SYSTEM  
A coordinate system, coord for short, maps the position of objects onto the plane of the plot. Position is often specified by two coordinates (x, y), but could be any number of coordinates. The Cartesian coordinate system is the most common coordinate system for two dimensions, whereas polar coordinates and various map projections are used less frequently.  
Coordinate systems affect all position variables simultaneously and differ from scales in that they also change the appearance of the geometric objects. For example, in polar coordinates, bar geoms look like segments of a circle. Additionally, scaling is performed before statistical transformation, whereas coordinate transformations occur afterward.  
Coordinate systems control how the axes and grid lines are drawn.  
  
#### IV. FACETING  
There is also another graphical tool that turns out to be sufficiently useful that we should include it in our general framework: faceting (a more general case of the plots known as conditioned or trellis plots). Faceting makes it easy to create small multiples of different subsets of an entire dataset. This is a powerful tool when investigating whether patterns are the same or different across conditions. The  faceting specification describes which variables should be used to split up the data, and how they should be arranged.  


<br><br>

### “ggplot2” LIBRARY IN R
The intuition behind ggplot2 is very simple. The construction of the data is done based on layers that contain certain types of information.  

1. **Data**  
The first layer is the data that we will use.  

2. **Aesthetics**  
The second layer corresponds to the mapping of the variables within the space. In this step, we use `mapping = aes()`, which will contain the variable that we will have on our x-axis and our y-axis. For `aes()` there are many more options, some of them are, for example, fill, color, shape, and alpha. All these options are a set of signs that will allow us to better translate what we want to say through our graphic. These options are usually called aesthetics or aes().  

3. **Geometric object**  
It sounds strange, but when we talk about a geom or geometric object, we are talking about the type of graph we want to make, be it a line graph, a bar graph, a histogram, a density graph, or a dot graph, or if we want to make a boxplot. This is the third layer.  

4. **Faceting**  
It is not always necessary, but it is always useful to show what you can achieve. When we use this layer, what we are looking for is to organize the geometries that we are using based on a categorical variable.  

5. **Transformations**  
Another layer that you can use is a layer that will allow you to do scale transformations on your variables. It will normally appear with the name scale_x_discrete, which will vary depending on the aesthetics that we are using within our mapping.  

6. **Coordinate system**  
Normally, we will work with an x-axis and a y-axis. There are functions in ggplot2 like `coord_flip` that will allow us to change the direction of our graph. But we can also use this type of layer when we work with geographic data or when, for example, we want to make a pie chart.  

7. **Themes**  
When we map the data, we use aesthetic options. When we want to change how the graph looks, we change the theme. This can be done through a theme, which allows you to modify issues that are not related to the content of the graphic. For example, the colors of the background or the type of letters of the axes. You can also change where the legend will be located, the location of the title, the title, the name of the axes, add annotations, etc.  


> Hadley Wickham (2010) A Layered Grammar of Graphics, Journal of Computational and Graphical Statistics, 19:1, 3-28, DOI: 10.1198/jcgs.2009.07098  
> Capítulo 4 Visualización de datos | AnalizaR Datos Políticos. (2019). Arcruz0.github.io. Retrieved 27 April 2020, from https://arcruz0.github.io/libroadp/dataviz.html


<br>

---

<br>

# HOMEWORK 2
### Geom_Jitter()  
The jitter geom is a convenient shortcut for geom_point(position = "jitter"). It adds a small amount of random variation to the location of each point, and is a useful way of handling overplotting caused by discreteness in smaller datasets.  

#### Usage  
~~~~
geom_jitter(mapping = NULL, data = NULL, stat = "identity",  
  position = "jitter", ..., width = NULL, height = NULL,  
  na.rm = FALSE, show.legend = NA, inherit.aes = TRUE)  
~~~~

#### Arguments  

<table>
<tr>
    <td><code>mapping</code></td>
    <td>
      Set of aesthetic mappings created by <code>aes()</code> or <code>aes_()</code>. If specified and <code>inherit.aes = TRUE</code> (the default), it is combined with the default mapping at the top level of the plot. You must supply mapping if there is no plot mapping.
    </td>
</tr>
<tr>
    <td><code>data</code></td>
    <td>
      The data to be displayed in this layer. There are three options:  
      If NULL, the default, the data is inherited from the plot data as specified in the call to <code>ggplot()</code>.  
      A data.frame, or other object, will override the plot data. All objects will be fortified to produce a data frame.  
      A function will be called with a single argument, the plot data. The return value must be a data.frame, and will be used as the layer data. A function can be created from a formula (e.g. <code>~ head(.x, 10)</code>). 
    </td>
</tr>
<tr>
    <td><code>stat</code></td>
    <td>
      The statistical transformation to use on the data for this layer, as a string. 
    </td>
</tr>
<tr>
    <td><code>position</code></td>
    <td>
      Position adjustment, either as a string, or the result of a call to a position adjustment function.
    </td>
</tr>
<tr>
    <td><code>...</code></td>
    <td>
      Other arguments passed on to <code>layer()</code>. These are often aesthetics, used to set an aesthetic to a fixed value, like colour = "red" or size = 3. They may also be parameters to the paired geom/stat. 
    </td>
</tr>
<tr>
    <td><code>width</code></td>
    <td>
      Amount of vertical and horizontal jitter. The jitter is added in both positive and negative directions, so the total spread is twice the value specified here.  
      If omitted, defaults to 40% of the resolution of the data: this means the jitter values will occupy 80% of the implied bins. Categorical data is aligned on the integers, so a width or height of 0.5 will spread the data so it's not possible to see the distinction between the categories. 
    </td>
</tr>
<tr>
    <td><code>height</code></td>
    <td>
      Amount of vertical and horizontal jitter. The jitter is added in both positive and negative directions, so the total spread is twice the value specified here.  
      If omitted, defaults to 40% of the resolution of the data: this means the jitter values will occupy 80% of the implied bins. Categorical data is aligned on the integers, so a width or height of 0.5 will spread the data so it's not possible to see the distinction between the categories.
    </td>
</tr>
<tr>
    <td><code>na.rm</code></td>
    <td>
      If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed. 
    </td>
</tr>
<tr>
    <td><code>show.legend</code></td>
    <td>
      logical. Should this layer be included in the legends? NA, the default, includes if any aesthetics are mapped. FALSE never includes, and TRUE always includes. It can also be a named logical vector to finely select the aesthetics to display. 
    </td>
</tr>
<tr>
    <td><code>inherit.aes</code></td>
    <td>
      If FALSE, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g. <code>borders()</code>. 
    </td>
</tr>
</table>
 
#### Aesthetics  
`geom_point()` understands the following aesthetics (required aesthetics are in bold):  
* x
* y
* alpha
* colour
* fill
* group
* shape
* size
* stroke

#### Examples  
~~~~
p <- ggplot(mpg, aes(cyl, hwy))
p + geom_point()
~~~~
<img src="https://ggplot2.tidyverse.org/reference/geom_jitter-1.png" 
alt="image" width="55%">

~~~~
p + geom_jitter()
~~~~
<img src="https://ggplot2.tidyverse.org/reference/geom_jitter-2.png" 
alt="image" width="55%">

~~~~
# Add aesthetic mappings
p + geom_jitter(aes(colour = class))
~~~~
<img src="https://ggplot2.tidyverse.org/reference/geom_jitter-3.png" 
alt="image" width="55%">

~~~~
# Use smaller width/height to emphasise categories
ggplot(mpg, aes(cyl, hwy)) + geom_jitter()
~~~~
<img src="https://ggplot2.tidyverse.org/reference/geom_jitter-4.png" 
alt="image" width="55%">

~~~~
ggplot(mpg, aes(cyl, hwy)) + geom_jitter(width = 0.25)
~~~~
<img src="https://ggplot2.tidyverse.org/reference/geom_jitter-5.png" 
alt="image" width="55%">

~~~~
# Use larger width/height to completely smooth away discreteness
ggplot(mpg, aes(cty, hwy)) + geom_jitter()
~~~~
<img src="https://ggplot2.tidyverse.org/reference/geom_jitter-6.png" 
alt="image" width="55%">

~~~~
ggplot(mpg, aes(cty, hwy)) + geom_jitter(width = 0.5, height = 0.5)
~~~~
<img src="https://ggplot2.tidyverse.org/reference/geom_jitter-7.png" 
alt="image" width="55%">

> Jittered points — geom_jitter. (2020). Ggplot2.tidyverse.org. Retrieved 27 April 2020, from https://ggplot2.tidyverse.org/reference/geom_jitter.html  

---

<br>

# HOMEWORK 3
### What is a p-value?
The p-value is actually the probability of obtaining a sample like ours, or more extreme than ours IF the null hypothesis is true. So we assume that the null hypothesis is true and then determine how "strange" our sample really is. If it's not that strange (a large p-value), then we don't change our minds about the null hypothesis. As the p-value gets smaller, we start to wonder if the null value is really true and good, maybe we should change our mind (and reject the null hypothesis).

**A little more detail:**

* A small p-value indicates that just by sheer luck, it would be unlikely to get a sample like the one we have if the null hypothesis is true. If this is small enough, we begin to think that we may not be very lucky, and instead our assumption that the nullity is true is incorrect. That is why we reject with a small p-value.

* A large p-value indicates that it would be quite normal to obtain a sample like ours if the null hypothesis is true. As you can see, there is no reason to change your mind here as we did with a small p-value.

The approximation of the P value to aid in decision-making is quite natural since almost all computer packages that provide hypothesis test computation deliver P values along with values from the appropriate test statistic.

* A P value is the lowest level (of significance) at which the observed value of the test statistic is significant.
* The P value is the smallest level of significance leading to the rejection of the null hypothesis Ho.


>What is a p-value? (2012, enero 21).  Retrieved May 2 2020, from https://www.mathbootcamps.com/what-is-a-p-value/
