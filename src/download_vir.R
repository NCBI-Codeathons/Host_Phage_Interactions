
#JLW -2019

# old/bad - Dont use, rentrez frequently crashes (just use efetch commands, see format_virsearch_query.R for example of how to format commands/make script)

#install.packages("rentrez")
library(rentrez)

setwd("~/Host_Phage_Interactions/data/")
seqs <- unique(readLines("Viral_Genbank_Accesions.txt"))# %>% unique()
# id <- entrez_search(db="nuccore",term=seqs[1])
# summ <- entrez_summary(db="nuccore",id=id$ids)

setwd("~/vir")
getSeq <- function(seqi){
  id <- entrez_search(db="nuccore",term=seqi)
  write(entrez_fetch(db="nuccore",id=id$ids,rettype = "fasta"),
        file=paste0(seqi,".fasta"))
}

tryGetSeq <- function(seqi){getSeq(seqi)}

lapply(seqs,tryGetSeq)