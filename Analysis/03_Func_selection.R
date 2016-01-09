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
mgdat2 <- mgdat %>% select(Genotype, Treatment, one_of(samplevars)) %>%
  mutate(RelFit = SumFlowers/mean(SumFlowers)) %>%
  mutate_each(funs(scale), one_of(samplevars)) %>% as.data.frame()

###Selection

#Selection Differential, Total Selection, Direct and Indirect Selection (Univariate)

  #DOFF
  ts.doff <- lm(RelFit ~ DOFF, data = mgdat2)
#    anova(ts.doff)
#    summary(ts.doff)
  
  #LeafSum34    
  ts.lvsum <- lm(RelFit ~ LeafSum34, data = mgdat2)
#    anova(ts.lvsum)
#    summary(ts.lvsum)

  
  #HeightRGRC    
  ts.grw <- lm(RelFit ~ HeightRGRC, data = mgdat2)
#    anova(ts.grw)
#    summary(ts.grw)

#Selection Gradient; Direct Selection (mulitvariate analysis)
  
  #linear selection gradients
  ds.mod <- lm(RelFit ~ DOFF + LeafSum34 + HeightRGRC,
               data = mgdat2)
  #    anova(ds.mod)
  #    summary(ds.mod)
  
  #Quadratic selection gradients
  dsquad.mod <- lm(RelFit ~ DOFF + LeafSum34 + HeightRGRC +
                     DOFF:LeafSum34 + DOFF:HeightRGRC +
                     LeafSum34:HeightRGRC + I(DOFF^2) +
                     I(LeafSum34^2) + I(HeightRGRC^2),
                 data = mgdat2)
#    anova(dsquad.mod)
#    summary(dsquad.mod) 
  
  

#Does the direction and/or intensity of selection differ by treatment (ANCOVA)

#selection differentials  
#DOFF
  asd.doff <- lm(RelFit ~ DOFF + DOFF:Treatment + Treatment, data = mgdat2)
    anova(asd.doff)

  ts.doff.treat <- lapply(unique(mgdat2$Treatment), function(t){
      summary(lm(RelFit ~ DOFF, data = mgdat2[ which(mgdat2$Treatment == t), ]))$coefficients[2]
    })  
    
#LeafSum34
  asd.lsum <- lm(RelFit ~ LeafSum34 + LeafSum34:Treatment + Treatment, data = mgdat2)
#    anova(asd.lsum)
  
  ts.lvsum.treat <- lapply(unique(mgdat2$Treatment), function(t){
    summary(lm(RelFit ~ LeafSum34, data = mgdat2[ which(mgdat2$Treatment == t), ]))$coefficients[2]
  })    
      
#HeightRGRC
  asd.grw <- lm(RelFit ~ HeightRGRC + HeightRGRC:Treatment + Treatment, data = mgdat2)
#    anova(asd.grw)

  ts.grw.treat <- lapply(unique(mgdat2$Treatment), function(t){
    summary(lm(RelFit ~ HeightRGRC, data = mgdat2[ which(mgdat2$Treatment == t), ]))$coefficients[2]
  })    
  
  
#Selection gradients

   asg <- lm(RelFit ~ DOFF + LeafSum34 + HeightRGRC +
                     DOFF:Treatment + LeafSum34:Treatment +
                     HeightRGRC:Treatment + Treatment,
                   data = mgdat2)
#  anova(asg)
   