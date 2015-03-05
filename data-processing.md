iDigBio DataProcessing Presentation
========================================================
author: Derek Masaki
date: March 9, 2015

Data Processing Using R
========================================================

Processing is
**80-90%** of Data Analysis

Most data requires some level of processing to be used

- Fix variable names
- Create new variables
- Merge data sets
- Handle missing data
- Transform variables
- Detect and remove inconsistent values

Files/Datasets
========================================================

Dropbox Links:



https://www.dropbox.com/s/qz25wwgesl4kshr/USGS_DRO_flat.txt?dl=0
https://www.dropbox.com/s/bee6cyk450m6041/Field2DB_Instructions.R?dl=0




RStudio
========================================================

   ![RStudio-Screenshot](rstudio_screen_capture.JPG)

RStudio
========================================================

Panels

   Identify and Click on Tabs Within Panels


   - Source, Console, Environment, Packages
   - Modify Panel Layout - RStudio>>Preferences
   -  Navigate Through Panels




RStudio - Console Panel
========================================================

In console panel you can type commands directly


```r
getwd()
```

```
[1] "C:/Users/derek/R"
```

Type a command and run it

```r
Sys.time()
```

```
[1] "2015-03-05 15:32:55 EST"
```

RStudio - R Scripts Introduction
========================================================


Why Use Scripts?

***


1. *Document/Comment Procedures*

1. *Reproducibility*

1. *Reduce Error*

1. *Avoid Repetitive Tasks*



R Script Example
========================================================


```r
# Import data
pwrcwb <- read.csv("CWBMaster.csv")

# Review data
View(pwrcwb)
View(pwrcwbspecies)

# Modify dataset
pwrcwb_join$header<-NULL

# Write results to file
write.csv(pwrcwb_join,"pwrcwb_bison_final_2015-02-06.csv",row.names=FALSE)
```


Let's Create A New R Script
========================================================

In the menu bar, click
**File >> New File>>R Script**

   *A new untitled tab will appear in Source Panel*

**Select File >> Save** Type: Field2DB

Navigate to History Tab

Highlight R Code >> **ClickTo Source**

Highlight R Code >> **ClickTo Console**


Script Elements
========================================================

Comments - Lines starting with # will not execute

```r
# Import dataset
# View dataset
# Review data
```
Executable code - run using editor Click Run; [ctrl][enter]

```r
getwd()
Sys.time()
```

Script Outline
========================================================
1. Download Data
1. Import Data from File
1. View Data
1. Transform
1. Write Out to File

Add to Field2DB.R file - Download
========================================================
incremental: true
Path https://www.dropbox.com/s/qz25wwgesl4kshr/USGS_DRO_flat.txt?dl=0


```r
# Import dataset

# Download data from:
# https://www.dropbox.com/s/qz25wwgesl4kshr/
# USGS_DRO_flat.txt?dl=0
```
Use web browser to download this file. Copy to working directory.

Add to Field2DB.R file - Import Data
========================================================
incremental: true
Tab delimited text file - read into a dataframe


```r
# Read Data In and Create Dataframe Object
usgsdata<-read.delim("USGS_DRO_flat.txt")
```

Field2DB.R file
========================================================

```r
# Review dataset

View(usgsdata)
```


Subset - Field2DB.R
========================================================


```r
# Subset data

usgsdata10k<-usgsdata[1:10000,]

View(usgsdata10k)
```

Field2DB.R Date Formatting
========================================================


```r
# Date Process  Transform Character String to ISO Date

usgsdatatnlas$date<-
  substr(usgsdatatnlas$time1,1,8)

usgsdatatnlas$iso_date<-
  as.Date(strptime(usgsdatatnlas$date,'%Y%m%d'))

usgsdatatn$year<-
  as.character
  (format(usgsdatatnlas$iso_date,"%Y"))
```

Field2DB.R file
========================================================


```r
# check for null values

colnames(usgsdatatnlas)

usgsdatatnlas_nolatlon<-
  usgsdatatnlas
  [!complete.cases(usgsdatatnlas[,14:15]),]
```

Field2DB.R Detect Null Values
========================================================

```r
colnames(usgsdatatn)

# subset rows with null values

usgsdatatn_na<- usgsdatatn[usgsdatatn$name=='',]

View(usgsdatatn_na)
```


Field2DB.R file Remove Nulls
========================================================

```r
# drop rows with null values
```

```r
colnames(usgsdatatn)

# subset rows with null values

usgsdatatn<- usgsdatatn[usgsdatatn$name!='',]

View(usgsdatatn)
```

Field2DB.R Pattern Matching
========================================================


```r
# Extract records from Tennessee

usgsdatatn<-usgsdata10k
  [usgsdata10k$state=="Tennessee",]

View(usgsdatatn)

grep(pattern, x , ignore.case=FALSE, fixed=FALSE)
```

Field2DB.R Pattern Matching
========================================================


```r
# Extract records Lasioglossum genus

usgsdatatnlas<-usgsdatatn
  [grep("Lasioglossum",usgsdatatn$name,
    ignore.case=FALSE, fixed=TRUE),]

View(usgsdatatnlas)

row.names(usgsdatatnlas)<-NULL
```

Field2DB.R file Concatenate Fields
========================================================

```r
# concatenate field values

usgsdatatnlas$method <- paste(usgsdatatnlas$how0,
                              usgsdatatnlas$how1,
                              usgsdatatnlas$how2,
                              usgsdatatnlas$how3,
                              usgsdatatnlas$how4,
                              sep=' | ')

usgsdatatnlas$locality <- paste(usgsdatatnlas$city,
                              usgsdatatnlas$site,
                              usgsdatatnlas$habitat,
                              sep=' | ')

usgsdatatnlas$notes <- paste(usgsdatatnlas$field_note,
                              usgsdatatnlas$note,
                              sep=' | ')
```

Field2DB.R file Modify Headers
========================================================

```r
# modify column headers

colnames(usgsdatatnlas)

colnames(usgsdatatnlas)[2]<-"scientific_name"
```

Field2DB.R - Drop Columns
========================================================

```r
# drop un-needed columns

colnames (usgsdatatnlas)

usgsdatatnlas<-usgsdatatnlas[,-c(4:8,10,12,13,16,17,21:38)]
```


Field2DB.R file
========================================================

```r
# write out dataframe to tab delimited text file

write.table(usgsdatatnlas,
            file = "usgs_bees_tenessee_lasioglossum_2015-03-14.txt",
            append = FALSE, quote = FALSE,
            sep = "\t",eol = "\n",
            na = "", dec = ".",
            row.names = FALSE,
            col.names = TRUE)
```

On Your Own
========================================================
Try Running Your R Script Against Entire Dataset

Try Subsetting Different Species

Try Subsetting Different Date Range

Save Each With Different File Name




Join/Merge (Optional)
========================================================
Download Data and Script

https://dl.dropboxusercontent.com/u/4259612/bands.csv
https://dl.dropboxusercontent.com/u/4259612/cntry_state_cnty_lookup.csv
https://dl.dropboxusercontent.com/u/4259612/species_lookup.csv
https://www.dropbox.com/s/ooj4t0feih1189l/pwrc_processing_bbl_2015-01-30.R?dl=0




Mapping (Optional)
========================================================
Download Data and Script

https://www.dropbox.com/s/irx2gth0aei9xzk/sesc_biscayne_map.r?dl=0
https://www.dropbox.com/s/ysw5wme0gd9ulap/sesc_bisc_herpetofauna_2002_2003.CSV?dl=0
