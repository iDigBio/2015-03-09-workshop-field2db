## R lesson on APIs
## Field to Database workshop
## 3/12/2015 at iDigBio
##
## Line with one "#" in front are R code you can uncomment to follow along.
## Lines with two "##" are comments and should be left in place. Beware that
## some of this code calls external APIs which may be slow. Resist the urge
## to uncomment everything!
##
## Pre-work:
##
## 1) Get a NOAA web token here: http://www.ncdc.noaa.gov/cdo-web/token
##
## 2) Create a plot.ly account here: http://plot.ly/
##
## 3) Install the following R packages: rnoaa, ridigbio, plotly, gridExtra
##
## On Ubuntu, needed at least these libraries: apt-get install libgdal-dev 
## libproj-dev to install rnoaa
## 

## Install packages

## You almost certainly have these installed already, please don't re-install
## them.
##install.packages("devtools")
##install.packages("jsonlite")
##install.packages("grid")
##install.packages("ggplot2")

## You will need to install these
#library("devtools")
#install.packages("gridExtra")
#install.packages("rnoaa")
#install_github("iDigBio/ridigbio")
#install_github("ropensci/plotly")


## Load survey & species data from Portal, AZ

species <- read.csv("data/species.csv", stringsAsFactors=FALSE)
surveys <- read.csv("data/surveys.csv", stringsAsFactors=FALSE)

## What are we interested in?

gen <- "Chaetodipus"
sp <- "penicillatus"

## Do we have any in our Portal survey data?

sp_row <- subset(species, genus==gen & species==sp)
survey_cha_pen <- subset(surveys, species_id==sp_row$species_id)


## CHALLENGE
## 
## How many Chaetodipus penicillatus were trapped in Portal, AZ?


## Let's look at the month they were collected to see if that reflects this
## species being dormant during winter.

hist(survey_cha_pen$month, breaks=1:12)

## Wow, sure does. But what if our scientist was lazy and didn't go out to the
## field when it was cold? How can we gauge sampling effort from the data? 

hist(surveys$month, breaks=1:12)

## Now it's time to compare this to a wider data set. Recall the hypothesis is 
## that these mice are less active in "southern Arizona". Let's look for mice 
## collected in other places.

## Load the ridigbio library (install first if needed)

library("ridigbio")


## PAUSE TO CHECK THAT EVERYONE HAS THIS LOADED


## Remember the JSON out, JSON in slide from the API introduction? We're going
## to have to build a data structure that R can transform into the JSON the API
## expects to see. This is something ridigbio has chosen to use, not all
## packages work this way.

query <- list("scientificname"=paste(gen, sp))

## (
## Let's look at how R encodes objects as JSON. This block is a side-trip and 
## not something you need to remember. The ridigbio package (and others) take 
## care of this for you.

library("jsonlite")
toJSON(query)

## Now compare that to the documentation for what the iDigBio API expects for a
## record query: https://github.com/iDigBio/idigbio-search-api/wiki/Query-Format
## Skip down to "Searching for multiple values within a field"
## )

## Back to searching for mice in iDigBio:

cha_pen_idig <- idig_search_records(rq=query)

## Unlike the surveys data set, iDigBio provides a dwc:DateCollected field as a
## string and not a month number. We need to add a column to the cha_pen_idig
## data frame with month number. We'll do that in 3 steps:
##
## 1) Change the datecollected vector to date objects
## 2) Use R's date functions to get just the month from the date object
## 3) Bind the resulting vector back to the data frame

cha_pen_idig_months <- format(
                              as.Date(cha_pen_idig$datecollected), 
                              "%m")

## CHALLENGE
## 
##  Do step 3 and add the cha_pen_idig_months column to the cha_pen_idig data 
## frame as "monthcollected". The next line won't work until you do.

#cha_pen_idig <- cbind(

  
## Now let's make a histogram on month collected.

hist(as.numeric(cha_pen_idig$monthcollected), breaks=1:12)

