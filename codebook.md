
The script has five sections, corrosponding to five steps in the problem statement

First step is to download and unzip files. Script checks if the file is present, if not then downloads it, otherwise unzips the one in the folder.

STEP 1: Merge the training and the test sets to create one data set
For this, a folder named 'Combined Data_Nitish' with a subfolder 'Inertial Signals' is created in the working directory. A For loop is used to cycle through the data sets within 'Inertial Signals' folder of both the test and train data sets.

rbind(f1,f2) is used to combine the two files of the same measurement and saved into 'Combined Data_Nitish/Inertial Signals' folder

Consequently, subject_test & subject_train, X_test and X_train, and y_test and y_train are imported and combined using rbind function. The merged data frames are stored in the 'Combined Data_Nitish' folder.
 
The file names are transformed as follows :

        body_acc_x_test/train.txt-     body_acc_x.txt
        body_acc_y_test/train.txt-     body_acc_y.txt
        body_acc_z_test/train.txt-     body_acc_z.txt
        body_gyro_x_test/train.txt-    body_gyro_x.txt
        body_gyro_y_test/train.txt-    body_gyro_y.txt
        body_gyro_z_test/train.txt-    body_gyro_z.txt
        total_acc_x_test/train.txt-    total_acc_x.txt
        total_acc_y_test/train.txt-     total_acc_y.txt
        total_acc_z_test/train.txt-     total_acc_z.txt

        subject_test/train.txt-     subject.txt
        X_test/train.txt-     X.txt
        y_test/train.txt-     y.txt

STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement
Use grep to find index of matching variables with 'mean' and 'std' in the text.

Use this index to subset the data set. A total of 81 columns meet the criteria.

STEP 3: Use descriptive activity names to name the activities in the data set
Using lapply function, the values in activity data set i.e 'y.txt' are substituded with activity labels.

STEP 4: Appropriately labels the data set with descriptive variable names
Using previously found index, subset the feature function to only include name of required functions.

Using names function rename the subsetted data set(X.txt) to the subsetted feature vector (features.txt)
Following are the column names for the final Data Set

    [1] "Subject_ID"                      "Activity_ID"                     "tBodyAcc.mean...X"              
     [4] "tBodyAcc.mean...Y"               "tBodyAcc.mean...Z"               "tBodyAcc.std...X"               
     [7] "tBodyAcc.std...Y"                "tBodyAcc.std...Z"                "tGravityAcc.mean...X"           
    [10] "tGravityAcc.mean...Y"            "tGravityAcc.mean...Z"            "tGravityAcc.std...X"            
    [13] "tGravityAcc.std...Y"             "tGravityAcc.std...Z"             "tBodyAccJerk.mean...X"          
    [16] "tBodyAccJerk.mean...Y"           "tBodyAccJerk.mean...Z"           "tBodyAccJerk.std...X"           
    [19] "tBodyAccJerk.std...Y"            "tBodyAccJerk.std...Z"            "tBodyGyro.mean...X"             
    [22] "tBodyGyro.mean...Y"              "tBodyGyro.mean...Z"              "tBodyGyro.std...X"              
    [25] "tBodyGyro.std...Y"               "tBodyGyro.std...Z"               "tBodyGyroJerk.mean...X"         
    [28] "tBodyGyroJerk.mean...Y"          "tBodyGyroJerk.mean...Z"          "tBodyGyroJerk.std...X"          
    [31] "tBodyGyroJerk.std...Y"           "tBodyGyroJerk.std...Z"           "tBodyAccMag.mean.."             
    [34] "tBodyAccMag.std.."               "tGravityAccMag.mean.."           "tGravityAccMag.std.."           
    [37] "tBodyAccJerkMag.mean.."          "tBodyAccJerkMag.std.."           "tBodyGyroMag.mean.."            
    [40] "tBodyGyroMag.std.."              "tBodyGyroJerkMag.mean.."         "tBodyGyroJerkMag.std.."         
    [43] "fBodyAcc.mean...X"               "fBodyAcc.mean...Y"               "fBodyAcc.mean...Z"              
    [46] "fBodyAcc.std...X"                "fBodyAcc.std...Y"                "fBodyAcc.std...Z"               
    [49] "fBodyAcc.meanFreq...X"           "fBodyAcc.meanFreq...Y"           "fBodyAcc.meanFreq...Z"          
    [52] "fBodyAccJerk.mean...X"           "fBodyAccJerk.mean...Y"           "fBodyAccJerk.mean...Z"          
    [55] "fBodyAccJerk.std...X"            "fBodyAccJerk.std...Y"            "fBodyAccJerk.std...Z"           
    [58] "fBodyAccJerk.meanFreq...X"       "fBodyAccJerk.meanFreq...Y"       "fBodyAccJerk.meanFreq...Z"      
    [61] "fBodyGyro.mean...X"              "fBodyGyro.mean...Y"              "fBodyGyro.mean...Z"             
    [64] "fBodyGyro.std...X"               "fBodyGyro.std...Y"               "fBodyGyro.std...Z"              
    [67] "fBodyGyro.meanFreq...X"          "fBodyGyro.meanFreq...Y"          "fBodyGyro.meanFreq...Z"         
    [70] "fBodyAccMag.mean.."              "fBodyAccMag.std.."               "fBodyAccMag.meanFreq.."         
    [73] "fBodyBodyAccJerkMag.mean.."      "fBodyBodyAccJerkMag.std.."       "fBodyBodyAccJerkMag.meanFreq.." 
    [76] "fBodyBodyGyroMag.mean.."         "fBodyBodyGyroMag.std.."          "fBodyBodyGyroMag.meanFreq.."    
    [79] "fBodyBodyGyroJerkMag.mean.."     "fBodyBodyGyroJerkMag.std.."      "fBodyBodyGyroJerkMag.meanFreq.."
 

STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Merge the subject id's and activity labels to the data set (X.txt) using cbind.

Summarize the resulting data frame using data.table package.

Assign "Subject_ID" and "Activity_ID" as keys for the data frame.
using lapply transform the dataframe to the required format.

    library(data.table)
    f1<-as.data.table(f1)
    keycols <- c("Subject_ID", "Activity_ID")
    setkeyv(f1, keycols)
    tidy_data_set<- f1[, lapply(.SD,mean), by = key(f1)]
    
Writing tidy data to file

    dir.create("Tidy_Data")
    fname<-"Tidy_Data/tidy_data.txt"
    write.table(tidy_data_set,fname,append = FALSE)
    
Code ends!

