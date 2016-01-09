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

#create new variables -- realtive fitness
mgdat <- mgdat %>% select(Genotype, Treatment, one_of(samplevars)) %>%
  mutate(RelFit = SumFlowers/mean(SumFlowers)) 

  #%>%
  #mutate_each(funs(scale), one_of(samplevars)) %>% as.data.frame()

mgdatgeno <- mgdat %>% 
  group_by(Genotype, Treatment) %>% 
  summarise_each(funs(mean), -Treatment) %>% ungroup()

###Selection

#Selection Differential, Total Selection, Direct and Indirect Selection (Univariate)

  ts.doff <- lm(RelFit ~ scale(DOFF), data = mgdatgeno)
#    anova(ts.doff)
#    summary(ts.doff)
#      plot(ts.doff) #resids look good

  ts.lvsum <- lm(RelFit ~ scale(LeafSum34), data = mgdatgeno)
#    anova(ts.lvsum)
#    summary(ts.lvsum)
#      plot(ts.lvsum) #resids look good
    
  ts.grw <- lm(RelFit ~ scale(HeightRGRC), data = mgdatgeno)
#    anova(ts.grw)
#    summary(ts.grw)
#      plot(ts.grw) #resids look good
    
  #not using mean data
#     ts.doff2 <- lm(RelFit ~ scale(DOFF), data = mgdat)
#       anova(ts.doff2)
#       summary(ts.doff2)
#         plot(ts.doff2) #resids look good
#         
#     ts.lvsum2 <- lm(RelFit ~ scale(LeafSum34), data = mgdat)
#       anova(ts.lvsum2)
#       summary(ts.lvsum2)
#         plot(ts.lvsum2) #resids look good
#         
#     ts.grw2 <- lm(RelFit ~ scale(HeightRGRC), data = mgdat)
#       anova(ts.grw2)
#       summary(ts.grw2)
#         plot(ts.grw2) #resids look good
      

  
#Selection Gradient; Direct Selection (mulitvariate analysis)

    ds.mod <- lm(RelFit ~ scale(DOFF) + scale(LeafSum34) + scale(HeightRGRC),
               data = mgdatgeno)
#    anova(ds.mod)
#    summary(ds.mod)
    
#not genotype means
#   ds.mod2 <- lm(RelFit ~ scale(DOFF) + scale(LeafSum34) + scale(HeightRGRC),
#                  data = mgdat)
#     anova(ds.mod2)
#     summary(ds.mod2)
  
  #and Quadratic selection gradients
  dsquad.mod <- lm(RelFit ~ scale(DOFF) + scale(LeafSum34) + scale(HeightRGRC) +
                     (scale(DOFF):scale(LeafSum34)) + (scale(DOFF):scale(HeightRGRC)) +
                     (scale(LeafSum34):scale(HeightRGRC)) + I(scale(DOFF)^2) +
                     I(scale(LeafSum34)^2) + I(scale(HeightRGRC)^2),
                 data = mgdatgeno)
#    anova(dsquad.mod)
#    summary(dsquad.mod) 
  
  
  

#Does the direction and/or intensity of selection differ by treatment (ANCOVA)

#selection differentials  
#DOFF
  asd.doff <- lm(RelFit ~ scale(DOFF) + (scale(DOFF):Treatment) + Treatment, data = mgdatgeno)
    anova(asd.doff)
    
#LeafSum34
  asd.lsum <- lm(RelFit ~ scale(LeafSum34) + (scale(LeafSum34):Treatment) + Treatment, data = mgdatgeno)
#    anova(asd.lsum)
    
#HeightRGRC
  asd.grw <- lm(RelFit ~ scale(HeightRGRC) + (scale(HeightRGRC):Treatment) + Treatment, data = mgdatgeno)
#    anova(asd.grw)

#Selection gradients

   asg <- lm(RelFit ~ scale(DOFF) + scale(LeafSum34) + scale(HeightRGRC) +
                     (scale(DOFF):Treatment) + (scale(LeafSum34):Treatment) +
                     (scale(HeightRGRC):Treatment) + Treatment,
                   data = mgdatgeno)
#  anova(asg)