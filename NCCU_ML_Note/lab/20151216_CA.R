fisher <- read.table("~/Documents/NCCU/ML/NCCU_ML_Note/lab/20151216_fisher.txt")
library(stats) 
library(MASS)
fisher.ca<-corresp(fisher,nf=2)
fisher.ca
biplot(fisher.ca,cex=0.8,xlab='Dimension 1',ylab='Dimension 2')
fisher.ca<-corresp(fisher,nf=3) 
fisher.ca
fisher.ca$cor[1]^2/(fisher.ca$cor[1]^2+fisher.ca$cor[2]^2+fisher.ca$cor[3]^2)
fisher.ca$cor[2]^2/(fisher.ca$cor[1]^2+fisher.ca$cor[2]^2+fisher.ca$cor[3]^2)

mammals<-read.table("~/Documents/NCCU/ML/NCCU_ML_Note/lab/20151216_mammals.txt",h=T)
mammals.mca<-mca(mammals,nf=23,abbrev=TRUE)
sum(mammals.mca$d^2/sum(mammals.mca$d^2))
mammals.mca

