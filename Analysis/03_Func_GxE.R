#==============================================================================================#
# Script created by Lindsay Chaney 2015 - lchaney@byu.edu
# Script created in version R 3.2.1 
# This script is used for the Chaney et al 2016 Morning glory microbe paper
# This function examines trait differences by genotype, treatment, and their interacitons
#==============================================================================================#

#differences in trait by genotype (maternal line), treatment, and interaction

  #DOFF -- Day of first flower / Phenology
    fit1 <- lmer(DOFF ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit1)
#       rand(fit1)

     qqnorm(residuals(fit1))
     qqline(residuals(fit1))
      plot(resid(fit1) ~ fitted(fit1),main="residual plot")
      abline(h=0)
      qqnorm(resid(fit1), main="Q-Q plot for residuals")
      qqnorm(ranef(fit1)$Genotype$"(Intercept)", main="Q-Q plot for the random effect" )
      qqnorm(ranef(fit1)$`Genotype:Treatment`$"(Intercept)", main="Q-Q plot for the random effect" )
          
  #SumFlowers -- Total Number of Flowers
    fit4 <- lmer(SumFlowers ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit4)
#       rand(fit4)
#       summary(glht(fit4, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
#         cld(glht(fit4, linfct = mcp(Treatment = "Tukey"))) #letters

    plot(resid(fit4) ~ fitted(fit4),main="residual plot")
    abline(h=0)
    qqnorm(resid(fit4), main="Q-Q plot for residuals")
    qqnorm(ranef(fit4)$Genotype$"(Intercept)", main="Q-Q plot for the random effect" )
    qqnorm(ranef(fit4)$`Genotype:Treatment`$"(Intercept)", main="Q-Q plot for the random effect" )
    
    
  #LeafSum34 -- Sum of Leaf Lengths *LATE*
    fit7 <- lmer(LeafSum34 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit7)
#       rand(fit7)
#       summary(glht(fit7, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
#         cld(glht(fit7, linfct = mcp(Treatment = "Tukey"))) #letters
 
    plot(resid(fit7) ~ fitted(fit7),main="residual plot")
    abline(h=0)
    qqnorm(resid(fit7), main="Q-Q plot for residuals")
    qqnorm(ranef(fit7)$Genotype$"(Intercept)", main="Q-Q plot for the random effect" )
    qqnorm(ranef(fit7)$`Genotype:Treatment`$"(Intercept)", main="Q-Q plot for the random effect" )
    
       
  #HeightRGRC -- RGR for height *Late - Early*
    fit37 <- lmer(HeightRGRC ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
#       anova(fit37)
#       rand(fit37)
#       summary(glht(fit37, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
#         cld(glht(fit37, linfct = mcp(Treatment = "Tukey"))) #letters

    plot(resid(fit37) ~ fitted(fit37),main="residual plot")
    abline(h=0)
    qqnorm(resid(fit37), main="Q-Q plot for residuals")
    qqnorm(ranef(fit37)$Genotype$"(Intercept)", main="Q-Q plot for the random effect" )
    qqnorm(ranef(fit37)$`Genotype:Treatment`$"(Intercept)", main="Q-Q plot for the random effect" )
    
    
#summarrize each trait value in each treatment
      
    std <- function(x) sd(x)/sqrt(length(x)) #standard error of the mean
        
    trait_summary <- mgdat %>% #data input
        group_by(Treatment) %>% #group data by treatment
        select(one_of(samplevars)) %>% #specify what variables to look at
        summarise_each(funs(mean, std)) %>% #what functions to summarise by
        gather(variable, value, -Treatment) %>% #do not gather by treatment
        separate(variable, c("var", "stat"), sep = "\\_") %>% #seperate varibable name and stat
        spread(var, value) #spread data by variable name along top

#==============================================================================================#
    
source('Analysis/03_Func_GxE_plot.R')
    
#==============================================================================================#