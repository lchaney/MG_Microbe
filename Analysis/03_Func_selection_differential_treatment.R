#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
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
