
The script has five sections, corrosponding to five steps in the problem statement

First step is to download and unzip files. Script checks if the file is present, if not then downloads one otherwise unzips the one in the folder.

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

