# ---- C1 ----
library("data.table")
setwd("C:/Data Science/Data cleaning/Project")

# ---- C2 ----
trnX<-read.table("X_train.txt")
trnY<-read.table("y_train.txt")



tstX<-read.table("X_test.txt")
tstY<-read.table("y_test.txt")


lblact<-read.table("activity_labels.txt")


subtst<-read.table("subject_test.txt")


subtrn<-read.table("subject_train.txt")


fture<-read.table("features.txt")

# ---- C3 ----

merge_x<-rbind(tstX,trnX)
merge_y<-rbind(tstY,trnY)
merge_sub<-rbind(subtst,subtrn)

# ---- C4 ----


sel_col<-grep("mean\\(\\)|std\\(\\)",fture[,2])
merge_scol<-merge_x[,sel_col]

# ---- C5 ----

Activity_ID<-lblact[merge_y[,1],2]

names(merge_scol)<-fture[sel_col,2]
names(merge_sub)<-"Subject_ID"
fdata<-cbind(merge_sub, Activity_ID,merge_scol)

# ---- C6 ----

fdata<-data.table(fdata)
sd_avg <- fdata[,lapply(.SD,mean), by = 'Subject_ID,Activity_ID']
# ---- C7 ----

write.table(sd_avg,"tidydataset.txt",row.names = FALSE)
write.table(fture[sel_col,2],"copybook.txt",row.names = FALSE)
















