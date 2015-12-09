#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection differences by treatment on different traits
#==============================================================================================#

#SumFlowers will be used as proxy for fitness
#We will use relative fitness: RelFit <- (SumFlowers/(mean(SumFlowers)))
#trait values will be standardized to have a mean of zero and a standard deviation of one

#????Should I look at maternal line averages?

#relative fitness function
relfun <- function(x){
  x / mean(x)
}

#create new variables for all but treatment -- realtive and z score
mgdat2 <- mgdat[,c(3, 8:11)] %>% mutate_each(funs(z = scale(.), rel = relfun(.)), -Treatment)

#  mgdat$RelFit <- mgdat$SumFlowers/mean(mgdat$SumFlowers)

#total selection or selection differential/gradient?!?
  #DOFF
    #treatment 1
      with(mgdat2[which(mgdat2$Treatment == 1),], cor.test(SumFlowers_rel, DOFF_z))
      coef(lm(SumFlowers_rel ~ DOFF_z, data = mgdat2[which(mgdat2$Treatment == 1),]))
      confint(lm(SumFlowers_rel ~ DOFF_z, data = mgdat2[which(mgdat2$Treatment == 1),]))
    #treatment 2
      with(mgdat2[which(mgdat2$Treatment == 2),], cor.test(SumFlowers_rel, DOFF_z))
      coef(lm(SumFlowers_rel ~ DOFF_z, data = mgdat2[which(mgdat2$Treatment == 2),]))
      confint(lm(SumFlowers_rel ~ DOFF_z, data = mgdat2[which(mgdat2$Treatment == 2),]))
      