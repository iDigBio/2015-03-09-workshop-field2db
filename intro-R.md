
# Introduction to R

* Start RStudio
* Under the `File` menu, click on `New project`, choose `New directory`, then
  `Empty project`
* Enter a name for this new folder, and choose a convenient location for
  it. This will be your **working directory** for the rest of the day
  (e.g., `~/field2db`)
* Click on "Create project"
* Under the `Files` tab on the right of the screen, click on `New Folder` and
  create a folder named `data` within your newly created working directory.
  (e.g., `~/field2db/data`)
* Create a new R script (File > New File > R script) and save it in your working
  directory (e.g. `intro-R.R`)

## Good practices

There are two main ways of interacting with R: using the console or by using
script files (plain text files that contain your code).

The recommended approach when working on a data analysis project is dubbed "the
source code is real". The objects you are creating should be seen as disposable
as they are the direct realization of your code. Every object in your analysis
can be recreated from your code, and all steps are documented. Therefore, it is
best to enter as little commands as possible in the R console. Instead, all code
should be written in script files, and evaluated from there. The R console
should be used to inspect objects, test a function or get help. With this
approach, the `.Rhistory` file automatically created during your session should
not be very useful.

You may want your RStudio settings (Tools > Global options) so that the
following three settings are unchecked:

- "Restore most recently opened project at startup"
- "Restore previously open source document at startup" (less important)
- "Restore .RData into workspace at startup"

and Select "Never" for "Save workspace to .RData on exit".

Similarly, you should separate the original data (raw data) from intermediate
datasets that you may create for the need of a particular analysis. For
instance, you may want to create a `data/` directory within your working
directory that stores the raw data, and have a `data_output/` directory for
intermediate datasets and a `figure_output/` directory for the plots you will
generate.

You can choose your own names for these folders, but it's important that you
document their purpose (and their content) in a README file, and that you are
coherent in their usage.

## Creating objects



Let's start by creating a simple object:


```r
x <- 10
x
```

```
## [1] 10
```

We assigned to `x` the number 10. `<-` is the assignment operator. It assigns
values on the right to objects on the left. Mostly similar to `=` but not
always. Learn to use `<-` as it is good programming practice. Using `=` in place
of `<-` can lead to issues down the line. In RStudio, use the key combination
`Alt + -` to generate the assignment operator.

`=` should only be used to specify the values of arguments in functions for
instance `read.csv(file="data/some_data.csv")`.

Now that `x` exists in R memory, We can do things with it. For instance:


```r
x * 2
```

```
## [1] 20
```

```r
x + 5
```

```
## [1] 15
```

```r
x + x
```

```
## [1] 20
```

or we can create new objects using `x`:


```r
y <- x + x + 5
```

Let's try something different:


```r
x <- c(2, 4, 6)
x
```

```
## [1] 2 4 6
```

Two things:

- we overwrote the content of `x`
- `x` now contains 3 elements

Using the `[]`, we can access individual elements of this object:


```r
x[1]
```

```
## [1] 2
```

```r
x[2]
```

```
## [1] 4
```

```r
x[3]
```

```
## [1] 6
```

---

### Challenge

What is the content of this vector?


```r
q <- c(x, x, 5)
```

What is the value of `y` at the end of this script?


```r
x <- 1
y <- x + 2
x <- 3
# y <- ???
```

---

We can also use these objects with functions, for instance to compute the mean
and the standard deviation:


```r
x <- c(1, 3, 5, 6, 3, 5)
mean(x)
```

```
## [1] 3.833333
```

```r
sd(x)
```

```
## [1] 1.834848
```

This is useful to print the value of the mean or the standard deviation, but we
can also save these values in their own variables:

```r
mean_x <- mean(x)
mean_x
```

The function `ls()` returns the objects that are currently in the memory of
your session.

The function `data()` allows you to load into memory datasets that are provided
as examples with R (or some packages). Let's load the `Nile` dataset that
provides the annual flow of the river Nile between 1871 and 1970.

```r
data(Nile)
```

Using `ls()` shows you that the function `data()` made the variable `Nile`
available to you.

Let's make an histogram of the values of the flows:

```r
hist(Nile)
```

---

### Challenge

The following: `abline(v=100, col="red")` would draw a vertical line on an
existing plot at the value 100 colored in red.

How would you add such a line to our histogram to show where the mean falls in
this distribution?

---

We can now save this plot in its own file:


```r
pdf(file="nile_flow.pdf")
hist(Nile)
abline(v=mean(Nile), col="red")
dev.off()
```

