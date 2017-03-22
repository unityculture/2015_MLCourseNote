
c<-read.table("/Users/sheng/Documents/NCCU/ML/NCCU_ML_Note/lab/citycrime.txt",h=T)
install.packages('fastICA')
library(fastICA)



a <- fastICA(c,7)



a$A


a$W


Plotting original mixed signals:

par(mfcol = c(2, 3))
plot(1:72, c[,1], type = "l", main = "Mixed Signals D-1")
plot(1:72, c[,2], type = "l", main = "Mixed Signals D-2")

Plotting ICA Source Estimates:

plot(1:72, a$S[,1], type = "l", main = "ICA Source Estimate D-1")
plot(1:72, a$S[,2], type = "l", main = "ICA Source Estimate D-2")