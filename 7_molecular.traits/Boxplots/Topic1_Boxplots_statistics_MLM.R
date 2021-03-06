#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#SCRIPT EXPLORATORY ANALYSIS Topic 1: DOM CORE-SAT PAPER (WHONDRS crowdsource)
#AUTHOR: Michaela de Melo
#CONTACT:michaelaldemelo@gmail.com

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
##############################
# Analysis of Core-Sat flags #
##############################
#Load libraries
library(car)
library(ggplot2)
library(vegan)
library(FSA)
library(viridis)
library(ggpubr)

#Path
setwd('C:/Users/micha/OneDrive/Documentos/GitHub/Topic1/4_gather.thresholds')


#Input tables
cross_merge1= read.csv('FTICR_crosstable_rep.merged1_all_em.thres_2022-03-01.csv')
names(cross_merge1)

cross_merge2= read.csv('FTICR_crosstable_rep.merged2_all_em.thres_2022-03-01.csv')
names(cross_merge2)

peaks_merge1= read.csv('FTICR_peaks_crosstable_rep.merged1_all_em.thres_2022-03-01.csv')
names(peaks_merge1)

peaks_merge2= read.csv('FTICR_peaks_crosstable_rep.merged2_all_em.thres_2022-03-01.csv')
names(peaks_merge2)


    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
           #Boxplots and violin Plots
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
 
########################
#1) Merged 1 - SEDIMENTS
########################
#Plot
ggplot(data=cross_merge1, aes(x=cs.flag.emergent_sed, y=NOSC))+   
  geom_boxplot()

# To compare if metrics are statistically different between groups, we need to run a test and check the assumptions
#Normality and Variances to decide for a parametric or non-parametric test

#Testing the homegeneity of Variances with Levene's Test in 2+x samples
## Levene's test
#Null hypothesis: group variances are equal
leveneTest(NOSC ~ cs.flag.emergent_sed, data = cross_merge1)
leveneTest(DBE ~ cs.flag.emergent_sed, data = cross_merge1)
leveneTest(AI_Mod ~ cs.flag.emergent_sed, data = cross_merge1)
#Non homogeneous --> need to use a non-parametric test

#A Kruskal-Wallis test is used to determine whether or not there is a statistically significant difference between the medians of three or more independent groups. 
#It is considered to be the non-parametric equivalent of the One-Way ANOVA.
kruskal.test(NOSC ~ cs.flag.emergent_sed, data = cross_merge1)

#If the results of a Kruskal-Wallis test are statistically significant, then it's appropriate to conduct Dunn's Test to determine exactly which groups are different.
dunnTest(NOSC ~ cs.flag.emergent_sed, data = cross_merge1,
         method="holm")
#All the 3 groups are statistically significantly different from each other 

##Boxplot
p=ggplot(data=cross_merge1, aes(x=cs.flag.emergent_sed, y=NOSC, fill=cs.flag.emergent_sed))+   
  geom_boxplot() + theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
p+stat_compare_means(method = "kruskal.test")


########################################################################################
#I can plot everything together
##NOSC - SED MERGE1
res.kruskal <- cross_merge1 %>% kruskal_test( NOSC~cs.flag.emergent_sed)
res.kruskal
stat.test <-cross_merge1 %>% dunn_test( NOSC~cs.flag.emergent_sed, p.adjust.method = "holm") 
stat.test
stat.test <- stat.test %>% add_xy_position(x = "cs.flag.emergent_sed")

