# This script downloads data about human movement as recorded by
# a Samsung Galaxy S2 phone and creates a new tidy data file
# containing only average values of all mean and standard deviation
# movement features for each test subject and activity.

library(dplyr)
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download file if necessary
if(!file.exists("./data")) {
        dir.create("./data")
        download.file(fileUrl, destfile="./data/sII.zip")
        unzip("./data/sII.zip")
}

# Read in training data
subTrain <- fread("UCI HAR Dataset/train/subject_train.txt")
Xtrain <- fread("UCI HAR Dataset/train/X_train.txt")
Ytrain <- fread("UCI HAR Dataset/train/Y_train.txt")

# Read in test data
subTest <- fread("UCI HAR Dataset/test/subject_test.txt")
Xtest <- fread("UCI HAR Dataset/test/X_test.txt")
Ytest <- fread("UCI HAR Dataset/test/Y_test.txt")

# Link subject and activity to features for test and training data
train <- cbind(Xtrain, activity=Ytrain, subject=subTrain)
test <- cbind(Xtest, activity=Ytest, subject=subTest)

# Delete separate txt files to free up space
rm("subTest")
rm("Xtest")
rm("Ytest")
rm("subTrain")
rm("Xtrain")
rm("Ytrain")

# Merge training and test data
fullData <- rbind(train, test)
# Fix the activity and subject column names
fullData <- rename(fullData, activity=activity.V1, subject=subject.V1)
rm("test")
rm("train")

# Read in activity_labels
actLabels <- fread("UCI HAR Dataset/activity_labels.txt")
# Make all activity labels lowercase & remove "_"
actLabels$V2 <- tolower(actLabels$V2)
actLabels$V2 <- gsub("_","",actLabels$V2)

# Assign activity label to activity number
# This takes the number value from the fullData$activity colunm
# and selects that number entry from the list of activity labels
# actLabels[[2]].
fullData$activity <- actLabels[[2]][fullData$activity]

# Read in feature labels
featLabels <- fread("UCI HAR Dataset/features.txt")

# Rename columns to corresponding feature label
names(fullData)[1:561] <- as.character(featLabels[[2]])

# Select only mean & std. dev. columns (along with activity & subject)
s2mean <- select(fullData, grep("mean\\(\\)|std\\(\\)", names(fullData)), activity, subject)
rm("fullData")

# Re-shape the data set so that it gives feature value
# as a function of subject and activity.
s2melt <- melt(s2mean, id=c("subject","activity"))

# Compute mean for each feature as a function of subject and activity.
s2tidy <- dcast(s2melt,subject+activity~variable,mean)

# Make the column names more manageable:
# remove "-" and "()" and capitalize "M" in "mean" and "S" in "s
names(s2tidy) <- gsub("-","",names(s2tidy))
names(s2tidy) <- gsub("\\(\\)","",names(s2tidy))
names(s2tidy) <- gsub("mean","Mean",names(s2tidy))
names(s2tidy) <- gsub("std","Std",names(s2tidy))
# Make names more descriptive by replacing "t" and "f" with
# "time" and "freq"
names(s2tidy) <- gsub("^t","time",names(s2tidy))
names(s2tidy) <- gsub("^f","freq",names(s2tidy))

# Write tidy data to file
write.table(s2tidy, file="samsungS2tidy.txt", row.names=FALSE)