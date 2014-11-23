---
title: "CodeBook.md"
---

Source required for this script
The script works on the data set "Human Activity Recognition Using Smartphones Dataset" - (Version 1.0) by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Actions leading to the creation of the first data set called "DataSet"
* It takes the training data (tables X_train, y_train, and subject_train) and merges them into one data frame
* It takes the test data (tables X_test, y_test, and subject_test) and merges them into one table
* It merges both of these tables, marks training data with a 0 and test data with a 1 (column Data_type)
* It gives appropriate names to the variables (Features) and replaces the activity code by their real name
* It extracts only the variables corresponding to a mean or a standard deviation (the data set is reduced from 561variables to 79 variables)
* It puts the column "Data_type" first, and the column "Activity" second

Actions leading to the creation of the second data set called "DataSet_2"
Once this first data set is created, the script creates a second data set. This second data set contains the mean of each variable for each subject and each activity.
Finally, it writes a new text file with this second data set. 

