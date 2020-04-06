##############################################
#Install packages commands 
install.packages("tidyverse")
install.packages("quantreg")
install.packages("gridExtra")
install.packages("ggpubr")

install.packages("hrbrthemes")
install.packages("viridis")

library(tidyverse)
library(hrbrthemes)
library(viridis)

library(ggplot2)
library(cowplot)
library(ggpubr)

library(dplyr)
library(tidyr)
library(scales)  # for percentage scales
###############################################
###############################################

getwd()

###############################################

###############################################
#Reading commands
###############################################
df_1 <- read.table("optimist.csv", sep = ",", fill = TRUE, header = TRUE)
df_2 <- read.table("pesimist.csv", sep = ",", fill = TRUE, header = TRUE)
df_0 <- read.table("all.csv", sep = ",", fill = TRUE, header = TRUE)


df_1 <- df_1[!(df_1$step == 0) ,]
df_2 <- df_2[!(df_2$step == 0) ,]
df_0 <- df_0[!(df_0$step == 0) ,]

data_optimist <- df_1[(df_1$step == 32),]
data_pesimist <- df_2[(df_2$step == 32),]
data_all <- df_0[(df_0$step == 32),]

data_optimist_join <- data_optimist[!(data_optimist$first_join_year_new == 10000),]
data_pesimist_join <- data_pesimist[!(data_pesimist$first_join_year_new == 10000),]
data_all_join <- data_all[!(data_all$first_join_year_new == 10000),]

data_optimist_convert <- data_optimist[!(data_optimist$first_convert_year_industries == 10000),]
data_pesimist_convert <- data_pesimist[!(data_pesimist$first_convert_year_industries == 10000),]
data_all_convert <- data_all[!(data_all$first_convert_year_industries == 10000),]

data_optimist_notjoin <- data_optimist[(data_optimist$first_join_year_new == 10000),]
data_pesimist_notjoin <- data_pesimist[(data_pesimist$first_join_year_new == 10000),]
data_all_notjoin <- data_all[(data_all$first_join_year_new == 10000),]

data_optimist_notconvert <- data_optimist[(data_optimist$first_convert_year_industries == 10000),]
data_pesimist_notconvert <- data_pesimist[(data_pesimist$first_convert_year_industries == 10000),]
data_all_notconvert <- data_all[(data_all$first_convert_year_industries == 10000),]

data_optimist_notjoin_lowprice <- data_optimist_notjoin[(data_optimist_notjoin$advanced_prices_increase == -5),]
data_pesimist_notjoin_lowprice <- data_pesimist_notjoin[(data_pesimist_notjoin$advanced_prices_increase == -5),]

data_optimist_notjoin_highprice <- data_optimist_notjoin[(data_optimist_notjoin$advanced_prices_increase == 5),]
data_pesimist_notjoin_highprice <- data_pesimist_notjoin[(data_pesimist_notjoin$advanced_prices_increase == 5),]

data_best <- data_optimist[(data_optimist$advanced_prices_increase == 5),]
data_worst <- data_pesimist[(data_pesimist$advanced_prices_increase == -5),]

data_mid1 <- data_best[(data_best$advanced_feedstock_prices_increase == 5),]
data_mid2 <- data_worst[(data_worst$advanced_feedstock_prices_increase == -5),]

data_best <- data_best[(data_best$advanced_feedstock_prices_increase == -5),]
data_worst <- data_worst[(data_worst$advanced_feedstock_prices_increase == 5),]

data_best_join <- data_best[(data_best$first_join_year_new == 10000),]
data_worst_join <- data_worst[(data_worst$first_join_year_new == 10000),]

data_best_join03 <- data_best[(data_best$join_pora_percent == 3),]
data_worst_join03 <- data_worst[(data_worst$join_pora_percent == 3),]

data_best_join10 <- data_best[(data_best$join_pora_percent == 10),]
data_worst_join10 <- data_worst[(data_worst$join_pora_percent == 10),]

data_best_join03_area50 <- data_best_join03[(data_best_join03$area_advanced == 50),]
data_worst_join03_area50 <- data_worst_join03[(data_worst_join03$area_advanced == 50),]

