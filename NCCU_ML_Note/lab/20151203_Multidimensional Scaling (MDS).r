Multidimensional Scaling (MDS)

We analyze Fisher's iris data set (which has been used to illustrate various classification methods). 
The data can be found in the Data Sets folder. 
First, we rescale the variables by dividing with their standard deviations.

> iris <- read.table("iris.dat")
> variris <- apply(iris,2,var)
> iris.adjusted <- sweep(iris,2,sqrt(variris),"/")

Then we perform a classical Torgerson-Gower scaling. 
Here, we request a 2-dimensinal solution by minimizing the loss function “STRAIN”:

> library(stats)
> iris.scal <- cmdscale(dist(iris.adjusted),k=2,eig=T)

Let's plot the results now:

> library(MASS)
> eqscplot(iris.scal$points,type="n")
> text(iris.scal$point,row.names(iris),cex=.8)

Let's calculate a measure of fit of the solution based on the accumulative proportion of eigenvalues:

> iris.scal$GOF
[1] 0.9581321 0.9581321

which shows a "good" fit.

Remark: There are two different ways for computing goodness of fit (see help(cmdscale)). Also, the solution here is rotationally invariant.

The dimension reduction can be used to examine the "dissimilarity" between variables as well. 

Here we use the correlation coefficient as a measure of "proximity" (similarity) between two variables. 

Furthermore, the dissimilarity is taken to be the reciprocal of the correlation coefficient.

> variable.scal <- cmdscale(1/cor(iris),k=2,eig=T)
> eqscplot(variable.scal$points,type="n")
> text(variable.scal$point,row.names(cor(iris)),cex=.8)

A version of nonmetric scaling due to Kruskal and Shepard is implemented in the isoMDS function in R.

> library(MASS)
> iris.iso <- isoMDS(dist(iris.adjusted[-107,]))

We are forced to exclude object 107 since it is very close to object 129 (almost zero distance). 
Let's plot the results.

> eqscplot(iris.iso$points,type="n")
> text(iris.iso$points,label=iris[-107,1],cex=.8)

Let's calculate a measure of fit of the solution, the minimum value of the stress (in percentage), which is the square root of the ratio of the sum of squared differences between the input distances and those of the configuration to the sum of configuration distances squared.

> iris.iso$stress
[1] 4.143843  (in percent)

which shows a "good" fit.

Another version of nonmetric scaling is implemented in the sammon function in R, which uses “nonlinear mapping” instead of isotonic regression.

> iris.sammon <- sammon(dist(iris.adjusted[-107,]),k=2)
> eqscplot(iris.sammon$points,type="n")
> text(iris.sammon$points,label=iris[-107,1],cex=.8)

Checking goodness of fit:

> iris.sammon$stress
[1] 0.006206077 

which shows a "perfect" fit.

Remark: The non-metric methods like "isoMDS" and "sammon" usually use only "rotations" and "reflections" in the algorithm.