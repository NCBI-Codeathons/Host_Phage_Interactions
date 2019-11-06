
library(rentrez)

setwd("~/Host_Phage_Interactions/data/")
l <- readLines("Full_Viruses_Taxonomy_IDs.txt")
l2 <- paste0("txid",l,"[Organism]") %>% unique()

# write(l2[1:2000],file="Full_Viruses_Taxonomy_IDs_1.txt")
# write(l2[2001:4000],file="Full_Viruses_Taxonomy_IDs_2.txt")
# write(l2[4001:6000],file="Full_Viruses_Taxonomy_IDs_3.txt")
# write(l2[6001:8000],file="Full_Viruses_Taxonomy_IDs_4.txt")
# write(l2[8001:9998],file="Full_Viruses_Taxonomy_IDs_5.txt")

efetch_cmds <- paste0('cd ~/vir_all; esearch -db "nucleotide" -query ',
       l2,
       ' |efetch -format fasta > ',
       paste0(l,".fasta"))

write(c("#!/bin/sh",efetch_cmds),file="efetch_vir.sh")
