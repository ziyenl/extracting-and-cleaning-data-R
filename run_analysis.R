######################################################################
# PART I; Merges the training and the test sets to create one data set
######################################################################

# Install packages
install.packages('data.table')

# Load Libraries
library(data.table)

# Download Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "dataset.zip")
unzip("dataset.zip")

# Reading Label
# featureLabels is the list of all features
# activityLabels contains the link of the class labels with the activity names
featureLabels <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Reading Training Data
trainingFeatures <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainingActivity <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainingSubject <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# Reading Test Data
testFeatures <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)

# Merge Training Set and Test Set
mergedFeatures <- rbind( trainingFeatures, testFeatures )
mergedSubjects <- rbind(trainingSubject, testSubject )
mergedActivities <- rbind( trainingActivity, testActivity )

# Naming Columns
colnames( mergedFeatures ) <- featureLabels$V2
colnames( mergedSubjects ) <- 'Subject'
colnames( mergedActivities ) <- 'Activity'
allData <- cbind( mergedFeatures, mergedActivities, mergedSubjects )

#################################################################################################
# PART II: Extracts only the measurements on the mean and standard deviation for each measurement
#################################################################################################
# Extract fields containing mean() and std() ( along with the colUmns: Subject and Activity )
extractedData <- allData[,grepl("mean\\(\\)|std\\(\\)|Subject|Activity", names(allData))]

##################################################################################
# PART III: Uses descriptive activity names to name the activities in the data set
##################################################################################
# Using the factorizing approach
extractedData$Activity <- factor(extractedData$Activity,levels=activityLabels$V1,labels=activityLabels$V2)

###################################################################
# PART IV: Appropriately labels the data set with descriptive names
###################################################################
# Labelling features using descriptive names:
# prefix t = 'time'
# prefix f = 'frequency'
# prefix Acc = 'Accelerometer'
# prefix Gyro = 'Gyroscope'
# prefix Mag = 'Magnitude'
# prefix BodyBody = 'Body'
# prefix std() = 'StdDev'
# prefix mean() = 'Mean'

names(extractedData)<-gsub("^t", "time", names(extractedData))
names(extractedData)<-gsub("^f", "frequency", names(extractedData))
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("std\\(\\)", "StdDev", names(extractedData))
names(extractedData)<-gsub("mean\\(\\)", "Mean", names(extractedData))

##########################################################################################################################
# PART V: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
##########################################################################################################################
finalData <- aggregate(. ~Subject + Activity, extractedData, mean)
finalData <- finalData[order(finalData$Subject,finalData$Activity),]
write.table(finalData, file = "tidydata.txt",row.name=FALSE)
 