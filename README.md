# README - Explanation of analysis.R

analysis.R performs the following functions on the raw data to output TidyData.txt

* Load in relevant data (found in the projectData folder)
* Collates data from the training and test sets, and adds the relevant variable names
* Removes irrelevant data
* Selects only the relevant data from the dataset (i.e. only the mean and standard deviations of each recording)
* Converts the numeric activity labels to more informative labels
* Groups by the activity labels and subjects
* Provides the mean of each variable grouped by activity and subject
