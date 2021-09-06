# 0. Preparation -------------------
## 0.1. Load packages ----------------
# data.table and dplyr packages - cuz we'll need them
library(data.table)
library(dplyr)

## 0.2. Get data from the internet ----------------
# https://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
unzip(zipfile = "dataset.zip", exdir = ".")



# You should create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set. ------

# A set is basically a collection of the 561 features (with data for each feature)
# We deduce that from the fact that it has 561 elements, which is exactly the number of features
# In the description is found as the 561-feature vector with time and frequency domain variables 
# It is quite confusing that they call it vector, since it's more of a list or dataframe, but nobody's perfect
test_set <- fread(file.path(".", "UCI HAR Dataset/test/X_test.txt"))
training_set <- fread(file.path(".", "UCI HAR Dataset/train/X_train.txt"))
complete_set<- rbind(test_set, training_set)



# 2. Extracts only the measurements on the mean and standard deviation for each measurement. -----
# Basically we have signals: tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyAccJerk-XYZ, ... (-> from features_info)
# from which a set of variables were estimated: 
# mean(): Mean value, std(): Standard deviation, mad(): Median absolute deviation, ... (-> from features_info)
# We need to extract only the mean and standard deviation for each measurement,
# that is, practically, the features which have mean or std in the name

## 2.1. Extract the names of the features -----
features <- fread(file.path(".", "UCI HAR Dataset/features.txt")) 
colnames(features) <- c("index", "featureName")

## 2.2. Name the columns in the complete set (which has data for all the features for both sets) -----
colnames(complete_set) <- features$featureName

## 2.3. Extract only the features which have mean or std in the name -----
selected_set <- subset(complete_set, select = c(grepl("(mean|std)\\(\\)", colnames(complete_set)) == TRUE))



# 3. Uses descriptive activity names to name the activities in the data set -----

## 3.1. Get the activity labels
activity_labels <- fread(file.path(".", "UCI HAR Dataset/activity_labels.txt"))
colnames(activity_labels) <- c("index", "activityName")

## 3.2. Get the labels for each set -----
# From README we know that 
# 'train/y_train.txt': Training labels.
# 'test/y_test.txt': Test labels.
test_labels_nr <- fread(file.path(".", "UCI HAR Dataset/test/y_test.txt"))
test_labels_nr <- test_labels_nr$V1 # save as vector instead of dataframe
training_labels_nr <- fread(file.path(".", "UCI HAR Dataset/train/y_train.txt"))
training_labels_nr <- training_labels_nr$V1 # save as vector instead of dataframe

## 3.3. Save labels as names (character) instead of integers ------
test_labels <- activity_labels$activityName[test_labels_nr]
training_labels <- activity_labels$activityName[training_labels_nr]
# basically, it gets the name from the activity_labels dataframe, by using the index
# To check it counts correctly, run the following commands
activity_labels # to show the activity labels
table(test_labels_nr) # to show how many counts under each label (as nr)
table(test_labels) # to show how many counts under each label (as character)
# we notice that for example under the label 6 as well as under label "LAYING" there are 537 counts
# and we notice that 6 is the index for LAYING in the activity_labels dataframe

## 3.4. Put all labels in one vector
all_labels <- c(test_labels, training_labels)
# they have to be in the same order as in the complete set
# since for the complete set we first added test_set, then training_set, labels should be in the same order

## 3.5. Add labels to the selected dataset
selected_set <- cbind(`Activity` = all_labels, selected_set)



# 4. Appropriately labels the data set with descriptive variable names. -----
# I think all I've done so far gave this result, that variables are appropriately named



# 5. Create tidy data set ------ 
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.


## 5.1. Add subjects to the dataset -----

### 5.1.1. Get the subjects for each set -----
test_subjects <- fread(file.path(".", "UCI HAR Dataset/test/subject_test.txt"))
test_subjects <- test_subjects$V1 # save as vector instead of dataframe
training_subjects <- fread(file.path(".", "UCI HAR Dataset/train/subject_train.txt"))
training_subjects <- training_subjects$V1 # save as vector instead of dataframe

### 5.1.2. Put all subjects in one vector -----
all_subjects <- c(test_subjects, training_subjects)
# they have to be in the same order as in the complete set
# since for the complete set we first added test_set, then training_set, subjects should be in the same order

### 5.1.3. Add subjects to the selected dataset ------
selected_set <- cbind(`SubjectID` = all_subjects, selected_set)


## 5.2. Create new data set, sorted by activity and subject and calculate average-----

### 5.2.1. Calculate the average of each variable for each activity and each subject -----
# start with the selected set, arrange by subject and activity (arranging is optional), 
# then group by activity and by subject, then calculate means
clean_set <- selected_set %>%
   arrange(SubjectID, Activity) %>%
   group_by(SubjectID, Activity) %>%
   summarise(across(.cols = everything(), mean)) # recommended
# you can do the same thing like this, but summarise_each is deprecated 
# (despite code being more readable)
clean_set2 <- selected_set %>%
   arrange(SubjectID, Activity) %>%
   group_by(SubjectID, Activity) %>%
   summarise_each(mean) # deprecated
# you can check it gives the same result (will give TRUE)
identical(clean_set, clean_set2)

### 5.2.2. Rename the columns so that they are more intelligible -----
old_names <- colnames(clean_set[,3:length(clean_set)])
new_names <- paste("mean-of-", old_names, sep="")
# could have been one in one command
new_names <- paste("mean-of-", colnames(clean_set[,3:length(clean_set)]),sep="")
# rename columns for better understanding
colnames(clean_set)[3:ncol(clean_set)] <- new_names


## 5.3. Save tidy dataset into a new file
fwrite(x = clean_set, file = "clean_data.txt", quote = FALSE)