data_best_join10_area50 <- data_best_join10[(data_best_join10$area_advanced == 50),]
data_worst_join10_area50 <- data_worst_join10[(data_worst_join10$area_advanced == 50),]

data_best_area50 <- data_best[(data_best$area_advanced == 50),]
data_worst_area50 <- data_worst[(data_worst$area_advanced == 50),]
data_mid1_area50 <- data_mid1[(data_mid1$area_advanced == 50),]
data_mid2_area50 <- data_mid2[(data_mid2$area_advanced == 50),]

########################################################################
## map data to ggplot and save graph
########################################################################

## 8.1 
#######################################################################
##The prospect of advanced biofuel in the Netherlands with European market
## View 1
all_advanced_density <- ggplot(data =  data_all, aes(x= sum_new_advanced)) +
  geom_density(aes(fill=factor(feedstock_price), color=factor(feedstock_price)), alpha=0.1)+
  labs(title ="Density of New Advanced Biofuel", x = "New Advanced Biofuel in Europe", y = "Density")
ggsave("8.1 Overall Density.png", all_advanced_density, width=15, height=10)

## View 2
all_advanced_optimist <- ggplot(data =  data_optimist, aes(x= sum_new_advanced)) +
  stat_bin(breaks=seq(90,100,1), fill="blue", color="blue", alpha=0.5) +
 labs(title ="Low feedstock price", x = "Advanced biofuel companies", y = "Count")

all_advanced_pesimist <- ggplot(data =  data_pesimist, aes(x= sum_new_advanced)) +
  stat_bin(breaks=seq(90,100,1), fill="tomato", color="tomato", alpha=0.5) +
  labs(title ="High feedstock price", x = "Advanced biofuel companies", y = "Count")

plot_grid(all_advanced_optimist,all_advanced_pesimist,align="v")
ggsave("8.1 Overall histogram.png", width=20, height=10)

## View 3
##The effects of area vs subsidy per ton
optimist1 <- ggplot(data =  data_optimist_join, aes(x = sum_new_advanced, y = market_new_advanced_production)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_feedstock_prices_increase))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price with advanced feedstock price increase", x = "Number of factory", y = "Biofuel productions")

pesimist1 <- ggplot(data =  data_pesimist_join, aes(x = sum_new_advanced, y = market_new_advanced_production)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_feedstock_prices_increase))) + 
  # geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price with advanced feedstock price increase", x = "Number of factory", y = "Biofuel productions")

optimist2 <- ggplot(data =  data_optimist_join, aes(x = sum_new_advanced, y = market_new_advanced_production)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_prices_increase))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price with advanced biofuel price increase", x = "Number of factory", y = "Biofuel productions")

pesimist2 <- ggplot(data =  data_pesimist_join, aes(x = sum_new_advanced, y = market_new_advanced_production)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_prices_increase))) + 
  # geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price with advanced biofuel price increase", x = "Number of factory", y = "Biofuel productions")

plot_grid(optimist1,pesimist1, optimist2, pesimist2, align="v")
ggsave("8.1 companies and productions.png", width=20, height=20)



## 8.2 
#######################################################################
##The prospect of advanced biofuel in the Port of Rotterdam
## View 4
por_advanced_density <- ggplot(data =  data_all, aes(x= sum_new_advanced_por)) +
  geom_density(aes(fill=factor(feedstock_price), color=factor(feedstock_price)), alpha=0.5)+
  labs(title ="Density of New Advanced Biofuel", x = "New Advanced Biofuel in Port of Rotterdam", y = "Density")
ggsave("8.2 PoR Advanced Density.png", por_advanced_density, width=15, height=10)

## View 5
por_advanced_optimist <- ggplot(data =  data_optimist, aes(x= sum_new_advanced_por)) +
  stat_bin(breaks=seq(-1,30,1), fill="blue", color="blue", alpha=0.5) +
  labs(title ="Low feedstock price", x = "Advanced biofuel companies", y = "Count")

