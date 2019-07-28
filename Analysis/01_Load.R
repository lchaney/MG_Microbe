#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#

#load data
  mgdat <- read.csv("Data/mgdat.csv")

  
#install the following packages
  packagelist <- c("dplyr", "ggplot2", "lme4", "lmerTest", "multcomp", 
                   "gridExtra", "tidyr", "fields", "wesanderson",
                   "lattice", "RColorBrewer")
  
  new.packages <- packagelist[!(packagelist %in% installed.packages()[,"Package"])]
  
  if(length(new.packages)>0) {install.packages(new.packages, dependencies = TRUE)}
  
  
#load packages
  library(dplyr) #data management
  library(ggplot2) #plotting
  library(lme4) #mixed model
  library(lmerTest) #test for significance
  library(multcomp) #allows multiple comparison tests for lmer
  library(gridExtra) #multiple plot panels
  library(tidyr) #data organization
  library(fields) #surface plot
  library(wesanderson) #colors palletes for plots
  library(lattice) #used for surface plots
  library(RColorBrewer) #used for colors of surface plot
  