library(rpart)
library(MASS)
fish <- read.table('/Users/sheng/Documents/NCCU/ML/NCCU_ML_Note/lab/fish.txt',header=T)
L21<-fish$L2-fish$L1
L32<-fish$L3-fish$L2
L31<-fish$L3-fish$L1
newfish<-cbind(fish,L21,L32,L31)
# 發現共線性
newfish.lda<-lda(Species~.,data=newfish)
# 丟掉共線性的變數
newfish.lda<-lda(Species~Weight+L1+Height+Width+L21+L32,data=newfish)
# 注意min(K-1,m)=6 -> LD6
newfish.lda

newfish.ldapred<-predict(newfish.lda,newfish[,-1])
newfish.ldacv<-lda(Species~Weight+L1+Height+Width+L21+L32,data=newfish,CV=T)
table(newfish$Species,newfish.ldacv$class)

eqscplot(newfish.ldapred$x,type=”n”,xlab=”1st LD”,ylab=”2nd LD”)
fish.species<-c(rep(“B”,33),rep(“W”,5),rep(“R”,18),rep(“Pa”,10),rep(“S”,12),rep(“Pi”,16),
                  rep(“Pe”,54))
fish.colors<-c(rep(1,33),rep(2,5),rep(3,18),rep(4,10),rep(5,12),rep(6,16),rep(7,54))
text(newfish.ldapred$x[,1:2],fish.species,col=fish.colors)


# 1014 tree
library(rpart)
fish <- read.table('/Users/sheng/Documents/NCCU/ML/NCCU_ML_Note/lab/20151014_fish.txt',header=T)
  ## minisplit:至少那組10個以上的obs才會切 , minbucket: 至少3個node（要比class少）
fish.control<-rpart.control(minisplit=10,minbucket=3,xval=0)
fish.treeorig<-rpart(Species~
                     Weight+L1+L2+L3+Height+Width,data=fish,method='class',
                     control=fish.control)
plot(fish.treeorig)
text(fish.treeorig)

  # complexity
printcp(fish.treeorig)
summary(fish.treeorig) # 通常不看

  # 看a的改變對樹的大小
fish.prunetree<-prune.rpart(fish.treeorig,cp=0.02)
plot(fish.prunetree)
text(fish.prunetree)

  # 加了變數近來, 樹也變小, error rate也降低
  # Variables actually used in tree construction 選變數
L21<-fish$L2-fish$L1
L32<-fish$L3-fish$L2
L31<-fish$L3-fish$L1
newfish<-cbind(fish,L21,L32,L31)
newfish.treenew<-rpart(Species~., data=newfish,method='class',
                       parms=list(split='information'),control=fish.control)
printcp(newfish.treenew)

# CV , true error rate
    # xerror : true error rate
    # xstd : CV true error rate sd -> 1-SE rule
    # rel error rate : apparent error rate = training error rate 
fish.control<-rpart.control(minbucket=3,minsplit=10,xval=148)
newfish.treenewcv<- rpart(Species~., data=newfish,method='class',
                          parms=list(split='information'),control=fish.control)
printcp(newfish.treenewcv)
plot(newfish.treenewcv)
text(newfish.treenewcv)

#
newfish.test<-read.table('/Users/sheng/Documents/NCCU/ML/NCCU_ML_Note/lab/testdata.txt')
L31<-newfish.test$L3- newfish.test$L1
L32<-newfish.test$L3- newfish.test$L2
L21<-newfish.test$L2- newfish.test$L1
newfish.test <- cbind(newfish.test,L21,L32,L31)
newfish.tpred<-predict(newfish.treenewcv,newfish.test)
newfish.tpred

# QDA 
library(MASS)
newfish.test<-read.table('/Users/sheng/Documents/NCCU/ML/NCCU_ML_Note/lab/newfish.txt',
                         header=T)
    # 把白魚拿掉, 有共線性問題
newfish <- newfish.test[which(newfish.test$Species!='white'),]
newfish.qda<-qda(Species~.,data=newfish)

    # 共線拿掉
newfish.qda<-qda(Species~Weight+L1+Height+Width+L21+L32,data=newfish)
newfish.qdapred<-predict(newfish.qda,newfish)
table(newfish$Species,newfish.qdapred$class)
predict(newfish.qda,newfish.test)$class


## LD
library(nnet)
newfish.logd<-multinom(Species~.,data=newfish,maxit=250)
newfish.logd
table(newfish$Species,predict(newfish.logd,newfish))
predict(newfish.logd,newfish.test)
