
# package import and set up -----
library(ggplot2)
library(cowplot)
library(MetBrewer)

setwd("~/GitHub/cyanophycin/transcriptomes/")

path_mcdaniel <- "./results/combined_cpha_ppk_result.csv"
path_wang <- "./results/ac_only.csv"


# data read in ----------------------
mcdaniel <- read.csv(path_mcdaniel)
wang <- read.csv(path_wang)

wang$source <- factor(wang$source,
                         c("ana","anx","aer"))

mcdaniel$source <- factor(mcdaniel$source,
                          c("ana_1045","ana_1116","ana_1155","aer_1240","aer_1315","aer_1355","aer_1455"))

# plotting - mcdaniel ----------------------
bar_4ia <- ggplot(data=subset(mcdaniel,bin=="UW4-IA"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  scale_fill_manual("legend", values=met.brewer("Redon",3)) + 
  labs(x="",y="Transcripts per Million Reads [TPM]",title="UW4-IA") +
  ylim(0,150) +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

bar_5ia <- ggplot(data=subset(mcdaniel,bin=="UW5-IIA"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  scale_fill_manual("legend", values=met.brewer("Redon",3)) + 
  labs(x="Phase and Time",y="Transcripts per Million Reads [TPM]",title="UW5-IIA") +
  ylim(0,5) +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

bar_ic <- ggplot(data=subset(mcdaniel,bin=="UW6-IIC"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  scale_fill_manual("legend", values=met.brewer("Redon",3)) + 
  labs(x="",y="",title="UW6-IIC") +
  ylim(0,150) +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

bar_if <- ggplot(data=subset(mcdaniel,bin=="UW7-IIF"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  scale_fill_manual("legend", values=met.brewer("Redon",3)) + 
  ylim(0,0.2) +
  labs(x="Phase and Time",y="",title="UW7-IIF") +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

mcdaniel_high <- plot_grid(bar_4ia,bar_ic,
          nrow=1,align="hv",axis="b",
          rel_widths=c(1,1))

low <- plot_grid(bar_5ia,bar_if,
                 nrow=1,align="hv",axis="b",
                 rel_widths=c(1,1))
# plotting - wang ----------------------------------
bar_ia <- ggplot(data=subset(wang,bin=="Acc_IA"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  scale_fill_manual("legend", values=met.brewer("Redon",3)) + 
  labs(x="Phase",y="Transcripts per Million Reads [TPM]",title="Acc-IA") +
  ylim(0,125) +
  theme(legend.position="none")

bar_ic <- ggplot(data=subset(wang,bin=="Acc_IC"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  scale_fill_manual("legend", values=met.brewer("Redon",3)) + 
  labs(x="Phase",y="",title="Acc-IC") +
  ylim(0,125) +
  theme(legend.position="none")

bar_if <- ggplot(data=subset(wang,bin=="Acc_IF"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  scale_fill_manual("legend", values=met.brewer("Redon",3)) + 
  ylim(0,125) +
  labs(x="Phase",y="",title="Acc-IF") +
  theme(legend.position="none")

wang_plots <- plot_grid(bar_ia,bar_ic,bar_if,
          nrow=1,align="hv",axis="b",
          rel_widths=c(1,1,1))

# saving plots ---------
ggsave("mcdaniel_high.tiff",plot=mcdaniel_high,height=3,width=5,units="in")
ggsave("mcdaniel_low.tiff",plot=low,height=3,width=5,units="in")
ggsave("wang_plots.tiff",plot=wang_plots,height=3,width=5,units="in")

