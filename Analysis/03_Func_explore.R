#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used to run Functions needed for the Chaney et al 2016 Morning glory microbe paper
#==============================================================================================#

#==============================================================================================#
#data exploration to determine what variables to focus on

#group traits together for exploration
flowvars <- c("DOFF", "DOLF", "DurationFlowering", "SumFlowers") 

leafsumvars <- c("LeafSum14", "LeafSum26", "LeafSum34", 
                 "LeafSumRGRA", "LeafSumRGRB", "LeafSumRGRC")

leafnumvars <- c("LeafNum14", "LeafNum26", "LeafNum34", 
                 "LeafNumRGRA", "LeafNumRGRB", "LeafNumRGRC")

heightvars <- c("Height14", "Height26", "Height34", 
                "HeightRGRA", "HeightRGRB", "HeightRGRC")


samplevars <- c("DOFF", "SumFlowers", "LeafSum34", "HeightRGRC")  
  #these are the variables I end up keeping

#check for phenotypic correlations  
  source('~/GitHub/corrPlot_v2/corrPlot_v2.R')

#   corrPlot2(mgdat[flowvars])
#   corrPlot2(mgdat[leafsumvars])
#   corrPlot2(mgdat[leafnumvars])
#   corrPlot2(mgdat[heightvars])
#   corrPlot2(mgdat[samplevars])

#check for patterns in data -- box plot by genotype, treatment and gxe

gxe_potgrid2 <- function(i){
  
  geno2 <- ggplot(data = mgdat, aes_string(x = "Genotype", y = i)) +
    geom_boxplot() + 
    theme_bw()
  
  tret2 <- ggplot(data = mgdat, aes_string(x = "Treatment", y = i, fill = "Treatment")) +
    geom_boxplot() + 
    theme_bw() + 
    theme(legend.position = "none")
  
  gxt2 <- ggplot(data = mgdat, aes_string(x = "Genotype", y = i, fill = "Treatment")) +
    geom_boxplot() + 
    theme_bw() + 
    theme(legend.position = "none")
  
  grid.arrange(arrangeGrob(geno2, tret2, nrow = 1, widths = c(3, 1)), gxt2, nrow = 2, heights = c(1,1))
  
}



#grid.arrange(arrangeGrob(geno2, gxt2, nrow = 2, heights = c(2, 2)), tret2, ncol = 2, widths = c(3,1))


# lapply(flowvars, gxe_potgrid2)
# lapply(leafsumvars, gxe_potgrid2)
# lapply(leafnumvars, gxe_potgrid2)
# lapply(heightvars, gxe_potgrid2)

 
colplot <- function (i){
  
  ggplot(data = mgdat, aes_string(x = "Treatment", y = i, fill = "Color", color = "Color")) + 
    geom_boxplot() +
    scale_color_manual(values = c("red", "purple", "black")) +
    scale_fill_manual(values = c("pink", "thistle", "white")) +
    theme_bw()
}

#lapply(samplevars, colplot)
