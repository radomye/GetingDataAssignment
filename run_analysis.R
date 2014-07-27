

fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile = "./data/UCI.zip", method = "curl")

unzip

# Step1: Merges the training and the test sets to create one dataset.

# Reading subjects

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("SubjectID"))
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("SubjectID"))

# Reading labels

yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("Activity"))
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("Activity"))

# Reading features

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("FeatureID","Featurenames"))

# Reading dataset

xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$Featurenames)
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$Featurenames)




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

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Activity", "ActivityName"))

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