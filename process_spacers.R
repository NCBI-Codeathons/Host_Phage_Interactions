

#
# COmpile all spacer db's into one file (csv or fasta)
# sorry it's a messs -Jake





# # To process raw jake db files
#awk -F ";" '{print $1,$4}' jake_spacers.gff > jake_spacers_clean.txt
#awk -F "\t" '{print $1" "$9}' jake_spacers_clean.txt  > jake_spacers_final.txt
#awk -F ";" '{print $1,$4}' jake_repeats.gff > jake_repeats_clean.txt
#awk -F "\t" '{print $1" "$9}' jake_repeats_clean.txt  > jake_repeats_final.txt
# 
# library(dplyr)
# library(data.table)
# 
# merge.easy <- function(df1,df2,key){
#   df1 <- data.table(df1,key=key)
#   df2 <- data.table(df2,key=key)
#   return(unique(merge(df1,df2,all.x=TRUE,by=.EACHI,allow.cartesian=TRUE)))
# }
# 
# setwd("~/CDout")
# sp <- read.delim("jake_spacers_final.txt",sep=" ",header=F,stringsAsFactors = F)
# spacers <- data.frame(Accession=sp$V1,
#                       ArrayID=sp$V2 %>% gsub(pattern="ID=",replace="") %>% gsub(pattern="_.*",replace=""),
#                       SpacerId=sp$V2 %>% strsplit(split="_") %>% lapply("[",2) %>% unlist(),
#                       SpacerSeq=sp$V3 %>% gsub(pattern="Note=",replace=""))
# write.csv(spacers,file="spacers_jake.csv")
# 
# rp <- read.delim("jake_repeats_final.txt",sep=" ",header=F,stringsAsFactors = F)
# repeats <- data.frame(Accession=rp$V1,
#                       ArrayID=rp$V2 %>% gsub(pattern="ID=",replace="") %>% gsub(pattern="_.*",replace=""),
#                       SpacerId=rp$V2 %>% strsplit(split="_") %>% lapply("[",2) %>% unlist(),
#                       SpacerSeq=rp$V3 %>% gsub(pattern="Note=",replace=""))
# save(repeats,file="repeats.RData")
# write.csv(repeats,file="repeats_jake.csv")
# 
# accessionlines <- readLines("headersCD.txt")
# accessions2 <- accessionlines %>% strsplit("_") %>% lapply("[",1:2) %>% lapply(.,paste,collapse="_") %>% unlist()
# accessions <- accessionlines %>% gsub(pattern=".*>",replace="") %>% gsub(pattern="-.*",replace="")
# acc2acc <- data.frame(Accession=accessions,
#                       Accession2=accessions2,
#                       stringsAsFactors = F) %>% unique()
# save(acc2acc,file="acc2acc.RData")
# 


library(dplyr)
library(data.table)

merge.easy <- function(df1,df2,key){
  df1 <- data.table(df1,key=key)
  df2 <- data.table(df2,key=key)
  return(unique(merge(df1,df2,all.x=TRUE,by=.EACHI,allow.cartesian=TRUE)))
}

#### Add metadata

setwd("~/Host_Phage_Interactions/data")
bac <- read.delim("bac120_taxonomy_r89.tsv",head=F,stringsAsFactors = F)
arch <- read.delim("ar122_taxonomy_r89.tsv",head=F,stringsAsFactors = F)
gtdb <- rbind(bac,arch)
names(gtdb) <- c("Accession2","TaxonomyGTDB")
gtdb$Accession2 <- gtdb$Accession2 %>% strsplit("_") %>% 
  lapply("[",2:3) %>% lapply(.,paste,collapse="_") %>% unlist()

load("spacers.RData")
load("acc2acc.RData")
spacers2 <- merge.easy(spacers,acc2acc,key="Accession")

spacers2$Accession3 <- spacers2$Accession2 %>% gsub(pattern="[.].*",replace="")
gtdb$Accession3 <- gtdb$Accession2 %>% gsub(pattern="[.].*",replace="") %>% gsub(pattern="GCA",replace="GCF")
spacers3 <- merge.easy(spacers2,gtdb,key="Accession3") %>% subset(!is.na(TaxonomyGTDB))

