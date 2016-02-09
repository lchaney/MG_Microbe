#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection differences by treatment on different traits
#==============================================================================================#

#SumFlowers will be used as proxy for fitness
#We will use relative fitness: RelFit <- (SumFlowers/(mean(SumFlowers)))
#trait values will be standardized to have a mean of zero and a standard deviation of one

#create new variables -- realtive fitness
mgdat2 <- mgdat %>% 
  select(Genotype, Treatment, one_of(samplevars)) %>%
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
  
  #mgdat2 %>% mutate_each(funs(as.numeric), DOFF)
  
  #remove scale attributes from variabels
  #lapply(samplevars, function(x1){
  #  attr(x1, "scaled:center") <- NULL
  #  attr(x1,"scaled:scale") <-NULL 
  #})
  
###Selection

  #source to perform Selection Differential FUNCTIONS on data
  source('Analysis/03_Func_selection_differential.R')
  
  #source to perform Selection Differential Plot FUNCTIONS on data
  source('Analysis/03_Func_selection_differential_plot.R')
  
  #source to perform Selection Gradient FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient.R')
  
  #source to perform Selection Gradient quadratic selection plot FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient_quadplot.R')
  
  #source to perform Selection Gradient surface plot FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient_surfaceplot.R')
  
  #source to perform Selection Gradient quadratic selection plot by treatment FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient_quadplot_treatment.R')
  
  #source to perform Selection Gradient surface plot by treatment FUNCTIONS on data
  source('Analysis/03_Func_selection_gradient_surfaceplot_treatment.R')