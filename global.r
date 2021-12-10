data <- read.csv("data.tsv",sep = "\t")
transdata <- read.csv("for_jbrowse/Deseq2_normalised_count.csv",header = T)
transdata<-transdata[,c('Gene_ID','R15','R20','R25','R30','S15','S20','S25','S30','L15','L20','L25','L30','Bd','Flwr','YSe','MSe')]
