#summarizes the climate data
#ignore data before 1900
clim<-clim[!substr(clim$DATE,1,2)=="18",]

clim$date<-format(format(clim$DATE,format="%b/%d/%Y"),format="%Y-%B-%D")

clim$year<-substr(clim$DATE,1,4)#this only works for years less than 1900

clim$mon<-substr(clim$DATE,6,7)
clim$doy<-format(clim$date,format="%j")
clim$TMN_C<-(clim$TMAX_C+clim$TMIN_C)/2
clim<-as.data.frame(clim)
mat<-aggregate(clim$TMN_C,by=list(clim$year), mean, na.rm=TRUE)
head(mat)
tail(mat)
head(clim)
