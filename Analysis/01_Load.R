#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used to LOAD data and packages needed for 
# the Chaney et al 2016 Morning glory microbe paper
#==============================================================================================#

#load data
  mgdat <- read.csv("Data/mg_ghsoil.csv")

#load packages
  library(dplyr) #data management
  library(ggplot2) #plotting
  library(lme4) #mixed model
  library(lmerTest) #test for significance
  library(multcomp) #allows multiple comparison tests for lmer
  library(gridExtra) #multiple plot panels
  