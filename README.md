# Getting-and-Cleaning-Data
Assignment of Getting and cleaning data using R
MergedTable <- data.table(Merged_Data)
                          #Standrad deviation calculation for a grouped by subject_id and activity
           SD_MergedTable<- MergedTable [, lapply(.SD, sd), by=c("subject_Id", "activity")]
                     #saving Independent data
           write.table(SD_MergedTable, "SD_MergedTable.txt")
            #mean calculation for a grouped by subject_id and activity
       Mean_MergedTable<- MergedTable [, lapply(.SD, mean), by=c("subject_Id", "activity")]
   #saving indpendent data
  write.table(Mean_MergedTable, "Mean_MergedTable.txt")