por_advanced_pesimist <- ggplot(data =  data_pesimist, aes(x= sum_new_advanced_por)) +
  stat_bin(breaks=seq(-1,30,1), fill="tomato", color="tomato", alpha=0.5) +
  labs(title ="High feedstock price", x = "Advanced biofuel companies", y = "Count")

plot_grid(por_advanced_optimist,por_advanced_pesimist,align="v")
ggsave("8.2 por histogram.png", width=20, height=10)

por_advanced_optimist_year <- ggplot(data =  data_optimist_join, aes(x= sum_new_advanced_por)) +
  stat_bin(breaks=seq(0,30,1), aes(fill=factor (first_join_year_new), color=factor (first_join_year_new)), alpha=0.9) +
  labs(title ="Low feedstock price", x = "Advanced biofuel companies", y = "Count")

por_advanced_pesimist_year <- ggplot(data =  data_pesimist_join, aes(x= sum_new_advanced_por)) +
  stat_bin(breaks=seq(0,30,1), aes(fill=factor (first_join_year_new), color=factor (first_join_year_new)), alpha=0.9) +
  labs(title ="High feedstock price", x = "Advanced biofuel companies", y = "Count")

plot_grid(por_advanced_optimist_year,por_advanced_pesimist_year,align="v")
ggsave("8.2 por histogram year.png", width=20, height=10)

## View 6
##The effects of area vs subsidy per ton
optimist1 <- ggplot(data =  data_optimist, aes(x = sum_new_advanced_por, y = por_advanced_production_new)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_feedstock_prices_increase))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price with advanced feedstock price increase", x = "Number of factory", y = "Biofuel productions")

pesimist1 <- ggplot(data =  data_pesimist, aes(x = sum_new_advanced_por, y = por_advanced_production_new)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_feedstock_prices_increase))) + 
  # geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price with advanced feedstock price increase", x = "Number of factory", y = "Biofuel productions")

optimist2 <- ggplot(data =  data_optimist, aes(x = sum_new_advanced_por, y = por_advanced_production_new)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_prices_increase))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price with advanced biofuel price increase", x = "Number of factory", y = "Biofuel productions")

pesimist2 <- ggplot(data =  data_pesimist, aes(x = sum_new_advanced_por, y = por_advanced_production_new)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_prices_increase))) + 
  # geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price with advanced biofuel price increase", x = "Number of factory", y = "Biofuel productions")

plot_grid(optimist1,pesimist1, optimist2, pesimist2, align="v")
ggsave("8.2 companies and productions por.png", width=20, height=20)

## 8.3 
#######################################################################

##The prospect of advanced biofuel in the Port of Rotterdam (for incumbent)
## View 7
por_converted_density <- ggplot(data =  data_all, aes(x= sum_converted_industries)) +
  geom_density(aes(fill=factor(feedstock_price), color=factor(feedstock_price)), alpha=0.5)+
  labs(title ="Density of Converted Advanced Biofuel", x = "New Advanced Biofuel in Port of Rotterdam", y = "Density")
ggsave("8.3 PoR Converted Advanced Density.png", por_converted_density, width=15, height=10)

## View 8
por_converted_optimist <- ggplot(data =  data_optimist, aes(x= sum_converted_industries)) +
  stat_bin(breaks=seq(-1,4,1), fill="blue", color="blue", alpha=0.5) +
  labs(title ="Low feedstock price", x = "Converted advanced biofuel companies", y = "Count")

por_converted_pesimist <- ggplot(data =  data_pesimist, aes(x= sum_converted_industries)) +
  stat_bin(breaks=seq(-1,4,1), fill="tomato", color="tomato", alpha=0.5) +
  labs(title ="High feedstock price", x = "Converted advanced biofuel companies", y = "Count")

plot_grid(por_converted_optimist,por_converted_pesimist,align="v")
ggsave("8.3 por converted histogram.png", width=20, height=10)

por_converted_optimist_year <- ggplot(data =  data_optimist_convert, aes(x= sum_converted_industries)) +
  stat_bin(breaks=seq(0,4,1), aes(fill= factor (first_convert_year_industries), color=factor (first_convert_year_industries)), alpha=0.9) +
  labs(title ="Low feedstock price", x = "Converted advanced biofuel companies", y = "Count")

