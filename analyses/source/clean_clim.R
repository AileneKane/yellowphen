#summarizes the climate data
#ignore data before 1900
clim<-clim[!substr(clim$DATE,1,2)=="18",]

clim$year<-substr(clim$DATE,nchar(clim$DATE)-3,nchar(clim$DATE))#this only works for years less than 1900

#clim$mon<-substr(clim$DATE,6,7)

clim$date<-as.Date(clim$DATE,format="%m/%d/%Y")
clim$doy<-format(clim$date, "%j")
clim$TMN_C<-(clim$TMAX_C+clim$TMIN_C)/2

clim<-as.data.frame(clim)
mat<-aggregate(clim$TMN_C,by=list(clim$year), mean, na.rm=TRUE)
clim$doy<-as.integer(clim$doy)
spclim<-clim[clim$doy<91,]
spt<-aggregate(spclim$TMN_C,by=list(spclim$year), mean, na.rm=TRUE)
spp<-aggregate(spclim$PRCP_MM,by=list(spclim$year), sum, na.rm=TRUE)
yrclim<-cbind(mat,spt$x, spp$x)
colnames(yrclim)<-c("year","mat","spt","spp")
yrclimrec<-yrclim[as.numeric(yrclim$year)>=1982,]
