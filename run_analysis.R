## Setting working directory
dir <- "C:/Users/User/Desktop/01. Private/09. Online classes/2. Coursera/Working directory/2. Data"
setwd(dir)

## 1. Read the activity labels and give names to the columns of the table
ActivityLabels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep = "", header = F)
colnames(ActivityLabels) <- c("Activity_code", "Activity")

## 2. Read the features and give names to the columns of the table
Features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
colnames(Features) <- c("Feature_code", "Feature")

## 3. Read the training data from the tables X_train, y_train, and subject_train, merge them into one data table, add in a new column on the left a marker (0) to indicate that the data is from the training set
TrainingSet <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
TrainingActivities <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
TrainingSubjects <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
TrainingMarker <- matrix(0, nrow(TrainingSet), 1)
TrainingSet <- cbind(TrainingMarker, TrainingSubjects, TrainingActivities, TrainingSet)

## 3.bis Give names to the columns of the training set
colnames(TrainingSet) <- c("Data_type", "Subject_code","Activity_code", as.character(Features$Feature))

## 4. Read the test data from the tables X_test, y_test, and subject_test, merge them into one data table, add in a new column on the left a marker (1) to indicate that the data is from the test set
TestSet <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
TestActivities <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
TestSubjects <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
TestMarker <- matrix(1, nrow(TestSet), 1)
TestSet <- cbind(TestMarker, TestSubjects, TestActivities, TestSet)

## 4.bis Give names to the columns of the test set
colnames(TestSet) <- c("Data_type", "Subject_code","Activity_code", as.character(Features$Feature))

## 5. Merge the training set and the test set
DataSet <- rbind(TrainingSet, TestSet)

## 6. Give activities a real name
DataSet <- merge(ActivityLabels, DataSet)

## 7. Select "mean" and "std" columns
MeanCol <- grep("mean", names(DataSet))
StdCol <- grep("std", names(DataSet))
A <- matrix(2:4,3,1)
Col_Select <- rbind(A, as.matrix(MeanCol), as.matrix(StdCol))
DataSet <- DataSet[,Col_Select]
DataSet <- DataSet[,c(2, 1, 3:82)]

##8. From the first data set created (DataSet), create a second, independent tidy data set with the average of each variable for each activity and each subject
factor <- list(DataSet$Activity, as.factor(DataSet$Subject_code))
s <- split(DataSet, factor)
DataSet_2 <- t(sapply(s, function (x) colMeans(x[, 4:82])))

##9. Add two columns on the left to indicate the subject and the actvity (this info was previously included in the row names, which is not tidy - more than one information in one column) and rename rows from 1 to 180
out <- strsplit(as.character(rownames(DataSet_2)),'\\.') 
Names <- do.call(rbind, out)
DataSet_2 <- cbind(Names[,2], Names[,1], DataSet_2)
colnames(DataSet_2) <- c("Subject", "Activity", paste ("mean", colnames(DataSet_2[,3:81])))
write.table(DataSet_2, "./DataSet_2.txt", row.names = F)
