olive<-read.table("/Users/sheng/Documents/NCCU/ML/NCCU_ML_Note/lab/olive.txt",h=T) 
newolive<-olive[,3:10]
library(cluster)
x<-daisy(newolive)
agn<-agnes(x,metric="euclidean",stand=FALSE,method="single")
plot(agn,ask=T)
plot(agn,which.plots=1)
plot(agn,which.plots=2)
agn$ac
## order 為在樹狀圖左邊到右邊分別為資料的第幾筆
olive[,1][agn$order]
olive[,2][agn$order]

di<-diana(x,metric="euclidean",stand=FALSE) > print(di)
plot(di, which.plots=2)
di$dc
olive[,1][di$order]
olive[,2][di$order]

## k means
km<-kmeans(newolive,3,20)
pca.newolive<-princomp(scale(newolive,scale=TRUE,center=TRUE),cor=FALSE) 
pcs.newolive<-predict(pca.newolive)
plot(pcs.newolive[,1:2], type="n")
text(pcs.newolive,as.character(km$cluster),col=km$cluster,cex=0.6)
plot(pcs.newolive[,1:2],type="n",xlab='1st PC',ylab='2nd PC')
text(pcs.newolive[,1:2],as.character(olive$Region),col=olive$Region,cex=0.6)

# k=5 SC=0.38 最大
pa<-pam(daisy(newolive,stand=T),5,diss=T) 
pa$silinfo
plot(pa,ask=T)


## SOM
library(som)
n.newolive<-normalize(newolive)
library(kohonen)
olive.som<-som(n.newolive,grid = somgrid(20, 20, "hexagonal"))
plot(olive.som,type="mapping",labels=olive[,1])
plot(olive.som, type="dist.neighbours", main = "SOM neighbour distances")
## 因為看不出來群，所以加入tree的方式去幫忙分類
som.hc <- cutree(hclust(dist(olive.som$codes),method='ward.D'), 5)
add.cluster.boundaries(olive.som,som.hc)
cutree(hclust(dist(olive.som$codes)), 5)
## SOM -> choose best SC -> decides # of group -> tree
