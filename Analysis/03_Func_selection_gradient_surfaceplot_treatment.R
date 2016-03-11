#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection gradients surface plots by treatment
#==============================================================================================#

pal <- wes_palette("Zissou", 100, type = "continuous") #set color pallete

#inoculum
xFGi <- cbind(mgdat2i$HeightRGRC, mgdat2i$DOFF)
outFGi <- Tps(xFGi, mgdat2i$RelFit)

FG.surface.In <- surface(outFGi, type="p", xlab="Growth", ylab="Flowering Day", zlab="Fitness", add.legend=FALSE, col= pal, border = NA)
FG.countour.In <- surface(outFGi, type="C", xlab="Growth", ylab="Flowering Day", add.legend = TRUE, col = pal)


#autoclave
xFGac <- cbind(mgdat2ac$HeightRGRC, mgdat2ac$DOFF)
outFGac <- Tps(xFGac, mgdat2ac$RelFit)

FG.surface.Au <- surface(outFGac, type="p", xlab="Growth", ylab="Flowering Day", zlab="RelFit", add.legend = FALSE, col= pal, border = NA)
FG.countour.Au <- surface(outFGac, type="C", xlab="Growth", ylab="Flowering Day", zlab="RelFit", add.legend = TRUE, col = pal)
