# Kaggle-Data
Data analysis with public data from Kaggle (not in competition)


This repository is where you will find my work with the public data sets, Game of Thrones, found on Kaggle, but not part of their competition.


For this analysis, I used the character deaths data set. I was interested in predicting deaths based on their house allegiances.

First, I had to clean the data and add a new column, Alive, to indicate whether a character was dead (0) or alive (1).
I used this binomial outcome to set up a generalized linear model. However, those fits didn't seem ideal, so I next used a mixed effects model with Allegiances as my fixed factor and nobility as a random effect. These probabilities made more sense and better fit the data. I did add Gender to investigate that, but because of the highly skewed male population in Westeros (80% male), it did not improve my explanatory power. 

Therefore, the final model is simply allegiances and nobility. The intercepts are transformed to probabilities using the plogis function, and I only transformed the House Allegiances that were noted to be significant (based on the reported p-values). To summarize the findings, you don't want to be associated with Wildlings in Westeros - there is a 43% chance you will live, or 57% chance you will die. The next worse allegiance is Night's Watch (46% chance of death), then the Starks (43% chance of death), and finally Baratheon (40% chance of death). 
