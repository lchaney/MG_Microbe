#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
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