## Not as clear is it? We don't have a convenient measure of sampling effort
## here to help us with why.

## Remember this histogram? The nice one?

hist(survey_cha_pen$month, breaks=1:12)

## Wouldn't you love to see an average monthly temperature graph below it?
## Folks from Norway probably don't have a good idea of what "winter" is
## is like in Arizona. Let's get some data from NOAA.


## BACK TO POWER POINT!


## Start by loading the library and filling in the web token you got from
## NOAA via email. Also, the station name is long to type so let's save it as a
## variable too. (tlnrvjzLToJojhXEsUYzeGNmUEUHurYk)

library("rnoaa")
tok <- ""
stn <- "GHCND:USC00026716"

## The rnoaa package requires us to know the name of the data set that we are
## going to download. Because the datasets vary by station, let's get a list
## of all the datasets for our station.


## CHALLENGE
##
## Use "?" to look at the help for the ncdc_datasets function. Call the 
## function to get a list of the datasets the station has availible.

#ncdc_datasets(


## After you've met the challenge above, just type in the name of the dataset
## that has the monthly summaries into the assignment below.

ds_name <- ""

## The NOAA API is not the fastest way to get lots of data. We're just going to
## get one year of monthly summaries. The limit parameter will make sense when
## we look at what is returned by ncdc.

weather <- ncdc(datasetid=ds_name, stationid=stn, startdate='2014-01-01',
                enddate='2014-12-01', limit=300, token=tok)

## Take a look at weather with head(). Can you describe what you see?


## BACK TO POWER POINT!


# Now that we know the units and the column we want, let's pull that out to
# to it's own vector to be easier to work with.

mean_temp <- subset(weather$data, weather$data$datatype=="MNTM")
mean_temp$degf <- mean_temp$value/10*9/5 + 32


## (
## Another aside: You can write your own functions in R. That C to F conversion
## is just asking to be made into a function:

c_to_f <- function (c){
  c*9/5 + 32
}

## Now try:

mean_temp$degf_fun <- c_to_f(mean_temp$value/10)

## Simpler than having to rewrite a lot of formulas. Functions can contain any
## R code that you want to reuse.
## )


## Remember our goal here is to make a graph of average monthly temperature to
## compare to the collection frequency of our mouse. Lets make it look like a 
## bar chart to match the histogram we drew before.

plot(mean_temp$degf, type="n")
lines(mean_temp$degf, type="s")
lines(mean_temp$degf, type="h")


## CHALLENGE
##
## Use "?" to look at the help for the par() function. Scroll down to the mfcol, 
## mfrow parameters section and read it. Call par() with the mfrow parameter to
## get ready to make a layout with the collection histogram above the 
## temperature plot.

#par(

  
## Now let's draw both our graphs again on the same layout:

hist(survey_cha_pen$month, breaks=1:12)
plot(mean_temp$degf, type="n")
lines(mean_temp$degf, type="s")
lines(mean_temp$degf, type="h")


## BACK TO POWERPOINT!


## The plot.ly URL: https://plot.ly/ggplot2/getting-started/
##
## Paste in the rest of your credentials here:

library("plotly")
#set_credentials_file(


## We're going to go really fast here. I had hoped to use rfigshare but is has
## a bug in it that causes crashes at the moment so we'll have to use plotly.
## They use ggplot2 for plotting so we'll have to re-do our plots using some 
## slightly more complicated commands.

library(ggplot2)
library(grid)
library(gridExtra)
mice <- ggplot(survey_cha_pen, aes(survey_cha_pen$month)) + 
        geom_histogram(fill=NA, color="black", binwidth=1) + theme_bw()

## Notice that we assigned the plot to a variable. We're going to pass that
## plot to a function in the plot.ly package that will upload it to your
## account. Probably it will open a browser window too but in case it does not
## the last line will print out the URL to your plot.
  
py <- plotly()
resp <- py$ggplotly(mice)
resp$response$url

