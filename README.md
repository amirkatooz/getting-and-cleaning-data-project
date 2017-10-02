# Course Project: Getting and Cleaning Data
This is the final project for the Getting and Cleaning Data course from coursera.org.
The R code in this repo (run_analysis.R) works only for the UCI HAR dataset as follow:

- Loads the activity labels and the features.
- Selects only the features related to mean and standard deviation.
- Does a little text cleaning.
- Loads the features and the target for both train and test sets and combines them.
- Converts the activity type into factors
- Creates a tidy dataset of the average value of each variable for each subject ID and activity and stores it in a text file (tidy.txt).
