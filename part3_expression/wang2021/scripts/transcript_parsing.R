
# package import
library(ggplot2)
library(dplyr)
library(readxl)
library(tidyr)
library(cowplot)

setwd("~/GitHub/cyanophycin/transcriptomes/wang2021")

path_annotations <- "./results/all_annotations.csv"
path_samples <- "./results/sample_list.txt"

# data read in ----------------------

annotations <- read.csv(path_annotations) # prokka master annotation sheet
annotations <- annotations %>% rename(target_id=locus_tag) %>% filter(ftype=="CDS") # rename to match kallisto tables and filter by CDS
annotations$bin <- sub(".tsv","",annotations$bin) # clean up bin 
annotations <- annotations %>% filter(bin!="Acc_IB") # Acc-IB remove

# samples - read in each abundance table
samples <- read.table(path_samples,header=TRUE)
# assign file path to each phase and read in
for(i in 1:nrow(samples)) {
  samples$path[i] <- file.path("./results",samples$sample[i],"abundance.tsv")
  assign(samples$sample[i],read.table(samples$path[i],header=TRUE))
}

# parsing by sample and bin ----------------------
cpha <- annotations %>% filter(product=="Cyanophycin synthetase")

aer_ac_cpha <- merge(aer_ac,cpha,by="target_id")
aer_pr_cpha <- merge(aer_pr,cpha,by="target_id")
anx_ac_cpha <- merge(anx_ac,cpha,by="target_id")
anx_pr_cpha <- merge(anx_pr,cpha,by="target_id")
ana_ac_cpha <- merge(ana_ac,cpha,by="target_id")
ana_pr_cpha <- merge(ana_pr,cpha,by="target_id")

all_cpha <- dplyr::bind_rows(list(aer_ac=aer_ac_cpha,aer_pr=aer_pr_cpha,anx_ac=anx_ac_cpha,anx_pr=anx_pr_cpha,ana_ac=ana_ac_cpha,ana_pr=ana_pr_cpha),.id="source")

ppk <- annotations %>% filter(product=="Polyphosphate kinase" | target_id=="BLJGAGFF_02569")
# manually setting target ID for Acc_IC based on Blast results
ppk$gene[ppk$target_id=="BLJGAGFF_02569"] <- "ppk"

aer_ac_ppk <- merge(aer_ac,ppk,by="target_id")
aer_pr_ppk <- merge(aer_pr,ppk,by="target_id")
anx_ac_ppk <- merge(anx_ac,ppk,by="target_id")
anx_pr_ppk <- merge(anx_pr,ppk,by="target_id")
ana_ac_ppk <- merge(ana_ac,ppk,by="target_id")
ana_pr_ppk <- merge(ana_pr,ppk,by="target_id")

all_ppk <- dplyr::bind_rows(list(aer_ac=aer_ac_ppk,aer_pr=aer_pr_ppk,anx_ac=anx_ac_ppk,anx_pr=anx_pr_ppk,ana_ac=ana_ac_ppk,ana_pr=ana_pr_ppk),.id="source")

all_cpha$source <- factor(all_cpha$source,
                          c("ana_ac","anx_ac","aer_ac","ana_pr","anx_pr","aer_pr"))
all_ppk$source <- factor(all_ppk$source,
                          c("ana_ac","anx_ac","aer_ac","ana_pr","anx_pr","aer_pr"))

both_concat <- rbind(all_cpha,all_ppk)
both_concat <- both_concat %>% select(-c(COG,EC_number))
# write.csv(both_concat,"combined_cpha_ppk_result.csv",row.names=FALSE)


