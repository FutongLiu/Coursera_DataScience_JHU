setwd("C:/Users/futong/Desktop/Coursera/R_work/CleaningDataProjectAssignment")

## read data
features <- read.table("features.txt", header=F)
activity_labels <- read.table("activity_labels.txt", header=F)
colnames(activity_labels) <- c("activityID", "activityTYPE")
subject_train <- read.table("./train/subject_train.txt", header=F)
colnames(subject_train) <- c("subjectID")
x_train <- read.table("./train/X_train.txt", header=F)
colnames(x_train) <- features[,2]
y_train <- read.table("./train/y_train.txt", header=F)
colnames(y_train) <- c("activityID")
TrainData <- cbind(subject_train, y_train, x_train)

subject_test <- read.table("./test/subject_test.txt", header=F)
colnames(subject_test) <- c("subjectID")
x_test <- read.table("./test/X_test.txt", header=F)
colnames(x_test) <- features[,2]
y_test <- read.table("./test/y_test.txt", header=F)
colnames(y_test) <- c("activityID")
TestData <- cbind(subject_test, y_test, x_test)

## 1. Merges the training and the test sets to create one data set.
MergedData <- rbind(TrainData, TestData)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
colname <- colnames(MergedData)
ExtractMeanStd <- MergedData[,grepl("subjectID", colname)|grepl("activityID", colname)|grepl("mean|std",colname)]

##3. Uses descriptive activity names to name the activities in the data set
FinalData <- merge(activity_labels, ExtractMeanStd, by.x="activityID", by.y="activityID", all=T)

##4. Appropriately labels the data set with descriptive variable names -- done in the first step

##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
MeltData <- melt(FinalData, id=c("subjectID", "activityTYPE", "activityID"), measure.vars=colnames(FinalData)[4:82])
TidyData   = dcast(MeltData, subjectID + activityTYPE + activityID ~ variable, mean)
write.table(TidyData, "TidyData.txt", row.names = FALSE, quote = FALSE)
