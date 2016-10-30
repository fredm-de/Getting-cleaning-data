# Download and unzip data
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
file.dest <- 'UCI_HAR_Dataset.zip'
download.file(file.url, file.dest, method='curl')
unzip(file.dest)


# load and merge test data

test.subject = read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subject.id"))
test.subject$id <- as.numeric(rownames(test.subject)) # rownum as id

test.x = read.table("UCI HAR Dataset/test/X_test.txt")
test.x$id <- as.numeric(rownames(test.x)) # rownum as id

test.y = read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("activity.id"))  # max = 6
test.y$id <- as.numeric(rownames(test.y)) # rownum as id

# merge to test.data
test.data <- merge(test.x, test.y, all=TRUE)
test.data <- merge(test.subject, test.data, all=TRUE)


# load and merge train.data

train.subject = read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("subject.id"))
train.subject$id <- as.numeric(rownames(train.subject)) # rownum as id

train.x = read.table("UCI HAR Dataset/train/X_train.txt")
train.x$id <- as.numeric(rownames(train.x)) # rownum as id

train.y = read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("activity.id"))  # max = 6
train.y$id <- as.numeric(rownames(train.y)) # rownum as id

# merge to train.data
train.data <- merge(train.x, train.y, all=TRUE)
train.data <- merge(train.subject, train.data, all=TRUE)


# 1 Merge data to master.data
master.data <- merge(train.data, test.data, all=TRUE)


# 2 Extract only mean and std features
features = read.table("UCI HAR Dataset/features.txt", col.names=c("id", "label"),) 
selection <- features[grepl("mean\\(\\)", features$label) | grepl("std\\(\\)", features$label), ]
master.data <- master.data[names(master.data[,c(1,2,564,3:563)])] # reorganize cols in master data for easier selection
selected.data <- master.data[, c(1, 2, 3, selection$id + 3)]

# 3 descriptive activity labeling
activity.labels = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity.id", "activity.label"),) #read label list
selected.data = merge(selected.data, activity.labels)
selected.data <- selected.data[names(selected.data[,c(2,3,1,70,4:69)])] # reorganize cols for easier selection

# 4 descriptive feature labeling
measurement.labels = gsub("\\(\\)", "", selection$label)
measurement.labels = gsub("-", ".", measurement.labels)
names(selected.data) <- c(names(selected.data)[1:4], measurement.labels)

data <- selected.data

# creation of new dataset with average of each variable for each activity and each subject
agg.data <- data[,c(2,4,5:70)] # drop colons id and activity.id
agg.data <- aggregate(agg.data, by=list(subject = agg.data$subject.id, activity = agg.data$activity.label), FUN=mean, na.rm=TRUE)
agg.data <- agg.data[,c(1,2,5:70)] # drop colons subject.id and activity.label
write.csv(file="submit.csv", x=agg.data) # write file