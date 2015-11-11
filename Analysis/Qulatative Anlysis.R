#load data
mgdat <- read.csv("Data/mg_ghsoil.csv")


#load packages
library(dplyr) #data management
library(ggplot2) #plotting
library(lme4) #mixed model
library(lmerTest) #test for significance
library(multcomp) #allows multiple comparison tests for lmer

#clean data
mgdat <- mgdat %>% mutate_each(funs(factor), Genotype, Treatment, Replicate)

#create new RGR variables -- these ones are weird
mgdat <- mgdat %>% mutate(LeafSumRGRA = (LeafSum26 - LeafSum14)/12,
                       LeafSumRGRB = (LeafSum34 - LeafSum26)/8,
                       LeafSumRGRC = (LeafSum34 - LeafSum14)/20,
                       LeafNumRGRA = (LeafNum26 - LeafNum14)/12,
                       LeafNumRGRB = (LeafNum34 - LeafNum26)/8,
                       LeafNumRGRC = (LeafNum34 - LeafNum14)/20,
                       HeightRGRA = (Height26 - Height14)/12,
                       HeightRGRB = (Height34 - Height26)/8,
                       HeightRGRC = (Height34 - Height14)/20
                       )

#explore data
tbl_df(mgdat)
glimpse(mgdat)

summary(mgdat)
unique(mgdat$Genotype)

with(mgdat, table(Genotype, Treatment))

#flower color genotype by phenotype
with(mgdat, table(ColorbyPhenotype, ColorbyGenotype))

#new variable that is just simply color - no dark or lights, etc (Pink, Purple, White)
#WHAT COLOR DO I USE?

#explore flowering
mgdat %>% group_by(Treatment, Color) %>% summarise_each(funs(mean), DOFF, DurationFlowering, SumFlowers)

ggplot(data = mgdat, aes(x = Treatment, y = SumFlowers, fill = Color, color = Color)) + 
  geom_boxplot() +
  scale_color_manual(values = c("red", "purple", "black")) +
  scale_fill_manual(values = c("pink", "thistle", "white")) +
  theme_bw()

