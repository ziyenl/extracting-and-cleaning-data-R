Code Book
========================================================
 
This code book summarizes the resulting data fields in tidy.txt.

# Raw Data Collection
Based on [UCI Machine Learning Repositories](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names), the data was collected during experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years old. Each volunteer performed six activities ( WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING ) while wearing a smartphone (Samsung Galaxy S  II ) on the waist. Embedded accelerometer and gyroscope was used to capture the 3-axial (x,y,z) linear acceleration and 3-axial (x,y,z) angular velocity at a constant rate of 50 Hz. The experiments were video recorded in order to label the data manually. The dataset generated is randomized into two datasets with 70% of the volunteers selected for generating the training dataset and 30% selected for test datasets.

The sensor signals from accelerometer and gyroscope were pre-processed using noise filters application and then sampled in fixed-width sliding windows of 2.56 seconds and 50% overlap( 128 readings/window). 

# Dataset  Description
## Files Utilised In This Project
The dataset includes the following files:
- `features_info.txt`:information about the variables used in the feature vector.
- `features.txt`: list of all features.
- `activity_labels.txt`: links the class labels with their activity name.
- `train/X_train.txt`: Training set.
- `train/y_train.txt`: Training labels.
- `train/subject_train.txt`: Subjects in Training set.
- `test/X_test.txt`: Test set.
- `test/y_test.txt`: Test labels.
- `test/subject_test.txt`: Subjects in Test set.

## Features
Based on __features\_info.txt__ file in the dataset zip file, the measurements came from accelerometer and gyroscope: time domain signals ( _tAcc-XYZ_ and _tGyro-XYZ_ ), body and gravity acceleration signals ( _tBodyAcc-XYZ_ and _tGravityAcc-XYZ_ ), body linear acceleration and angular velocity derived in time to obtain Jerk signals ( _tBodyAccJerk-XYZ_ and _tBodyGyroJerk-XYZ_ ), Eucliden norm calculated magnitude of these three-dimensional signals ( _tBodyAccMag_, _tGravityAccMag_, _tBodyAccJerkMag_, _tBodyGyroMag_, _tBodyGyroJerkMag_ ) and Fast Fourier Transform (FFT) application on the signals ( _fBodyAcc-XYZ_, _fBodyAccJerk-XYZ_, _fBodyGyro-XYZ_, _fBodyAccJerkMag_, _fBodyGyroMag_, _fBodyGyroJerkMag_ ). Prefix 't' denotes time and 'f' denotes frequency domain signals. 

The following signals were used to estimate variables of the feature vector for each pattern with '-XYZ' denoting the 3-axial signals in the X, Y and Z directions:

- `tBodyAcc-XYZ`
- `tGravityAcc-XYZ`
- `tBodyAccJerk-XYZ`
- `tBodyGyro-XYZ`
- `tBodyGyroJerk-XYZ`
- `tBodyAccMag`
- `tGravityAccMag`
- `tBodyAccJerkMag`
- `tBodyGyroMag`
- `tBodyGyroJerkMag`
- `fBodyAcc-XYZ`
- `fBodyAccJerk-XYZ`
- `fBodyGyro-XYZ`
- `fBodyAccMag`
- `fBodyAccJerkMag`
- `fBodyGyroMag`
- `fBodyGyroJerkMag`

The set of variables that were estimated from these signals are: 

- `mean()`: Mean value
- `std()`: Standard deviation
- `mad()`: Median absolute deviation 
- `max()`: Largest value in array
- `min()`: Smallest value in array
- `sma()`: Signal magnitude area
- `energy()`: Energy measure. Sum of the squares divided by the number of values. 
- `iqr()`: Interquartile range 
- `entropy()`: Signal entropy
- `arCoeff()`: Autorregresion coefficients with Burg order equal to 4
- `correlation()`: correlation coefficient between two signals
- `maxInds()`: index of the frequency component with largest magnitude
- `meanFreq()`: Weighted average of the frequency components to obtain a mean frequency
- `skewness()`: skewness of the frequency domain signal 
- `kurtosis()`: kurtosis of the frequency domain signal 
- `bandsEnergy()`: Energy of a frequency interval within the 64 bins of the FFT of each window.
- `angle()`: Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the `angle()` variable:

- `gravityMean`
- `tBodyAccMean`
- `tBodyAccJerkMean`
- `tBodyGyroMean`
- `tBodyGyroJerkMean`

## Activity
- `WALKING (value 1)`: subject was walking during the test
- `WALKING_UPSTAIRS (value 2)`: subject was walking up a staircase during the test
- `WALKING_DOWNSTAIRS (value 3)`: subject was walking down a staircase during the test
- `SITTING (value 4)`: subject was sitting during the test
- `STANDING (value 5)`: subject was standing during the test
- `LAYING (value 6)`: subject was laying down during the test

# Data Transformation

## PART I: Merges the training and the test sets to create one data set

### Install Packages
 

```r
install.packages('data.table')
```
### Load Libraries

```r
library(data.table)
```

### Download and Unzip Data

```r
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "dataset.zip")
unzip("dataset.zip")
```

### Reading Features and Activities Labels  

```r
featureLabels <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
```

### Reading Training Data

```r
trainingFeatures <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainingActivity <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainingSubject <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
```

### Reading Test Data

```r
testFeatures <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
```

### Merge Training Set and Test Set

```r
mergedFeatures <- rbind( trainingFeatures, testFeatures )
mergedSubjects <- rbind(trainingSubject, testSubject )
mergedActivities <- rbind( trainingActivity, testActivity )
```

### Naming Columns Headers

```r
colnames( mergedFeatures ) <- featureLabels$V2
colnames( mergedSubjects ) <- 'Subject'
colnames( mergedActivities ) <- 'Activity'
allData <- cbind( mergedFeatures, mergedActivities, mergedSubjects )
```

## PART II: Extracts only the measurements on the mean and standard deviation for each measurement
### Extract fields containing mean() and std() (along with the columns: 'Subject' and 'Activity')

```r
extractedData <- allData[,grepl("mean\\(\\)|std\\(\\)|Subject|Activity", names(allData))]
```

## PART III: Uses descriptive activity names to name the activities in the data set

```r
extractedData$Activity <- factor(extractedData$Activity,levels=activityLabels$V1,labels=activityLabels$V2)
```

## PART IV: Appropriately labels the data set with descriptive names
Labelling features using descriptive names:
* prefix t = 'time'
* prefix f = 'frequency'
* prefix Acc = 'Accelerometer'
* prefix Gyro = 'Gyroscope'
* prefix Mag = 'Magnitude'
* prefix BodyBody = 'Body'
* prefix std() = 'StdDev'
* prefix mean() = 'Mean'


```r
names(extractedData)<-gsub("^t", "time", names(extractedData))
names(extractedData)<-gsub("^f", "frequency", names(extractedData))
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("std\\(\\)", "StdDev", names(extractedData))
names(extractedData)<-gsub("mean\\(\\)", "Mean", names(extractedData))
```
 
## PART V: Creates a second, independent tidy data set with the average of each variable for each activity and each subject

```r
finalData <- aggregate(. ~Subject + Activity, extractedData, mean)
finalData <- finalData[order(finalData$Subject,finalData$Activity),]
write.table(finalData, file = "tidydata.txt",row.name=FALSE)
```

### Summary
The initial merged data of both training and test datasets contain 10299 observations and 563 variables. After retaining only those variables containing mean() and std(), the number of variables narrow down to 68 variables. After averaging each variable for each activity and each subject, the number of observations narrow down to 180 observations. 