por_converted_pesimist_year <- ggplot(data =  data_pesimist_convert, aes(x= sum_converted_industries)) +
  stat_bin(breaks=seq(0,4,1), aes(fill= factor (first_convert_year_industries), color=factor (first_convert_year_industries)), alpha=0.9) +
  labs(title ="High feedstock price", x = "Converted advanced biofuel companies", y = "Count")

plot_grid(por_converted_optimist_year,por_converted_pesimist_year,align="v")
ggsave("8.3 por converted histogram year.png", width=20, height=10)

## View 9
## 
optimist1 <- ggplot(data =  data_optimist, aes(x = sum_converted_industries, y = por_advanced_production_industries)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_feedstock_prices_increase))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price with advanced feedstock price increase", x = "Number of factory", y = "Biofuel productions")

pesimist1 <- ggplot(data =  data_pesimist, aes(x = sum_converted_industries, y = por_advanced_production_industries)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_feedstock_prices_increase))) + 
  # geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price with advanced feedstock price increase", x = "Number of factory", y = "Biofuel productions")

optimist2 <- ggplot(data =  data_optimist, aes(x = sum_converted_industries, y = por_advanced_production_industries)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_prices_increase))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price with advanced biofuel price increase", x = "Number of factory", y = "Biofuel productions")

pesimist2 <- ggplot(data =  data_pesimist, aes(x = sum_converted_industries, y = por_advanced_production_industries)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (advanced_prices_increase))) + 
  # geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price with advanced biofuel price increase", x = "Number of factory", y = "Biofuel productions")

plot_grid(optimist1,pesimist1, optimist2, pesimist2, align="v")
ggsave("8.3 converted companies and productions in por.png", width=20, height=20)


## 8.4 
#######################################################################
## View 10
##The effects of area
area_advanced_optimist <- ggplot(data =  data_optimist, aes(x= sum_new_advanced_por)) +
  stat_bin(breaks=seq(-1,30,1), aes(fill= factor (area_advanced), color=factor (area_advanced)), alpha=0.5) +
  labs(title ="Low feedstock price", x = "Advanced biofuel companies", y = "Count")

area_advanced_pesimist <- ggplot(data =  data_pesimist, aes(x= sum_new_advanced_por)) +
  stat_bin(breaks=seq(-1,30,1), aes(fill= factor (area_advanced), color=factor (area_advanced)), alpha=0.5) +
  labs(title ="High feedstock price", x = "Advanced biofuel companies", y = "Count")

plot_grid(area_advanced_optimist,area_advanced_pesimist,align="v")
ggsave("8.4 area histogram.png", width=20, height=10)

## View 11
##The effects of area vs first year 
optimist1 <- ggplot(data =  data_optimist_join, aes(x = first_join_year_new, y = sum_new_advanced_por)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (area_advanced))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price with advanced feedstock price increase", x = "First year joining the facility", y = "Number of factory")

pesimist1 <- ggplot(data =  data_pesimist_join, aes(x = first_join_year_new, y = sum_new_advanced_por)) + 
  geom_jitter(alpha = 0.1, aes (color = factor (area_advanced))) + 
  # geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price with advanced feedstock price increase", x = "First year joining the facility", y = "Number of factory")

plot_grid(optimist1,pesimist1, align="v")
ggsave("8.4  companies and first join in por.png", width=20, height=10)

## View 12
##The effects of different condition
optimist1 <- ggplot(data =  data_optimist_notjoin_lowprice, aes(x= area_advanced)) +
  stat_bin(breaks=seq(0,300,100), aes(fill= factor (advanced_feedstock_prices_increase), color=factor (advanced_feedstock_prices_increase)), alpha=0.3) +
  labs(title ="Low feedstock price and low selling price", x = "Area needed for advanced biofuel", y = "Count")

pesimist1 <- ggplot(data =  data_pesimist_notjoin_lowprice, aes(x= area_advanced)) +
  stat_bin(breaks=seq(0,300,100), aes(fill= factor (advanced_feedstock_prices_increase), color=factor (advanced_feedstock_prices_increase)), alpha=0.3) +
  labs(title ="High feedstock price and low selling price", x = "Area needed for advanced biofuel", y = "Count")

