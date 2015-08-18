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

