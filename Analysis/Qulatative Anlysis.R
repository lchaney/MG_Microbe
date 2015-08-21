#load data
mgdat <- read.csv("Data/mg_ghsoil.csv")


#load packages
library(dplyr) #data management
library(ggplot2) #plotting

#clean data
mgdat <- mgdat %>% mutate_each(funs(factor), Genotype, Treatment, Replicate)

#explore data
tbl_df(mgdat)
glimpse(mgdat)


#flower color genotype by phenotype
with(mgdat, table(ColorbyPhenotype, ColorbyGenotype))

#new variable that is just simply color - no dark or lights, etc (Pink, Purple, White)


#explore flowering
mgdat %>% group_by(Treatment, Color) %>% summarise_each(funs(mean), DOFF, DurationFlowering, SumFlowers)

ggplot(data= mgdat, aes(x = Treatment, y = SumFlowers)) + geom_violin()
       