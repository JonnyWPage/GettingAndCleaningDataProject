# Load in relevant datasets
library(dplyr)
setwd("C:/Users/jonny/Documents/Coursera/projectData")

activity_labels = read.table("./activity_labels.txt")
train_set = read.table("./train/X_train.txt")
train_labels = read.table("./train/y_train.txt")
train_subjects = read.table("./train/subject_train.txt")

test_set = read.table("./test/X_test.txt")
test_labels = read.table("./test/y_test.txt")
test_subjects = read.table("./test/subject_test.txt")

features = read.table("./features.txt")

# Combine all data together
train_set <- cbind(train_subjects, train_labels, train_set)
test_set <- cbind(test_subjects, test_labels, test_set)

tot_set <- rbind(train_set, test_set)

# Add column names to everything
column_names <- as.character(features$V2)
colnames(tot_set) <- c("subject","activity",column_names)

# Convert everything we're using to a tibble using tbl_df
# Remove anything unecessary
remove(test_labels, train_labels, test_subjects, train_subjects,
       test_set, train_set)

# select the only columns with mean() and std() [select()]
req_cols <- grep(("subject|activity|mean\\()|std\\()"),
                 colnames(tot_set))
tot_set <- tot_set[,req_cols]

# add more informative activity labels
tot_df <- merge(tot_set,activity_labels,by.x="activity",
                by.y="V1")
tot_df$activity <- tot_df$V2
tot_df$V2 <- NULL      # remove extra column
tot_df <- tbl_df(tot_df)

# use group_by() to group by activity labels and subjects
by_activity <- group_by(tot_df,activity,subject)

# use summarise(mean()) to get the means of each activity
averaged <- summarise_each(by_activity,funs(mean))

# averaged can then be output to TidyData.txt using write.table