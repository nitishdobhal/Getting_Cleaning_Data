run_analysis<-function() {
    
    fname<-"MotionData.zip"
    if(!file.exists(fname)) {
           url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
           download.file(url, destfile = "MotionData.zip")
    }
    
    unzip("MotionData.zip", exdir = "MotionData")
    
    ##Storing paths of training and testing data sets
    path_test<-"MotionData/UCI HAR Dataset/test"
    path_train<-"MotionData/UCI HAR Dataset/train"
    path_combined<-"Combined Data_Nitish"

##STEP 1:Merge the training and the test sets to create one data set.
        
    ##Creating Directories for storing combined data sets
    unlink(path_combined,recursive = TRUE)
    dir.create(paste(path_combined,"/Inertial Signals",sep = ""),recursive=TRUE)
    
    ##Storing the names of files within 'Inertial Signal' folder of test & train data set in one variable each 
    list_inertial_test<-dir(paste(path_test,"/Inertial Signals",sep = ""))
    list_inertial_train<-dir(paste(path_train,"/Inertial Signals",sep = ""))
    
    
    ##Importing Inertial Files from both test and train data sets, merging and writing to new folder 
    for(i in 1:length(list_inertial_test))
    {
      f1<-read.table(paste(path_test,"Inertial Signals",list_inertial_test[i],sep="/"))
      f2<-read.table(paste(path_train,"Inertial Signals",list_inertial_train[i],sep="/"))
      f3<-rbind(f1,f2)
      new_fpath<-paste(path_combined,"Inertial Signals",paste0(substr(list_inertial_test[i],1,nchar(list_inertial_test[i])-9),".txt"),sep = "/")
      write.table(f3,new_fpath,append = FALSE)
      
    }
    
    ##Importing the subject id numbers from subject_test and subject_train file, mergina and writing to new folder
    f1<-read.table(paste(path_test,"subject_test.txt",sep="/"))
    f2<-read.table(paste(path_train,"subject_train.txt",sep="/"))
    f3<-rbind(f1,f2)
    new_fpath<-paste(path_combined,"subject_IDs.txt",sep = "/")
    names(f3)<-"Subject_ID"
    write.table(f3,new_fpath,append = FALSE)
    
    
    ##Importing the feature functions calculated for each record in the both sets, merging and writing to new folder
    f1<-read.table(paste(path_test,"X_test.txt",sep="/"))
    f2<--read.table(paste(path_train,"X_train.txt",sep="/"))
    f3<-rbind(f1,f2)
    new_fpath<-paste(path_combined,"X.txt",sep = "/")
    write.table(f3,new_fpath,append = FALSE)
    
        
    ##Importing the activity id from both data sets, merging, and writing to new folder
    f1<-read.table(paste(path_test,"y_test.txt",sep="/"))
    f2<-read.table(paste(path_train,"y_train.txt",sep="/"))
    f3<-rbind(f1,f2)
    names(f3)<-"Activity_ID"
    new_fpath<-paste(path_combined,"y.txt",sep = "/")
    write.table(f3,new_fpath,append = FALSE)
    
    
    ##Freeing Memory
    f1<-NULL
    f2<-NULL
    f3<-NULL
    gc()
    
##STEP 1 OF THE PROBLEM FINISHED
    
    
##STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement
    
    
    ##Reading the merged data set
    f1<-read.table(paste(path_combined,"X.txt",sep = "/"))
    
    ##Reading feature function names
    f2<-read.table("MotionData/UCI HAR Dataset/features.txt")
    
    ##Finding index of vectors with Mean and standard deviation in the text
    index_mean<-grep("*mean*",f2[,2])
    index_sd<-grep("*std*",f2[,2])
    index_meansd<-c(index_mean, index_sd)
    index_meansd<-index_meansd[order(index_meansd)]
    
    ##Keeping only the required columns from the data set
    f1<-f1[,index_meansd]
   
##STEP 2 OF THE PROBLEM STATEMENT COMPLETED
    
    
##STEP 3: Use descriptive activity names to name the activities in the data set
    
    ##Getting Activity Labels and substituting them in the activity data set (y)
    a_labels<-read.table("MotionData/UCI HAR Dataset/activity_labels.txt")[,2]
    f3<-read.table(paste(path_combined,"y.txt",sep = "/"))
    f3<-as.data.frame(lapply(f3,function(x){a_labels[x]}))
    
##STEP 3 OF THE PROBLEM STATEMENT COMPLETED
    
##STEP 4: Appropriately labels the data set with descriptive variable names
    
    ##Renaming the variable names with names of functions from features vector
    names(f1)<-f2[index_meansd,2]

##STEP 4 OF THE PROBLEM STATEMENT COMPLETED

##STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.        
    
    ##Combining Activity ID with the rest of the data
    f1<-cbind(f3,f1)  
    
    ##Combining Subject ID with the rest of the data
    f4<-read.table(paste(path_combined,"subject_IDS.txt",sep = "/"))
    f1<-cbind(f4,f1)   
    
    ##Summarizing data using data.table package
    library(data.table)
    f1<-as.data.table(f1)
    keycols <- c("Subject_ID", "Activity_ID")
    setkeyv(f1, keycols)
    tidy_data_set<- f1[, lapply(.SD,mean), by = key(f1)]
    
    ##Writing tidy data to file
    dir.create("Tidy_Data")
    fname<-"Tidy_Data/tidy_data.txt"
    write.table(tidy_data_set,fname,append = FALSE)
    f1<-NULL
    f2<-NULL
    f3<-NULL
    f4<-NULL
    gc()
    
    
}
  