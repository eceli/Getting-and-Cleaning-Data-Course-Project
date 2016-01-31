# Code Book
This code book summarizes the processing and the resulting archive tidy_data.txt.

The script `run_analysis.R` does the following:

* First, download the data and unzip it in the working directory.
* Then, loads the data in many data frames and merges the training and the test sets to create one data set.
* After that, extracts only the measurements on the mean and standard deviation for each measurement.
* Then adds descriptive activity names to name the activities in the data set
* And also labels the data set with descriptive variable names.
* Finally, from the resulting data set, creates a second (average_data), independent tidy data set with the average of each variable for each activity and each subject.

# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded and unziped files.
* `x_data`, `y_data` and `subject_data` merge the datasets from train and test for further analysis.
* `features` contains the names for the `x_data` dataset, which are applied to the column names stored in `featuresWanted`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `all_data` is the result of merging `x_data`, `y_data` and `subject_data` in a big dataset.
* Finally, `average_data` contains the relevant average which will be later stored in `tidy_data.txt` file.