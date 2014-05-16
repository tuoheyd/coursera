##Background:    
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S Smartphone. A full description is available at the site where the data was obtained:
           http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

   Here are the data for the project: 
             https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

##Requirements:

1.  A tidy data set as described 

     *A). You should create one R script called run_analysis.R that does the following. 

     *B). Merges the training and the test sets to create one data set.

     *C). Extracts only the measurements on the mean and standard deviation for each measurement. 

     *D). Uses descriptive activity names to name the activities in the data set

     *E). Appropriately labels the data set with descriptive activity names. 
2. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
3. A link to a Github repository with your script for performing the analysis, and 
4. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
5. Include a README.md in the repository with your scripts. This document explains how all of the scripts work and how they are connected. 

###Program flow:

To execute the program the dataset’s folder “UCI HAR Dataset” must be located in R’s working directory.  From R’s command line load the source file source(“run_analysis.R”) and the script will run automatically generating the resultant file “Tidydata.csv” in the working directory.

First the table of activity code and activity are read into the variable “activity”.  The columns are re-labeled and converted in a factor.
Then the features table is read into the variable “features”.  This is a 561 parameter list which is reduced down to just the variable set of interest (see requirement 1c) 
The original data set contain looked at 30 subjects performing 6 different activities and collected 561 parameters per sample repeated.  Approximately 5.7 million data points were collected in this study. For the purpose of this analysis the 561 features parameters were reduced down by only looking at the mean and standard deviation feature parameters.  The reduction was perform by looking for any expression that contained “mean()” or “std()”

                   features[grep("mean\\(|std\\(", features$feature),]

This resulted in a reduced list of only 66 parameters reducing the dataset size by ~88%:

"tBodyAcc-mean-X"         "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z"         
"tBodyAcc-std-X"          "tBodyAcc-std-Y"            "tBodyAcc-std-Z"           
"tGravityAcc-mean-X"      "tGravityAcc-mean-Y"        "tGravityAcc-mean-Z"       
"tGravityAcc-std-X"       "tGravityAcc-std-Y"         "tGravityAcc-std-Z"        
"tBodyAccJerk-mean-X"     "tBodyAccJerk-mean-Y"       "tBodyAccJerk-mean-Z"      
"tBodyAccJerk-std-X"      "tBodyAccJerk-std-Y"        "tBodyAccJerk-std-Z"       
"tBodyGyro-mean-X"        "tBodyGyro-mean-Y"          "tBodyGyro-mean-Z"         
"tBodyGyro-std-X"         "tBodyGyro-std-Y"           "tBodyGyro-std-Z"          
"tBodyGyroJerk-mean-X"    "tBodyGyroJerk-mean-Y"      "tBodyGyroJerk-mean-Z"     
"tBodyGyroJerk-std-X"     "tBodyGyroJerk-std-Y"       "tBodyGyroJerk-std-Z"      
"tBodyAccMag-mean"        "tBodyAccMag-std"           "tGravityAccMag-mean"      
"tGravityAccMag-std"      "tBodyAccJerkMag-mean"      "tBodyAccJerkMag-std"      
"tBodyGyroMag-mean"       "tBodyGyroMag-std"          "tBodyGyroJerkMag-mean"    
"tBodyGyroJerkMag-std"    "fBodyAcc-mean-X"           "fBodyAcc-mean-Y"          
"fBodyAcc-mean-Z"         "fBodyAcc-std-X"            "fBodyAcc-std-Y"           
"fBodyAcc-std-Z"          "fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"      
"fBodyAccJerk-mean-Z"     "fBodyAccJerk-std-X"        "fBodyAccJerk-std-Y"       
"fBodyAccJerk-std-Z"      "fBodyGyro-mean-X"          "fBodyGyro-mean-Y"         
"fBodyGyro-mean-Z"        "fBodyGyro-std-X"           "fBodyGyro-std-Y"          
"fBodyGyro-std-Z"         "fBodyAccMag-mean"          "fBodyAccMag-std"          
"fBodyBodyAccJerkMag-mean "fBodyBodyAccJerkMag-std"   "fBodyBodyGyroMag-mean"    
"fBodyBodyGyroMag-std"    "fBodyBodyGyroJerkMag-mean" "fBodyBodyGyroJerkMag-std" 

Several features such as meanfreq and stdfreq were excluded from this analysis by could have been included by a simple change to the grep’s regular expression:

        features[grep("mean|std", features$feature),]     

“listmean”  is the variable containing the above list.   The list above is transformed again to remove the “()” from each name.

Next step is to read in the raw data for the test group.  The variables: “subject”, “ytest” and “xtest”.  The column titles are properly named.  These variables contain the id of the subject, the id for activity and the 561 parameters collected.  The parameters from “xtest” are selected in are used to form the vector variable “final”.  The subject id, activity id and the matrix final are merged together.  The key variable is still named “final”.
Once the test data set has been process the same steps are repeated for the train data set.  The only difference in this step is the final variable is named “final2”.

Now “final” and “final2” are merged to form the complete data set “final”.  (Requirement 1b) This variable contains all of the collected data.  The activity descriptions are substituted in for the activity codes (currently column 2, requirement 1d &1e)

At this point the data has been filtered, merged and renamed it is time for the analysis part.


##Analysis:
The aggregate command is used to find the mean of each column based on the activity and subject ID.  (Requirement 2)

        analysis<-aggregate(final[,3:finalwidth], by=list(final$activity, final$subject), FUN=mean)

The final matrix is 180 columns long (30 subjects * 6 activities per subject)


From R’s command line load the source file 

          source(“run_analysis.R”) 

and the script will run automatically generating the resultant file “Tidydata.csv” in the working directory.

(This document is Requirement 4)
