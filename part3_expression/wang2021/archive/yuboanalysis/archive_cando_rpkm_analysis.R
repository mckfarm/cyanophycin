# CANDO+P reactor RNA-RPKM visuals

# package import
library(ggplot2)
library(dplyr)
library(readxl)
library(tidyr)
library(RColorBrewer)
library(cowplot)
library(stringr)

# data import
# I saved the cphA values into a csv
# df <- read.csv("./RNA_RPKM_all_genes_in_MAGs/rna_rpkm_cando.csv")
# cpha <- df %>% 
#   filter(gene_name=="Cyanophycin synthetase") %>% 
#   select(-gene_name)
# write.csv(cpha,"cpha_rpkm.csv",row.names=FALSE)

cpha <- read.csv("cpha_rpkm.csv")
ppk <- read.csv("./RNA_RPKM_all_genes_in_MAGs/rna_rpkm_ppk.csv") # ppk1 data derived from Table 5 of SI

# filtering by cphA
ppk <- ppk %>% select(-gene_name)
cpha <- cpha %>% select(-gene_id_original)

# make long dataframe for plotting
cpha_melt <- cpha %>% pivot_longer(!gene_id,names_to="metric",values_to="value")
ppk_melt <- ppk %>% pivot_longer(!gene_id,names_to="metric",values_to="value")

# keep rpkm
cpha_rpkm <- cpha_melt %>% filter(str_detect(metric,"rpkm"))
ppk_rpkm <- ppk_melt %>% filter(str_detect(metric,"rpkm"))

# acetate
cpha_rpkm_ac <- cpha_rpkm %>% filter(str_detect(metric,"ac"))
# order factor by anaerobic anoxic aerobic to show reactor cycle
cpha_rpkm_ac$metric <- factor(cpha_rpkm_ac$metric,
                              c("rpkm_ac_anaerobic","rpkm_ac_anoxic","rpkm_ac_aerobic"))

ppk_rpkm_ac <- ppk_rpkm %>% filter(str_detect(metric,"ac"))
# order factor by anaerobic anoxic aerobic to show reactor cycle
ppk_rpkm_ac$metric <- factor(ppk_rpkm_ac$metric,
                             c("rpkm_ac_anaerobic","rpkm_ac_anoxic","rpkm_ac_aerobic"))

# propionate
cpha_rpkm_pr <- cpha_rpkm %>% filter(str_detect(metric,"pr"))
# order factor by anaerobic anoxic aerobic to show reactor cycle
cpha_rpkm_pr$metric <- factor(cpha_rpkm_pr$metric,
                              c("rpkm_pr_anaerobic","rpkm_pr_anoxic","rpkm_pr_aerobic"))

ppk_rpkm_pr <- ppk_rpkm %>% filter(str_detect(metric,"pr"))

# order factor by anaerobic anoxic aerobic to show reactor cycle
ppk_rpkm_pr$metric <- factor(ppk_rpkm_pr$metric,
                             c("rpkm_pr_anaerobic","rpkm_pr_anoxic","rpkm_pr_aerobic"))


#------------------------------
# acetate

# ppk acetate
bar_ppk_ac <- ggplot(ppk_rpkm_ac, aes(x=gene_id,y=value,fill=metric)) +
  geom_bar(stat="identity", position=position_dodge(),color="black") +
  theme_bw() +
  scale_fill_manual(values=brewer.pal(3,"Set2"),labels=c("anaerobic","anoxic","aerobic")) +
  labs(x="Accumulibacter MAG",y="RNA-RPKM",title="ppk1") +
  ylim(0,150) + 
  theme(legend.position="none",axis.text.x=element_text(angle=45,hjust=1),plot.title = element_text(face="italic"))

# cpha acetate
bar_cpha_ac <- ggplot(cpha_rpkm_ac, aes(x=gene_id,y=value,fill=metric)) +
  geom_bar(stat="identity", position=position_dodge(),color="black") +
  theme_bw() +
  scale_fill_manual(values=brewer.pal(3,"Set2"),labels=c("anaerobic","anoxic","aerobic"),name="Phase") +
  labs(x="Accumulibacter MAG",y="",title="cphA") +
  ylim(0,150)
carb_legend <- get_legend(bar_cpha_ac)
bar_cpha_ac <- bar_cpha_ac + 
  theme(legend.position="none",axis.text.x=element_text(angle=45,hjust=1),plot.title = element_text(face="italic"))

# cpha carbon grid
grid_ac <- plot_grid(bar_ppk_ac,bar_cpha_ac,carb_legend,
                     nrow=1,align="hv",axis="b",
                     rel_widths=c(1,1,0.4))
grid_ac

ggsave("./visuals/acetate.png",plot=grid_ac,dpi=300,width=7,height=4)


#-----------------------------
# propionate

bar_ppk_pr <- ggplot(ppk_rpkm_pr, aes(x=gene_id,y=value,fill=metric)) +
  geom_bar(stat="identity", position=position_dodge(),color="black") +
  theme_bw() +
  scale_fill_manual(values=brewer.pal(3,"Set2"),labels=c("anaerobic","anoxic","aerobic")) +
  labs(x="Accumulibacter MAG",y="RNA-RPKM",title="ppk1") +
  ylim(0,150) + 
  theme(legend.position="none",axis.text.x=element_text(angle=45,hjust=1),plot.title = element_text(face="italic"))

bar_cpha_pr <- ggplot(cpha_rpkm_pr, aes(x=gene_id,y=value,fill=metric)) +
  geom_bar(stat="identity", position=position_dodge(),color="black") +
  theme_bw() +
  scale_fill_manual(values=brewer.pal(3,"Set2"),labels=c("anaerobic","anoxic","aerobic"),name="Phase") +
  labs(x="Accumulibacter MAG",y="",title="cphA") +
  ylim(0,150) + 
  theme(legend.position="none",axis.text.x=element_text(angle=45,hjust=1),plot.title = element_text(face="italic"))

# ppk carbon grid
grid_pr <- plot_grid(bar_ppk_pr,bar_cpha_pr,carb_legend,
                     nrow=1,align="hv",axis="b",
                     rel_widths=c(1,1,0.4))
grid_pr

ggsave("./visuals/prop.png",plot=grid_pr,dpi=300,width=7,height=4)