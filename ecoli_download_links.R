
library(dplyr)

setwd("~/Host_Phage_Interactions/data/")

ecoli <- read.csv("pathogens_combined_table.csv",stringsAsFactors = F)
ecoli$Assembly
table(substr(ecoli$Assembly,1,3))
all_gb <- read.delim("assembly_summary_genbank.txt",stringsAsFactors = F,skip=2,header=F)
all_gb <- all_gb %>% subset(V1 %in% ecoli$Assembly)

write(all_gb$V20,file="ecoli_links.txt")





