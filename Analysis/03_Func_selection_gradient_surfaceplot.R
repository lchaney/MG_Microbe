#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection gradients surface plots
#==============================================================================================#


#graph the surface plot for flowering day and size
#set colors
  colr <- brewer.pal(11, "Spectral")
  colr <- colorRampPalette(colr, space="rgb")

#prepare data -- expand to extrapolate across the whole surface
mg.loess = loess(RelFit ~ DOFF*LeafSum34, data = mgdat2, degree = 2, span = 0.25)

expand.dat = expand.grid(list(DOFF = seq(from = range(mgdat2$DOFF)[1], 
                                         to = range(mgdat2$DOFF)[2], length.out = 100), 
                              LeafSum34 = seq(from = range(mgdat2$LeafSum34)[1], 
                                              to = range(mgdat2$LeafSum34)[2], length.out = 100)
))

z = predict(mg.loess, newdata = expand.dat)
expand.dat$z = as.numeric(z)

#surface plot
FSsurface <- wireframe(z ~ DOFF*LeafSum34, data = expand.dat,
                       scales=list(arrows=FALSE),
                       zlab=list("Relative Fitness", rot=90),
                       xlab=list("Flowering Day", rot=-55), 
                       ylab=list("Size", rot=30),
                       colorkey = TRUE,
                       screen = list(z = -60, x = -60),
                       col.regions = colr(100), 
                       col="gray50", 
                       col.contour=1,
                       panel.3d.wireframe="panel.3d.contour", 
                       type="on",
                       drape=TRUE
)