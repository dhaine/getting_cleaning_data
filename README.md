# Getting and Cleaning Data Course Project

The goal of this project is to prepare tidy data that can be used
for later analysis.

The R script `run_analysis.R`:

1. Downloads the dataset if it does not already exist in the working directory,
2. Loads the activity and features info,
3. Loads the training and test datasets,
4. Merges the two datasets,
5. Extracts only the columns with means and standard deviations,
6. Uses descriptive activity names to name the activities in the data set,
7. Labels the data set with descriptive variable names,
8. Creates a tidy dataset with the average of each variable for activity and
   each subject, `data_tidy.txt`.