ggboxplot(cross_merge1, x = "cs.flag.emergent_sed" , y = "NOSC", fill = "cs.flag.emergent_sed") +
  stat_pvalue_manual(stat.test, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_NOSC_sediment_merged1.png", dpi=300, width = 6, height = 4)

########################################################################################
## DBE - SED MERGE1
#I can plot everything together
res.kruskal2 <- cross_merge1 %>% kruskal_test( DBE~cs.flag.emergent_sed)
res.kruskal2
stat.test2 <-cross_merge1 %>% dunn_test( DBE~cs.flag.emergent_sed, p.adjust.method = "holm") 
stat.test2
stat.test2 <- stat.test2 %>% add_xy_position(x = "cs.flag.emergent_sed")

ggboxplot(cross_merge1, x = "cs.flag.emergent_sed" , y = "DBE", fill = "cs.flag.emergent_sed") +
  stat_pvalue_manual(stat.test2, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_DBE_sediment_merged1.png", dpi=300, width = 6, height = 4)

######################################################################################
## Ai Mod - SED MERGE1
#I can plot everything together
res.kruskal3 <- cross_merge1 %>% kruskal_test( AI_Mod~cs.flag.emergent_sed)
res.kruskal3
stat.test3 <-cross_merge1 %>% dunn_test( AI_Mod~cs.flag.emergent_sed, p.adjust.method = "holm") 
stat.test3
stat.test3 <- stat.test3 %>% add_xy_position(x = "cs.flag.emergent_sed")

ggboxplot(cross_merge1, x = "cs.flag.emergent_sed" , y = "AI_Mod", fill = "cs.flag.emergent_sed") +
  stat_pvalue_manual(stat.test3, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_AI-Mod_sediment_merged1.png", dpi=300, width = 6, height = 4)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
########################
#2) Merged 1 - WATER
########################
## Levene's test
leveneTest(NOSC ~ cs.flag.emergent_water, data = cross_merge1)
leveneTest(DBE ~ cs.flag.emergent_water, data = cross_merge1)
leveneTest(AI_Mod ~ cs.flag.emergent_water, data = cross_merge1)


##NOSC - WATER MERGE1
res.kruskal4 <- cross_merge1 %>% kruskal_test( NOSC~cs.flag.emergent_water)
res.kruskal4
stat.test4 <-cross_merge1 %>% dunn_test( NOSC~cs.flag.emergent_water, p.adjust.method = "holm") 
stat.test4
stat.test4 <- stat.test4 %>% add_xy_position(x = "cs.flag.emergent_water")

ggboxplot(cross_merge1, x = "cs.flag.emergent_water" , y = "NOSC", fill = "cs.flag.emergent_water") +
  stat_pvalue_manual(stat.test4, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_NOSC_water_merged1.png", dpi=300, width = 6, height = 4)

########################################################################################
## DBE - WATER MERGE1
#I can plot everything together
res.kruskal5 <- cross_merge1 %>% kruskal_test( DBE~cs.flag.emergent_water)
res.kruskal5
stat.test5 <-cross_merge1 %>% dunn_test( DBE~cs.flag.emergent_water, p.adjust.method = "holm") 
stat.test5
stat.test5 <- stat.test5 %>% add_xy_position(x = "cs.flag.emergent_water")

ggboxplot(cross_merge1, x = "cs.flag.emergent_water" , y = "DBE", fill = "cs.flag.emergent_water") +
  stat_pvalue_manual(stat.test5, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_DBE_water_merged1.png", dpi=300, width = 6, height = 4)

######################################################################################
## Ai Mod - WATER MERGE1
#I can plot everything together
res.kruskal6 <- cross_merge1 %>% kruskal_test( AI_Mod~cs.flag.emergent_water)
res.kruskal6
stat.test6 <-cross_merge1 %>% dunn_test( AI_Mod~cs.flag.emergent_water, p.adjust.method = "holm") 
stat.test6
stat.test6 <- stat.test6 %>% add_xy_position(x = "cs.flag.emergent_water")

ggboxplot(cross_merge1, x = "cs.flag.emergent_water" , y = "AI_Mod", fill = "cs.flag.emergent_water") +
  stat_pvalue_manual(stat.test6, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_AI-Mod_water_merged1.png", dpi=300, width = 6, height = 4)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
########################
#2) Merged 2 - SEDIMENT
########################
leveneTest(NOSC ~ cs.flag.emergent_water, data = cross_merge2)
leveneTest(DBE ~ cs.flag.emergent_water, data = cross_merge2)
leveneTest(AI_Mod ~ cs.flag.emergent_water, data = cross_merge2)

##NOSC - SED MERGE2
res.kruskal8 <- cross_merge2 %>% kruskal_test( NOSC~cs.flag.emergent_sed)
res.kruskal8
stat.test8 <-cross_merge2 %>% dunn_test( NOSC~cs.flag.emergent_sed, p.adjust.method = "holm") 
stat.test8
stat.test8<- stat.test8 %>% add_xy_position(x = "cs.flag.emergent_sed")

ggboxplot(cross_merge2, x = "cs.flag.emergent_sed" , y = "NOSC", fill = "cs.flag.emergent_sed") +
  stat_pvalue_manual(stat.test8, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_NOSC_sediment_merged2.png", dpi=300, width = 6, height = 4)

########################################################################################
## DBE - SED MERGE2
#I can plot everything together
res.kruskal9 <- cross_merge2 %>% kruskal_test( DBE~cs.flag.emergent_sed)
res.kruskal9
stat.test9 <-cross_merge2 %>% dunn_test( DBE~cs.flag.emergent_sed, p.adjust.method = "holm") 
stat.test9
stat.test9 <- stat.test9 %>% add_xy_position(x = "cs.flag.emergent_sed")

ggboxplot(cross_merge2, x = "cs.flag.emergent_sed" , y = "DBE", fill = "cs.flag.emergent_sed") +
  stat_pvalue_manual(stat.test9, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_DBE_sediment_merged2.png", dpi=300, width = 6, height = 4)

######################################################################################
## Ai Mod - SED MERGE2
#I can plot everything together
res.kruskal10 <- cross_merge2 %>% kruskal_test( AI_Mod~cs.flag.emergent_sed)
res.kruskal10
stat.test10 <-cross_merge2 %>% dunn_test( AI_Mod~cs.flag.emergent_sed, p.adjust.method = "holm") 
stat.test10
stat.test10 <- stat.test10 %>% add_xy_position(x = "cs.flag.emergent_sed")

ggboxplot(cross_merge2, x = "cs.flag.emergent_sed" , y = "AI_Mod", fill = "cs.flag.emergent_sed") +
  stat_pvalue_manual(stat.test10, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_AI-Mod_sediment_merged2.png", dpi=300, width = 6, height = 4)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

########################
#2) Merged 2 - WATER
########################
## Levene's test
leveneTest(NOSC ~ cs.flag.emergent_water, data = cross_merge2)
leveneTest(DBE ~ cs.flag.emergent_water, data = cross_merge2)
leveneTest(AI_Mod ~ cs.flag.emergent_water, data = cross_merge2)


##NOSC - WATER MERGE1
res.kruskal11 <- cross_merge2 %>% kruskal_test( NOSC~cs.flag.emergent_water)
res.kruskal11
stat.test11 <-cross_merge2 %>% dunn_test( NOSC~cs.flag.emergent_water, p.adjust.method = "holm") 
stat.test11
stat.test11 <- stat.test11 %>% add_xy_position(x = "cs.flag.emergent_water")

ggboxplot(cross_merge2, x = "cs.flag.emergent_water" , y = "NOSC", fill = "cs.flag.emergent_water") +
  stat_pvalue_manual(stat.test11, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_NOSC_water_merged2.png", dpi=300, width = 6, height = 4)

########################################################################################
## DBE - WATER MERGE2
#I can plot everything together
res.kruskal12 <- cross_merge2 %>% kruskal_test( DBE~cs.flag.emergent_water)
res.kruskal12
stat.test12 <-cross_merge2 %>% dunn_test( DBE~cs.flag.emergent_water, p.adjust.method = "holm") 
stat.test12
stat.test12 <- stat.test12 %>% add_xy_position(x = "cs.flag.emergent_water")

ggboxplot(cross_merge2, x = "cs.flag.emergent_water" , y = "DBE", fill = "cs.flag.emergent_water") +
  stat_pvalue_manual(stat.test12, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_DBE_water_merged2.png", dpi=300, width = 6, height = 4)

######################################################################################
## Ai Mod - WATER MERGE1
#I can plot everything together
res.kruskal13 <- cross_merge2 %>% kruskal_test( AI_Mod~cs.flag.emergent_water)
res.kruskal13
stat.test13 <-cross_merge2 %>% dunn_test( AI_Mod~cs.flag.emergent_water, p.adjust.method = "holm") 
stat.test13
stat.test13 <- stat.test13 %>% add_xy_position(x = "cs.flag.emergent_water")

ggboxplot(cross_merge2, x = "cs.flag.emergent_water" , y = "AI_Mod", fill = "cs.flag.emergent_water") +
  stat_pvalue_manual(stat.test13, hide.ns = FALSE) +
  theme_bw() +theme(legend.position="none")+ scale_fill_viridis(discrete = TRUE)
setwd("C:/Users/micha/OneDrive/Documentos/GitHub/whondrs-coresat-topic1/Analyses/Michaela")
ggsave("Boxplot_AI-Mod_water_merged2.png", dpi=300, width = 6, height = 4)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#





#Plot showing number of samples per boxplot

#Add number samples and mean in each boxplot
stat_box_data <- function(y, upper_limit = max(cross_merge1$DBE) * 1.15) {
  return( 
    data.frame(
      y = 0.95 * upper_limit,
      label = paste('count =', length(y), '\n',
                    'mean =', round(mean(y), 1), '\n')
    )
  )
}

plot_DBE= ggplot(data=cross_merge1, aes(x=cs.flag.emergent_sed, y=DBE))+   
  geom_boxplot() +stat_summary(
  fun.data = stat_box_data, 
  geom = "text", 
  hjust = 0.5,
  vjust = 0.9
)+  geom_jitter(color="black", size=0.4, alpha=0.9)

#It is difficult to compare because the number of formula among groups is very different

#Violin plot
ggplot(data=cross_merge1, aes(x=cs.flag.emergent_sed, y=DBE))+   
  geom_violin() +stat_summary(
    fun.data = stat_box_data, 
    geom = "text", 
    hjust = 0.5,
    vjust = 0.9
  )+  geom_jitter(color="black", size=0.4, alpha=0.9)
ggsave("Violin_DBE_sediment_merged1.png", dpi=300)
