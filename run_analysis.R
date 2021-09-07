# Please check the run_analysis_with_comments.R file for a very commented version of the same code

library(data.table)
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
unzip(zipfile = "dataset.zip", exdir = ".")

# 1. Merges the training and the test sets to create one data set.
test_set <- fread(file.path(".", "UCI HAR Dataset/test/X_test.txt"))
training_set <- fread(file.path(".", "UCI HAR Dataset/train/X_train.txt"))
complete_set<- rbind(test_set, training_set)

# 4. Appropriately labels the data set with descriptive variable names. 
features <- fread(file.path(".", "UCI HAR Dataset/features.txt")) 
colnames(features) <- c("index", "featureName")
colnames(complete_set) <- features$featureName

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
selected_set <- subset(complete_set, select = c(grepl("(mean|std)\\(\\)", colnames(complete_set)) == TRUE))


# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- fread(file.path(".", "UCI HAR Dataset/activity_labels.txt"))
colnames(activity_labels) <- c("index", "activityName")
test_labels_nr <- fread(file.path(".", "UCI HAR Dataset/test/y_test.txt"))
test_labels_nr <- test_labels_nr$V1 
training_labels_nr <- fread(file.path(".", "UCI HAR Dataset/train/y_train.txt"))
training_labels_nr <- training_labels_nr$V1
test_labels <- activity_labels$activityName[test_labels_nr]
training_labels <- activity_labels$activityName[training_labels_nr]
all_labels <- c(test_labels, training_labels)

selected_set <- cbind(`Activity` = all_labels, selected_set)

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
test_subjects <- fread(file.path(".", "UCI HAR Dataset/test/subject_test.txt"))
test_subjects <- test_subjects$V1 
training_subjects <- fread(file.path(".", "UCI HAR Dataset/train/subject_train.txt"))
training_subjects <- training_subjects$V1 
all_subjects <- c(test_subjects, training_subjects)

selected_set <- cbind(`SubjectID` = all_subjects, selected_set)


clean_set <- selected_set %>%
     arrange(SubjectID, Activity) %>%
     group_by(SubjectID, Activity) %>%
     summarise(across(.cols = everything(), mean)) 


new_names <- paste("mean-of-", colnames(clean_set[,3:length(clean_set)]),sep="")
colnames(clean_set)[3:ncol(clean_set)] <- new_names


fwrite(x = clean_set, file = "clean_data.txt", row.name=FALSE)

