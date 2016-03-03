#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used to CLEAN data needed for the Chaney et al 2016 Morning glory microbe paper
#==============================================================================================#

#clean data
  mgdat <- mgdat %>% mutate_each(funs(factor), Genotype, Treatment, Replicate) #Change varibale to Factors

#data entry mistake on LeafSum26 for plant 18-1-5, replace with NA
  mgdat <- mgdat %>% mutate(LeafSum26 = replace(LeafSum26, which(LeafSum26 == 72.50), NA))

#Potential data enty error for SumFlowers (208) for plant 22-2-5 was investigated, but seems legit
  mgdat <- mgdat %>% filter(Plant != "22-2-5")
  
#create new RGR variables -- the ones orginally calculated are weird
  mgdat <- mgdat %>% mutate(LeafSumRGRA = (LeafSum26 - LeafSum14)/12,
                          LeafSumRGRB = (LeafSum34 - LeafSum26)/8,
                          LeafSumRGRC = (LeafSum34 - LeafSum14)/20,
                          LeafNumRGRA = (LeafNum26 - LeafNum14)/12,
                          LeafNumRGRB = (LeafNum34 - LeafNum26)/8,
                          LeafNumRGRC = (LeafNum34 - LeafNum14)/20,
                          HeightRGRA = (Height26 - Height14)/12,
                          HeightRGRB = (Height34 - Height26)/8,
                          HeightRGRC = (Height34 - Height14)/20
                          )
#list of focal traits
  samplevars <- c("DOFF", "LeafSum34", "HeightRGRC", "SumFlowers")
  
#Names of variables
  var_names <- c(
    `DOFF` = "Flowering Day",
    `LeafSum34` = "Size",
    `HeightRGRC` = "Growth",
    `SumFlowers` = "Total Flowers"
  )
  
#rename treatments
  levels(mgdat$Treatment) <- c("Antibiotic", "Inoculum", "Field", "Autoclave")
  
#Subset data to just include autoclave and inoculum
mgdat_t_all <- mgdat #save a copy of the full data set for future
  
mgdat <- mgdat %>% filter(Treatment == "Autoclave" | Treatment == "Inoculum")

#And one subset for Field vs Autoclave
mgdat_fa <- mgdat_t_all %>% filter(Treatment == "Field" | Treatment == "Autoclave")
