Getting and Cleaning Data
========================================================
Course Project - Codebook
--------------------------------------------------------
### Question 1 
The data was first loaded into different datasets and then merged as answer to question 1.  The merged dataset was also updated to reflect the original column names.   
An example of how this was done is shown here (the complete listing is contained in the submitted R script):
````
Xtest<-read.table("./data/UCI HAR Dataset/test/X_test.txt",sep=" ",header=F)
X1<-cbind(Xtrain,Strain,Ytrain)
X<-rbind(X1,X2)
colnames(X)<-c(Xnames[,2],"Subject","Activity")
````
### Question 4  
Adding the column names helps to subset by mean and standard deviation, but also complies with the requirement in question 4 (add descriptive names to variables)  
### Question 2  
As answer to question 2, the mean and standard deviation measurements were subset from the dataset, resulting in a feature reduction from 563 to 81 (including subject and activity), the code used for this step was:
````
Xsub<-X[,c(which(grepl("mean()|std()",Xnames[,2])),562,563)]
````
### Question 3  
In order to use descriptive names for activities, the column was converted to factor and labels were taken from the original activity_lablels.txt file, the code used was:
````
Xsub[,81]<-factor(Xsub[,81],labels=Activity[,2])
````
### Question 5
Finally, a tidy dataset was calculated by taking the mean value of each measurement by subject and activity, and writing the result to a file in order to upload it.
````
agX<-aggregate(Xsub[,1:79],by=list(as.factor(Xsub[,80]),Xsub[,81]),FUN=mean)
write.table(agX,"./data/tidy.txt",sep=",")
````