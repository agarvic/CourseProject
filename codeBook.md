#Code Book

The file contains the description of the datasets, variables; and the steps that the script called "run_analysis.R" follows to merge, clean and reshape data:

1. The datasets were obtained on 22th February 2015 from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Read data from X_train.txt and X_test.txt from the "./data/train" folder, store them in trainData and testData variables and merge them into mergedData Object
3. Read data from y_train.txt and y_test.txt from the "./data/train" folder, store them in trainLabel and testLabel variables and merge them into mergedLabel Object
4. Read data from subject_train.txt and subject_test.txt from the "./data/train" folder, store them in trainSubject and testSubject variables and merge them into mergedSubject Object
5. Store the contain of features.txt file, readen from the "./data" folder, and store the data in "features" variable, extracting the measurements of the mean and standard deviation, generating a 66 indices list.
6. Subset mergedData to get the corresponding columns
7. Clean the names of columns in the subset, so that we remove none alphabetical characters and capitalize the fist letter of the second word.
8. Read the activity_labels.txt file from the "./data"" folder, storing its data in the activityLabels variable.
9. Clean the activity names in activityLabels, following the same rules as in 7
10. Change the values of mergedLabel assigning values from activityLabels
11. Build a new data frame (10299 rows and 68 cols), called appropriateData. 
12. We name the first to columns "subject" and "activity":
	- subject: integers from 1 to 30 (both inclusive)
	- activity: activity names
	- cols 3 to 68:  measurements that range from -1 to 1 (exclusive)
13. Outputs the appropriateData to "mergedData.txt"
14. Creates a second, independent tidy data set with the average of each variable for each activity and each subject (30 subjects x 6 activities)
For each combination of subject and activity, we calculate the mean of each measurement, resulting a 180x68 data frame.
15. Outputs the data frame to "dataMeans.txt"