optimist2 <- ggplot(data =  data_optimist_notjoin_highprice, aes(x= area_advanced)) +
  stat_bin(breaks=seq(0,300,100), aes(fill= factor (advanced_feedstock_prices_increase), color=factor (advanced_feedstock_prices_increase)), alpha=0.3) +
  labs(title ="Low feedstock price and high selling price", x = "Area needed for advanced biofuel", y = "Count")

pesimist2 <- ggplot(data =  data_pesimist_notjoin_highprice, aes(x= area_advanced)) +
  stat_bin(breaks=seq(0,300,100), aes(fill= factor (advanced_feedstock_prices_increase), color=factor (advanced_feedstock_prices_increase)), alpha=0.3) +
  labs(title ="High feedstock price and high selling price", x = "Area needed for advanced biofuel", y = "Count")

plot_grid(optimist1,pesimist1, optimist2, pesimist2, align="v")
ggsave("8.4 area different scenarios in por.png", width=20, height=20)

#8.5 Effects of joining PoR probability
#######################################################################
## View 13
##
optimist1 <- ggplot(data = data_best_area50, aes(x = join_pora_percent, y = sum_new_advanced_por, group = factor (join_pora_percent))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (first_join_year_new))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "Probability joining PoR", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = join_pora_percent, y = sum_new_advanced_por, group = factor (join_pora_percent))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (first_join_year_new))) + 
   geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "Probability joining PoR", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = join_pora_percent, y = sum_new_advanced_por, group = factor (join_pora_percent))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (first_join_year_new))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "Probability joining PoR", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = join_pora_percent, y = sum_new_advanced_por, group = factor (join_pora_percent))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (first_join_year_new))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "Probability joining PoR", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.5  join por in best and worst scenarios.png", width=20, height=20)

#8.6 Effects of joining PoR connection reduced risk 
#######################################################################
## View 14
##
optimist1 <- ggplot(data = data_best_area50, aes(x = PoR_connection_reduced_risk, y = sum_new_advanced_por, group = factor (PoR_connection_reduced_risk))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
    geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "PoR connection risk reducing effect", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = PoR_connection_reduced_risk, y = sum_new_advanced_por, group = factor (PoR_connection_reduced_risk))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "PoR connection risk reducing effect", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = PoR_connection_reduced_risk, y = sum_new_advanced_por, group = factor (PoR_connection_reduced_risk))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "PoR connection risk reducing effect", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = PoR_connection_reduced_risk, y = sum_new_advanced_por, group = factor (PoR_connection_reduced_risk))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "PoR connection risk reducing effect", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.6  connection por in best and worst scenarios.png", width=20, height=20)

#8.7 Effects of joining PoR one-time subsidy 
#######################################################################
## View 14
##
optimist1 <- ggplot(data = data_best_area50, aes(x = subsidy_onetime, y = sum_new_advanced_por, group = factor (subsidy_onetime))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "PoR Subsidy one-time", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = subsidy_onetime, y = sum_new_advanced_por, group = factor (subsidy_onetime))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "PoR Subsidy one-time", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = subsidy_onetime, y = sum_new_advanced_por, group = factor (subsidy_onetime))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "PoR Subsidy one-time", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = subsidy_onetime, y = sum_new_advanced_por, group = factor (subsidy_onetime))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "PoR Subsidy one-time", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.7  one-time por in best and worst scenarios.png", width=20, height=20)

#8.8 Effects of joining PoR per-ton subsidy 
#######################################################################
## View 14
##
optimist1 <- ggplot(data = data_best_area50, aes(x = subsidy_perton, y = sum_new_advanced_por, group = factor (subsidy_perton))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "PoR Subsidy per-ton", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = subsidy_perton, y = sum_new_advanced_por, group = factor (subsidy_perton))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "PoR Subsidy per-ton", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = subsidy_perton, y = sum_new_advanced_por, group = factor (subsidy_perton))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "PoR Subsidy per-ton", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = subsidy_perton, y = sum_new_advanced_por, group = factor (subsidy_perton))) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "PoR Subsidy per-ton", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.8  per-ton por in best and worst scenarios.png", width=20, height=20)


