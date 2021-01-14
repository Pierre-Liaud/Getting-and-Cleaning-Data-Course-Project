# **Getting-and-Cleaning-Data-Course-Project**
<p>
</p>

## Original files used for the project
<p>
Files comes from UCI HAR Dataset<br>
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 

### Files selected to answer to the scope of this project <br>

Recorded data: <br>
*Contain recordings with all of the 6 activities for each of 30 subjects in 561 variables* <br>
'train/X_train.txt': Training set <br> 
'test/X_test.txt': Test set <br>

Activity labels: <br>
*Contain activity labels for each record* <br>
'train/y_train.txt': Training labels <br>
'test/y_test.txt': Test labels <br>

Subject id: <br>
*Contain subject id for each record* <br>
'subject_train.txt'<br> 
'subject_test.txt'<br> 

Features (columns labels): <br>
*Contain the 561 variables names* <br>
'features'<br> 
</p>

## Tidy file
<p>
The Tidy file contain a tables with: <br> 
30 obs.: one for each subject <br>
81 variables: including subject and activity identification 
</p>

<p>
[1] "subject": identify subject id from 1 to 30 <br> 
[2]to[80] "variable name": represent records means for the variable by subject, unities are the same as the original variables <br> 
*The variable names for the Tidy file are the same as the original X_train and X_test files, exept that they represent records means for the variable by subject instead of one record value.* <br>
[81] "activity": identify activity among the following: <br>
WALKING <br>
WALKING_UPSTAIRS <br>
WALKING_DOWNSTAIRS <br>
SITTING <br>
STANDING <br>
LAYING <br> 
</p>

<p>
Complete list of variables: <br>
 [1] "subject"                         "tBodyAcc-mean()-X"              
 [3] "tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"              
 [5] "tBodyAcc-std()-X"                "tBodyAcc-std()-Y"               
 [7] "tBodyAcc-std()-Z"                "tGravityAcc-mean()-X"           
 [9] "tGravityAcc-mean()-Y"            "tGravityAcc-mean()-Z"           
[11] "tGravityAcc-std()-X"             "tGravityAcc-std()-Y"            
[13] "tGravityAcc-std()-Z"             "tBodyAccJerk-mean()-X"          
[15] "tBodyAccJerk-mean()-Y"           "tBodyAccJerk-mean()-Z"          
[17] "tBodyAccJerk-std()-X"            "tBodyAccJerk-std()-Y"           
[19] "tBodyAccJerk-std()-Z"            "tBodyGyro-mean()-X"             
[21] "tBodyGyro-mean()-Y"              "tBodyGyro-mean()-Z"             
[23] "tBodyGyro-std()-X"               "tBodyGyro-std()-Y"              
[25] "tBodyGyro-std()-Z"               "tBodyGyroJerk-mean()-X"         
[27] "tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"         
[29] "tBodyGyroJerk-std()-X"           "tBodyGyroJerk-std()-Y"          
[31] "tBodyGyroJerk-std()-Z"           "tBodyAccMag-mean()"             
[33] "tBodyAccMag-std()"               "tGravityAccMag-mean()"          
[35] "tGravityAccMag-std()"            "tBodyAccJerkMag-mean()"         
[37] "tBodyAccJerkMag-std()"           "tBodyGyroMag-mean()"            
[39] "tBodyGyroMag-std()"              "tBodyGyroJerkMag-mean()"        
[41] "tBodyGyroJerkMag-std()"          "fBodyAcc-mean()-X"              
[43] "fBodyAcc-mean()-Y"               "fBodyAcc-mean()-Z"              
[45] "fBodyAcc-std()-X"                "fBodyAcc-std()-Y"               
[47] "fBodyAcc-std()-Z"                "fBodyAcc-meanFreq()-X"          
[49] "fBodyAcc-meanFreq()-Y"           "fBodyAcc-meanFreq()-Z"          
[51] "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"          
[53] "fBodyAccJerk-mean()-Z"           "fBodyAccJerk-std()-X"           
[55] "fBodyAccJerk-std()-Y"            "fBodyAccJerk-std()-Z"           
[57] "fBodyAccJerk-meanFreq()-X"       "fBodyAccJerk-meanFreq()-Y"      
[59] "fBodyAccJerk-meanFreq()-Z"       "fBodyGyro-mean()-X"             
[61] "fBodyGyro-mean()-Y"              "fBodyGyro-mean()-Z"             
[63] "fBodyGyro-std()-X"               "fBodyGyro-std()-Y"              
[65] "fBodyGyro-std()-Z"               "fBodyGyro-meanFreq()-X"         
[67] "fBodyGyro-meanFreq()-Y"          "fBodyGyro-meanFreq()-Z"         
[69] "fBodyAccMag-mean()"              "fBodyAccMag-std()"              
[71] "fBodyAccMag-meanFreq()"          "fBodyBodyAccJerkMag-mean()"     
[73] "fBodyBodyAccJerkMag-std()"       "fBodyBodyAccJerkMag-meanFreq()" 
[75] "fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-std()"         
[77] "fBodyBodyGyroMag-meanFreq()"     "fBodyBodyGyroJerkMag-mean()"    
[79] "fBodyBodyGyroJerkMag-std()"      "fBodyBodyGyroJerkMag-meanFreq()"
[81] "activity"  
</p>