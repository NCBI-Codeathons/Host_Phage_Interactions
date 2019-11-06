
# JLW -2019

library(dplyr)

setwd("~/CDout")
sdb <- read.csv("spacer_db.csv",stringsAsFactors = F)

table(sdb$Source)


sp_unique <- sdb$SpacerSeq %>% unique() 

setwd("~/Host_Phage_Interactions/images/")
pdf("spacer_lengths.pdf",width=5,height=5)
hist(nchar(sp_unique),xlim=c(0,75),breaks=200,main="",xlab="Spacer Length")
abline(v=quantile(nchar(sp_unique),0.5),col="red",lwd=2)
abline(v=quantile(nchar(sp_unique),c(0.025,0.975)),col="red",lty=2)
dev.off()
