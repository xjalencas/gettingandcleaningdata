
read_training <- function(){
  
  # Read the training data set
  training <- read.table('UCI HAR Dataset/train/X_train.txt')
  
  # Read features
  features <- read.table("UCI HAR Dataset/features.txt",  stringsAsFactors = F)
  colnames(training) <- unlist(features[2])

  subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
  colnames(subjects)<- "subject"
  
  # Read subject data
  activities <- read.table("UCI HAR Dataset/train/y_train.txt")
  colnames(activities)<- "activity"
  
  training <- cbind(subjects, activities, training)
  return(training)  
}

read_test <- function(){
  
  # Read the training data set
  test <- read.table('UCI HAR Dataset/test/X_test.txt')
  
  # Read features
  features <- read.table("UCI HAR Dataset/features.txt",  stringsAsFactors = F)
  colnames(test) <- unlist(features[2])
  
  # Read subject data

  subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
  colnames(subjects)<- "subject"
  
  activities <- read.table("UCI HAR Dataset/test/y_test.txt")
  colnames(activities)<- "activity"
  
  test <- cbind(subjects, activities, test)
  return(test)  
}

rename_labels <- function(name){
  
  # Labels are renamed according to several simple rule:
  
  #1) Acc -> Acceleration
  
  replacements <- c(c("Acc", "Acceleration"),
                    c("Gyro", "Gyroscope"),
                    c("Mag", "Magnitude"),
                    c("-mean()", "Mean"),
                    c("-std()", "Std"),
                    c("-X", "X"),
                    c("-Y", "Y"),
                    c("-Z", "Z"),
                    c("BodyBody", "Body"))
  
  replacements_re <- c(c("^f", "Freq"),
                       c("^t", "Time"))
    
  dim(replacements) <- c(2, length(replacements)/2)
  dim(replacements_re) <- c(2, length(replacements_re)/2)
  
  for (i in seq(ncol(replacements))){
    name <- gsub(replacements[1, i], replacements[2, i], name, fixed=T)  
    
  for (i in seq(ncol(replacements_re))){
    name <- gsub(replacements_re[1, i], replacements_re[2, i], name, fixed=F)  
  } 
  }
  return(name)
}

main <- function(){
  
  # Read training set
  training <- read_training()
  test <- read_test()
    
  # 1. Merges the training and the test sets to create one data set.
  data <- rbind(training, test)
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  # Select variables
  mean_var_idx <- grep("-mean()", names(data), fixed=T)
  std_var_idx <- grep("-std()", names(data), fixed=T)
  # All selected indices. 1 is for "Subjects" column and 2 for "Activity"
  idx <- sort(c(mean_var_idx,std_var_idx,1,2))
  data2 <- data[,idx] 
  # Set "Activity" and "Subject" as factors
  data2$activity <- as.factor(data2$activity)
  data2$subject <- as.factor(data2$subject)
  
  # 3. Uses descriptive activity names to name the activities in the data set
  # Read activity labels
  activity_labels = read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F )
  levels(data2$activity) <- activity_labels[,2]
  
  # 4. Appropriately labels the data set with descriptive variable names. 
  names(data2) <- sapply(names(data2), rename_labels)
  
  # 5. From the data set in step 4, creates a second, independent tidy data set with the 
  #average of each variable for each activity and each subject.
  #require(dplyr)
  
  meanset <- data2 %>% group_by(activity, subject) %>% summarise_each(funs(mean))
  write.table(meanset, file="HARUS.txt", row.names=FALSE, sep=',' )
  return(meanset)
  
}

main()


