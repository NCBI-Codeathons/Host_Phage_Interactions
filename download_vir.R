

install.packages("rentrez")
library(rentrez)

setwd("~/Host_Phage_Interactions/data/")
seqs <- readLines("Viral_Genbank_Accesions.txt")

setwd("~/")
getseq <- function(seqi){
  id <- entrez_search(db="nuccore",term=seqi)
  write(entrez_fetch(db="nuccore",id=id$ids,rettype = "fasta"),
        file=paste0(seqi,".fasta"))
}