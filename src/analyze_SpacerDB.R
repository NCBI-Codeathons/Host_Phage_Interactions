
# JLW -2019

library(dplyr)

setwd("~/CDout")
sdb <- read.csv("spacer_db.csv",stringsAsFactors = F)

table(sdb$Source)


sp_unique <- sdb$SpacerSeq %>% unique() 

setwd("~/Host_Phage_Interactions/images/")
pdf("spacer_lengths_zoom.pdf",width=5,height=5)
hist(nchar(sp_unique),xlim=c(0,60),breaks=200,main="",xlab="Spacer Length")
abline(v=quantile(nchar(sp_unique),0.5),col="red",lwd=2)
abline(v=quantile(nchar(sp_unique),c(0.025,0.975)),col="red",lty=2)
dev.off()

setwd("~/Host_Phage_Interactions/images/")
pdf("spacer_lengths.pdf",width=5,height=5)
hist(nchar(sp_unique),breaks=200,main="",xlab="Spacer Length")
abline(v=quantile(nchar(sp_unique),0.5),col="red",lwd=2)
abline(v=quantile(nchar(sp_unique),c(0.025,0.975)),col="red",lty=2)
dev.off()

sp_counts <- sdb %>% subset(select=c(Accession3,SpacerSeq)) %>% unique() %>% group_by(Accession3) %>% count()

setwd("~/Host_Phage_Interactions/images/")
pdf("spacer_counts.pdf",width=5,height=5)
hist(sp_counts$n,breaks=100,xlab="Number of Unique Spacers Per Genome")
dev.off()




sp_counts <- sdb %>% subset(select=c(Accession3,Source,SpacerSeq)) %>% unique() %>% group_by(Source,Accession3) %>% count()

setwd("~/Host_Phage_Interactions/images/")
pdf("spacer_counts_bysource.pdf",width=5,height=5)
par(mar=c(12,5,3,3))
boxplot(n~Source,data=sp_counts,ylab="Number of Spacers Per Genome",las=2,xlab="")
dev.off()

setwd("~/Host_Phage_Interactions/images/")
pdf("spacer_counts_bysource_zoom.pdf",width=5,height=5)
par(mar=c(12,5,3,3))
boxplot(n~Source,data=sp_counts,las=2,xlab="",ylab="Number of Spacers Per Genome",ylim=c(0,100))
dev.off()


setwd("~/Host_Phage_Interactions/images/")
pdf("spacer_counts_bysource.pdf",width=5,height=5)
par(mar=c(12,5,3,3))
boxplot(nchar(SpacerSeq)~Source,data=sdb,ylab="Spacer Length",las=2,xlab="")
dev.off()


setwd("~/Host_Phage_Interactions/images/")
pdf("spacer_counts_bysource_zoom.pdf",width=5,height=5)
par(mar=c(12,5,3,3))
boxplot(nchar(SpacerSeq)~Source,data=sdb,las=2,xlab="",ylab="Spacer Length",ylim=c(0,60))
dev.off()

