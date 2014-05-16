#R script goes here
if (!file.exists("./UCI HAR Dataset")) {
#	dir.create("data")
	print("file does not exist")
	dateDownloaded<-data()
}

#read activity table
activity<-read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ", head=FALSE)
names(activity)<-c("acode", "activity")

#convert to lower case and to factors
activity$activity<-tolower(activity$activity)
activity$activity<-as.factor(activity$activity)

#read the features (data headigs)
features<-read.table("./UCI HAR Dataset/features.txt", sep=" ", head=FALSE)
names(features)<-c("fcode", "feature")


#find the list of means and std and then combine to one list
listmean<-features[grep("mean\\(|std\\(", features$feature),]
#remove the () from the names and convert to lower case
listmean$feature<-gsub("\\(\\)", "", listmean$feature)
listmean$feature<-tolower(listmean$feature)
print(nrow(listmean))

#Read subject and activity list and raw for test dataset.
   subject<-read.table("./UCI HAR Dataset/test/subject_test.txt", sep=" ", head=FALSE, col.names=c("subject"))

   ytest<-read.table("./UCI HAR Dataset/test/y_test.txt", sep=" ", head=FALSE, col.names=c("acode"))

   xtest<-read.table("./UCI HAR Dataset/test/x_test.txt", head=FALSE, col.names=features$feature)

    #reduce the full array down to columns of interest (mean and std columns)
   final<-xtest[,listmean$fcode]
   names(final)<-listmean$feature
   final<-cbind(subject, ytest, final)

print("Test Dataset Processed")

#seperate out final code from developement code to speed developement
if (1)
{
    #Read subject and activity list and raw for train dataset.
    subject<-read.table("./UCI HAR Dataset/train/subject_train.txt", sep=" ", head=FALSE, col.names=c("subject"))

    ytest<-read.table("./UCI HAR Dataset/train/y_train.txt", sep=" ", head=FALSE, col.names=c("acode"))

    xtest<-read.table("./UCI HAR Dataset/train/x_train.txt", head=FALSE, col.names=features$feature)
    
    final2<-xtest[,listmean$fcode]
    names(final2)<-listmean$feature
    final2<-cbind(subject, ytest, final2)
   
    #Combine both datasets together
    final<-rbind(final, final2)
    print("Train Dataset Processed")
}

#convert activity code to human readable value
final<-merge(activity, final,  by="acode" )
final<-final[-1]  #remove activity code from final table
print(table(final$subject, final$activity))

#Process the analysis
finalwidth<-length(final)
analysis<-aggregate(final[,3:finalwidth], by=list(final$activity, final$subject), FUN=mean)
#Clean up columns after aggregate
names(analysis)[1:2]<-c("activity", "subject")

print(analysis[1:15,1:5])
write.csv(analysis, file="Tidydata.csv")

#Replace Body in the columns names with something shorter
#gsub("Body", "B_", names(final))
