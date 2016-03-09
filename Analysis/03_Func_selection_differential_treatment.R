#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.3 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection differentials by treatments
#==============================================================================================#


#Does the direction and/or intensity of selection differ by treatment (ANCOVA)
#selection differentials - ANCOVA  
#DOFF
asd.doff <- lm(RelFit ~ DOFF + DOFF:Treatment + Treatment, data = mgdat2)
#   anova(asd.doff)

ts.doff.treat <- lapply(unique(mgdat2$Treatment), function(t){
  summary(lm(RelFit ~ DOFF, data = mgdat2[ which(mgdat2$Treatment == t), ]))
})  

#LeafSum34
asd.lsum <- lm(RelFit ~ LeafSum34 + LeafSum34:Treatment + Treatment, data = mgdat2)
#    anova(asd.lsum)

ts.lvsum.treat <- lapply(unique(mgdat2$Treatment), function(t){
  summary(lm(RelFit ~ LeafSum34, data = mgdat2[ which(mgdat2$Treatment == t), ]))
})    

#HeightRGRC
asd.grw <- lm(RelFit ~ HeightRGRC + HeightRGRC:Treatment + Treatment, data = mgdat2)
#    anova(asd.grw)

ts.grw.treat <- lapply(unique(mgdat2$Treatment), function(t){
  summary(lm(RelFit ~ HeightRGRC, data = mgdat2[ which(mgdat2$Treatment == t), ]))
})      