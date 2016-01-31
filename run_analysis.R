library(plyr)

##download the zip
filename <- "data.zip"
if (!file.exists(filename)) {
        fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL,destfile=filename)
}
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}


## 1. Merges the training and the test sets to create one data set.

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("UCI HAR Dataset/features.txt")

# get only the columns with mean or std in their names
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])

# subset the columns
x_data <- x_data[, featuresWanted]

# put the column names
names(x_data) <- features[featuresWanted, 2]

## 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# put column name
names(y_data) <- "activity"

## 4. Appropriately labels the data set with descriptive variable names.

# put column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# all columns except last two (activity and subject)
average_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:(ncol(all_data)-2)]))
write.table(average_data, "tidy_data.txt", row.name=FALSE)