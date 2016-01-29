#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines trait differences by genotype, treatment, and their interacitons
#==============================================================================================#

#differences in trait by genotype (maternal line), treatment, and interaction

# mixedmod <- function(r){
#   capture.output(mod <- lmer(substitute(j ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), list(j = as.name(r))), data = mgdat))
# 
#   fm <- formula(mod)
#   am <- anova(mod)
#   rm <- rand(mod)
#   tm <- summary(glht(mod, linfct = mcp(Treatment = "Tukey")))
#   
#   print(fm)
#   cat("\n")
#   print(am)
#   cat("\n") 
#   
#   }
# 
# lapply(samplevars, mixedmod)

  #DOFF -- Day of first flower / Phenology
    fit1 <- lmer(DOFF ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit1)
#       rand(fit1)
      
  #SumFlowers -- Total Number of Flowers
    fit4 <- lmer(SumFlowers ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit4)
#       rand(fit4)
#       summary(glht(fit4, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp

  #LeafSum34 -- Sum of Leaf Lengths *LATE*
    fit7 <- lmer(LeafSum34 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit7)
#       rand(fit7)
#       summary(glht(fit7, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    
  #HeightRGRC -- RGR for height *Late - Early*
    fit37 <- lmer(HeightRGRC ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit37)
#       rand(fit37)
#       summary(glht(fit37, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp

#summarrize each trait value in each treatment
      
    std <- function(x) sd(x)/sqrt(length(x)) #standard error of the mean
        
    trait_summary <- mgdat %>% #data input
        group_by(Treatment) %>% #group data by treatment
        select(one_of(samplevars)) %>% #specify what variables to look at
        summarise_each(funs(mean, std)) %>% #what functions to summarise by
        gather(variable, value, -Treatment) %>% #do not gather by treatment
        separate(variable, c("var", "stat"), sep = "\\_") %>% #seperate varibable name and stat
        spread(var, value) #spread data by variable name along top

    
#Plotting means of trait values by treatment    
#New data format
    #melt data into 3 columns
    dat.m <- mgdat %>% 
      group_by(Treatment) %>% 
      select(one_of(samplevars)) %>% 
      gather(variable, value, -Treatment)
    
    #melt data with trait Std errors by treatment and variable
    dat.m2 <- mgdat %>% 
      group_by(Treatment) %>% 
      select(one_of(samplevars)) %>% 
      gather(variable, value, -Treatment) %>%
      group_by(Treatment, variable) %>%
      mutate(upper = mean(value) + std(value), # upper limit for error bar
             lower = mean(value) - std(value)) # lower limit for error bar
    
    
