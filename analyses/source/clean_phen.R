#cleans yellow island phenology data
#started 17 Jan 2020 by Ailene EttingerR
#Remove some unnecessary columns
phen<-phen[,-2]
phen<-phen[,-2]
phen<-phen[,-2]
#rename some columns
colnames(phen)[1]<-"species"
colnames(phen)[2]<-"X1982"
colnames(phen)[38:41]<-c("min","max","mean","numyr")
#remove some more unnecessary columns
phen<-phen[1:24,1:37]

#clean the species names
phen$species<-substr(phen$species,3,nchar(phen$species)-2)
fname<-strsplit(phen$species," - ")
fname<-as.data.frame(do.call("rbind",fname))
colnames(fname)<-c("sciname","comname")
genus.species<-strsplit(fname$sciname," ")
genus.species<-as.data.frame(do.call("rbind",genus.species))
genus.species<-genus.species[,1:2]
colnames(genus.species)<-c("genus","species")
genus.species$species[24]<-"parviflora"
genus.species$gen.sp<-paste(genus.species$genus,genus.species$species,sep=".")

phen<-cbind(genus.species,phen)
phen<-phen[,-4]

