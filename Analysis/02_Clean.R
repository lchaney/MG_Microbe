#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used to CLEAN data needed for the Chaney et al 2016 Morning glory microbe paper
#==============================================================================================#

#clean data
mgdat <- mgdat %>% mutate_each(funs(factor), Genotype, Treatment, Replicate)

#rename treatments
levels(mgdat$Treatment) <- c("Antibiotic", "Inoculum", "Field", "Autoclave")

#create new RGR variables -- the ones Laurie calculated are weird
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