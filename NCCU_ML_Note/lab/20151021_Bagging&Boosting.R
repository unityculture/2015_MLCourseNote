fish<-read.table("/Users/sheng/Documents/NCCU/ML/NCCU_ML_Note/lab/20151014_fish.txt",h=T)
L21<-fish$L2-fish$L1
L32<-fish$L3-fish$L2
L31<-fish$L3-fish$L1
newfish<-cbind(fish,L21,L32,L31)

#install.packages('adabag')
library(adabag)
library(rpart)

fish.control<-rpart.control(minisplit=10,minbucket=3,cp=0.01) 
# the same tree with nsplit=8 was used before #
newfish.bagging<-bagging(Species~.,data=newfish,mfinal=20,control=fish.control) 
# the number of iteration is 20 #
newfish.bagging.pred <- predict.bagging(newfish.bagging,newfish)
newfish.bagging.pred$confusion



Now we estimate the true error rate by leave-one-out (i.e. 148-fold) CV.
In order to reduce the computation load, here we choose a smaller number of iteration 20.
(but it still takes a while)

newfish.baggingcv<-bagging.cv(Species~., data=newfish,v=148,mfinal=20,control=fish.control)
newfish.baggingcv[-1]$confusion
Clase real
Clase estimada bream parki perch pike roach smelt white
bream    33     0     0    1     0     0     0
parki     0    10     0    0     0     0     0
perch     0     0    54    0     0     0     0
pike      0     0     0   15     0     0     0
roach     0     0     0    0    17     0     0
smelt     0     0     0    0     0    12     0
white     0     0     0    0     1     0     5

$error
[1] 0.01351351

The estimated true error = 1.35% 

Note: The result of estimated error by CV may be different under bagging (due to sampling). 
However, this procedure can reduce the estimation variation.

Now we predict the new observations.
To do this I need to play some tricks:
  
newfish.test<-read.table("/Users/sheng/Documents/NCCU/ML/NCCU_ML_Note/lab/20151021_test.txt",h=T) #create some fake classes in the prediction data#
L31<-newfish.test$L3- newfish.test$L1
L32<-newfish.test$L3- newfish.test$L2
L21<-newfish.test$L2- newfish.test$L1
newfish.test<-cbind(newfish.test,L21,L32,L31)
data<-rbind(newfish,newfish.test) #combine the existing data with the ones we want to predict# 
newfish.test.pred<-predict.bagging(newfish.bagging,data[149:159,])
newfish.test.pred$class
[1] "bream" "bream" "perch" "perch" "pike"  "smelt" "smelt" "parki" "roach" "roach" "white"

==> The prediction result is the same as that obtained from a single tree.


# Boosting

newfish.adaboost <- boosting(Species~., data=newfish, boos=F, mfinal=3)
newfish.adaboost.pred <- predict.boosting(newfish.adaboost,newfish)
newfish.adaboost.pred$confusion

#Now we estimate the true error rate by leave-one-out (i.e. 148-fold) CV.
#Again, here we choose a smaller number of iteration 20. 
#(this also takes a while)
sub <- sample(1:148,100)
newfish.adaboost<-boosting(Species~., data=newfish[sub,],mfinal=5,control=fish.control)
newfish.adaboost.pred <- predict(newfish.adaboost,newdata=newfish[-sub, ],type="class")
newfish.adaboost.pred$confusion
newfish.adaboostcv<-boosting.cv(Species~.,boos=F ,data=newfish,v=4,mfinal=5,control=fish.control)
newfish.adaboostcv[-1]

Note that the default "coeflearn=Breiman" choose the weight "alpha=(1/2)log((1-err)/err)".
On the other hand, if we choose "coeflearn=Zhu" (Zhu et al., 2009), the SAMME algorithm is implemented 
with "alpha=log((1-err)/err)+log(nclasses-1)". 

newfish.adaboostcv<-boosting.cv(Species~.,data=newfish,coeflearn='Zhu',v=148,mfinal=20,control=fish.control)
newfish.adaboostcv[-1]
$confusion
Observed Class
Predicted Class bream parki perch pike roach smelt white
bream    32     1     0    0     0     0     0
parki     1     9     0    0     0     0     0
perch     0     0    53    0     0     0     1
pike      0     0     0   16     0     0     0
roach     0     0     1    0    17     0     0
smelt     0     0     0    0     0    12     0
white     0     0     0    0     1     0     4

$error
[1] 0.03378378

This results in a similar estimated true error = 3.378%

Now we predict the new observations.

newfish.test.pred<-predict.boosting(newfish.adaboost,data[149:159,])
newfish.test.pred$class
[1] "bream" "bream" "perch" "perch" "pike"  "smelt" "smelt" "parki" "roach" "roach" "white"

==> The same prediction result is obtained!
  