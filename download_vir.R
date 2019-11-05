

#install.packages("rentrez")
library(rentrez)

setwd("~/Host_Phage_Interactions/data/")
seqs <- unique(readLines("Viral_Genbank_Accesions.txt"))# %>% unique()
# id <- entrez_search(db="nuccore",term=seqs[1])
# summ <- entrez_summary(db="nuccore",id=id$ids)

setwd("~/")
getseq <- function(seqi){
  id <- entrez_search(db="nuccore",term=seqi)
  write(entrez_fetch(db="nuccore",id=id$ids,rettype = "fasta"),
        file=paste0(seqi,".fasta"))
}