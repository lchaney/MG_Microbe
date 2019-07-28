#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#


#is this true stabilizing/disruptive selection with an intermediate optimum for fitness  
fit <- lm(RelFit ~ as.numeric(DOFF) + I(as.numeric(DOFF^2)), data = mgdat2)
prd <- data.frame(DOFF = seq(from = range(mgdat2$DOFF)[1], to = range(mgdat2$DOFF)[2], length.out = 100))
err <- predict(fit, newdata = prd, se.fit = TRUE)

prd$lci <- err$fit - 1.96 * err$se.fit
prd$fit <- err$fit
prd$uci <- err$fit + 1.96 * err$se.fit

doff.quad <- ggplot(data = prd, aes(x = DOFF, y = fit)) +
  theme_bw() +
  geom_line() +
  geom_smooth(aes(ymin = lci, ymax = uci), color = "black", stat = "identity") +
  geom_point(data = mgdat2, aes(x = DOFF, y = RelFit)) + 
  labs(x = "Flowering Time", y = "Relative Fitness")
