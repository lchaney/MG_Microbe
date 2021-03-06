#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#

pal <- wes_palette("Zissou", 100, type = "continuous") #set color pallete

#inoculum
xFGi <- cbind(mgdat2i$HeightRGRC, mgdat2i$DOFF)
outFGi <- Tps(xFGi, mgdat2i$RelFit)

  #surface plot
  FG.surface.In <- surface(outFGi, type="p", xlab="Growth", ylab="Flowering Day", zlab="Fitness", add.legend=FALSE, col= pal, border = NA)
  #contour plot
  FG.contour.In <- surface(outFGi, type="C", xlab="Growth", ylab="Flowering Day", add.legend = TRUE, col = pal)
  points(xFGi, pch = 2, col = "gray20", cex = .8)

#autoclave
xFGac <- cbind(mgdat2ac$HeightRGRC, mgdat2ac$DOFF)
outFGac <- Tps(xFGac, mgdat2ac$RelFit)

  #surface plot
  FG.surface.Au <- surface(outFGac, type="p", xlab="Growth", ylab="Flowering Day", zlab="RelFit", add.legend = FALSE, col= pal, border = NA)
  #contour plot
  FG.contour.Au <- surface(outFGac, type="C", xlab="Growth", ylab="Flowering Day", zlab="RelFit", add.legend = TRUE, col = pal)
  points(xFGac, pch = 2, col = "gray20", cex = .8)
