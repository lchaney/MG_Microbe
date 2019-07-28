#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#


#Plotting means of trait values by treatment    
#New data format
#melt data into 3 columns
dat.m <- mgdat %>% 
  group_by(Treatment) %>% 
  dplyr::select(one_of(samplevars)) %>% 
  gather(variable, value, -Treatment)

#melt data with trait Std errors by treatment and variable
dat.m2 <- mgdat %>% 
  group_by(Treatment) %>% 
  dplyr::select(one_of(samplevars)) %>% 
  gather(variable, value, -Treatment) %>%
  group_by(Treatment, variable) %>%
  mutate(upper = mean(value) + std(value), # upper limit for error bar
         lower = mean(value) - std(value)) # lower limit for error bar


#boxplot
gebox <- ggplot(data = dat.m, #use melted data 
                aes(x=Treatment, y = value, fill = Treatment)) + #variables
  geom_boxplot() + #boxplot
  theme_minimal() +#minimal theme
  facet_wrap( ~ variable, #facet wrap
              nrow = 1, scales = "free", #one row for facet wrap
              labeller = as_labeller(var_names), #label names
              strip.position = "bottom") + #facet label on bottom
  scale_fill_manual(values = wes_palette("GrandBudapest1")) + #color pallete
  labs(x = NULL,  y = NULL) + #no x or y labels
  theme(axis.ticks = element_blank(), #removes x tick labels
        axis.text.x = element_blank(), #removes x tick labels
        #axis.line.x=element_blank(), #turns off x axis line
        axis.line = element_line(size = .2)) #adds faint line to axis
