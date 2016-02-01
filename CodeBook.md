# Code Book for Getting and Cleaning Data Course Project

## Data

The data can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Data Overview

From 'README.txt' included in the data set:

> The experiments have been carried out with a group of 30 volunteers within 
> an age bracket of 19-48 years. Each person performed six activities 
> (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
> wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded 
> accelerometer and gyroscope, we captured 3-axial linear acceleration and 
> 3-axial angular velocity at a constant rate of 50Hz. The experiments have 
> been video-recorded to label the data manually. The obtained dataset has 
> been randomly partitioned into two sets, where 70% of the volunteers was 
> selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by 
> applying noise filters and then sampled in fixed-width sliding windows of 
> 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration 
> signal, which has gravitational and body motion components, was separated 
> using a Butterworth low-pass filter into body acceleration and gravity. 
> The gravitational force is assumed to have only low frequency components, 
> therefore a filter with 0.3 Hz cutoff frequency was used. From each 
> window, a vector of features was obtained by calculating variables from 
> the time and frequency domain. See 'features_info.txt' for more details. 

### Relevant Files in the Data Set

This project makes use of the following files included in the data set:

- 'README.txt': Provides complete reference to all data files included

- 'features_info.txt': Shows information about the variables used on the 
feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'train/subject_train.txt': Traning subject id numbers.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'test/subject_test.txt': Test subject id numbers.

### Variables

From 'features_info.txt' included in the data set:

> The features selected for this database come from the accelerometer 
> and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time 
> domain signals (prefix 't' to denote time) were captured at a constant 
> rate of 50 Hz. Then they were filtered using a median filter and a 3rd 
> order low pass Butterworth filter with a corner frequency of 20 Hz to 
> remove noise. Similarly, the acceleration signal was then separated into 
> body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) 
> using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were 
> derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and 
> tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional 
> signals were calculated using the Euclidean norm (tBodyAccMag, 
> tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these 
> signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, 
> fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to 
> indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for 
> each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

> The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of 
values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

> Additional vectors obtained by averaging the signals in a signal 
> window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

> The complete list of variables of each feature vector is available 
> in 'features.txt'

The final tidy set in 'samsungS2tidy.txt' contains only:
- subject: numeric id 1-30
- activity: "laying", "sitting", "standing", "walking", "walkingupstairs",
"walkingdownstairs"
- average of each mean and standard deviation variable for each activity 
and each subject

## Transformations

1.  The data is downloaded and unzipped into a 'data' directory, unless one
already exists.
2.  The subject, labels and data for both the training and test data and
read in.
3.  Complete training and test data tables are created using cbind().
4.  The training and test data tables are merged into one using rbind().
5.  The activity labels are read in and used to label the activity values.
6.  The feature labels are read in and used to rename the corresponding
columns.
7.  A subset of the full test and training data is created by selecting only
the columns which have mean and standard deviation values.
8.  This data table is "melted" and re-cast so it contains the mean value of
each feature for each subject and activity.
9.  The column names are edited to be more despcriptive and remove special
characters.
10.  The tidy data set is written to the text file 'samsungS2tidy.txt'.

## Running the Code

1.  Copy this repository to a local directory.
2.  Type 'source("run_analysis.R")' on the R command line.
