# Getting_Cleaning_Data
Repository containing submission for Getting and Cleaning Course from Coursera

This Repository has 4 files.
  a) ReadMe.md (this file)
  b) run_analysis.R
  c) codebook.md
  d) tidy_data.txt (within Tidy_Data folder)
  
The script 'run_analysis.R' downloads a data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and names it 'MotionData.zip'

The data is sensor data from 30 subjects performing 6 activities each, multiple times during the study. More information about the experiment can be found here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script will then create three additional folders into the working directory of R
  a) First the unzipped folder MotionData
  b) Combined_Data_Nitish
      Contains the merged data set
  c) Tidy_Data
      Contains cleaned data with only mean values by subjects and acitivies.
Total Physical Space required: 329 MB
