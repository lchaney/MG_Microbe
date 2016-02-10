#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used to source files needed for the Chaney et al 2016 Morning glory microbe paper
#==============================================================================================#

#==============================================================================================#
# Set working directory and source LOAD, CLEAN, and FUNCTION scripts

#source to LOAD data
source('Analysis/01_Load.R')

#source to CLEAN data
source('Analysis/02_Clean.R')

#source to perform FUNCTIONS on data
source('Analysis/03_Func.R')

#==============================================================================================#

#==============================================================================================#		
#save figures in output	folder

#create Output folder
if(!file.exists("Output"))
  dir.create("Output")

#Treatment means of each trait
ggsave("Output/Treatment_means.png", gebox)

#Difference in selection of flowering time by treatment
ggsave("Output/Flower_Selection_Treatment.png", ts.doffplot)

#Quadratic plot for Flowering
ggsave("Output/Flower_Selection_Quadratic.png", doff.quad)

#Surface plot for Flowering and Size
#ggsave("Output/FS_surface", FSsurface)

#Difference in joint selection of flowering time and growth by treatment
#ggsave("Output/FG_surface_An", FSsurface.antibiotic)
#ggsave("Output/FG_surface_In", FSsurface.inoculum)
#ggsave("Output/FG_surface_Fi", FSsurface.field)
#ggsave("Output/FG_surface_Ac", FSsurface.autoclave)

#==============================================================================================#		

