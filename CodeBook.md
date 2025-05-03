## Dataset Files Used
1. `UCI HAR Dataset/features.txt`: List of measurement labels
2. `./UCI HAR Dataset/train/X_train.txt`: Training set measurements
3. `./UCI HAR Dataset/test/X_test.txt`: Test set measurements
4. `./UCI HAR Dataset/train/y_train.txt`: Training set activity labels
5. `./UCI HAR Dataset/test/y_test.txt`: Test set activity labels
6. `UCI HAR Dataset/train/subject_train.txt`: Subject tied to train set
7. `UCI HAR Dataset/train/subject_test.txt`: Subject tied to test set
8. `./UCI HAR Dataset/activity_labels.txt`: Activity labels

## Transformations
1. Train and test data set labels are read from their respective `y_*.txt` files.
2. Activity descriptive names are read from the `./UCI HAR Dataset/activity_labels.txt` file.
3. Descriptive activity names are left joined to the train and test data set labels data frames.
4. Measurement labels are read from the `./UCI HAR Dataset/features.txt` file. Only the measurements containing `mean()` and `std()` in their names are stored in the `meanAndStdFeatures` data frame.
5. Train and test data set measurements are read from their respective `X_*.txt` files. Only the measurements in `meanAndStdFeatures` are kept.
6. A merged train and test dataset is formed using `rbind` and `cbind` methods.
7. Column names are assigned to the merged data set.
8. Subjects are read from train and test sets, added to the merged set in the same order they were `rbind` previously then `cbind`.
9. Produce the `avgMergedSet` by grouping the merged data set by `Subject`,`Activity` and summarizing the data across all columns EXCEPT the first two using the mean function.

## `avgMergedSet` Variable Description
1. `Subject`: Subject ID (1-30)
2. `Activity`: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
3. Cols 3-79: Average value for that variable for that activity and subject