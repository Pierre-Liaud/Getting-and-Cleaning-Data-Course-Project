# 1. Merges the training and the test sets to create one data set
# Read useful files
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Label rows with activity labels
train <- cbind(X_train, y_train)
test <- cbind(X_test, y_test)

# Label rows with unique subjet ID
train$subj_id <- c(paste(subject_train$V1, "_train", sep=""))
test$subj_id <- c(paste(subject_test$V1, "_test", sep=""))

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
