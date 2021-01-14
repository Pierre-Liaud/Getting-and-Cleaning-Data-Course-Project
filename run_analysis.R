# 1. Merges the training and the test sets to create one data set
# Read useful files
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Label rows with activity labels
temp_train <- cbind(X_train, y_train)
temp_test <- cbind(X_test, y_test)

# Label rows with subjet ID
train <- cbind(temp_train, subject_train)
test <- cbind(temp_test, subject_test)

# Merge sets
all_data <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# Find columns to extract
features <- read.table("./UCI HAR Dataset/features.txt")
columns <- grep("*mean*|*std*",features$V2)

# Extract columns in focused tidy dataset
mean_std <- all_data[,c(columns,562,563)]

# 3. Uses descriptive activity names to name the activities in the data set
# Name activities
read.table("./UCI HAR Dataset/activity_labels.txt")
mean_std$V1.1[mean_std$V1.1 == "1"] <- "WALKING"
mean_std$V1.1[mean_std$V1.1 == "2"] <- "WALKING_UPSTAIRS"
mean_std$V1.1[mean_std$V1.1 == "3"] <- "WALKING_DOWNSTAIRS"
mean_std$V1.1[mean_std$V1.1 == "4"] <- "SITTING"
mean_std$V1.1[mean_std$V1.1 == "5"] <- "STANDING"
mean_std$V1.1[mean_std$V1.1 == "6"] <- "LAYING"

# 4. Appropriately labels the data set with descriptive variable names
colnames(mean_std) <- c(features$V2[columns], "activity" ,"subj_id" )
head(mean_std)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Subseting by activities
temp_WALKING <- mean_std[mean_std$activity=="WALKING",]
temp_WALKING_UPSTAIRS <- mean_std[mean_std$activity=="WALKING_UPSTAIRS",]
temp_WALKING_DOWNSTAIRS <- mean_std[mean_std$activity=="WALKING_DOWNSTAIRS",]
temp_SITTING <- mean_std[mean_std$activity=="SITTING",]
temp_STANDING <- mean_std[mean_std$activity=="STANDING",]
temp_LAYING <- mean_std[mean_std$activity=="LAYING",]

# Obtain mean values for each activities by subject and (re)label rows with activity for further merging
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

# Recreate one dataset with selected variable means by subject
tidy_dataset<- rbind(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
names(tidy_dataset)[names(tidy_dataset) == "Group.1"] <- "subject"

# tidy_data file creation
write.table(tidy_dataset, file = "tidy_data.txt", row.name=FALSE)