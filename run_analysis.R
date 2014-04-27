# R script called run_analysis.for creating independent tidy data set 
#with the average of each variable for each activity and each subject. 
#reading fetrues text- date set feature names
fileFeatures<-file.path('UCI HAR Dataset','features.txt')
features<-read.table(fileFeatures)

#reading Activity lables & XTrainLebel
activityLabelFile<-file.path('UCI HAR Dataset','activity_labels.txt')
activityLabel<-read.table(activityLabelFile,as.is =c(2))

#reading  XTrainLebel
xTrainLabelFile<-file.path('UCI HAR Dataset/train','y_train.txt')
xTrainLabel<-read.table(xTrainLabelFile)
names(xTrainLabel)<-"activity_id"   

#Uses descriptive activity names to name the activities for XTrain data set
activityDfTrain<-data.frame(xTrainLabel)
activityDfTrain$activity<-"unset"
for(i  in 1:nrow(activityLabel)){
    activityDfTrain$activity[activityDfTrain$activity_id == i]<- activityLabel[i,2]
}
activityDfTrain$activity<-as.factor(activityDfTrain$activity)

#reading  XTestLabel
xTestLabelFile<-file.path('UCI HAR Dataset/test','y_test.txt')
xTestLabel<-read.table(xTestLabelFile)
names(xTestLabel)<-"activity_id"


#Uses descriptive activity names to name the activities for XTest data set
activityDfTest<-data.frame(xTestLabel)
activityDfTest$activity<-"unset"
for(i  in 1:nrow(activityLabel)){
    activityDfTest$activity[activityDfTest$activity_id == i]<- activityLabel[i,2]
}
activityDfTest$activity<-as.factor(activityDfTest$activity)

#reading subjectTrain text and naming feature as subject
subjectTrainFile<-file.path('UCI HAR Dataset/train','subject_train.txt')
subjectTrain<-read.table(subjectTrainFile)
names(subjectTrain)<-"subject"

#reading subjectTest text and naming feature as subject
subjectTestFile<-file.path('UCI HAR Dataset/test','subject_test.txt')
subjectTest<-read.table(subjectTestFile)
names(subjectTest)<-"subject"

#reading xTrain text &assing features names for xTrain data set
xTrainFile<-file.path('UCI HAR Dataset/train','X_train.txt')
xTrain<-read.table(xTrainFile)
names(xTrain)<-features$V2

#reading xTest files  and give coloumn names for features
xTestFile<-file.path('UCI HAR Dataset/test','X_test.txt')
xTest<-read.table(xTestFile)
names(xTest)<-features$V2

#extracting mean and std feature vector from from features$V2
selectedFeature<-unique (grep( "mean\\()$|std\\()$",features$V2,  value=TRUE))

#subseting xTrain & xTest only column with mean & std feaures
xTrain<-xTrain[,selectedFeature]
xTest<-xTest[,selectedFeature]


#merging sujectTrain ,activityDfTrain & xTrain by cbind
trainDf<-cbind(subjectTrain,activityDfTrain,xTrain)

#merging sujectTest ,activityDfTest & xTest by cbind
testDf<-cbind(subjectTest,activityDfTest,xTest)

#meging traindf & testDf by rbind
mergedDf<-rbind(trainDf,testDf)

#creating tidy data set with the average of each variable for each activity and each subject.
meanDf <- sapply(split(mergedDf[,4:21], list(mergedDf$activity, mergedDf$subject)), colMeans)

#for Transpose data set to 180 rows & 18 colums and assign names and add acitvity column
meanMat<-matrix(meanDf, 180,18)
tempDf<-data.frame(meanMat)
names(tempDf)<-row.names(meanDf)
activitySubject<- data.frame(colnames(meanDf))
names(activitySubject)<-"activity for each Subject"

tidydata<-cbind(activitySubject,tempDf)

#writting tidydata set as "tidydata.txt"
write.table(tidydata, file="./tidydata.txt", sep="\t")