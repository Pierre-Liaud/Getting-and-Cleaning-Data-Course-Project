# **Getting-and-Cleaning-Data-Course-Project**
<p>
Getting and Cleaning Data Course (JHU) in Coursera
</p>

## Setup project 
<p>
</p>

### Create GitHub repo for this project
<p> 
Create and copy Url from a repo dedicated to this project. <br>
Create a new project in R under version control (GIT), paste project Url.
</p>

### Download raw data
<p> 
Data are acquired downloading and extracting zip file from this URL: <br>
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
Extract the folder ("UCI HAR Dataset"") in the project directory 
</p>

### Install and load usefull packages in R
<p>
```{r}
install.packages("tidyverse")
library(tidyverse)
```
</p>

## 1. Merges the training and the test sets to create one data set
<p> 
Needed files according to UCI HAR Dataset 'README.txt': <br>

'train/X_train.txt': Training set <br> 
'test/X_test.txt': Test set

'subject_test.txt''subject_test.txt' will be used to label rows before merging test and training data.  
</p>

### Read files <br>
<p>
```{r}
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
```
'train/X_train.txt' contains 7352 obs. and 561 variables <br> 
'test/X_test.txt' contains 2947 obs. and 561 variables <br>  

**Informations abount variables:** 561 variables are listed in UCI HAR Dataset 'features.txt'

```{r}
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
```
These files contains respectively 7352 and 2947 obs. <br>  

**Informations about observations:** According UCI HAR Dataset 'README.txt', each row of subject files identifies the subject who performed the activity (1 to 30) for each window sample.
</p>

### Merge files <br>
<p>
```{r}
test_train <- rbind()
```
</p>

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
<p>
</p>

### Find columns to extract <br>
<p>
561 variables are listed in UCI HAR Dataset 'features.txt'
```{r}
features <- read.table("./UCI HAR Dataset/features.txt")
```
A vector with columns of variables corresponding to means and standard deviations can be obtained searching for these terms in 'features.txt' (second column) <br>

```{r}
columns <- grep("*mean*|*std*",features$V2) 
```
</p>

### Extract columns in focused tidy dataset <br>
<p>
subseting on column with corresponding variables
```{r}
mean_std <- test_train[,columns] 
```
</p>

## 3. Uses descriptive activity names to name the activities in the data set
<p>
Usefull files according to UCI HAR Dataset README:
'activity_labels.txt': Links the class labels with their activity name
'train/y_train.txt': Training labels
'test/y_test.txt': Test labels

Change (label) in data <br>

1 WALKING <br>
2 WALKING_UPSTAIRS <br>
3 WALKING_DOWNSTAIRS <br>
4 SITTING <br>
5 STANDING <br>
6 LAYING <br>
</p>

## 4. Appropriately labels the data set with descriptive variable names
<p>
Usefull files according to UCI HAR Dataset README:
'activity_labels.txt': Links the class labels with their activity name

from 'feature-info': <br>

prefix 't' to denote time <br>
prefix 'f' to indicate frequency domain signals <br>
"acc" accelerometer data <br>
"Gyro" gyroscope data <br>
"-X" is used to denote 1-axial signals in the X direction <br>
"-Y" is used to denote 1-axial signals in the Y direction <br>
"-Z" is used to denote 1-axial signals in the Z direction <br>
"-XYZ" is used to denote 3-axial signals in the X, Y and Z directions <br>
</p>

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
<p>
</p>


