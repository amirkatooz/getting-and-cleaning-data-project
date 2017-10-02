library(reshape2)

activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')
features <- read.table('UCI HAR Dataset/features.txt', as.is=TRUE)
mean_std_mask <- grepl('mean|std', features[, 2])
features <- features[mean_std_mask, 2]
features <- gsub('-mean', 'Mean', features)
features <- gsub('-std', 'Std', features)
features <- gsub('[-()]', '', features)
features <- gsub('^f', 'frequency', features)
features <- gsub('^t', "time", features)

subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
X_train <- read.table('UCI HAR Dataset/train/X_train.txt')[mean_std_mask]
y_train <- read.table('UCI HAR Dataset/train/y_train.txt')

subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
X_test <- read.table('UCI HAR Dataset/test/X_test.txt')[mean_std_mask]
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')

train_set <- cbind(subject_train, X_train, y_train)
test_set <- cbind(subject_test, X_test, y_test)

activity_df <- rbind(train_set, test_set)
colnames(activity_df) <- c('subject_id', features, 'activity')

activity_df$activity <- factor(
  activity_df$activity,
  levels = activity_labels[, 1],
  labels = activity_labels[, 2]
  )

melted_df <- melt(activity_df, id = c('subject_id', 'activity'))
mean_df <- dcast(melted_df, subject_id + activity ~ variable, mean)

write.table(mean_df, "tidy.txt", row.names = FALSE, quote = FALSE)


