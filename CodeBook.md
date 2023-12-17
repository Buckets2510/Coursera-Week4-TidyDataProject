# Codebook for Coursera "Getting and Cleaning Data" Project

The data set referred to in this codebook can be viewed in tidy_data.txt.
See the README file for background on the project.

## Introduction to the pre-tidy data set
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

Each record contains the following:
- Triaxial acceleration from the accelerometer (total acceleration) and the           estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The pre-tidy dataset contains the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature       vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the         activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the     smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a    128 element vector. The same description applies for the 'total_acc_x_train.txt'    and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal          obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector          measured by the gyroscope for each window sample. The units are radians/second.

## Project tasks and walkthrough
A R script, called run_analysis.R does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each          measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the    average of each variable for each activity and each subject.

Executing the work is as follows:
1. Download of the required files to the working directory and read the files to the workspace with 'download.file' and 'fread'.

2. Extract measurements based on mean and standard deviation from the features dataset. Adjust column names to more descriptive variabels using the 'gsubfn' function

3. Load the remaining data from the training and test sets. Use 'fread' to read the files and 'col.names' to set column names for future merging and clean-up. Use 'cbind' to combine the training and test sets separately.

4. Merge the training and test datasets with 'rbind'. Remove the redundant tables to save memory.

5. Use 'factor' and 'as.factor' functions to change the activity values with named factor levels in preparation for the tidy data set.

6. Use 'group_by' and 'summarise_all' with mean to create the tidy data set of the average of each variable for each activity and subject .

## The variables changed from the original data set are as follows:
- "t" = "Time"
- "f" = "Frequency"
- "Acc" = "Accelerometer"
- "Gyro" = "Gyroscope"
- "Mag" = "Magnitude"
- "BodyBody" = "Body"
- "()" = ""
