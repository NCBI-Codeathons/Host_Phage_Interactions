
library(dplyr)
library(igraph)

setwd("~/Host_Phage_Interactions/data/")
x <- read.delim("Network_Data_v1.tsv",sep="\t",header=T,stringsAsFactors = F)
head(x)

x <- x %>% subset(select=c(virus.tax.id,Genus)) %>% subset(Genus!="")
grph <- graph_from_edgelist(as.matrix(x), directed = F)
plot(grph,vertex.size=0.001,vertex.label="")

grph2 <- delete.vertices(grph, degree(grph)==0)
plot(grph2,vertex.size=0.001,vertex.label="")
V(grph2)$type <- trimws(V(grph2)$name) %in% as.character(x$virus.tax.id)
projections <- bipartite_projection(grph2)

bac <- projections[[1]]
vir <- projections[[2]]
bac2 <- delete.vertices(bac,degree(bac)==0)
vir2 <- delete.vertices(vir,degree(vir)==0)

setwd("~/Host_Phage_Interactions/images/")
pdf("hostgenus_virsharing.pdf",height=5,width=5)
plot(bac2,vertex.size=0.001)
dev.off()

plot(vir2,vertex.size=0.001,vertex.label="")
