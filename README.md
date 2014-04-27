projectGetnClean
================
##R script called run_analysis.for creating independent tidy data set 
#with the average of each variable for each activity and each subject. 

* reading fetrues text- date set feature name
*reading Activity lables from 'activity_labels.txt'(Links the class labels with their activity name.)
*Uses descriptive activity names to name the activities for XTrain data set

*reading  XTrainLebel from 'train/y_train.txt': Training labels.

*Uses descriptive activity names to name the activities for XTest data set
*reading subjectTrain text froam train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. and naming feature as subject 
*reading subjectTest text test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. and naming feature as subject 

*reading xTrain text  from 'train/X_train.txt': Training set.&assing features names for xTrain data set

*reading xTest files fromtest/X_test.txt': Test set.  and give coloumn names for features

*extracting mean and std feature(selectedFeature) vector from from features$V2 using grep and regexp

*subseting xTrain & xTest only column with mean & std feaures using selectedFeature 


*merging sujectTrain ,activityDfTrain & xTrain by cbind

*merging sujectTest ,activityDfTest & xTest by cbind

*meging traindf & testDf by rbind


*creating tidy data set with the average of each variable for each activity and each subject.

*for Transpose data set to 180 rows & 18 colums and assign names and add acitvity column

* writing tidy data set wiht write.table

