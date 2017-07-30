# Coursera-Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project
This repository hosts the R code and documentation files for Coursera Peer-graded Assignment: Getting and Cleaning Data Course Project.

## Files
CodeBook.md describes how to use all the, variables, the data, and any transformations or work that was performed to clean up the data.

run_analysis.R contains all the code to perform the analyses described in the five steps. 

The output of the 5th step is called SecondTidyData.txt.

## Source of data

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## R script

File with R code "run_analysis.R" performs the following five steps:

1. Merge the training and the test sets to create one data set.
1.1 Read files
1.1.1 Train tables
1.1.2 Test tables
1.1.3 Feature vector
1.1.4 Activity labels
1.2 Assign column names
1.3 Merge all data in one set

2. Extracts only the measurements on the mean and standard deviation for each measurement.
2.1 Read column names
2.2 Create vector for defining Id, mean and standard deviation
2.3 Make nessesary subset from setAllInOne

3. Use descriptive activity names to name the activities in the data set.

4. Appropriately label the data set with descriptive variable names.

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
5.1 Second tidy dataset
5.2 Write second tidy data set in txt file


##  Variable
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in
