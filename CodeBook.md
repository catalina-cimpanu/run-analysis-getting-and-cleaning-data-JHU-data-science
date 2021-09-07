---
title: "CodeBook"
output: html_document
---

## Original dataset information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


## Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ \
tGravityAcc-XYZ \
tBodyAccJerk-XYZ \
tBodyGyro-XYZ \
tBodyGyroJerk-XYZ \
tBodyAccMag \
tGravityAccMag \
tBodyAccJerkMag \
tBodyGyroMag \
tBodyGyroJerkMag \
fBodyAcc-XYZ \
fBodyAccJerk-XYZ \
fBodyGyro-XYZ \
fBodyAccMag \
fBodyAccJerkMag \
fBodyGyroMag \
fBodyGyroJerkMag \
 
The set of variables that were estimated from these signals are: 

mean(): Mean value \
std(): Standard deviation \
mad(): Median absolute deviation  \
max(): Largest value in array \
min(): Smallest value in array \
sma(): Signal magnitude area \
energy(): Energy measure. Sum of the squares divided by the number of values.  \
iqr(): Interquartile range \
entropy(): Signal entropy \
arCoeff(): Autorregresion coefficients with Burg order equal to 4 \
correlation(): correlation coefficient between two signals \
maxInds(): index of the frequency component with largest magnitude \
meanFreq(): Weighted average of the frequency components to obtain a mean frequency \
skewness(): skewness of the frequency domain signal  \
kurtosis(): kurtosis of the frequency domain signal  \
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window. \
angle(): Angle between to vectors. \

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean \
tBodyAccMean \
tBodyAccJerkMean \
tBodyGyroMean \
tBodyGyroJerkMean \

The complete list of variables of each feature vector is available in 'features.txt'.


## Creation of the tidy dataset 
From this list of variables of features vectors, only the measurements on the mean and standard deviation for each measurement were selected, rom both training and the test sets.
A second, independent tidy data set with the average of each variable for each activity and each subject was created. 

The clean dataset contains the following variables:

- "SubjectID": the ID of the subject that performed the activity                           
- "Activity": the performed activity
- Averages of the means and standard deviations of the variables of the feature vector for each pattern: (where '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.) \
-- "mean-of-tBodyAcc-mean()-X"    
-- "mean-of-tBodyAcc-mean()-Y"           
-- "mean-of-tBodyAcc-mean()-Z"           
-- "mean-of-tBodyAcc-std()-X"           
-- "mean-of-tBodyAcc-std()-Y"            
-- "mean-of-tBodyAcc-std()-Z"            
-- "mean-of-tGravityAcc-mean()-X"       
-- "mean-of-tGravityAcc-mean()-Y"        
-- "mean-of-tGravityAcc-mean()-Z"        
-- "mean-of-tGravityAcc-std()-X"        
-- "mean-of-tGravityAcc-std()-Y"         
-- "mean-of-tGravityAcc-std()-Z"         
-- "mean-of-tBodyAccJerk-mean()-X"      
-- "mean-of-tBodyAccJerk-mean()-Y"       
-- "mean-of-tBodyAccJerk-mean()-Z"       
-- "mean-of-tBodyAccJerk-std()-X"       
-- "mean-of-tBodyAccJerk-std()-Y"        
-- "mean-of-tBodyAccJerk-std()-Z"        
-- "mean-of-tBodyGyro-mean()-X"         
-- "mean-of-tBodyGyro-mean()-Y"          
-- "mean-of-tBodyGyro-mean()-Z"          
-- "mean-of-tBodyGyro-std()-X"          
-- "mean-of-tBodyGyro-std()-Y"           
-- "mean-of-tBodyGyro-std()-Z"          
-- "mean-of-tBodyGyroJerk-mean()-X"     
-- "mean-of-tBodyGyroJerk-mean()-Y"     
-- "mean-of-tBodyGyroJerk-mean()-Z"      
-- "mean-of-tBodyGyroJerk-std()-X"      
-- "mean-of-tBodyGyroJerk-std()-Y"       
-- "mean-of-tBodyGyroJerk-std()-Z"       
-- "mean-of-tBodyAccMag-mean()"         
-- "mean-of-tBodyAccMag-std()"           
-- "mean-of-tGravityAccMag-mean()"       
-- "mean-of-tGravityAccMag-std()"       
-- "mean-of-tBodyAccJerkMag-mean()"      
-- "mean-of-tBodyAccJerkMag-std()"       
-- "mean-of-tBodyGyroMag-mean()"        
-- "mean-of-tBodyGyroMag-std()"          
-- "mean-of-tBodyGyroJerkMag-mean()"     
-- "mean-of-tBodyGyroJerkMag-std()"     
-- "mean-of-fBodyAcc-mean()-X"           
-- "mean-of-fBodyAcc-mean()-Y"           
-- "mean-of-fBodyAcc-mean()-Z"          
-- "mean-of-fBodyAcc-std()-X"            
-- "mean-of-fBodyAcc-std()-Y"            
-- "mean-of-fBodyAcc-std()-Z"           
-- "mean-of-fBodyAccJerk-mean()-X"       
-- "mean-of-fBodyAccJerk-mean()-Y"       
-- "mean-of-fBodyAccJerk-mean()-Z"      
-- "mean-of-fBodyAccJerk-std()-X"        
-- "mean-of-fBodyAccJerk-std()-Y"        
-- "mean-of-fBodyAccJerk-std()-Z"       
-- "mean-of-fBodyGyro-mean()-X"          
-- "mean-of-fBodyGyro-mean()-Y"          
-- "mean-of-fBodyGyro-mean()-Z"         
-- "mean-of-fBodyGyro-std()-X"           
-- "mean-of-fBodyGyro-std()-Y"           
-- "mean-of-fBodyGyro-std()-Z"          
-- "mean-of-fBodyAccMag-mean()"          
-- "mean-of-fBodyAccMag-std()"     
-- "mean-of-fBodyBodyAccJerkMag-mean()"      
-- "mean-of-fBodyBodyAccJerkMag-std()"     
-- "mean-of-fBodyBodyGyroMag-mean()"     
-- "mean-of-fBodyBodyGyroMag-std()"       
-- "mean-of-fBodyBodyGyroJerkMag-mean()"      
-- "mean-of-fBodyBodyGyroJerkMag-std()"

#### Notes: 

For more information about this dataset contact: activityrecognition@smartlab.ws

#### License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
