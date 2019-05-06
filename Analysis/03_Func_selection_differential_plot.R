#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.3 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function PLOTS selection differentials
#==============================================================================================#

#PLOT SELECTION DIFFERENTIAL BY TREATMENT
ts.doffplot <- ggplot(data = mgdat2,
                      aes(x = DOFF, y = RelFit, color = Treatment)) +
  geom_point() +
  stat_smooth(method = lm, se = FALSE) +
  scale_color_manual(values = wes_palette("GrandBudapest1")) +
  facet_wrap( ~ Treatment, nrow = 1) +
  labs(x = "Flowering Time (scaled) ", y = "Relative Fitness") +
  theme_minimal() +
  theme(axis.line = element_line(size = .2))

ts.lvsumplot <- ggplot(data = mgdat2,
                       aes(x = LeafSum34, y = RelFit, color = Treatment)) +
  geom_point() +
  stat_smooth(method = lm, se = FALSE) +
  scale_color_manual(values = wes_palette("GrandBudapest1")) +
  facet_wrap( ~ Treatment, nrow = 1) +
  labs(x = "Size (scaled) ", y = "Relative Fitness") +
  theme_minimal() +
  theme(axis.line = element_line(size = .2))

ts.grwplot <- ggplot(data = mgdat2,
                     aes(x = HeightRGRC, y = RelFit, color = Treatment)) +
  geom_point() +
  stat_smooth(method = lm, se = FALSE) +
  scale_color_manual(values = wes_palette("GrandBudapest1")) +
  facet_wrap( ~ Treatment, nrow = 1) +
  labs(x = "Growth (scaled) ", y = "Relative Fitness") +
  theme_minimal() +
  theme(axis.line = element_line(size = .2))

#grid.arrange(arrangeGrob(ts.doffplot, ts.lvsumplot, ts.grwplot, nrow = 3))