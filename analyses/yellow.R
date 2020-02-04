#############################################
###    Yellow Island Phenology Analyses   ###
###    By Ailene Ettinger                 ###
###    STarted 17 Januar 2020             ###
#############################################

#housekeeping

rm(list=ls()) 
options(stringsAsFactors = FALSE)


# Set working directory: 
setwd("~/GitHub/yellowphen")

# Load libraries

#Read in phenology data
phen<-read.csv("data/dunwiddie/flora_bloomdates_03_07_2019.csv", header=TRUE)
clim<-read.csv("data/clim/olgaclim2006736.csv", header=TRUE)

#Clean the data
source("analyses/source/clean_phen.R")
head(phen)
head(clim)