#differences in trait by genotype (maternal line), treatment, and interaction
  #DOFF -- Day of first flower / Phenology
    fit1 <- lmer(DOFF ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit1)
      rand(fit1)
    #Sig G
      
  #DOLF -- Day of last flower
    fit2 <- lmer(DOLF ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit2)
      rand(fit2)
    #sig G
      
  #DurationFlowering -- Length of flowering
    fit3 <- lmer(DurationFlowering ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit3)
      rand(fit3)
    #sig G
      
  #SumFlowers -- Total Number of Flowers
    fit4 <- lmer(SumFlowers ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit4)
      rand(fit4)
      summary(glht(fit4, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), SumFlowers)
    ggplot(data = mgdat, aes(x = Treatment, y = SumFlowers)) + geom_boxplot()
    #sig G, sig E

  #LeafSum14 -- Sum of Leaf Lengths *EARLY*
    fit5 <- lmer(LeafSum14 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit5)
      rand(fit5)
      summary(glht(fit5, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafSum14)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafSum14)) + geom_boxplot()
    #sig G, sig E

  #LeafSum26 -- Sum of Leaf Lengths *MID*
    fit6 <- lmer(LeafSum26 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit6)
      rand(fit6)
      summary(glht(fit6, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafSum26)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafSum26)) + geom_boxplot()
    #sig E, near sig GxE

  #LeafSum34 -- Sum of Leaf Lengths *LATE*
    fit7 <- lmer(LeafSum34 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit7)
      rand(fit7)
      summary(glht(fit7, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafSum34)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafSum34)) + geom_boxplot()
    #sig E, near sig GxE
    
  #LeafSumRGR1 -- Sum of Leaf Lengths Relative Growth Rate *EARLY*
    fit8 <- lmer(LeafSumRGR1 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit8)
      rand(fit8)
      summary(glht(fit8, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafSumRGR1)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafSumRGR1)) + geom_boxplot()
    #sig G, sig E
    
  #LeafSumRGR2 -- Sum of Leaf Lengths Relative Growth Rate *LATE*
    fit9 <- lmer(LeafSumRGR2 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit9)
      rand(fit9)
    #no SIG
      
  #LeafNum14 -- Number of Leaves *EARLY*
    fit10 <- lmer(LeafNum14 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit10)
      rand(fit10)
      summary(glht(fit10, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafNum14)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafNum14)) + geom_boxplot()
    #sig G, sig E
  
  #LeafNum26 -- Number of Leaves *MID*
    fit11 <- lmer(LeafNum26 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit11)
      rand(fit11)
      summary(glht(fit11, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafNum26)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafNum26)) + geom_boxplot()
    #sig G, sig E, sig GxE

  #LeafNum34 -- Number of Leaves *LATE*
    fit12 <- lmer(LeafNum34 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit12)
      rand(fit12)
      summary(glht(fit12, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafNum34)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafNum34)) + geom_boxplot()
    #sig G, sig E

   #LeafNumRGR1 -- Number of Leaves Relative Growth Rate *EARLY*
    fit13 <- lmer(LeafNumRGR1 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit13)
      rand(fit13)
      summary(glht(fit13, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafNumRGR1)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafNumRGR1)) + geom_boxplot()
    #sig G, sig E
    
  #LeafNumRGR2 -- Number of Leaves Relative Growth Rate *LATE*
    fit14 <- lmer(LeafNumRGR2 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit14)
      rand(fit14)
    #no SIG
      
  #Height14 -- Height *EARLY*
    fit15 <- lmer(Height14 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit15)
      rand(fit15)
      summary(glht(fit15, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), Height14)
    ggplot(data = mgdat, aes(x = Treatment, y = Height14)) + geom_boxplot()
    #sig G, sig E
    
  #Height26 -- Height *MID*
    fit16 <- lmer(Height26 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit16)
      rand(fit16)
      summary(glht(fit16, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), Height26)
    ggplot(data = mgdat, aes(x = Treatment, y = Height26)) + geom_boxplot()
    #sig E, near sig G, near sig GxE
  
  #Height34 -- Height *LATE*
    fit17 <- lmer(Height34 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit17)
      rand(fit17)
      summary(glht(fit17, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), Height34)
    ggplot(data = mgdat, aes(x = Treatment, y = Height34)) + geom_boxplot()
    #sig E
    
  #HeightRGR1 -- Height Relative Growth Rate *EARLY*
    fit18 <- lmer(HeightRGR1 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit18)
      rand(fit18)
      summary(glht(fit18, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), HeightRGR1)
    ggplot(data = mgdat, aes(x = Treatment, y = HeightRGR1)) + geom_boxplot()
    #sig E
    
  #HeightRGR2 -- Height Relative Growth Rate *EARLY*
    fit19 <- lmer(HeightRGR2 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit19)
      rand(fit19)
      summary(glht(fit19, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), HeightRGR2)
    ggplot(data = mgdat, aes(x = Treatment, y = HeightRGR2)) + geom_boxplot()
    #sig E
    
