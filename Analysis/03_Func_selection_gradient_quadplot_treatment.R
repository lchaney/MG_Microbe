#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.3 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines selection gradients -- quadratic selection plot by treatment
#==============================================================================================#


#is this true stabilizing/disruptive selection with an intermediate optimum for fitness  
#Antibiotic
mgdat2a <- mgdat2[ which(mgdat2$Treatment == "Antibiotic"), ]

  fita <- lm(RelFit ~ as.numeric(DOFF) + I(as.numeric(DOFF^2)), data = mgdat2a)
  prda <- data.frame(DOFF = seq(from = range(mgdat2a$DOFF)[1], to = range(mgdat2a$DOFF)[2], length.out = 100))
  erra <- predict(fita, newdata = prda, se.fit = TRUE)

    prda$lci <- erra$fit - 1.96 * erra$se.fit
    prda$fit <- erra$fit
    prda$uci <- erra$fit + 1.96 * erra$se.fit

doff.quad.Antibiotic <- ggplot(data = prda, aes(x = DOFF, y = fit)) +
  theme_bw() +
  geom_line() +
  geom_smooth(aes(ymin = lci, ymax = uci), color = wes_palette("GrandBudapest")[1], stat = "identity") +
  geom_point(data = mgdat2a, aes(x = DOFF, y = RelFit), color = wes_palette("GrandBudapest")[1]) + 
  labs(title = "Antibiotic", x = "Flowering Time", y = "Relative Fitness")

#Inoculum
mgdat2i <- mgdat2[ which(mgdat2$Treatment == "Inoculum"), ]

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
  labs(title = "Inoculum", x = "Flowering Time", y = "Relative Fitness")


#Field
mgdat2f <- mgdat2[ which(mgdat2$Treatment == "Field"), ]

fitf <- lm(RelFit ~ as.numeric(DOFF) + I(as.numeric(DOFF^2)), data = mgdat2f)
prdf <- data.frame(DOFF = seq(from = range(mgdat2f$DOFF)[1], to = range(mgdat2f$DOFF)[2], length.out = 100))
erraf <- predict(fitf, newdata = prdf, se.fit = TRUE)

prdf$lci <- erraf$fit - 1.96 * erraf$se.fit
prdf$fit <- erraf$fit
prdf$uci <- erraf$fit + 1.96 * erraf$se.fit

doff.quad.Field <- ggplot(data = prdf, aes(x = DOFF, y = fit)) +
  theme_bw() +
  geom_line() +
  geom_smooth(aes(ymin = lci, ymax = uci), color = wes_palette("GrandBudapest")[3], stat = "identity") +
  geom_point(data = mgdat2f, aes(x = DOFF, y = RelFit), color = wes_palette("GrandBudapest")[3]) + 
  labs(title = "Field", x = "Flowering Time", y = "Relative Fitness")


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
  labs(title = "Autoclave", x = "Flowering Time", y = "Relative Fitness")



#grid.arrange(arrangeGrob(doff.quad.Antibiotic, doff.quad.Inoculum, doff.quad.Field, doff.quad.Autoclave, nrow = 1))