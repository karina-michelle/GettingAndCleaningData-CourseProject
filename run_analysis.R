library(dplyr)
library(tidyr)

## Read train and test sets into dataframes
trainLabels <- read.table('./UCI HAR Dataset/train/y_train.txt')
testLabels <- read.table('./UCI HAR Dataset/test/y_test.txt')

## Get descriptive activity names and add to labels data frame
activities <- read.table('./UCI HAR Dataset/activity_labels.txt')
testLabels <- left_join(testLabels,activities)
trainLabels <- left_join(trainLabels,activities)

## Identify mean and std measurements columns
features <- read.table('./UCI HAR Dataset/features.txt')
meanAndStdFeatures <- features[grepl("mean()", features$V2) | 
                               grepl("std()", features$V2),]

## Read and store only the mean and std measurements
trainMeas <- read.table(
        './UCI HAR Dataset/train/X_train.txt')[,meanAndStdFeatures[,1]]
testMeas <- read.table(
        './UCI HAR Dataset/test/X_test.txt')[,meanAndStdFeatures[,1]]

## Merge training and test sets into one data set
## Select all but the first column containing Activity ID
mergedSet <- rbind(cbind(trainLabels, trainMeas),
                   cbind(testLabels, testMeas))[,-1]
colnames(mergedSet) <- c("Activity", meanAndStdFeatures[,2])

## Read subjects for train and test data sets, add to merged set
subjects <- rbind(read.table('UCI HAR Dataset/train/subject_train.txt'),
                  read.table('UCI HAR Dataset/test/subject_test.txt'))
mergedSet <- cbind(subjects, mergedSet)
colnames(mergedSet)[1] <- "Subject"

## Average each variable for each activity and each subject
avgMergedSet <- mergedSet %>%
        group_by(Subject, Activity) %>%
        summarise_all(mean)
