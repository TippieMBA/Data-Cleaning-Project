# Setting up the working directory and installing package
library("data.table")
setwd("C:/Data Science/Data cleaning/Project")

# Reading train, test, actiivity, and feature files into R
trnX<-read.table("X_train.txt")
trnY<-read.table("y_train.txt")

tstX<-read.table("X_test.txt")
tstY<-read.table("y_test.txt")


lblact<-read.table("activity_labels.txt")

subtst<-read.table("subject_test.txt")
subtrn<-read.table("subject_train.txt")

fture<-read.table("features.txt")

# Merges the training and the test sets to create one data set.
merge_x<-rbind(tstX,trnX)
merge_y<-rbind(tstY,trnY)
merge_sub<-rbind(subtst,subtrn)

# Extracts only the measurements on the mean and standard deviation for each measurement.
sel_col<-grep("mean\\(\\)|std\\(\\)",fture[,2])
merge_scol<-merge_x[,sel_col]

# Uses descriptive activity names to name the activities in the data set
Activity_ID<-lblact[merge_y[,1],2]

#Appropriately labels the data set with descriptive variable names.
names(merge_scol)<-fture[sel_col,2]
names(merge_sub)<-"Subject_ID"
fdata<-cbind(merge_sub, Activity_ID,merge_scol)

# creates a second, independent tidy data set with the average of each variable for each activity and each subject
fdata<-data.table(fdata)
sd_avg <- fdata[,lapply(.SD,mean), by = 'Subject_ID,Activity_ID']

# Write the dataset to the file
write.table(sd_avg,"tidydataset.txt",row.names = FALSE)

















