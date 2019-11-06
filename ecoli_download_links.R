
#JLW -2019

#ftp links to download ecoli genomes, get "assembly_summary_genbank.txt" at ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/assembly_summary_genbank.txt (too big for git)

library(dplyr)

setwd("~/Host_Phage_Interactions/data/")

ecoli <- read.csv("pathogens_combined_table.csv",stringsAsFactors = F)
ecoli$Assembly
table(substr(ecoli$Assembly,1,3))
all_gb <- read.delim("assembly_summary_genbank.txt",stringsAsFactors = F,skip=2,header=F)
all_gb <- all_gb %>% subset(V1 %in% ecoli$Assembly)

files <- paste(all_gb$V20,
      all_gb$V20 %>% gsub(pattern=".*[/]",replace="") %>% paste0(.,"_genomic.fna.gz"),
      sep="/")


write(files,file="ecoli_links.txt")





