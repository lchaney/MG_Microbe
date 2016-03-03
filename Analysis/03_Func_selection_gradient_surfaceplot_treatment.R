#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection gradients surface plots by treatment
#==============================================================================================#


#inoculum
mg.loessi = loess(RelFit ~ DOFF*HeightRGRC, data = mgdat2i, degree = 2, span = 0.25)

expand.dati = expand.grid(list(DOFF = seq(from = range(mgdat2i$DOFF)[1], 
                                          to = range(mgdat2i$DOFF)[2], length.out = 100), 
                               HeightRGRC = seq(from = range(mgdat2i$HeightRGRC)[1], 
                                                to = range(mgdat2i$HeightRGRC)[2], length.out = 100)
))

z = predict(mg.loessi, newdata = expand.dati)
expand.dati$z = as.numeric(z)

#surface plot
FSsurface.inoculum <- wireframe(z ~ DOFF*HeightRGRC, data = expand.dati,
                                  scales=list(arrows=TRUE),
                                  zlab=list("Relative Fitness", rot=95),
                                  xlab=list("Flowering Day"), 
                                  ylab=list("Growth"),
                                  colorkey = TRUE,
                                  #screen = list(z = -120, x = -80),
                                  col.regions = colr(100), 
                                  col="gray50", 
                                  col.contour=1,
                                  panel.3d.wireframe="panel.3d.contour", 
                                  type="on",
                                  drape=TRUE
)


#autoclave
mg.loessac = loess(RelFit ~ DOFF*HeightRGRC, data = mgdat2ac, degree = 2, span = 0.25)

expand.datac = expand.grid(list(DOFF = seq(from = range(mgdat2ac$DOFF)[1], 
                                          to = range(mgdat2ac$DOFF)[2], length.out = 100), 
                               HeightRGRC = seq(from = range(mgdat2ac$HeightRGRC)[1], 
                                                to = range(mgdat2ac$HeightRGRC)[2], length.out = 100)
))

z = predict(mg.loessac, newdata = expand.datac)
expand.datac$z = as.numeric(z)

#surface plot
FSsurface.autoclave <- wireframe(z ~ DOFF*HeightRGRC, data = expand.datac,
                             scales=list(arrows=TRUE),
                             zlab=list("Relative Fitness", rot=95),
                             xlab=list("Flowering Day"), 
                             ylab=list("Growth"),
                             colorkey = TRUE,
                             #screen = list(z = -120, x = -80),
                             col.regions = colr(100), 
                             col="gray50", 
                             col.contour=1,
                             panel.3d.wireframe="panel.3d.contour", 
                             type="on",
                             drape=TRUE
)



#grid.arrange(arrangeGrob(FSsurface.inoculum, FSsurface.autoclave, nrow = 1))