#write.csv(spacers3,file="spacers_jake.csv")

#spacers3 <- read.csv("spacers_jake.csv",head=T,stringsAsFactors = F)
cdb <- read.csv("crisprcasdb.csv",head=T,stringsAsFactors = F)
cdb$Accession3 <- cdb$Accession2 %>% gsub(pattern="[.].*",replace="") %>% gsub(pattern="GCA",replace="GCF")
cdb2 <- merge.easy(cdb,gtdb,key="Accession3")
cdb2 <- cdb2 %>% subset(select=c(Accession,ArrayID,SpacerId,SpacerSeq,Accession3,TaxonomyGTDB))
spacersj <- spacers3 %>% subset(select=c(Accession,ArrayID,SpacerId,SpacerSeq,Accession3,TaxonomyGTDB))

gtdb_sp <- read.csv("minced_out.csv",header=F,stringsAsFactors = F)
names(gtdb_sp) <- c("Accession3","Accession","SpacerSeq","ArrayID","SpacerId")
gtdb_sp$Accession3 <- gsub("GCA","GCF",gtdb_sp$Accession3)
gtdb_sp <- merge.easy(gtdb_sp,gtdb,key="Accession3")
gtdb_sp <- gtdb_sp %>% subset(select=c(Accession,ArrayID,SpacerId,SpacerSeq,Accession3,TaxonomyGTDB))

nayfach <- read.csv("nayfach_minced_out.wTax.csv",header=F,stringsAsFactors = F)
names(nayfach) <- c("Accession3","Accession","SpacerSeq","ArrayID","SpacerId","TaxonomyGTDB")
nayfach$Accession3 <- gsub("GCA","GCF",nayfach$Accession3)
nayfach <- nayfach %>% subset(select=c(Accession,ArrayID,SpacerId,SpacerSeq,Accession3,TaxonomyGTDB))

cdb2$Source <- "CRISPRCasdb"
spacersj$Source <- "RefSeqAllWeissmanetal"
gtdb_sp$Source <- "GTDB"
nayfach$Source <- "MAGSNayfachetal"

spacer_db <- rbind(cdb2,spacersj,gtdb_sp,nayfach) %>% subset(!is.na(TaxonomyGTDB))
head(spacer_db)


blank_sp <- lapply(1:100,rep,x="N") %>% lapply(.,paste,collapse="") %>% unlist()
spacer_db <- spacer_db %>% subset(nchar(SpacerSeq)>10) %>% subset(!SpacerSeq %in% blank_sp)


# #get ncbi taxids corresponding to gtdb lineage
# setwd("~/CDout")
# #Download from https://data.ace.uq.edu.au/public/gtdb/data/releases/release89/89.0/
# bacm <- read.delim("bac120_metadata_r89.tsv") %>% subset(select=c(gtdb_taxonomy,ncbi_species_taxid)) %>% unique()
# archm <- read.delim("ar122_metadata_r89.tsv") %>% subset(select=c(gtdb_taxonomy,ncbi_species_taxid)) %>% unique()
# gtdb2ncbi <- rbind(bacm,archm)
# setwd("~/Host_Phage_Interactions/data")
# save(gtdb2ncbi,file="gtdb2ncbi.RData")

load("gtdb2ncbi.RData")
names(gtdb2ncbi) <- c("TaxonomyGTDB","NCBItaxid")
spacer_db2 <- merge.easy(spacer_db,gtdb2ncbi,key="TaxonomyGTDB")

setwd("~/CDout")
write.csv(spacer_db2,file="spacer_db.csv")

sp_gtdb <- spacer_db %>% subset(select=c(SpacerSeq,TaxonomyGTDB)) %>% unique()
sp_gtdb_count <- sp_gtdb %>% group_by(SpacerSeq) %>% count()
table(sp_gtdb_count$n)

names <- paste0(">",paste(spacer_db$TaxonomyGTDB,source,spacer_db$Accession3,spacer_db$Accession,sep="|"))
fasta <- character(length(names)*2)
fasta[seq(1,length(fasta),2)] <- names
fasta[seq(2,length(fasta),2)] <- spacer_db$SpacerSeq
head(fasta)
write(fasta,file="spacer_db.fasta")




