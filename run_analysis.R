## 0. Downloading data
filename <- "getdata_UCI_HAR.zip"

if (!file.exists(filename)){
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
## Reading labels and features
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features_names <- read.table("./UCI HAR Dataset/features.txt")
## Read training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
features_train <- read.table("UCI HAR Dataset/train/X_train.txt")
## Read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
features_test <- read.table("UCI HAR Dataset/test/X_test.txt")

## 1. Merge the training and test sets to create one data set
subject <- rbind(subject_train, subject_test)
activity <- rbind(activity_train, activity_test)
features <- rbind(features_train, features_test)

colnames(features) <- t(features_names[2])

colnames(activity) <- "activity"
colnames(subject) <- "subject"
data_all <- cbind(subject, activity, features)

## 2. Extract only the measurements on the mean and standard deviation for each
## measurement
mean_sd <- grep(".*Mean.*|.*Std.*", names(data_all), ignore.case = TRUE)
cols <- c(mean_sd, 1, 2)

data_extract <- data_all[, cols]

## 3. Use descriptive activity names to name the activities in the data set
data_extract$activity <- activity_labels[data_extract$activity, 2]

## 4. Appropriately label the data set with descriptive variable names
names(data_extract) <- gsub("^t", "Time", names(data_extract))
names(data_extract) <- gsub("^f", "Frequency", names(data_extract))
names(data_extract) <- gsub("Acc", "Accelerometer", names(data_extract))
names(data_extract) <- gsub("Gyro", "Gyroscope", names(data_extract))
names(data_extract) <- gsub("Mag", "Magnitude", names(data_extract))
names(data_extract) <- gsub("BodyBody", "Body", names(data_extract))
names(data_extract) <- gsub("tBody", "TimeBody", names(data_extract))
names(data_extract) <- gsub("-mean()", "Mean", names(data_extract))
names(data_extract) <- gsub("-std()", "SD", names(data_extract))
names(data_extract) <- gsub("-freq()", "Frequency", names(data_extract))
names(data_extract) <- gsub("angle", "Angle", names(data_extract))
names(data_extract) <- gsub("gravity", "Gravity", names(data_extract))

## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
data_extract$subject <- as.factor(data_extract$subject)
data_tidy <- aggregate(. ~ subject + activity, data_extract, mean)

write.table(data_tidy, file = "data_tidy.txt", row.names = FALSE)
