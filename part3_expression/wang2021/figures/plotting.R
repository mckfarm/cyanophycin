
# package import
library(ggplot2)
library(cowplot)
library(MetBrewer)

setwd("~/GitHub/cyanophycin/transcriptomes/wang2021")


# data read in ----------------------

path_ac_data <- "./results/ac_only.csv"
acetate <- read.csv(path_ac_data) 
acetate$source <- factor(acetate$source,
                         c("ana","anx","aer"))

# plotting ----------------------
bar_ia <- ggplot(data=subset(acetate,bin=="Acc_IA"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  labs(x="Phase",y="Transcripts per Million Reads [TPM]",title="Clade IA") +
  ylim(0,125) +
  theme(legend.position="none") +
  scale_fill_manual(values=met.brewer("Egypt",3))

bar_ic <- ggplot(data=subset(acetate,bin=="Acc_IC"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  labs(x="Phase",y="",title="Clade IC") +
  ylim(0,125) +
  theme(legend.position="none") +
  scale_fill_manual(values=met.brewer("Egypt",3))

bar_if <- ggplot(data=subset(acetate,bin=="Acc_IF"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  ylim(0,125) +
  labs(x="Phase",y="",title="Clade IF") +
  guides(fill=guide_legend(title="Gene")) +
  scale_fill_manual(values=met.brewer("Egypt",3), labels=c("cphA 1","cphA 2","ppk")) +
  theme(legend.text = element_text(face = "italic"))

legend <- get_legend(bar_if)

bar_if <- bar_if + theme(legend.position="none")

plot_grid(bar_ia,bar_ic,bar_if,legend,
          nrow=1,align="hv",axis="b",
          rel_widths=c(1,1,1,0.5))

ggsave("wang_tpm.tiff",width=5,height=3,units="in",dpi=300)
