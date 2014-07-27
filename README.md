# Code Book for Human Activity Recognition Using Smartphones Dataset

This code book describes the variables, the data, and  transformations or work that we performed to clean up the data. 

Data can be downloaded by url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

## Human Activity Recognition Using Smartphones Dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


## The dataset includes the following files:


- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

### The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


## Feature Selection 


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


## For this project, we only use:

Training data set - 'train/X_train.txt'
Test data set - 'test/X_test.txt'
Training labels - 'train/y_train.txt'
Test labels - 'test/y_test.txt'

* Two files with row identifies the subject who performed the activity for each window sample in range from 1 to 30. 
- 'train/subject_train.txt'
- 'test/subject_test.txt'

* Activity: factor with 6 levels, in order: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING, indicated the activity being performed at the moment of data gathering,

* SubjectID: numeric value from 1 to 30 indicating the subject Id.

### For variables 3 to 68 the variable is numeric and the name indicates:

* Acc and Gyro: data origin, accelerometer and gyroscope, respectively.
* -XYZ: the three dimensional axis, X,Y, or Z, respectively (3-axial)
* Body and Gravity: Acceleration signal source, Body or Gravity, determined using low pass Butter worth filter with a corner frequency of 0.3 Hz.
* Mean and Std: Mean value or Standard deviation, respectively.
* t of f: t denotes time domain signals, these were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butter worth filter with a corner frequency of 20 Hz to remove noise. On the other hand, f denotes the use of a Fast Fourier Transform (FFT) was applied.

* The tidy data set includes 180 (=30*6) observations of 30 subjects' 6 activities.Each subject has 6 activities. Each activity has 66 features as following shows.

```r
"names(tidy_data)" 

[1] "Activity" "SubjectID" "tBodyAccMeanX" "tBodyAccMeanY" "tBodyAccMeanZ" "tBodyAccStdX"
[7] "tBodyAccStdY" "tBodyAccStdZ" "tGravityAccMeanX" "tGravityAccMeanY" "tGravityAccMeanZ" "tGravityAccStdX"
[13] "tGravityAccStdY" "tGravityAccStdZ" "tBodyAccJerkMeanX" "tBodyAccJerkMeanY" "tBodyAccJerkMeanZ" "tBodyAccJerkStdX"
[19] "tBodyAccJerkStdY" "tBodyAccJerkStdZ" "tBodyGyroMeanX" "tBodyGyroMeanY" "tBodyGyroMeanZ" "tBodyGyroStdX"
[25] "tBodyGyroStdY" "tBodyGyroStdZ" "tBodyGyroJerkMeanX" "tBodyGyroJerkMeanY" "tBodyGyroJerkMeanZ" "tBodyGyroJerkStdX"
[31] "tBodyGyroJerkStdY" "tBodyGyroJerkStdZ" "tBodyAccMagMean" "tBodyAccMagStd" "tGravityAccMagMean" "tGravityAccMagStd"
[37] "tBodyAccJerkMagMean" "tBodyAccJerkMagStd" "tBodyGyroMagMean" "tBodyGyroMagStd" "tBodyGyroJerkMagMean" "tBodyGyroJerkMagStd"
[43] "fBodyAccMeanX" "fBodyAccMeanY" "fBodyAccMeanZ" "fBodyAccStdX" "fBodyAccStdY" "fBodyAccStdZ"
[49] "fBodyAccJerkMeanX" "fBodyAccJerkMeanY" "fBodyAccJerkMeanZ" "fBodyAccJerkStdX" "fBodyAccJerkStdY" "fBodyAccJerkStdZ"
[55] "fBodyGyroMeanX" "fBodyGyroMeanY" "fBodyGyroMeanZ" "fBodyGyroStdX" "fBodyGyroStdY" "fBodyGyroStdZ"
[61] "fBodyAccMagMean" "fBodyAccMagStd" "fBodyBodyAccJerkMagMean" "fBodyBodyAccJerkMagStd" "fBodyBodyGyroMagMean" "fBodyBodyGyroMagStd"
[67] "fBodyBodyGyroJerkMagMean" "fBodyBodyGyroJerkMagStd" 
```
Then we transform these column name to readable name


