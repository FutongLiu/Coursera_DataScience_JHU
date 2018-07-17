# Introduction

The script 'run_analysis.R' erforms the five steps described in the course project.

* First, all the similar data is merged using the 'rbind()' function. On the whole dataset, those columns with vague column names are corrected.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from 'features.txt'.
* As activity data is addressed with values 1:6, we take the activity names and IDs from 'activity_labels.txt' and they are substituted in the dataset. 
* Finally, we generate a tidy dataset with the average of each variable for each activity and each subject.The output file is called 'TidyData.txt', and uploaded to this repository.

# Variables

* 'x_train', 'y_train', 'x_test', 'y_test', 'subject_train' and 'subject_test' contain the data from the downloaded files.
* 'TrainData','TestData'and'MergedData' merge the previous datasets for further analysis.
* 'features' contains the correct names for the 'x_train' and 'x_test' dataset, which are applied to the column names of the two data set. A similar approach is taken with activity names through the 'activities' variable.
* A numeric vector used to extract the desired data and stored in 'ExtractMeanStd'
* 'FinalData' merges all the data in a big dataset with descriptive activity names to name the activities in the data set
* Finally, 'TidyData' contains the relevant averages which will be later stored in a 'txt' file. 'melt()''group_by()' from the reshape2 and plyr packages are used to clean the 'FinalData'.