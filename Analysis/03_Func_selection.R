#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#

#SumFlowers will be used as proxy for fitness
#We will use relative fitness: RelFit <- (SumFlowers/(mean(SumFlowers)))
#trait values will be standardized to have a mean of zero and a standard deviation of one

#create new variables -- realtive fitness
mgdat2 <- mgdat %>% 
  dplyr::select(Genotype, Treatment, one_of(samplevars)) %>%
  mutate(RelFit = SumFlowers/mean(SumFlowers)) %>%
  mutate_each(funs(scale), one_of(samplevars))

  #remove scale attributes
  attr(mgdat2$DOFF,"scaled:center")<-NULL 
  attr(mgdat2$LeafSum34,"scaled:center")<-NULL
  attr(mgdat2$HeightRGRC,"scaled:center")<-NULL
  attr(mgdat2$SumFlowers,"scaled:center")<-NULL
  
  attr(mgdat2$DOFF,"scaled:scale")<-NULL 
  attr(mgdat2$LeafSum34,"scaled:scale")<-NULL
  attr(mgdat2$HeightRGRC,"scaled:scale")<-NULL
  attr(mgdat2$SumFlowers,"scaled:scale")<-NULL

#==============================================================================================#
  
###soure different Selection functions

  #source to perform Selection Differential FUNCTIONS on data
  source('Analysis/03_Func_selection_differential.R')

  #source to perform Selection Differential by treatment FUNCTIONS on data
  source('Analysis/03_Func_selection_differential_treatment.R')
    
  #source to perform Selection Differential Plot FUNCTIONS on data
  source('Analysis/03_Func_selection_differential_plot.R')
  
  #source to perform Selection Gradient FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient.R')

  #source to perform Selection Gradient quadratic selection plot FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient_quadplot.R')
  
  #source to perform Selection Gradient quadratic selection plot by treatment FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient_quadplot_treatment.R')
  
  #source to perform Selection Gradient surface plot by treatment FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient_surfaceplot_treatment.R')
  
#==============================================================================================#