#8.9 Effects of joining PoR per-ton subsidy 
#######################################################################
## 
##
optimist1 <- ggplot(data = data_best_area50, aes(x = sum_subsidy_onetime, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "Sum of PoR Subsidy one-time", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = sum_subsidy_onetime, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "Sum of PoR Subsidy one-time", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = sum_subsidy_onetime, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "Sum of PoR Subsidy one-time", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = sum_subsidy_onetime, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "Sum of PoR Subsidy one-time", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.9  one-time por budget in best and worst scenarios.png", width=20, height=20)

## View 18
##
optimist1 <- ggplot(data = data_best_area50, aes(x = sum_subsidy_perton, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "Sum of PoR Subsidy per-ton", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = sum_subsidy_perton, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "Sum of PoR Subsidy per-ton", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = sum_subsidy_perton, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "Sum of PoR Subsidy per-ton", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = sum_subsidy_perton, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "Sum of PoR Subsidy per-ton", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.9  per-ton por budget in best and worst scenarios.png", width=20, height=20)


## View 19
##
optimist1 <- ggplot(data = data_best_area50, aes(x = por_subsidy_budget, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "Sum of PoR Subsidy", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = por_subsidy_budget, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "Sum of PoR Subsidy", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = por_subsidy_budget, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "Sum of PoR Subsidy", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = por_subsidy_budget, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "Sum of PoR Subsidy", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.9  por budget in best and worst scenarios.png", width=20, height=20)

####################################################################### FIN #######################################################################

#8.9 Effects of joining PoR per-ton subsidy 
#######################################################################
## 
##
optimist1 <- ggplot(data = data_best_area50, aes(x = sum_subsidy_onetime, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "Sum of PoR Subsidy one-time", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = sum_subsidy_onetime, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "Sum of PoR Subsidy one-time", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = sum_subsidy_onetime, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "Sum of PoR Subsidy one-time", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = sum_subsidy_onetime, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "Sum of PoR Subsidy one-time", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.9  one-time por budget in best and worst scenarios2.png", width=20, height=20)

## View 18
##
optimist1 <- ggplot(data = data_best_area50, aes(x = sum_subsidy_perton, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "Sum of PoR Subsidy per-ton", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = sum_subsidy_perton, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "Sum of PoR Subsidy per-ton", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = sum_subsidy_perton, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "Sum of PoR Subsidy per-ton", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = sum_subsidy_perton, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "Sum of PoR Subsidy per-ton", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.9  per-ton por budget in best and worst scenarios2.png", width=20, height=20)


## View 19
##
optimist1 <- ggplot(data = data_best_area50, aes(x = por_subsidy_budget, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price decrease, and advanced biofuel price increase", x = "Sum of PoR Subsidy", y = "Number of factory")

pesimist1 <- ggplot(data = data_worst_area50, aes(x = por_subsidy_budget, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price increase, and advanced biofuel price decrease", x = "Sum of PoR Subsidy", y = "Number of factory")

optimist2 <- ggplot(data = data_mid1_area50, aes(x = por_subsidy_budget, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0) +
  labs(title ="Low feedstock price, advanced feedstock price increase, and advanced biofuel price increase", x = "Sum of PoR Subsidy", y = "Number of factory")

pesimist2 <- ggplot(data = data_mid2_area50, aes(x = por_subsidy_budget, y = sum_new_advanced_por, group = 16)) + 
  geom_jitter(alpha = 0.3, aes (color = factor (join_pora_percent))) + 
  #geom_boxplot(alpha = 0)+
  labs(title ="High feedstock price advanced feedstock price decrease, and advanced biofuel price decrease", x = "Sum of PoR Subsidy", y = "Number of factory")


plot_grid(optimist1,pesimist1,optimist2,pesimist2, align="v")
ggsave("8.9  por budget in best and worst scenarios2.png", width=20, height=20)