```r
names(tidydata)
 [1] "Activity"                                "Subject.ID"                             
 [3] "tBodyAccelerometerMeanX"                 "tBodyAccelerometerMeanY"                
 [5] "tBodyAccelerometerMeanZ"                 "tBodyAccelerometerStdX"                 
 [7] "tBodyAccelerometerStdY"                  "tBodyAccelerometerStdZ"                 
 [9] "tGravityAccelerometerMeanX"              "tGravityAccelerometerMeanY"             
[11] "tGravityAccelerometerMeanZ"              "tGravityAccelerometerStdX"              
[13] "tGravityAccelerometerStdY"               "tGravityAccelerometerStdZ"              
[15] "tBodyAccelerometerJerkMeanX"             "tBodyAccelerometerJerkMeanY"            
[17] "tBodyAccelerometerJerkMeanZ"             "tBodyAccelerometerJerkStdX"             
[19] "tBodyAccelerometerJerkStdY"              "tBodyAccelerometerJerkStdZ"             
[21] "tBodyGyroscopeMeanX"                     "tBodyGyroscopeMeanY"                    
[23] "tBodyGyroscopeMeanZ"                     "tBodyGyroscopeStdX"                     
[25] "tBodyGyroscopeStdY"                      "tBodyGyroscopeStdZ"                     
[27] "tBodyGyroscopeJerkMeanX"                 "tBodyGyroscopeJerkMeanY"                
[29] "tBodyGyroscopeJerkMeanZ"                 "tBodyGyroscopeJerkStdX"                 
[31] "tBodyGyroscopeJerkStdY"                  "tBodyGyroscopeJerkStdZ"                 
[33] "tBodyAccelerometerMagnitudeMean"         "tBodyAccelerometerMagnitudeStd"         
[35] "tGravityAccelerometerMagnitudeMean"      "tGravityAccelerometerMagnitudeStd"      
[37] "tBodyAccelerometerJerkMagnitudeMean"     "tBodyAccelerometerJerkMagnitudeStd"     
[39] "tBodyGyroscopeMagnitudeMean"             "tBodyGyroscopeMagnitudeStd"             
[41] "tBodyGyroscopeJerkMagnitudeMean"         "tBodyGyroscopeJerkMagnitudeStd"         
[43] "fBodyAccelerometerMeanX"                 "fBodyAccelerometerMeanY"                
[45] "fBodyAccelerometerMeanZ"                 "fBodyAccelerometerStdX"                 
[47] "fBodyAccelerometerStdY"                  "fBodyAccelerometerStdZ"                 
[49] "fBodyAccelerometerJerkMeanX"             "fBodyAccelerometerJerkMeanY"            
[51] "fBodyAccelerometerJerkMeanZ"             "fBodyAccelerometerJerkStdX"             
[53] "fBodyAccelerometerJerkStdY"              "fBodyAccelerometerJerkStdZ"             
[55] "fBodyGyroscopeMeanX"                     "fBodyGyroscopeMeanY"                    
[57] "fBodyGyroscopeMeanZ"                     "fBodyGyroscopeStdX"                     
[59] "fBodyGyroscopeStdY"                      "fBodyGyroscopeStdZ"                     
[61] "fBodyAccelerometerMagnitudeMean"         "fBodyAccelerometerMagnitudeStd"         
[63] "fBodyBodyAccelerometerJerkMagnitudeMean" "fBodyBodyAccelerometerJerkMagnitudeStd" 
[65] "fBodyBodyGyroscopeMagnitudeMean"         "fBodyBodyGyroscopeMagnitudeStd"         
[67] "fBodyBodyGyroscopeJerkMagnitudeMean"     "fBodyBodyGyroscopeJerkMagnitudeStd"  

```
