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
Extract the folder ("UCI HAR Dataset") in the project directory 
</p>

## 1. Merges the training and the test sets to create one data set
<p> 
Needed files according to UCI HAR Dataset 'README.txt': <br>

Recorded data comes from: <br>
'train/X_train.txt': Training set <br> 
'test/X_test.txt': Test set <br>

Activity labels to associate activity to records comes from: <br>
'train/y_train.txt': Training labels <br>
'test/y_test.txt': Test labels <br>

Subject id to associate subjects to records comes from: <br>
'subject_train.txt' <br>
'subject_test.txt' <br> 
</p>

### Read files <br>
<p>
```{r}
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
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

### Label rows with activity labels <br>
<p>
Add columns with activity labels from 'y_...' file to 'X_...' data file <br>
The number and order of rows are the same in each set, we can use cbind to simply add activity label columns (last one) <br>
```{r}
temp_train <- cbind(X_train, y_train)
temp_test <- cbind(X_test, y_test)
```
** Datasets have now 561+1 variables **
</p>

### Label rows with subjet id <br>
<p>
Add columns with subject id from 'subject_...' file to corresponding data file <br>
The number and order of rows are the same in each set, we can use cbind to simply add activity label columns (last one) <br>

```{r}
train <- cbind(temp_train, subject_train)
test <- cbind(temp_test, subject_test)
```
** Datasets have now 561+2 variables **
</p>

### Merge sets <br>
<p>
The number and order of variables are the same in each set, we can use rbind to simply add test data under train data
```{r}
all_data <- rbind(train, test)
```
</p>

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
<p>
</p>

### Find columns to extract <br>
<p>
561 variables are listed in UCI HAR Dataset 'features.txt' <br>
** +2 for activity and subj_id columns at the end**
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
mean_std <- all_data[,c(columns,562,563)] 
```
*562 and 563 were created for activity and subj_id columns*
</p>

## 3. Uses descriptive activity names to name the activities in the data set
<p>
</p>

### Name activities
<p>
According to UCI HAR Dataset README, each descriptive activity names can be found in 'activity_labels.txt' <br>
Activity labels were added to datasets before merging and extracting in step 1 (562th column). <br> 
We have to change labels to corresponding activity names <br>

```{r}
read.table("./UCI HAR Dataset/activity_labels.txt")
```
1 WALKING <br>
2 WALKING_UPSTAIRS <br>
3 WALKING_DOWNSTAIRS <br>
4 SITTING <br>
5 STANDING <br>
6 LAYING <br>

Attribution of names for each value
```{r}
mean_std$V1.1[mean_std$V1.1 == "1"] <- "WALKING"
mean_std$V1.1[mean_std$V1.1 == "2"] <- "WALKING_UPSTAIRS"
mean_std$V1.1[mean_std$V1.1 == "3"] <- "WALKING_DOWNSTAIRS"
mean_std$V1.1[mean_std$V1.1 == "4"] <- "SITTING"
mean_std$V1.1[mean_std$V1.1 == "5"] <- "STANDING"
mean_std$V1.1[mean_std$V1.1 == "6"] <- "LAYING"
```
</p>

## 4. Appropriately labels the data set with descriptive variable names
<p>
According to UCI HAR Dataset README, each variable descriptive names are listed in 'features.txt' <br>
We have to pick the one needed to label selected columns and add the already assigned subj_id label to match number of columns <br>
```{r}
colnames(mean_std) <- c(features$V2[columns], "activity" ,"subj_id" )
head(mean_std)
```
*562th column was added but not renamed, 563th column has already subj_id name but the vector need to have a lenght corresponding to number of columns*
</p>

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
<p>
Tidy data set will be a matrix with the following variables <br>
6 activities <br>
30 subjects x 80 means of "mean and std variables" <br>

### Subseting by activities
```{r}
temp_WALKING <- mean_std[mean_std$activity=="WALKING",]
temp_WALKING_UPSTAIRS <- mean_std[mean_std$activity=="WALKING_UPSTAIRS",]
temp_WALKING_DOWNSTAIRS <- mean_std[mean_std$activity=="WALKING_DOWNSTAIRS",]
temp_SITTING <- mean_std[mean_std$activity=="SITTING",]
temp_STANDING <- mean_std[mean_std$activity=="STANDING",]
temp_LAYING <- mean_std[mean_std$activity=="LAYING",]
```
### Obtain mean values for each activities by subject and (re)label rows with activity for further merging
```{r}
WALKING <- aggregate(x = temp_WALKING[, 1:79], by = list(temp_WALKING$subj_id),FUN = mean)
WALKING$activity <- "WALKING"

WALKING_UPSTAIRS <- aggregate(x = temp_WALKING_UPSTAIRS[, 1:79], by = list(temp_WALKING_UPSTAIRS$subj_id), FUN = mean)
WALKING_UPSTAIRS$activity <- "WALKING_UPSTAIRS"

WALKING_DOWNSTAIRS <- aggregate(x = temp_WALKING_DOWNSTAIRS[, 1:79], by = list(temp_WALKING_DOWNSTAIRS$subj_id), FUN = mean)
WALKING_DOWNSTAIRS$activity <- "WALKING_DOWNSTAIRS"

SITTING <- aggregate(x = temp_SITTING[, 1:79], by = list(temp_SITTING$subj_id), FUN = mean)
SITTING$activity <- "SITTING"

STANDING <- aggregate(x = temp_STANDING[, 1:79], by = list(temp_STANDING$subj_id), FUN = mean)
STANDING$activity <- "STANDING"

LAYING <- aggregate(x = temp_LAYING[, 1:79], by = list(temp_LAYING$subj_id), FUN = mean)
LAYING$activity <- "LAYING"
```

### Recreate one dataset with selected 79 variable averaged by subjects for the 30 subjects in the 6 activities.
```{r}
tidy_dataset<- rbind(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
```
"Group.1" name was given to the first column when we aggregate means, this column is renamed "subjects"
```{r}
names(tidy_dataset)[names(tidy_dataset) == "Group.1"] <- "subject"
```
</p>
