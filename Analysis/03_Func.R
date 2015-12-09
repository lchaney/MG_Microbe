#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used to run Functions needed for the Chaney et al 2016 Morning glory microbe paper
#==============================================================================================#

#explore data
tbl_df(mgdat)
glimpse(mgdat)

summary(mgdat)
unique(mgdat$Genotype)

with(mgdat, table(Genotype, Treatment))

#flower color genotype by phenotype
with(mgdat, table(ColorbyPhenotype, ColorbyGenotype))

#new variable that is just simply color - no dark or lights, etc (Pink, Purple, White)
#WHAT COLOR DO I USE?

#explore flowering
mgdat %>% group_by(Treatment, Color) %>% summarise_each(funs(mean), DOFF, DurationFlowering, SumFlowers)

ggplot(data = mgdat, aes(x = Treatment, y = SumFlowers, fill = Color, color = Color)) + 
  geom_boxplot() +
  scale_color_manual(values = c("red", "purple", "black")) +
  scale_fill_manual(values = c("pink", "thistle", "white")) +
  theme_bw()

#are these traits phenotypically correlated
source('~/GitHub/corrPlot_v2/corrPlot_v2.R')

  corrPlot2(mgdat[,8:16])
  corrPlot2(mgdat[,16:26])
  corrPlot2(mgdat[,36:44])
  

#source to perform FUNCTION on data
  source('Analysis/03_Func_GxE.R')