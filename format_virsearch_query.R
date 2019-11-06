
#JLW -2019

#Makes a script to download all nucleotide sequences associated with a set of viral taxids

library(rentrez)

setwd("~/Host_Phage_Interactions/data/")
l <- readLines("Full_Viruses_Taxonomy_IDs.txt")
l2 <- paste0("txid",l,"[Organism]") %>% unique()

efetch_cmds <- paste0('cd ~/vir_all; esearch -db "nucleotide" -query ',
       l2,
       ' |efetch -format fasta > ',
       paste0(l,".fasta"))

write(c("#!/bin/sh",efetch_cmds),file="efetch_vir.sh")
