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
        select(one_of(samplevars)) %>% #specify what variables to look at
        summarise_each(funs(mean, std)) %>% #what functions to summarise by
        gather(variable, value, -Treatment) %>% #do not gather by treatment
        separate(variable, c("var", "stat"), sep = "\\_") %>% #seperate varibable name and stat
        spread(var, value) #spread data by variable name along top

    

source('Analysis/03_Func_GxE_plot.R')
    
        
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