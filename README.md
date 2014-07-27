# Human Activity Recognition Using Smartphones Dataset

The goal of this run_analysis.R is to prepare tidy data from UCI website that can be used for later analysis. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

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
## Load the required package
library(reshape2)

# download the data and save it into the data subfolder
require("R.utils")

if(!file.exists("./data")){dir.create("./data")}
# download file
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data/UCI.zip")){download.file(Url, destfile = "./data/UCI.zip")}
# unzip file
unzip("./data/UCI.zip",exdir = "./data" )

# Reading subjects

subject.test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names=c("Subject.ID"))
subject.train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names=c("Subject.ID"))
str(subject.test)
summary(subject.test)
table(subject.test)
table(subject.train)

# Reading labels
y.test <- read.table("data/UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names=c("Activity"))
y.train <- read.table("data/UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names=c("Activity"))
str(y.test)
head(y.test)


# Reading features
features <- read.table("data/UCI HAR Dataset/features.txt", header=FALSE, as.is=TRUE, col.names=c("Featire.ID", "Featire.Name"))
str(features)


# Reading data set and label the X. file variable (column) names. This takes time.
X.test <- read.table("data/UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="", col.names=features$Featire.Name)
X.train <- read.table("data/UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="", col.names=features$Featire.Name)
str(X.train)
summary(X.test)

# X. files have 561 variables whose column names are in the "feature" second column.


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. (Before mergering, subset the dataset and save time and space.) )

# Getting indexes of measurement names with std() and mean()
mean.std.index <- grep(".*mean\\(\\)|.*std\\(\\)", features$Featire.Name)
# 66 variable related to mean and std.
str(mean.std.index)
# Getting data by indexes. now X. file only have 66 variables which .
X.test <- X.test[, mean.std.index]
X.train <- X.train[, mean.std.index]
head(X.test)

# Setting subjects and labels to data set: 2947 test observation; 7352 train observation
X.test$Subject.ID <- subject.test$Subject.ID
X.train$Subject.ID <- subject.train$Subject.ID

# Setting activity and labels to data set: 2947 test observation; 7352 train observation
X.test$Activity <- y.test$Activity
X.train$Activity <- y.train$Activity


# 1. Merges the training and the test sets to create one data set.
# 66 measurement varaibles and subject.ID and Activity factor.
X.data <- rbind(X.test, X.train)
names(X.data)
head(X.data)

# 3. Uses descriptive activity names to name the activities in the data set
activity.labels <- read.table("data/UCI HAR Dataset/activity_labels.txt", header=F, col.names=c("Activity", "Activity.Name"))
# There are 6 activity, first three are active, and later three are still.
# WALKING; WALKING_UPSTAIRS; WALKING_DOWNSTAIRS; SITTING; STANDING; LAYING   
activity.labels
# factor
activity.labels$Activity.Name <- as.factor(activity.labels$Activity.Name)

# 4. Appropriately labels the data set with descriptive activity names: 
# WALKING; WALKING_UPSTAIRS; WALKING_DOWNSTAIRS; SITTING; STANDING; LAYING            
X.data$Activity <- factor(X.data$Activity, levels = 1:6, labels = activity.labels$Activity.Name)
head(X.data)
names(X.data)
# Transform all the column name to readable name. Shorten the variable name for easy reading; appropriately labels the data set with readable name
column.names <- colnames(X.data)
# Get rid of the .
column.names <- gsub("\\.+mean\\.+", column.names, replacement="Mean")
column.names <- gsub("\\.+std\\.+", column.names, replacement="Std")
# Give short name a full explaination
column.names <- gsub("Mag", column.names, replacement="Magnitude")
column.names <- gsub("Acc", column.names, replacement="Accelerometer")
column.names <- gsub("Gyro", column.names, replacement="Gyroscope")
column.names
# Put back to X. file
colnames(X.data) <- column.names

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
library(reshape2)
meltdata <- melt(X.data, id.vars = c("Activity", "Subject.ID"))
tidydata <- dcast(meltdata, Activity + Subject.ID ~ variable, mean)
head(meltdata)
# Get 180 (=30*6) observations of 30 subjects' 6 activities.
# Each subject has 6 activities. Each activity has 66 features.
head(tidydata)
table(tidydata$Subject.ID)
# 5.1 Save tidy data set
write.table(tidydata, "tidydata.txt", row.names = FALSE)


```
