library(plyr)

# Download dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataset
unzip(zipfile="./data/Dataset.zip",exdir="./data")
 
# 1. Merge the training and the test sets to create one data set.

	# 1.1 Read files
		# 1.1.1 Train tables
		  x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
		  y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
		  subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

		# 1.1.2 Test tables
		  x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
		  y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
		  subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

		# 1.1.3 Feature vector
		  features <- read.table('./data/UCI HAR Dataset/features.txt')

		# 1.1.4 Activity labels
		  activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

	# 1.2 Assign column names
		# 1.2.1 Train
		  colnames(x_train) <- features[,2]
		  colnames(y_train) <-"activityId"
		  colnames(subject_train) <- "subjectId"
 
		# 1.2.2 Test
		  colnames(x_test) <- features[,2]
		  colnames(y_test) <- "activityId"
		  colnames(subject_test) <- "subjectId"
		  colnames(activityLabels) <- c('activityId','activityType')

	# 1.3 Merge all data in one set
		mrg_train <- cbind(y_train, subject_train, x_train)
		mrg_test <- cbind(y_test, subject_test, x_test)
		OneDataSet <- rbind(mrg_train, mrg_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

	#2.1 Read column names
		MrgColNames <- colnames(OneDataSet)

	# 2.2 Create vector for defining Id, mean and standard deviation
		mean_and_std <- (grepl("activityId" , MrgColNames) | 
                      grepl("subjectId" , MrgColNames) | 
                      grepl("mean.." , MrgColNames) | 
                      grepl("std.." , MrgColNames) 
 )

	#2.3 Make subset from OneDataSet
		ExtractMeanAndStd <- OneDataSet[ , mean_and_std == TRUE]

# 3. Use descriptive activity names to name the activities in the data set.
	DescriptiveActivityNames <- merge(ExtractMeanAndStd, activityLabels,
                               by='activityId',
                               all.x=TRUE)

# 4. Appropriately label the data set with descriptive variable names.
      # Made in 1.3, 2.2, 2.3.
 

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

	# 5.1 Second tidy dataset
	SecondTidyData <- aggregate(. ~subjectId + activityId, DescriptiveActivityNames, mean)
	SecondTidyData <- SecondTidyData[order(SecondTidyData$subjectId, SecondTidyData$activityId),]

	# 5.2 Write second tidy dataset in txt file
		write.table(SecondTidyData, "SecondTidyData.txt", row.name=FALSE)
