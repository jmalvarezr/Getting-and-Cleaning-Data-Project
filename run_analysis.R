#Part 0 - Setting wd and reading files into memory
#----------------------------------------------------------------
#read test and train data files into initial datasets
Xtest<-read.table("X_test.txt",sep=" ",header=F)
Xtest<-Xtest[,2:562] #Remove leading space which gives a full column of NAs
Stest<-read.table("subject_test.txt",sep=" ",header=F)
Ytest<-read.table("y_test.txt",sep=" ",header=F)
Xtrain<-read.table("X_train.txt",sep=" ",header=F)
Xtrain<-Xtrain[,2:562] #Remove leading space which gives a full column of NAs
Strain<-read.table("subject_train.txt",sep=" ",header=F)
Ytrain<-read.table("y_train.txt",sep=" ",header=F)
#read column names and activity labels
Xnames<-read.table("features.txt",sep=" ",header=F)
Activity<-read.table("activity_labels.txt",sep=" ",header=F)
#Correct if labels were loaded as factor
Xnames[,2]<-as.character(Xnames[,2])

#Part 1 Merge the training and test sets to create one dataset
#--------------------------------------------------------------
#Create working dataframe (in case we need to redo work use another df!)
#First, bind the columns containing the subject and activity information
X1<-cbind(Xtrain,Strain,Ytrain)
X2<-cbind(Xtest,Stest,Ytest)
#Finally, merge both sets into one
X<-rbind(X1,X2)
#Free up some memory!
rm(list=c("X1","X2","Xtest","Xtrain","Stest","Strain","Ytest","Ytrain"))
#Assign column names to file 
#Note: this step effectively labels the variable names (columns) so it in fact serves a double
#purpose, first allow us to extract mean and std column names for question 2, and second
#label the columns for question 4

#Part 4 Appropriately labels the data set with descriptive variable names.
#--------------------------------------------------------------
colnames(X)<-c(Xnames[,2],"Subject","Activity")
#----Now df X contains the merged dataset answers to questions 1 and 4----

#Part 2 Extracts only the measurements on the mean and standard deviation for each measurement
#------------------------------------------------------------
#Extract only mean and standard deviation measurements (include subject and activity too!)
Xsub<-X[,c(which(grepl("mean()|std()",Xnames[,2])),562,563)]
#----df Xsub contains now answer to question 2 ------------

#Part 3 Uses descriptive activity names to name the activities in the data set
#------------------------------------------------------------
#convert Activity column into factor with labels based on description
Xsub[,81]<-factor(Xsub[,81],labels=Activity[,2])
#----at this point df Xsub contains answer to question 3---------

#Part 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#-----------------------------------------------------------
agX<-aggregate(Xsub[,1:79],by=list(as.factor(Xsub[,80]),Xsub[,81]),FUN=mean)
write.table(agX,"./data/tidy.txt",sep=",")
#df agX now contains answer to question 5, and was written to the tidy.txt file to be uploaded