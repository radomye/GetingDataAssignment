## Human Activity Recognition Using Smartphones Dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The detail of data can be found in CodeBook.md.

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## The script  run_analysis.R that does the following. 

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive activity names. 
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

```r
# download the data and save it into the data folder

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("./data")) {dir.create("./data")}
if (!file.exists("./data/UCI.zip")) {
        download.file(fileUrl, destfile = "./data/UCI.zip", method = "curl")
}
unzip("./data/UCI.zip", exdir = "/data")

# Step1: Merges the training and the test sets to create one dataset.

# Reading subjects

subjectTest <- read.table("data/UCI HAR Dataset/test/subject_test.txt", col.names = c("SubjectID"))
subjectTrain <- read.table("data/UCI HAR Dataset/train/subject_train.txt", col.names = c("SubjectID"))

# Reading labels

yTest <- read.table("data/UCI HAR Dataset/test/y_test.txt", col.names = c("Activity"))
yTrain <- read.table("data/UCI HAR Dataset/train/y_train.txt", col.names = c("Activity"))

# Reading features

features <- read.table("data/UCI HAR Dataset/features.txt", col.names = c("FeatureID","Featurenames"))

# Reading dataset

xTest <- read.table("data/UCI HAR Dataset/test/X_test.txt", col.names = features$Featurenames)
xTrain <- read.table("data/UCI HAR Dataset/train/X_train.txt", col.names = features$Featurenames)




# Step2: Extracts only the measurements on the mean and standard deviation for each measurement.

# Getting indexex of measurement names with mean() and std()

mean.std.index <- grep(".*mean\\(\\)|.*std\\(\\)", features$Featurenames)

xTest <- xTest[, mean.std.index]
xTrain <- xTrain[, mean.std.index]

# Setting subjects and labels to dataset

xTest$SubjectID <- subjectTest$SubjectID
xTrain$SubjectID <- subjectTrain$SubjectID

# Setting activity and labels to dataset

xTest$Activity <- yTest$Activity
xTrain$Activity <- yTrain$Activity

# Merges the training and test sets

xData <- rbind(xTest, xTrain)


# Step3: Uses descriptive activity names to name the activities in the dataset.

activityLabels <- read.table("data/UCI HAR Dataset/activity_labels.txt", col.names = c("Activity", "ActivityName"))

activityLabels$ActivityName <- as.factor(activityLabels$ActivityName)

# Step4: Appropriately labels the data set with descriptive variable names.

xData$Activity <- factor(xData$Activity, levels = 1:6, labels = activityLabels$ActivityName)

columnNames <- colnames(xData)

# Get rid of the '.'
columnNames <- gsub("\\.+mean\\.+", columnNames, replacement="Mean")
columnNames <- gsub("\\.+std\\.+", columnNames, replacement="Std")

# Give short name a full explaination
columnNames <- gsub("Mag", columnNames, replacement="Magnitude")
columnNames <- gsub("Acc", columnNames, replacement="Accelerometer")
columnNames <- gsub("Gyro", columnNames, replacement="Gyroscope")

# Put back to X. file
colnames(xData) <- columnNames

# Step5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)
meltData <- melt(xData, id.vars = c("Activity", "SubjectID"))
tidyData <- dcast(meltData, Activity + SubjectID ~ variable, mean)

write.table(tidyData, "tidyData.txt", row.names = FALSE)
