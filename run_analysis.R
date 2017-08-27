# Getting and cleaning data course final assignment
# 1- Merging the training and test sets to create one data set
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(url, temp)
df_test <- read.table(unzip(temp, "UCI HAR Dataset/test/X_test.txt" ))
df_train <- read.table(unzip(temp, "UCI HAR Dataset/train/X_train.txt"))
df_merged <- rbind(df_train, df_test)

# labeling merged data based on features (Appropriately labels the data set with descriptive variable names)
df_features <- read.table(unzip(temp, "UCI HAR Dataset/features.txt"))
colnames(df_merged) = df_features$V2

# Extracting only the measurements on the mean and standard deviation for each measurement
df_mergedIndex <- c(grep("mean", colnames(df_merged)), grep("std", colnames(df_merged)))
df_mergedMeanStd <- df_merged[df_mergedIndex]
colnames(df_mergedMeanStd)

# Reading activity labels for train and test data and adding it to the merged data
df_testLabel1 <- read.table(unzip(temp, "UCI HAR Dataset/test/y_test.txt" ))
df_trainLabel1 <- read.table(unzip(temp, "UCI HAR Dataset/train/y_train.txt"))
df_mergedLabel1 <- rbind(df_trainLabel1, df_testLabel1)
colnames(df_mergedLabel1) = "activities"
df_mergedMeanStd <- cbind(df_mergedMeanStd, df_mergedLabel1)

# Reading subject labels for train and test data and adding it to the merged data
df_testLabel2 <- read.table(unzip(temp, "UCI HAR Dataset/test/subject_test.txt" ))
df_trainLabel2 <- read.table(unzip(temp, "UCI HAR Dataset/train/subject_train.txt"))
df_mergedLabel2 <- rbind(df_trainLabel2, df_testLabel2)
colnames(df_mergedLabel2) = "subject"
df_mergedMeanStd <- cbind(df_mergedMeanStd, df_mergedLabel2)

# Using descriptive activity names to name the activities in the data set
df_activityLabels <- read.table(unzip(temp, "UCI HAR Dataset/activity_labels.txt"))
df_mergedMeanStd$activities <- as.factor(df_mergedMeanStd$activities)
levels(df_mergedMeanStd$activities) <- as.character(df_activityLabels$V2)


# Creating a second, independent tidy data set with the average of each variable for each activity and each subject
df_new <- aggregate(.~subject+activities, df_mergedMeanStd, mean)

#End






