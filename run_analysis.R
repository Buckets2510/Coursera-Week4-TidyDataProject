# The R script will perform the following tasks:
# 1. Merge the training and test sets to create one data set
# 2. Extracts measurements on the mean and standard deviation for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data set in Step 4, create a second, independent tidy data set with
#.   the average of each variable for each activity and each subject

# Check and load required packages
if (!require("dplyr")) {install.packages("dplyr")}
if (!require("data.table")) {install.packages("data.table")}
library(dplyr)
library(data.table)


# Get data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"
if (!file.exists(zipFile)) {download.file(fileUrl, zipFile, mode="wb")}

# Unzip the downloaded file
path <- "UCI HAR Dataset" ##verify again the file does not exist
if (!file.exists(path)) {unzip(zipFile)}

# Reading data from the downloaded files
wdpath <- getwd()
activityLabels <- fread(file.path(wdpath, "UCI HAR Dataset/activity_labels.txt"),
                    col.names = c("activityID", "activityNames"))
features <- fread(file.path(wdpath, "UCI HAR Dataset/features.txt"),
                    col.names = c("featureID", "featureNames"))

# Loading train and test data, binding each set separately

trainSubjects <- fread(file.path(wdpath, "UCI HAR Dataset/train/subject_train.txt"),
                       col.names = "SubjectID")
trainValues <- fread(file.path(wdpath, "UCI HAR Dataset/train/X_train.txt"),
                     col.names = features$featureNames)
trainActivity <- fread(file.path(wdpath, "UCI HAR Dataset/train/y_train.txt"),
                       col.names = "Activity")
testSubjects <- fread(file.path(wdpath, "UCI HAR Dataset/test/subject_test.txt"),
                      col.names = "SubjectID")
testValues <- fread(file.path(wdpath, "UCI HAR Dataset/test/X_test.txt"),
                    col.names = features$featureNames)
testActivity <- fread(file.path(wdpath, "UCI HAR Dataset/test/y_test.txt"),
                      col.names = "Activity")

XSet <- rbind(trainValues, testValues)
ySet <- rbind(trainActivity, testActivity)
subjectSet <- rbind(trainSubjects, testSubjects)

# Merging the training and test sets to create one data set. Remove redundant data

allActivity <- cbind(subjectSet, ySet, XSet)

rm(trainSubjects, trainValues, trainActivity, testSubjects, testValues, testActivity)

# Extract measurements on mean and standard deviation, and keep data in those columns
tidySet <- allActivity %>% select(SubjectID, Activity, contains("mean"), contains("std"))

# Use descriptive activity names to name the activities in the data set
tidySet$Activity <- activityLabels[tidySet$Activity, 2]

names(tidySet)[2] = "Activity"
names(tidySet) <- gsub("Acc", "Accelerometer", names(tidySet))
names(tidySet) <- gsub("Gyro", "Gyroscope", names(tidySet))
names(tidySet) <- gsub("BodyBody", "Body", names(tidySet))
names(tidySet) <- gsub("Mag", "Magnitude", names(tidySet))
names(tidySet) <- gsub("^t", "Time", names(tidySet))
names(tidySet) <- gsub("^f", "Frequency", names(tidySet))
names(tidySet) <- gsub("()", "", names(tidySet))


# Create a second independent tidy data set with the average of each variable
# for each activity and each subject
tidyMeans <- tidySet %>% group_by(SubjectID, Activity) %>% 
        summarise_all(funs(mean))


fwrite(tidyMeans, file = "tidy_data.txt")