#DAMAGE
  #Yellow_Dam1 -- Yellow Damage *EARLY*
    fit20 <- lmer(Yellow_Dam1 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit20)
      rand(fit20)
    #sig G -- error messages due to many NA's
      
  #Brown_Dam1 -- Brown Damage *EARLY*
    fit21 <- lmer(Brown_Dam1 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit21)
      rand(fit21)
    #sig G, sig GxE -- error messages due to many NA's

  #NoDam_Dam1 -- Leaves with No Damage *EARLY*
    fit22 <- lmer(NoDam_Dam1 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit22)
      rand(fit22)
    #sig G -- error messages due to many NA's
      
  #PerYellow_Dam1 -- Percentage of leaves with yellow damage *EARLY*
    fit23 <- lmer(PerYellow_Dam1 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit23)
      rand(fit23)
    #sig G, near sig E
      
  #PerBrown_Dam1 -- Percentage of leaves with brown damage *EARLY*
    fit24 <- lmer(PerBrown_Dam1 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit24)
      rand(fit24)
    #no sig
      
  #NumleavesYellow_Dam2 -- Number of leaves with yellow damage *LATE*
    fit25 <- lmer(NumleavesYellow_Dam2 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit25)
      rand(fit25)
      #no sig
      
  #NumleavesspottyYellow_Dam2 -- Number of leaves with spotty yellow damage *LATE*
    fit26 <- lmer(NumleavesspottyYellow_Dam2 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit26)
      rand(fit26)
    #sig E, near sig G
      
  #NumleavesGreen_Dam2 -- Number of leaves with no damage *LATE*
    fit27 <- lmer(NumleavesGreen_Dam2 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit27)
      rand(fit27)
    #no sig
      
  #Numleaves_Dam2 -- Number of leaves *LATE*
    fit28 <- lmer(Numleaves_Dam2 ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit28)
      rand(fit28)
    #no sig
      
#new RGR
  #LeafSumRGRA -- RGR for sum of leaf lengths *Mid - Early*
    fit29 <- lmer(LeafSumRGRA ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit29)
      rand(fit29)
      summary(glht(fit29, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafSumRGRA)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafSumRGRA)) + geom_boxplot()
    #sig E
    
  #LeafSumRGRB -- RGR for sum of leaf lengths *Late - Mid*
    fit30 <- lmer(LeafSumRGRB ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit30)
      rand(fit30)
      summary(glht(fit30, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafSumRGRB)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafSumRGRA)) + geom_boxplot()
    #sig E, sig G
  
  #LeafSumRGRC -- RGR for sum of leaf lengths *Late - Early*
    fit31 <- lmer(LeafSumRGRC ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit31)
      rand(fit31)
      summary(glht(fit31, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafSumRGRC)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafSumRGRC)) + geom_boxplot()
    #sig E, sig G
    
  #LeafNumRGRA -- RGR for number of leaves *Mid - Early*
    fit32 <- lmer(LeafNumRGRA ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit32)
      rand(fit32)
      summary(glht(fit29, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafNumRGRA)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafNumRGRA)) + geom_boxplot()
    #sig E, sig G
    
  #LeafNumRGRB -- RGR for number of leaves *Late - Mid*
    fit33 <- lmer(LeafNumRGRB ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit33)
      rand(fit33)
      summary(glht(fit33, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafNumRGRB)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafSumRGRA)) + geom_boxplot()
    #sig E, sig G
    
  #LeafNumRGRC -- RGR for number of leaves *Late - Early*
    fit34 <- lmer(LeafNumRGRC ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit34)
      rand(fit34)
      summary(glht(fit34, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), LeafNumRGRC)
    ggplot(data = mgdat, aes(x = Treatment, y = LeafNumRGRC)) + geom_boxplot()
    #sig E, sig G
    
  #HeightRGRA -- RGR for height *Mid - Early*
    fit35 <- lmer(HeightRGRA ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit35)
      rand(fit35)
      summary(glht(fit35, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), HeightRGRA)
    ggplot(data = mgdat, aes(x = Treatment, y = HeightRGRA)) + geom_boxplot()
    #sig E, near sig GxE
    
  #HeightRGRB -- RGR for height *Late - Mid*
    fit36 <- lmer(HeightRGRB ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit36)
      rand(fit36)
    #sig G
    
  #HeightRGRC -- RGR for height *Late - Early*
    fit37 <- lmer(HeightRGRC ~ Treatment + (1 | Genotype) + (1 | Genotype:Treatment), data = mgdat)
      anova(fit37)
      rand(fit37)
      summary(glht(fit37, linfct = mcp(Treatment = "Tukey"))) #post hoc Tukey's with MultComp
    mgdat %>% group_by(Treatment) %>% summarise_each(funs(mean), HeightRGRC)
    ggplot(data = mgdat, aes(x = Treatment, y = HeightRGRC)) + geom_boxplot()
    #sig E