#############################################
###    Yellow Island Phenology Analyses   ###
###    By Ailene Ettinger                 ###
###    Started 17 January 2020             ###
#############################################

#housekeeping

rm(list=ls()) 
options(stringsAsFactors = FALSE)


# Set working directory: 
setwd("~/GitHub/yellowphen")
#setwd("~/Documents/GitHub/yellowphen")
# Load libraries
library(tidyr)
library(lme4)
#Read in phenology data
phen<-read.csv("data/dunwiddie/flora_bloomdates_03_07_2019.csv", header=TRUE)
clim<-read.csv("data/clim/olgaclim2006736.csv", header=TRUE)

#Clean the data
source("analyses/source/clean_phen.R")
source("analyses/source/clean_clim.R")

#add climate data to phenology data
phenl$year<-as.character(phenl$year)
yrclimrec$year<-as.character(yrclimrec$year)
phenclim<-left_join(phenl,yrclimrec, by="year",copy= TRUE)
head(phenl)
head(yrclim)
summary(phen)

#Fit a model that accounts for year and species as crossed random effects
phenclim$gen.sp<-as.factor(phenclim$gen.sp)
phenclim$year<-as.factor(phenclim$year)
phenclim<- phenclim[apply(phenclim , 1, function(x) all(!is.na(x))),] # only keep rows of all not na

fit1<-lmer(fldoy~spt+spp + (1|year)+ (1|gen.sp), data=phenclim)
fit2<-lmer(fldoy~spt*spp + (1|year)+ (1|gen.sp), data=phenclim)
fit2a<-lmer(fldoy~spt*spp + (1|year)+ ((spt*spp )|gen.sp), data=phenclim)
fit3<-lmer(fldoy~spt + (1|year)+ (1|gen.sp), data=phenclim)
fit3a<-lmer(fldoy~spt + (spt|gen.sp), REML=FALSE,data=phenclim)

fit4<-lmer(fldoy~spp + (1|year)+ (1|gen.sp), data=phenclim)
anova(fit1, fit2, fit3, fit4, fit2a, fit3a)
summary(fit2)
quartz()
par(mfrow=c(1,2))
plot(phenclim$spt,phenclim$fldoy,pch=16,col="white", xlab= "Temperature",ylab="Day of Year")
abline(fixef(fit3a), lwd=2, col="darkred")
df<-as.data.frame(coef(fit3a)$gen.sp)
for(i in 1:dim(coef(fit3a)$gen.sp)[1]){
  abline(a=df[i,1],b= df[i,2],lwd=1, col="gray")
}
abline(fixef(fit3a), lwd=2, col="darkred")


phenclim$yr<-as.integer(as.character(phenclim$year))
mod3<-lmer(fldoy~yr + (1|gen.sp), data=phenclim)
summary(mod3)
plot(phenclim$yr,phenclim$fldoy,pch=16,col="white", xlab= "Year",ylab="Day of Year")
abline(fixef(mod3), lwd=2, col="darkgray")

plot(phenclim$yr,phenclim$spt,pch=16,col="lightblue", xlab= "Year",ylab="Day of Year")
climmod<-lm(spt~as.numeric(year),data=yrclim)
climmodrec<-lm(spt~as.numeric(year),data=yrclimrec)
quartz()
plot(as.numeric(yrclim$year),yrclim$spt, pch=16,col="gray", ylab="Temperature", xlab= "Year")
abline(climmod, lwd=2)
clip(1982, 2016, 1, 200)
abline(climmodrec,lwd=2,lty=2,col="darkred")
climmod2<-lm(mat~as.numeric(year),data=yrclim)
climmodrec2<-lm(mat~as.numeric(year),data=yrclimrec)
climmodrec3<-lm(spp~as.numeric(year),data=yrclimrec)
climmod3<-lm(spp~as.numeric(year),data=yrclim)

summary(climmod)
abline(fixef(mod3), lwd=2, col="darkgray")
