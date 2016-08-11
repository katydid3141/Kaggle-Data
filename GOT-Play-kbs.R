
####### Game of Thrones Data ################

setwd("~/Desktop/School/R Workspace/Kaggle/game-of-thrones")

GOT1 <-read.csv("character-deaths.csv", header = TRUE)

library(plyr)
library(dplyr)
library(lme4)
library(effects)
library(ggplot2)
library(car)

dim(GOT1)
str(GOT1)
View(GOT1)

## Cleaning it up
summary(GOT1$Allegiances)

GOT1$Gender<-recode(GOT1$Gender, c("1='M'; 0='F'"))
GOT1$Gender<-as.factor(GOT1$Gender)

summary(GOT1$Gender)

GOT1$Allegiances[GOT1$Allegiances=="House Baratheon"] <- "Baratheon"
GOT1$Allegiances[GOT1$Allegiances=="House Arryn"] <- "Arryn"
GOT1$Allegiances[GOT1$Allegiances=="House Greyjoy"] <- "Greyjoy"
GOT1$Allegiances[GOT1$Allegiances=="House Lannister"] <- "Lannister"
GOT1$Allegiances[GOT1$Allegiances=="House Martell"] <- "Martell"
GOT1$Allegiances[GOT1$Allegiances=="House Stark"] <- "Stark"
GOT1$Allegiances[GOT1$Allegiances=="House Targaryen"] <- "Targaryen"
GOT1$Allegiances[GOT1$Allegiances=="House Tully"] <- "Tully"
GOT1$Allegiances[GOT1$Allegiances=="House Tyrell"] <- "Tyrell"


GOT1$Alive<-ifelse(is.na(GOT1$Death.Year)==TRUE, 1, 0)
GOT1$Death.Year<-as.numeric(GOT1$Death.Year)

summary(GOT1$Alive)
summary(GOT1$Allegiances)
View(GOT1)

### Exploring ####
aggregate(GOT1$Death.Year ~ GOT1$Allegiances + GOT1$Gender + GOT1$Nobility
          , FUN = mean, na.rm=TRUE)

aggregate(GOT1$Book.of.Death ~ GOT1$Allegiances + GOT1$Gender + GOT1$Nobility
          , FUN = mean, na.rm=TRUE)

aggregate(GOT1$Book.of.Death ~ GOT1$Gender + GOT1$Allegiances, FUN = mean, na.rm = TRUE)


######################

GOTMdl3<-glm(Alive ~ Allegiances, data = GOT1)
summary(GOTMdl3)


y<-.83333
plogis(y)

plogis(y-.20833)
plogis(y-.31609)
plogis(y-.25926)
plogis(y-.40833)

### Fits don't look good here.


GOTMdl4<-glmer(Alive ~ Allegiances + (1|Nobility), family = "binomial", 
               control = glmerControl("bobyqa"), data=GOT1)


summary(GOTMdl4)


GOTMdl5<-glmer(Alive ~ Allegiances + Gender + (1|Nobility), family = "binomial", 
               control = glmerControl("bobyqa"), data=GOT1)

summary(GOTMdl5)
anova(GOTMdl4, GOTMdl5)
summary(GOT1$Gender)
157/760

summary(GOTMdl4)

z<-1.5802
plogis(1.5802)
plogis(z-1.1163) ##Baratheon 60% prob. living
plogis(z-1.4268) ## Night's watch 54% prob. living
plogis(z-1.8316) ## Wildling 43% prob. living
plogis(z-1.3094) ## Stark 57% chance living

### This makes sense!

sum(GOT1$Name)

Dracaris<-table(GOT1$Allegiances, GOT1$Alive)
plot(Dracaris)
barchart(Dracaris)
