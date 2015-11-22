run_analysis <- function()
{
    columnNames <- read.table("features.txt")
    activityNames <- read.table("activity_labels.txt")
    
    testDF <- read.table("test/X_test.txt")
    names(testDF) <- columnNames$V2
    testDF <- testDF[, grepl("-mean()|-std()", names(testDF))]
    testActivity <- read.table("test/y_test.txt")
    testActivity$activityFactor <- as.factor(testActivity$V1)
    levels(testActivity$activityFactor) <- activityNames$V2
    
    subjectTest <- read.table("test/subject_test.txt")
    
    testDF$activityFactor <- testActivity$activityFactor
    testDF$subject <- subjectTest$V1

    trainDF <- read.table("train/X_train.txt")
    names(trainDF) <- columnNames$V2
    trainDF <- trainDF[, grepl("-mean()|-std()", names(trainDF))]
    trainActivity <- read.table("train/y_train.txt")
    trainActivity$activityFactor <- as.factor(trainActivity$V1)
    levels(trainActivity$activityFactor) <- activityNames$V2
    
    subjectTrain <- read.table("train/subject_train.txt")
    
    trainDF$activityFactor <- trainActivity$activityFactor
    trainDF$subject <- subjectTrain$V1

    outputDF <- rbind(testDF, trainDF)
    
    outputDF %>% group_by(subject, activityFactor) %>% summarize_each(funs(mean))
    
}