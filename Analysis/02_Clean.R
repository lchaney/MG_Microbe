#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#

#clean data
  #data set has already been cleaned

#list of focal traits
  samplevars <- c("DOFF", "LeafSum34", "HeightRGRC", "SumFlowers")
  
#Names of variables
  var_names <- c(
    `DOFF` = "Flowering Day",
    `LeafSum34` = "Size",
    `HeightRGRC` = "Growth",
    `SumFlowers` = "Total Flowers"
  )


