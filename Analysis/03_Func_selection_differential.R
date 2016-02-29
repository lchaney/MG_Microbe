#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.3 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection differentials
#==============================================================================================#

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
