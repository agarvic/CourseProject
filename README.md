# Getting and Cleaning Data Course Project
This file explains the way run_analysis.R script works

This script gets some data collected from the accelerometers from the Samsung Galaxy S smartphone and perform the following steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To use the script:

1. Download the datasets from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and save it to your working directory, renaming the folder to "data"
2. Type source("run_analysis.R") command at RStudio 
3. You will get two different text files as output of the script:

a) mergedData.txt: 10299x68 data frame
b) dataMeans.txt: 180x68 data frame

4. You can read the text files using the command read.table()
