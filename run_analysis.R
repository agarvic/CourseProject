# 1. Merges the training and the test sets to create one data set.

# setwd("/Users/agarvic/Week3")

#A) Loading and merging X_train and X_test

  trainData <- read.table("data/train/X_train.txt") #Load data to Object
  dim(trainData) # Retrieve the dimension of the object. # 7352x561
  
  #head(trainData) # Get the beginning of the Object
  
  testData <- read.table("data/test/X_test.txt") #Load data to Object
  dim(testData) # Retrieve the dimension of the Object 2947x561
  
  #Merge the two Objects
  mergedData <- rbind(trainData, testData)
  dim(mergedData) # Check the dimension of the Object -- 10299x561 Right! :-)
  
#B) Loading and merging y_train and y_test

  trainLabel <- read.table("data/train/y_train.txt") #Load data to Object
  table(trainLabel) # Retrieve frequencies
  
  testLabel <- read.table("./data/test/y_test.txt") #Load data to Object 
  table(testLabel) # Retrieve frequencies
  
  #Merge the two Objects
  mergedLabel <- rbind(trainLabel, testLabel)
  table(testLabel) # Check frequencies
  dim(mergedLabel) # Check dimension of the Object -- 10299x1 Right! :-)

#C) Loading and merging subject_train and subject_test
  
  trainSubject <- read.table("./data/train/subject_train.txt") #Load data to Object
  table(trainSubject) # Retrieve frequencies
  
  testSubject <- read.table("./data/test/subject_test.txt") #Load data to Object
  table(testSubject) # Retrieve frequencies

  #Load data to Object
  mergedSubject <- rbind(trainSubject, testSubject)
  table(mergedSubject) # Check frequencies
  dim(mergedSubject) # Check dimension of the Object -- 10299x1 :-)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("./data/features.txt") #Load data to Object
dim(features)  # 561x2

#Match patterns to get only mean or deviation indices
meanDeviationInd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanDeviationInd) # 66

# Get only mean and deviation 
mergedData <- mergedData[, meanDeviationInd]
dim(mergedData) # 10299*66 Right! :-)

names(mergedData) <- features[meanDeviationInd, 2] #Assign names from "features"
names(mergedData) <- gsub("-", "", names(mergedData)) # removing -
names(mergedData) <- gsub("\\(\\)", "", names(mergedData)) # removing ()
names(mergedData) <- gsub("mean", "Mean", names(mergedData)) # capitalize M
names(mergedData) <- gsub("std", "Std", names(mergedData)) # capitalize S

# 3. Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table("./data/activity_labels.txt") #Load data to Object
head(activityLabels) # Check head

#Remove _ and convert to lower case
activityLabels[, 2] <- tolower(gsub("_", "", activityLabels[, 2]))

#Capitalize U in walkingUpstairs
substr(activityLabels[2, 2], 8, 8) <- toupper(substr(activityLabels[2, 2], 8, 8))

#Capitalize D in walkingDownstairs
substr(activityLabels[3, 2], 8, 8) <- toupper(substr(activityLabels[3, 2], 8, 8))

#Assign labels:
activityLabels2 <- activityLabels[mergedLabel[, 1], 2]
mergedLabel[, 1] <- activityLabels2
names(mergedLabel) <- "activityLabels"

# 4. Appropriately labels the data set with descriptive activityLabels names

names(mergedSubject) <- "subject" #Change name from V1 to subject

appropriateData <- cbind(mergedSubject, mergedLabel, mergedData) #Combine Subject,label and data
dim(appropriateData) # Check dimension 10299x68 :-)

#Write dataset to file
write.table(appropriateData, "mergedData.txt") # write the first required dataset

# 5. Creates a second, independent tidy data set with the average of each variable for each activityLabels and each subject.

#Calculate lengths for Matrix nrow:
subjectLength <- length(table(mergedSubject)) # Retrieve and store the length
activityLabelsLength <- dim(activityLabels)[1] # Retrieve and store the dimension of labels
#Calculate lengths for Matrix ncol:  
columnLength <- dim(appropriateData)[2] # Retrieve and store the dimension of the table created in #4

#Create an empty matrix
output <- matrix(NA, nrow=subjectLength*activityLabelsLength, ncol=columnLength) 
output <- as.data.frame(output)
  
colnames(output) <- colnames(appropriateData) #Assign colnames

#Filling the Matrix, with the 30 subjects x 6 activities combination:
row <- 1
#loops through each subject
for(i in 1:subjectLength) {
  #loops through each activity
  for(j in 1:activityLabelsLength) {
    output[row, 1] <- sort(unique(mergedSubject)[, 1])[i] #Fill the First col of the row with the subject
    output[row, 2] <- activityLabels[j, 2] #Fill the second col of the row with the activity name
    bool1 <- i == appropriateData$subject
    bool2 <- activityLabels[j, 2] == appropriateData$activityLabels
    output[row, 3:columnLength] <- colMeans(appropriateData[bool1&bool2, 3:columnLength]) #Fill the remaining cols with the means
    
    row <- row + 1 #once we have filled every col of the row we are ready for the following
  }
}

write.table(output, "dataMeans.txt",row.names = FALSE) # write the 2nd required dataset