#Plot options
  #boxplot
    gebox <- ggplot(data = dat.m, #use melted data 
                    aes(x=Treatment, y = value, fill = Treatment)) + #variables
      geom_boxplot() + #boxplot
      theme_minimal() +#minimal theme
      facet_wrap( ~ variable, #facet wrap
                  nrow = 1, scales = "free", #one row for facet wrap
                  labeller = as_labeller(var_names), #label names
                  switch = "x") + #facet label on bottom
      scale_fill_manual(values = wes_palette("GrandBudapest")) + #color pallete
      labs(x = NULL,  y = NULL) + #no x or y labels
      theme(axis.ticks = element_blank(), #removes x tick labels
            axis.text.x = element_blank(), #removes x tick labels
            #axis.line.x=element_blank(), #turns off x axis line
            axis.line = element_line(size = .2)) #adds faint line to axis
      
      
  #Violin plot with mean
    gevio <- ggplot(dat.m, #use melted data
           aes(x = variable, y = value, fill = Treatment)) + #variables
      geom_violin(adjust = .6) + #violin plot, adjusts makes it more shapely
      theme_minimal() + #minimal theme
      scale_fill_manual(values = wes_palette("GrandBudapest")) + #color pallete
      stat_summary(fun.y = mean, #add mean point to the plot
                  geom = "point", 
                  position = position_dodge(width = .9), #seperate by treatment
                  size = 10, #size of shape
                  shape = "-", #shape
                  show.legend = FALSE) + #not in legend
      labs(x = NULL, y = NULL) + #no x or y label
      facet_wrap( ~ variable, #facet wrap
                  nrow = 1, #one row
                  scales = "free", #scales differ by trait
                  labeller = as_labeller(var_names), #label names
                  switch = "x") + #facet label on bottom
      theme(axis.ticks = element_blank(), #removes x tick labels
            axis.text.x = element_blank(), #removes x tick labels
            #axis.line.x=element_blank(), #turns off x axis line
            axis.line = element_line(size = .2)) #adds faint line to axis
     
    
  #Jitter dot plot with mean
    gedot <- ggplot(dat.m, 
           aes(x = variable, y = value, fill = Treatment, colour = Treatment)) +
      stat_summary(fun.y = mean, 
                   geom = "point", 
                   position = position_dodge(width = .5),
                   size = 30, 
                   shape = "-", 
                   show.legend = FALSE, 
                   alpha = .7) + # plot mean as "-"
      geom_jitter(position = position_jitterdodge(jitter.width = .3, 
                                                  jitter.height = .1,
                                                  dodge.width = .5),
                  size = 1, 
                  alpha = .85) + #plot individual points jittered
      scale_color_manual(values = wes_palette("GrandBudapest")) + #colors
      theme_minimal() + #minimal theme    
      labs(x = NULL, y = NULL) + #no x or y label
      facet_wrap( ~ variable, #facet wrap
                  nrow = 1, #one row
                  scales = "free", #scales differ by trait
                  labeller = as_labeller(var_names), #label names
                  switch = "x") + #facet label on bottom
      theme(axis.ticks = element_blank(), #removes x tick labels
            axis.text.x = element_blank(), #removes x tick labels
            #axis.line.x=element_blank(), #turns off x axis line
            axis.line = element_line(size = .2)) #adds faint line to axis
  
    
  #Barplot with mean and Std
    gebar <- ggplot(dat.m2, 
           aes(x = variable, y = value, fill = Treatment)) +
      stat_summary(fun.y = mean, 
                   geom = "bar", 
                   position = position_dodge(width = .9),
                   size = 3) +
      geom_errorbar(aes(ymin = lower, ymax = upper),
                    width = .1,                    # Width of the error bars
                    position = position_dodge(.9)) +
      scale_fill_manual(values = wes_palette("GrandBudapest")) + #colors
      theme_minimal() + #minimal theme    
      labs(x = NULL, y = NULL) + #no x or y label
      facet_wrap( ~ variable, #facet wrap
                  nrow = 1, #one row
                  scales = "free", #scales differ by trait
                  labeller = as_labeller(var_names), #label names
                  switch = "x") + #facet label on bottom
      theme(axis.ticks = element_blank(), #removes x tick labels
            axis.text.x = element_blank(), #removes x tick labels
            #axis.line.x=element_blank(), #turns off x axis line
            axis.line = element_line(size = .2)) #adds faint line to axis
    
    
        
#Quick look at color significance
#         
#   cdoff <- lmer(DOFF ~ Treatment + Color + (1 | Color:Genotype) + 
#                   (1 | Color:Genotype:Treatment), data = mgdat)
#   anova(cdoff)
#   rand(cdoff)
#   
#   csumf <- lmer(SumFlowers ~ Treatment + Color + (1 | Color:Genotype) + 
#                   (1 | Color:Genotype:Treatment), data = mgdat)
#   anova(csumf)
#   rand(csumf)
#   
#   clsum <- lmer(LeafSum34 ~ Treatment + Color + (1 | Color:Genotype) + 
#                   (1 | Color:Genotype:Treatment), data = mgdat)
#   anova(clsum)
#   rand(clsum)
#   
#   chrgr <- lmer(HeightRGRC ~ Treatment + Color + (1 | Color:Genotype) + 
#                   (1 | Color:Genotype:Treatment), data = mgdat)
#   anova(chrgr)
#   rand(chrgr)