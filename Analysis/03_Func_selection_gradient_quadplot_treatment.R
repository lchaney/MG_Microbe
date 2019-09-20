#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#


#is this true stabilizing/disruptive selection with an intermediate optimum for fitness  
#Inoculum
mgdat2i <- mgdat2[ which(mgdat2$Treatment == "Autoclave Inoculum"), ]

  fiti <- lm(RelFit ~ as.numeric(DOFF) + I(as.numeric(DOFF^2)), data = mgdat2i)
  prdi <- data.frame(DOFF = seq(from = range(mgdat2i$DOFF)[1], to = range(mgdat2i$DOFF)[2], length.out = 100))
  errai <- predict(fiti, newdata = prdi, se.fit = TRUE)

prdi$lci <- errai$fit - 1.96 * errai$se.fit
prdi$fit <- errai$fit
prdi$uci <- errai$fit + 1.96 * errai$se.fit

doff.quad.Inoculum <- ggplot(data = prdi, aes(x = DOFF, y = fit)) +
  theme_bw() +
  geom_line() +
  geom_smooth(aes(ymin = lci, ymax = uci), color = wes_palette("GrandBudapest")[2], stat = "identity") +
  geom_point(data = mgdat2i, aes(x = DOFF, y = RelFit), color = wes_palette("GrandBudapest")[2]) + 
  scale_x_continuous(limits = c(-3.5, 2.5)) +
  scale_y_continuous(limits = c(0, 3.5)) +
  labs(title = "Complex", x = "Flowering Day", y = "Relative Fitness")

#Autoclave
mgdat2ac <- mgdat2[ which(mgdat2$Treatment == "Autoclave"), ]

fitac <- lm(RelFit ~ as.numeric(DOFF) + I(as.numeric(DOFF^2)), data = mgdat2ac)
prdac <- data.frame(DOFF = seq(from = range(mgdat2ac$DOFF)[1], to = range(mgdat2ac$DOFF)[2], length.out = 100))
errac <- predict(fitac, newdata = prdac, se.fit = TRUE)

prdac$lci <- errac$fit - 1.96 * errac$se.fit
prdac$fit <- errac$fit
prdac$uci <- errac$fit + 1.96 * errac$se.fit

doff.quad.Autoclave <- ggplot(data = prdac, aes(x = DOFF, y = fit)) +
  theme_bw() +
  geom_line() +
  geom_smooth(aes(ymin = lci, ymax = uci), color = wes_palette("GrandBudapest")[4], stat = "identity") +
  geom_point(data = mgdat2ac, aes(x = DOFF, y = RelFit), color = wes_palette("GrandBudapest")[4]) + 
  scale_x_continuous(limits = c(-3.5, 2.5)) +
  scale_y_continuous(limits = c(0, 3.5)) +
  labs(title = "Simple", x = "Flowering Day", y = "Relative Fitness")



quad.treatment <- grid.arrange(arrangeGrob(doff.quad.Inoculum, doff.quad.Autoclave, nrow = 1))
