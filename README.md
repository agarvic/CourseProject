# Getting and Cleaning Data Course Project

This file explains the way run_analysis.R script works

To use the script:

1. Download the datasets from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and save it to your working directory, renaming the forlder to "data"
2. Type source("run_analysis.R) command at RStudio 
3. You will get two different text files as output of the script:

a) mergedData.txt: 10299x68 data frame
b) dataMeans.txt: 180x68 data frame

4. You can read the text files using the command read.table()
