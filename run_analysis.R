   
   #######Assignment of Getting and Cleaning Data Course Project
  run_analysis <- function(){
           setwd("D:\\1ater\\Getting and Cleaning Data\\UCI HAR Dataset")
           library(data.table)
          
       ## Reading training data
     subj_train <- read.table("train\\subject_train.txt")     #vector of the subjects(1-30))
        Y_train <- read.table("train\\Y_train.txt")     #vector of Activities(1-6)
        X_train <- read.table("train\\X_train.txt")  #data frame of 561 features
  
     ## Reading test data  
    subj_test   <-read.table("test\\subject_test.txt")
         Y_test <-read.table("test\\Y_test.txt")      #vector of Activities(1-6)
         X_test <-read.table("test\\X_test.txt")  # Results with 561 Columns
  
  # ###reading the feautres information
          features <- read.table("features.txt")
    names(features)=c("feature_Id", "feature_Label")    #labeling names
           #nrow(features)   =561
                activities <- read.table("activity_labels.txt") 
          names(activities)<-c("activity_Id", "activity_Label")
  activities$activity_Label<-as.character(activities$activity_Label)
 activities$activity_Label <- gsub("_", " ", activities$activity_Label)  #//Space
     
  
  ### merging training and test data, which is a vector with no name
                subject <- rbind(subj_test, subj_train)  #  List of the subjects(1-30) //??????????????
         names(subject) <- "subject_Id"  # named after merged
                      X <- rbind(X_test, X_train)  
  Mean_and_Std_Features <- grep("-mean\\(\\)|-std\\(\\)", features$feature_Label)
 
    # ## // To identify mean and std summary
        X <- X[, Mean_and_Std_Features]
 names(X) <- gsub("\\(|\\)", "", features$feature_Label[Mean_and_Std_Features]) #  
          
          Y <- rbind(Y_test, Y_train)
  names(Y) <- "activity_Id"
  activity <- merge(Y, activities, by="activity_Id")$activity_Label 
  
  ### mergeing the d/t data frames using column binding
      Merged_Data <- cbind(subject,activity,X)
  #### saving the data to extranal
  write.table(Merged_Data, "Merged_Data.txt")
  
##########33#calculation of menn and stnadrd deviation for grouped by subjects id and activities
     MergedTable <- data.table(Merged_Data)
                          #Standrad deviation calculation for a grouped by subject_id and activity
           SD_MergedTable<- MergedTable [, lapply(.SD, sd), by=c("subject_Id", "activity")]
                     #saving Independent data
           write.table(SD_MergedTable, "SD_MergedTable.txt")
            #mean calculation for a grouped by subject_id and activity
       Mean_MergedTable<- MergedTable [, lapply(.SD, mean), by=c("subject_Id", "activity")]
   #saving indpendent data
  write.table(Mean_MergedTable, "Mean_MergedTable.txt")
}




