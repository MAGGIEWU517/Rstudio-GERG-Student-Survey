##DataID1
##clean numeric data by deleting repeated, testing, unfinished data
datarepeat<-subset(DataID1, duplicated(DataID1$ID)==TRUE)
Data1<-subset(DataID1, duplicated(DataID1$ID)==FALSE & DataID1$Progress==100 & is.na(DataID1$ID)==FALSE)
anyDuplicated(Data1$ID)
anyNA(Data1$ID)
##clean choice text data by deleting repeated, testing, unfinished data
Anontrepeat<-subset(AnonIDtext, duplicated(AnonIDtext$ID)==TRUE)
ANON1<-subset(AnonIDtext, duplicated(AnonIDtext$ID)==FALSE & AnonIDtext$Progress==100 & is.na(AnonIDtext$ID)==FALSE)
anyDuplicated(ANON1$ID)
anyNA(ANON1$ID)

##check the difference between G.N in text and G.N in numeric
fixdata1<-merge(Data1,ANON1, by="ID")
write.csv(fixdata1, file = "fixdata1.csv")
anyDuplicated(fixdata1$ID)
duplicated(fixdata1$ID)
table(fixdata1$Finished.y)
all((fixdata1$G.N.x+1==fixdata1$G.N.y)==TRUE)
##Then fix the column by adding 1

Data1$G.N = Data1$G.N + 1
write.csv(Data1, file = "Data1.csv")
Data1<-read.csv("Data1.csv")


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##similar things to DataID2
##clean numeric data by deleting repeated, testing, unfinished data
datarepeat2<-subset(DataID2, duplicated(DataID2$ID)==TRUE)
Data2<-subset(DataID2, duplicated(DataID2$ID)==FALSE & DataID2$Progress==100 & is.na(DataID2$ID)==FALSE)
anyDuplicated(Data1$ID)
anyNA(Data1$ID)
##clean choice text data by deleting repeated, testing, unfinished data
Anontrepeat2<-subset(AnonIDtext2, duplicated(AnonIDtext2$ID)==TRUE)
ANON2<-subset(AnonIDtext2, duplicated(AnonIDtext2$ID)==FALSE & AnonIDtext2$Progress==100 & is.na(AnonIDtext2$ID)==FALSE)
anyDuplicated(ANON2$ID)
anyNA(ANON2$ID)

##check the difference between G.N in text and G.N in numeric
fixdata2<-merge(Data2,ANON2, by="ID")
write.csv(fixdata2, file = "fixdata2.csv")
anyDuplicated(fixdata2$ID)
table(fixdata2$Finished.y)
all((fixdata2$G.N.x+1==fixdata2$G.N.y)==TRUE)
##Then fix the column by adding 1

Data2$G.N = Data2$G.N + 1
write.csv(Data2, file = "Data2.csv")
Data2<-read.csv("Data2.csv")

#################################
##Output two datasets, Data1 and Data2, without repeated data, test data, or unfinished data
##Rerun code to make a new report 
##look at group of 4
##16 observation deleted from Data1
Data31<-subset(Data1,Data1$G.N==4)
write.csv(Data31,"Data31.csv")
Data31<-read.csv("Data31.csv")
##19 observation delated from Data2
Data32<-subset(Data2, Data2$G.N==4)
write.csv(Data32,"Data32.csv")
Data32<-read.csv("Data32.csv")

##Merge two file to a big one 
DataID<-merge(Data1, Data2, by="ID")
write.csv(DataID,"DataID.csv")
DataID<-read.csv("DataID.csv")


##Manually fix Data32 and Data31 by excel 
Data31$G.Exp_Avg=as.numeric(Data31$G.Exp_Avg)
Data32$G.Exp_Avg=as.numeric(Data32$G.Exp_Avg)
Data31$G.Exp_SD=as.numeric(Data31$G.Exp_SD)
Data32$G.Exp_SD=as.numeric(Data32$G.Exp_SD)
Data32$Know_Avg=as.numeric(Data32$Know_Avg)
Data31$Study_Other=as.numeric(Data31$Study_Other)
Data32$Study_Other=as.numeric(Data32$Study_Other)


Data31$Decide_Disc=as.numeric(Data31$Decide_Disc)
Data32$Decide_Disc=as.numeric(Data32$Decide_Disc)
Data31$Future_diff=as.numeric(Data31$Future_diff)
write.csv(Data31,"Data31.csv")
Data31<-read.csv("Data31.csv")
write.csv(Data32,"Data32.csv")
Data32<-read.csv("Data32.csv")


##Look at Group of 4
DataID3<-merge(Data31,Data32,by="ID")
write.csv(DataID3,"DataID3.csv")
DataID3<-read.csv("DataID3.csv")

DataID3$G.Exp.MD=as.numeric(DataID3$G.Exp.MD)
DataID3$Know_Avg_S1=as.numeric(DataID3$Know_Avg_S1)
DataID3$Know_Avg_S2=as.numeric(DataID3$Know_Avg_S2)
write.csv(DataID3,"DataID3.csv")
DataID3<-read.csv("DataID3.csv")
