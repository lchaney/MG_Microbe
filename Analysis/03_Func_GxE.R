#==============================================================================================#
# Script created by Lindsay Chaney 2019 - lindsay.chaney@snow.edu
# Script created in version R 3.6.1
# This script is used to LOAD data and packages needed for 
# Chaney & Buacom 2019 "The soil microbial community alters patterns of 
#selection on flowering time and fitness related traits in Ipomoea purpurea"
#==============================================================================================#

#differences in trait by genotype (maternal line), treatment, and interaction

  #DOFF -- Day of first flower / Phenology
    fit1 <- lmer(I(DOFF^2) ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit1)
#       rand(fit1)

    
  #SumFlowers -- Total Number of Flowers
    fit4 <- lmer(SumFlowers ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit4)
#       rand(fit4)
#       summary(glht(fit4, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
#         cld(glht(fit4, linfct = mcp(Treatment = "Tukey"))) #letters

 
  #LeafSum34 -- Sum of Leaf Lengths *LATE*
    fit7 <- lmer(LeafSum34 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit7)
#       rand(fit7)
#       summary(glht(fit7, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
#         cld(glht(fit7, linfct = mcp(Treatment = "Tukey"))) #letters
 
       
  #HeightRGRC -- RGR for height *Late - Early*
    fit37 <- lmer(HeightRGRC ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit37)
#       rand(fit37)
#       summary(glht(fit37, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
#         cld(glht(fit37, linfct = mcp(Treatment = "Tukey"))) #letters

    
#summarrize each trait value in each treatment
      
    std <- function(x) sd(x)/sqrt(length(x)) #standard error of the mean
        
    trait_summary <- mgdat %>% #data input
        group_by(Treatment) %>% #group data by treatment
        dplyr::select(one_of(samplevars)) %>% #specify what variables to look at (dplyr's select() will get masked by the MASS package so need to specify package) )
        summarise_each(funs(mean, std)) %>% #what functions to summarise by
        gather(variable, value, -Treatment) %>% #do not gather by treatment
        separate(variable, c("var", "stat"), sep = "\\_") %>% #seperate varibable name and stat
        spread(var, value) #spread data by variable name along top

#==============================================================================================#
    
source('Analysis/03_Func_GxE_plot.R')
    
#==============================================================================================#