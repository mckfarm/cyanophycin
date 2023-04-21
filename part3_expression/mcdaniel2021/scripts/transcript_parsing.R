
# package import
library(dplyr)
library(readxl)
library(tidyr)

setwd("~/GitHub/cyanophycin/transcriptomes/mcdaniel2021")

path_annotations <- "./results/all_annotations.csv"
path_samples <- "./results/sample_list.txt"

# data read in ----------------------

annotations <- read.csv(path_annotations) # prokka master annotation sheet
annotations <- annotations %>% rename(target_id=locus_tag) %>% filter(ftype=="CDS") # rename to match kallisto tables and filter by CDS
# manually edited all_annotations.csv file to replace filename from quest with bin name


# samples - read in each abundance table
samples <- read.table(path_samples,header=TRUE)

# assign file path to each phase and read in
for(i in 1:nrow(samples)) {
  samples$path[i] <- file.path("./results",samples$sample[i],"abundance.tsv")
  assign(samples$sample[i],read.table(samples$path[i],header=TRUE))
}

# parsing by sample and bin ----------------------
cpha <- annotations %>% filter(product=="Cyanophycin synthetase")

aer_1455_cpha <- merge(aer_1455,cpha,by="target_id")
aer_1355_cpha <- merge(aer_1355,cpha,by="target_id")
aer_1315_cpha <- merge(aer_1315,cpha,by="target_id")
aer_1240_cpha <- merge(aer_1240,cpha,by="target_id")
ana_1155_cpha <- merge(ana_1155,cpha,by="target_id")
ana_1116_cpha <- merge(ana_1116,cpha,by="target_id")
ana_1045_cpha <- merge(ana_1045,cpha,by="target_id")

all_cpha <- dplyr::bind_rows(list(aer_1455=aer_1455_cpha,
                                  aer_1355=aer_1355_cpha,
                                  aer_1315=aer_1315_cpha,
                                  aer_1240=aer_1240_cpha,
                                  ana_1155=ana_1155_cpha,
                                  ana_1116=ana_1116_cpha,
                                  ana_1045=ana_1045_cpha),.id="source")

ppk <- annotations %>% filter(product=="Polyphosphate kinase")
# manually setting target ID for Acc_IC based on Blast results

aer_1455_ppk <- merge(aer_1455,ppk,by="target_id")
aer_1355_ppk <- merge(aer_1355,ppk,by="target_id")
aer_1315_ppk <- merge(aer_1315,ppk,by="target_id")
aer_1240_ppk <- merge(aer_1240,ppk,by="target_id")
ana_1155_ppk <- merge(ana_1155,ppk,by="target_id")
ana_1116_ppk <- merge(ana_1116,ppk,by="target_id")
ana_1045_ppk <- merge(ana_1045,ppk,by="target_id")

all_ppk <- dplyr::bind_rows(list(aer_1455=aer_1455_ppk,
                                 aer_1355=aer_1355_ppk,
                                 aer_1315=aer_1315_ppk,
                                 aer_1240=aer_1240_ppk,
                                 ana_1155=ana_1155_ppk,
                                 ana_1116=ana_1116_ppk,
                                 ana_1045=ana_1045_ppk),.id="source")

all_cpha$source <- factor(all_cpha$source,
                          c("ana_1045","ana_1116","ana_1155","aer_1240","aer_1315","aer_1355","aer_1455"))
all_ppk$source <- factor(all_ppk$source,
                         c("ana_1045","ana_1116","ana_1155","aer_1240","aer_1315","aer_1355","aer_1455"))

both_concat <- rbind(all_cpha,all_ppk)
both_concat <- both_concat %>% select(-c(COG,EC_number))
write.csv(both_concat,"combined_cpha_ppk_result.csv",row.names=FALSE)

