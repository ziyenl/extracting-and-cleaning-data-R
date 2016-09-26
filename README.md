Getting and Cleaning Data Course Project
========================================

## Project Description
This project is the final project for the 'Getting and Cleaning Data' Coursera course of the Data Science specialization. The purpose of the project is to demonstrate the ability to collect, work with, and clean a dataset based on lessons throughout the course. The final goal of the course is to prepare a tidy dataset that can be used for later analysis.


## Project Data Source
The data used in this project is related to wearable computing generated data. The data is collected from accelerometers from Samsung Galaxy S smartphone. 
The original data is sourced from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). A zip copy of the data can be download from [this site](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Files in this repository
* __CodeBook.md__: information about the raw and tidy dataset and steps taken to transform the raw dataset to the tidy dataset.
* __LICENSE__: license terms for source code and text.
* __README.md__: this file
* __run\_analysis.R__: R script to transform the raw dataset into a tidy dataset

## Steps to produce the tidy dataset
1. git clone or download this repository [https://github.com/ziyenl/getting-and-cleaning-data.git](https://github.com/ziyenl/extracting-and-cleaning-data-R.git)
4. open a R console and set the working directory to the repository root directory containing the __run\_analysis.R__ source file. This can be done using the command `setwd()`.
5. read and run the sourcecode run_analysis.R script by using the command `source('run_analysis.R')`

You will find the __tidyData.txt__ containing the tidy data set once the source code is ran.

## What does the run_analysis.R script do
1. Installs the __data.table__ package if they are not already installed.
2. Downloads the dataset zip file if it does not already exist in the working directory and then unzip the zip file.
3. Loads the features metadata, activities metadata, training dataset and test dataset.
4. Merges both the training and test datasets and naming the dataset based on features metadata.
5. Subsets the dataset to columns that only reflect mean and standard deviation. 
6. Uses descriptive activity names to name the activities in the merged dataset.
7. Labels features in the merged dataset with descriptive names.
8. Creates a tidy data set with the mean of each variable for each activity and each subject.
9. Outputs the tidy data set in the file __tidyData.txt__.
 

## About the CodeBook
The __CodeBook.md__ file explains the transofmration steps taken to convert the raw data into the tidy data. 
