# Analysis script for the Getting and Cleaning Data Project Course
# Reashaping dataset

library(reshape2)

# load test data
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")

# load train data
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")

# load activity names
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt")

# load feature names
features <- read.table("data/UCI HAR Dataset/features.txt")
headers <- features[,2]

# name columns of test and train features
names(X_test) <- headers
names(X_train) <- headers

# select only mean and std headers
mean_std <- grepl("mean\\(\\)|std\\(\\)", headers)

# filter mean and std columns on test and train
X_test_mean_std <- X_test[,mean_std]
X_train_mean_std <- X_train[,mean_std]

# merge all test and train rows
subject_all <- rbind(subject_test, subject_train)
X_all <- rbind(X_test_mean_std, X_train_mean_std)
y_all <- rbind(y_test, y_train)

# combine all data into one data.frame
merged <- cbind(subject_all, y_all, X_all)
names(merged)[1] <- "SubjectID"
names(merged)[2] <- "Activity"

# aggregate by subjectid and activity and perform the mean
agg <- aggregate(. ~ SubjectID + Activity, data=merged, FUN = mean)

# give activities better names
agg$Activity <- factor(agg$Activity, labels=activity_labels[,2])

write.table(agg, file="./data/tidy_final_data.txt", sep="\t", row.names=FALSE)















