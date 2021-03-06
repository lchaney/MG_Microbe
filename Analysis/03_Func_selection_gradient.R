#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#

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
#Selection gradients - ANCOVA

asgl <- lm(RelFit ~ DOFF + LeafSum34 + HeightRGRC +
             DOFF:Treatment + LeafSum34:Treatment + 
             HeightRGRC:Treatment + Treatment,
           data = mgdat2)
#  anova(asgl)
#  summary(asgl)   #just look at beta for DOFF

asgl.treat <- lapply(unique(mgdat2$Treatment), function(t){
  summary(lm(RelFit ~ DOFF + LeafSum34 + HeightRGRC, data = mgdat2[ which(mgdat2$Treatment == t), ]))
})    

asgq <- lm(RelFit ~ DOFF + LeafSum34 + HeightRGRC +
             DOFF:LeafSum34 + DOFF:HeightRGRC +
             LeafSum34:HeightRGRC + I(DOFF^2) +
             I(LeafSum34^2) + I(HeightRGRC^2) +
             DOFF:Treatment + LeafSum34:Treatment + 
             HeightRGRC:Treatment + DOFF:LeafSum34:Treatment + 
             DOFF:HeightRGRC:Treatment +
             LeafSum34:HeightRGRC:Treatment + I(DOFF^2):Treatment +
             I(LeafSum34^2):Treatment + I(HeightRGRC^2):Treatment +
             Treatment,
           data = mgdat2)
#  anova(asgq)
asgq.treat <- lapply(unique(mgdat2$Treatment), function(t){
  summary(lm(RelFit ~ DOFF + LeafSum34 + HeightRGRC +
               DOFF:LeafSum34 + DOFF:HeightRGRC +
               LeafSum34:HeightRGRC + I(DOFF^2) +
               I(LeafSum34^2) + I(HeightRGRC^2), 
             data = mgdat2[ which(mgdat2$Treatment == t), ]))
})   
