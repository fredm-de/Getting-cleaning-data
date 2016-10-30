Getting and Cleaning Data: Course Project
=========================================

Introduction
------------
This repository contains my results of the course project for Courseras "Getting and Cleaning Data".

Content
-------
This repository contains

- The ReadMe ReadMe-Files ReadMe.md
- The CodeBook-File CodeBook.md
- The R-Script run_analysis.R
- The resulting dataset submit.txt

The raw data that this analysis is based on are obtained from the UCI Machine Learning Repository. The dataset used is  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

About the script
----------------
The script **run_analysis.R** downloads the dataset *Human Activity Recognition Using Smartphone Data Set* from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). This dataset is then extracted and loaded into R.

The script merges and labels training and test data. Only colons that contain mean or standard deviation of measurements are kept.

Finally the script creates a new tidy dataset **submit.csv**, containing the means of all colons for every combination of subject and activity.

About the Code Book
-------------------
CodeBook.md gives informations about the data and variables in the result dataset submit.csv.
