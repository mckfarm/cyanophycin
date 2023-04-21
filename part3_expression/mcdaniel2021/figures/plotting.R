
# package import
library(ggplot2)
library(cowplot)

setwd("~/GitHub/cyanophycin/transcriptomes/mcdaniel2021")

path_annotations <- "./results/combined_cpha_ppk_result.csv"

# data read in ----------------------
both_concat <- read.csv(path_annotations) 


# plotting - mcdaniel ----------------------
bar_4ia <- ggplot(data=subset(both_concat,bin=="UW4-IA"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  labs(x="Phase_Time",y="TPM",title="UW4-IA") +
  ylim(0,150) +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

bar_5ia <- ggplot(data=subset(both_concat,bin=="UW5-IIA"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  labs(x="Phase_Time",y="TPM",title="UW5-IIA") +
  ylim(0,5) +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

bar_ic <- ggplot(data=subset(both_concat,bin=="UW6-IIC"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  labs(x="Phase_Time",y="",title="UW6-IIC") +
  ylim(0,150) +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

bar_if <- ggplot(data=subset(both_concat,bin=="UW7-IIF"),aes(x=source,y=tpm,fill=gene)) +
  geom_bar(stat="identity",position=position_dodge(),color="black") +
  theme_classic() +
  ylim(0,0.2) +
  labs(x="Phase_Time",y="",title="UW7-IIF") +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

high <- plot_grid(bar_4ia,bar_ic,
                  nrow=1,align="hv",axis="b",
                  rel_widths=c(1,1))

low <- plot_grid(bar_5ia,bar_if,
                 nrow=1,align="hv",axis="b",
                 rel_widths=c(1,1))
