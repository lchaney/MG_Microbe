#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.3 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection gradients -- quadratic selection plot
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