------

## Vectors

Vectors are at the heart of how data are stored into R's memory. Almost
everything in R is stored as a vector. When we typed `x <- 10` we created a
vector of length 1. When we typed `x <- c(2, 4, 6)` we created a vector of
length 3. These vectors are of class `numeric`. Vectors can be of 6 different
classes (we'll mostly work with 4).

### The different "classes" of vector

Vectors can hold numbers, characters, logical values and a special class that
characterizes R, factors.

* `"numeric"` is the general class for vectors that hold numbers (e.g., `c(1, 5,
  10)`)
* `"integer"` is the class for vectors for integers. To differentiate them from
  `numeric` we must add an `L` afterwards (e.g., `c(1L, 2L, 5L)`)
* `"character"` is the general class for vectors that hold text strings (e.g.,
  `c("blue", "red", "black")`)
* `"logical"` for holding `TRUE` and `FALSE` (boolean data type)

The other types of vectors are `"complex"` (for complex numbers) and `"raw"` a
special internal type that is not of use for the majority of users.


### Naming the elements of a vector

```r
fav_colors <- c("red", "blue", "green", "yellow")
names(fav_colors)
names(fav_colors) <- c("John", "Lucy", "Greg", "Sarah")
fav_colors
names(fav_colors)
unname(fav_colors)
```

### How to access elements of a vector?

They can be accessed by their indices:

```r
fav_colors[2]
fav_colors[2:4]
```

repeatitions are allowed:

```r
fav_colors[c(2,3,2,4,1,2)]
```

or if the vector is named, it can be accessed by the names of the elements:

```r
fav_colors[c("John")]
```

---

### Challenges

* How to access the content of the vector for "Lucy", "Sarah" and "John" (in this
order)?
* How to get the name of the second person?

---

### How to update/replace the value of a vector?

```r
x[4] <- 22
```

```r
fav_colors["Sarah"] <- "turquoise"
```


### How to add elements to a vector?

```r
x <- c(5, 10, 15, 20)
x <- c(x, 25) # adding at the end
x <- c(0, x)  # adding at the beginning
x
```

With named vectors:

```r
fav_colors
c(fav_colors, "purple")
fav_colors <- c(fav_colors, "Tracy" = "purple")
```

Notes:

* here is the case where using the `=` is OK/needed
* pay attention to where the quotes are

---

### Challenge

* If we add another element to our vector:

```r
fav_color <- c(fav_colors, "black")
```

how to use the function `names()` to assign the name "Ana" to this last element?

---


### How to remove elements from a vector?

```r
x[-5]
x[-c(1, 3, 5)]
```

but this `fav_colors[-c("Tracy")]` does not work. We need to use the function
`match()`:

```r
fav_colors[-match("Tracy", names(fav_colors))]
```

The function `match()` looks for the position of the **first exact match**
within another vector.


### Sequences

`:` is a special function that creates numeric vectors of integer in increasing
or decreasing order, test `1:10` and `10:1` for instance. The function `seq()`
(for __seq__uence) can be used to create more complex patterns:


```r
seq(1, 10, by=2)
```

```
## [1] 1 3 5 7 9
```

```r
seq(5, 10, length.out=3)
```

```
## [1]  5.0  7.5 10.0
```

```r
seq(50, by=5, length.out=10)
```

```
##  [1] 50 55 60 65 70 75 80 85 90 95
```

```r
seq(1, 8, by=3) # sequence stops to stay below upper limit
```

```
## [1] 1 4 7
```

```r
seq(1.1, 2, length.out=10)
```

```
##  [1] 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0
```

### Repeating

```r
x <- rep(8, 4)
x
rep(1:3, 3)
```

### Operations on vectors

```r
x <- c(5, 10, 15)
x + 10
x + c(10, 15, 20)
x * 10
x * c(2, 4, 3)
```

Note that operations on vectors are elementwise.

### Recycling

R allows you to do operations on vectors of different lengths. The shorter
vector will be "recycled" (~ repeated) to match the length of the longer one:

```r
x <- c(5, 10, 15)
x + c(2, 4, 6, 8, 10, 12)     # no warning when it's a multiple
x + c(2, 4, 6, 8, 10, 12, 14) # warning
```

### Boolean operations and Filtering

```r
u <- c(1, 4, 2, 5, 6, 3, 7)
u[TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE]
u < 3
u[u < 3]
u[u < 3 | u >= 4]
u[u > 5 & u < 1 ] ## nothing matches this condition
u[u > 5 & u < 8]
```

With character strings:

```r
fav_colors <- c("John" = "red", "Lucy" = "blue", "Greg" = "green",
                "Sarah" = "yellow", "Tracy" = "purple")
fav_colors == "blue"
fav_colors[fav_colors == "blue"]
which(fav_colors == "blue")
names(fav_colors)[which(fav_colors == "blue")]
```

## Presentation of the Survey Data

We are studying the species and weight of animals caught in plots in our study
area.  The dataset is stored as a `.csv` file: each row holds information for a
single animal, and the columns represent `survey_id` , `month`, `day`, `year`,
`plot`, `species` (a 2 letter code, see the `species.csv` file for
correspondance), `sex` ("M" for males and "F" for females), `wgt` (the weight in
grams).

The first few rows of the survey dataset look like this:

    "63","8","19","1977","3","DM","M","40"
    "64","8","19","1977","7","DM","M","48"
    "65","8","19","1977","4","DM","F","29"
    "66","8","19","1977","4","DM","F","46"
    "67","8","19","1977","7","DM","M","36"

To load our survey data, we need to locate the `surveys.csv` file. We will use
`read.csv()` to load into memory (as a `data.frame`) the content of the CSV
file.



```r
download.file("http://files.figshare.com/1919744/surveys.csv", "data/surveys.csv")
download.file("http://files.figshare.com/1919741/species.csv", "data/species.csv")
surveys <- read.csv('data/surveys.csv')
```

<!--- this chunk if for internal use so code in this lesson can be evaluated --->


This statement doesn't produce any output because assignment doesn't display
anything. If we want to check that our data has been loaded, we can print the
variable's value: `surveys`

Wow... that was a lot of output. At least it means the data loaded
properly. Let's check the top (the first 6 lines) of this `data.frame` using the
function `head()`:


```r
head(surveys)
```

```
##   record_id month day year plot_id species_id sex hindfoot_length weight
## 1         1     7  16 1977       2         NL   M              32     NA
## 2         2     7  16 1977       3         NL   M              33     NA
## 3         3     7  16 1977       2         DM   F              37     NA
## 4         4     7  16 1977       7         DM   M              36     NA
## 5         5     7  16 1977       3         DM   M              35     NA
## 6         6     7  16 1977       1         PF   M              14     NA
```

Let's now check the __str__ucture of this `data.frame` in more details with the
function `str()`:


```r
str(surveys)
```

```
## 'data.frame':	35549 obs. of  9 variables:
##  $ record_id      : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ month          : int  7 7 7 7 7 7 7 7 7 7 ...
##  $ day            : int  16 16 16 16 16 16 16 16 16 16 ...
##  $ year           : int  1977 1977 1977 1977 1977 1977 1977 1977 1977 1977 ...
##  $ plot_id        : int  2 3 2 7 3 1 2 1 1 6 ...
##  $ species_id     : Factor w/ 49 levels "","AB","AH","AS",..: 17 17 13 13 13 24 23 13 13 24 ...
##  $ sex            : Factor w/ 6 levels "","F","M","P",..: 3 3 2 3 3 3 2 3 2 2 ...
##  $ hindfoot_length: int  32 33 37 36 35 14 NA 37 34 20 ...
##  $ weight         : int  NA NA NA NA NA NA NA NA NA NA ...
```

__Also, show how to get this information from the "Environment" tab in RStudio.__


### Challenge

Based on the output of `str(surveys)`, can you answer the following questions?

* What is the class of the object `surveys`?
* How many rows and how many columns are in this object?
* How many species have been recorded during these surveys?



As you can see, the columns `species` and `sex` are of a special class called
`factor`. Before we learn more about the `data.frame` class, we are going to
talk about factors. They are very useful but not necessarily intuitive, and
therefore require some attention.


## Factors

Factors are used to represent categorical data. Factors can be ordered or
unordered and are an important class for statistical analysis and for plotting.

Factors are stored as integers, and have labels associated with these unique
integers. While factors look (and often behave) like character vectors, they are
actually integers under the hood, and you need to be careful when treating them
like strings.

Once created, factors can only contain a pre-defined set values, known as
*levels*. By default, R always sorts *levels* in alphabetical order. For
instance, if you have a factor with 2 levels:


```r
sex <- factor(c("male", "female", "female", "male"))
```

R will assign `1` to the level `"female"` and `2` to the level `"male"` (because
`f` comes before `m`, even though the first element in this vector is
`"male"`). You can check this by using the function `levels()`, and check the
number of levels using `nlevels()`:


```r
levels(sex)
```

```
## [1] "female" "male"
```

```r
nlevels(sex)
```

```
## [1] 2
```

Sometimes, the order of the factors does not matter, other times you might want
to specify the order because it is meaningful (e.g., "low", "medium", "high") or
it is required by particular type of analysis. Additionally, specifying the
order of the levels allows to compare levels:


```r
food <- factor(c("low", "high", "medium", "high", "low", "medium", "high"))
levels(food)
```

```
## [1] "high"   "low"    "medium"
```

```r
food <- factor(food, levels=c("low", "medium", "high"))
levels(food)
```

```
## [1] "low"    "medium" "high"
```

```r
min(food) ## doesn't work
```

```
## Error in Summary.factor(structure(c(1L, 3L, 2L, 3L, 1L, 2L, 3L), .Label = c("low", : 'min' not meaningful for factors
```

```r
food <- factor(food, levels=c("low", "medium", "high"), ordered=TRUE)
levels(food)
```

```
## [1] "low"    "medium" "high"
```

```r
min(food) ## works!
```

```
## [1] low
## Levels: low < medium < high
```

In R's memory, these factors are represented by numbers (1, 2, 3). They are
better than using simple integer labels because factors are self describing:
`"low"`, `"medium"`, and `"high"`" is more descriptive than `1`, `2`, `3`. Which
is low?  You wouldn't be able to tell with just integer data. Factors have this
information built in. It is particularly helpful when there are many levels
(like the species in our example data set).

### Converting factors

If you need to convert a factor to a character vector, simply use
`as.character(x)`.

Converting a factor to a numeric vector is however a little trickier, and you
have to go via a character vector. Compare:


```r
f <- factor(c(1, 5, 10, 2))
as.numeric(f)               ## wrong! and there is no warning...
```

```
## [1] 1 3 4 2
```

```r
as.numeric(as.character(f)) ## works...
```

```
## [1]  1  5 10  2
```

```r
as.numeric(levels(f))[f]    ## The recommended way.
```

```
## [1]  1  5 10  2
```

### Challenge

The function `table()` tabulates observations and can be used to create
bar plots quickly. For instance:


```r
## Question: How can you recreate this plot but by having "control"
## being listed last instead of first?
exprmt <- factor(c("treat1", "treat2", "treat1", "treat3", "treat1", "control",
                   "treat1", "treat2", "treat3"))
table(exprmt)
```

```
## exprmt
## control  treat1  treat2  treat3 
##       1       4       2       2
```

```r
barplot(table(exprmt))
```

![plot of chunk challenge-factor](figure/challenge-factor-1.png) 

## About the `data.frame` class



`data.frame` is the _de facto_ data structure for most tabular data and what we
use for statistics and plotting.

A `data.frame` is a collection of vectors of identical lengths. Each vector
represents a column, and each vector can be of a different class (e.g.,
characters, integers, factors). The `str()` function is useful to inspect the
data types of the columns.

The most common way you are going to create `data.frame` objects is when you
will use the functions `read.csv()` or `read.table()`, in other words, when
importing spreadsheets from your hard drive (or the web).


You can also create `data.frame` manually with the function `data.frame()`. This
function can also take the argument `stringsAsFactors`. Compare the output of
these examples:


```r
example_data <- data.frame(animal=c("dog", "cat", "sea cucumber", "sea urchin"),
                           feel=c("furry", "furry", "squishy", "spiny"),
                           weight=c(45, 8, 1.1, 0.8))
str(example_data)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ animal: Factor w/ 4 levels "cat","dog","sea cucumber",..: 2 1 3 4
##  $ feel  : Factor w/ 3 levels "furry","spiny",..: 1 1 3 2
##  $ weight: num  45 8 1.1 0.8
```

Here you can observe the default behavior of the `data.frame` function. The
columns `animal` and `feel` are of class `factor`. By default, `data.frame`
converts (= coerces) columns that contain characters (i.e., text) into a vector
of class `factor`. Depending on what you want to do with the data, you may want
to keep these columns as `character`. To do so, `read.csv()` and `read.table()`
have an argument called `stringsAsFactors` which can be set to `FALSE`:



```r
example_data <- data.frame(animal=c("dog", "cat", "sea cucumber", "sea urchin"),
                           feel=c("furry", "furry", "squishy", "spiny"),
                           weight=c(45, 8, 1.1, 0.8), stringsAsFactors=FALSE)
str(example_data)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ animal: chr  "dog" "cat" "sea cucumber" "sea urchin"
##  $ feel  : chr  "furry" "furry" "squishy" "spiny"
##  $ weight: num  45 8 1.1 0.8
```

If you want to manually change the class of one of the column, you can use the
function `as.factor()` (below we'll cover in more detail how to work with
columns):


```r
example_data$feel <- as.factor(example_data$feel)
str(example_data)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ animal: chr  "dog" "cat" "sea cucumber" "sea urchin"
##  $ feel  : Factor w/ 3 levels "furry","spiny",..: 1 1 3 2
##  $ weight: num  45 8 1.1 0.8
```

### Challenge

1. There are a few mistakes in this hand crafted `data.frame`, can you spot and
fix them? Don't hesitate to experiment!


```r
author_book <- data.frame(author_first=c("Charles", "Ernst", "Theodosius"),
                          author_last=c(Darwin, Mayr, Dobzhansky),
                          year=c(1942, 1970))
```

2. Can you predict the class for each of the columns in the following example?
   Check your guesses using `str(country_climate)`. Are they what you expected?
   Why? why not?


```r
country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18, "15"),
                              north_hemisphere=c(TRUE, TRUE, FALSE, "FALSE"),
                              has_kangaroo=c(FALSE, FALSE, FALSE, 1))
```

   Check your guesses using `str(country_climate)`. Are they what you expected?
   Why? why not?

   R coerces (when possible) to the data type that is the least common
   denominator and the easiest to coerce to. You can review the notes from the
   second lecture to review the coercion rules R uses.


## Inspecting `data.frame` objects

We already saw how the functions `head()` and `str()` can be useful to check the
content and the structure of a `data.frame`. Here is a non-exhaustive list of
functions to get a sense of the content/structure of the data.

* Size:
	* `dim()` - returns a vector with the number of rows in the first element, and
	  the number of columns as the second element (the __dim__ensions of the object)
	* `nrow()` - returns the number of rows
	* `ncol()` - returns the number of columns
* Content:
	* `head()` - shows the first 6 rows
	* `tail()` - shows the last 6 rows
* Names:
	* `names()` - returns the column names (synonym of `colnames()` for `data.frame`
	objects)
	* `rownames()` - returns the row names
* Summary:
	* `str()` - structure of the object and information about the class, length and
	content of  each column
	* `summary()` - summary statistics for each column

Note: most of these functions are "generic", they can be used on other types of
objects besides `data.frame`.

### Challenge

Use these functions on the `surveys` data set loaded in R.


## Slicing data

Our survey data frame has rows and columns (it's a 2-dimensional object), if we
want to extract some specific data from it (a slice of it), we need to specify
the "coordinates" we want the data to come from. To do this, we use the square
bracket notation (just like with vectors), except that we need to add a comma to
indicate the rows and columns we want. Row numbers come first, followed by
column numbers. Here are some examples:


```r
surveys[1, 1]   # first element in the first column of the data frame
surveys[1, 6]   # first element in the 6th column
surveys[1:3, 7] # first three elements in the 7th column
surveys[3, ]    # the 3rd element for all columns
surveys[, 8]    # the entire 8th column
head_surveys <- surveys[1:6, ] # surveys[1:6, ] is equivalent to head(surveys)
```

### Challenge

1. The function `nrow()` on a `data.frame` returns the number of rows. Use it,
   in conjuction with `seq()` to create a new `data.frame` called
   `surveys_by_10` that includes every 10th row of the survey data frame
   starting at row 10 (10, 20, 30, ...)


## Subsetting data



In particular for larger datasets, it can be tricky to remember the column
number that corresponds to a particular variable (Are species names in column 6
or 8? oh, right... they are in column 7), and using the column number to extract
the data (i.e., `surveys[, 7]`) may not be practical. In some cases, in which
column the variable will be can change if the script you are using adds or
removes columns. It's therefore often better to use column names to refer to a
particular variable, and it makes your code easier to read and your intentions
clearer.

You can do operations on a particular column, by selecting it using the `$`
sign. In this case, the entire column is a vector. For instance, to extract all
the weights from our datasets, we can use: `surveys$wgt`. You can use
`names(surveys)` or `colnames(surveys)` to remind yourself of the column names.

In some cases, you may way to select more than one column. You can do this using
the square brackets: `surveys[, c("wgt", "sex")]`.

When analyzing data, though, we often want to look at partial statistics, such
as the maximum value of a variable per species or the average value per plot.

One way to do this is to select the data we want, and create a new temporary
array, using the `subset()` function. For instance, if we just want to look at
the animals of the species "DO":


```r
surveys_DO <- subset(surveys, species == "DO")
```

### Challenge

1. What does the following do (Try to guess without executing it)?
   `surveys_DO$month[2] <- 8`

1. Use the function `subset` to create a `data.frame` that contains all
individuals of the species "DM" that were collected in 2002. How many
individuals of the species "DM" were collected in 2002?


## Adding a column to our dataset



Sometimes, you may have to add a new column to your dataset that represents a
new variable. You can add columns to a `data.frame` using the function `cbind()`
(__c__olumn __bind__). Beware, the additional column must have the same number
of elements as there are rows in the `data.frame`.

In our survey dataset, the species are represented by a 2-letter code (e.g.,
"AB"), however, we would like to include the species name. The correspondance
between the 2 letter code and the names are in the file `species.csv`. In this
file, one column includes the genus and another includes the species. First, we
are going to import this file in memory:



```r
species <- read.csv("data/species.csv", stringsAsFactors=FALSE)
```

We are then going to use the function `match()` to create a vector that contains
the genus names for all our observations. The function `match()` takes at least
2 arguments: the values to be matched (in our case the 2 letter code from the
`surveys` data frame held in the column `species`), and the table that contains
the values to be matched against (in our case the 2 letter code in the `species`
data frame held in the column `species_id`). The function returns the position
of the matches in the table, and this can be used to retrieve the genus names:


```r
surveys_spid_index <- match(surveys$species_id, species$species_id)
surveys_genera <- species$genus[surveys_spid_index]
```

Now that we have our vector of genus names, we can add it as a new column to our
`surveys` object:


```r
surveys <- cbind(surveys, genus=surveys_genera)
```

### Challenge

* Use the same approach to also include the species names in the `surveys` data
frame.





* Use the help in R to understand what the function `paste()` does. Use it to
  add a new column called `genus_species` into the `species` `data.frame`.
* Use the help to understand what the function `merge()` does. Use it to create
  a new `data.frame` that combines the content of `surveys` and the modified
  version of `species`.
* Use this data set to answer the following:
  - How many birds have been captured?
  - How many individuals of the genus *Dipodomys* have been captured?



## Adding rows

<!--- Even if this is not optimal, using this approach requires to cover less   -->
<!--- material such as logical operations on vectors. Depending on how fast the -->
<!--- group moves, it might be better to show the correct way.                  -->



Let's create a `data.frame` that contains the information only for the species
"DO" and "DM". We know how to create the data set for each species with the
function `subset()`:


```r
surveys_DO <- subset(surveys, species == "DO")
surveys_DM <- subset(surveys, species == "DM")
```

Similarly to `cbind()` for columns, there is a function `rbind()` (__r__ow
__bind__) that puts together two `data.frame`. With `rbind()` the number of
columns and their names must be identical between the two objects:


```r
surveys_DO_DM <- rbind(surveys_DO, surveys_DM)
```

### Challenge

* Using a similar approach, construct a new `data.frame` that only includes data
for the years 2000 and 2001.



* How does it differ from `subset(surveys, species == "DO" | species == "DM")`?


## Removing columns



Just like you can select columns by their positions in the `data.frame` or by
their names, you can remove them similarly.

To remove it by column number:


```r
surveys_noDate <- surveys[, -c(3:5)]
colnames(surveys)
```

```
##  [1] "record_id"       "month"           "day"            
##  [4] "year"            "plot_id"         "species_id"     
##  [7] "sex"             "hindfoot_length" "weight"         
## [10] "genus"           "species_name"
```

```r
colnames(surveys_noDate)
```

```
## [1] "record_id"       "month"           "species_id"      "sex"            
## [5] "hindfoot_length" "weight"          "genus"           "species_name"
```

The easiest way to remove by name is to use the `subset()` function. This time
we need to specify explicitly the argument `select` as the default is to subset
on rows (as above). The minus sign indicates the names of the columns to remove
(note that the column names should not be quoted):


```r
surveys_noDate2 <- subset(surveys, select=-c(month, day, year))
colnames(surveys_noDate2)
```

```
## [1] "record_id"       "plot_id"         "species_id"      "sex"            
## [5] "hindfoot_length" "weight"          "genus"           "species_name"
```
