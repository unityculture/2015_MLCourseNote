Simple Correspondence Analysis (CA)

The following R commands perform a simple CA on the following data set. 
The data come from Fisher's (1940) example on colors of eyes(row) and hair(column) of people in Caithness, Scotland.

The data are saved in the "fisher.txt" file that I read next.

> fisher<-read.table("fisher.txt")

Load next the multivariate analysis library and the MASS library.

> library(stats) 
> library(MASS)

Then apply CA to the two-way table using the R function corresp

> fisher.ca<-corresp(fisher,nf=2)

nf=2 means that we are interested in a 2-dimensional solution

Let us look at the scores and the fit of the solution

> fisher.ca

First canonical correlation(s): 0.4463684 0.1734554

Row scores: [,1] [,2] 
blue -0.89679252 0.9536227 
light -0.98731818 0.5100045 
medium 0.07530627 -1.4124778 
dark 1.57434710 0.7720361

Column scores: [,1] [,2] 
fair -1.21871379 1.0022432 
red -0.52257500 0.2783364 
medium -0.09414671 -1.2009094 
dark 1.31888486 0.5992920 
black 2.45176017 1.6513565

and then make a picture of the results

> biplot(fisher.ca,cex=0.8,xlab='Dimension 1',ylab='Dimension 2')

Remember that CA seeks `scores' X and Y for the rows and columns that are maximally correlated.

Also, the canonical correlations correspond to the diagonal elements in SVD.

The first two dimensions account for approximately 87% and 13% of the total inertia (Chi-square statistic) respectively. 
Since the maximal dimensionality for the solution is min(4-1,5-1)=3, this can be derived by

> fisher.ca<-corresp(fisher,nf=3) 
> fisher.ca

First canonical correlation(s): 0.44636840 0.17345540 0.02931691


 Row scores:
              [,1]       [,2]       [,3]
blue   -0.89679252  0.9536227  2.1884132
light  -0.98731818  0.5100045 -1.0837859
medium  0.07530627 -1.4124778  0.1894089
dark    1.57434710  0.7720361 -0.1482208

 Column scores:
              [,1]       [,2]       [,3]
fair   -1.21871379  1.0022432  0.4271282
red    -0.52257500  0.2783364 -4.0268545
medium -0.09414671 -1.2009094  0.1103959
dark    1.31888486  0.5992920  0.3450676
black   2.45176017  1.6513565 -1.5736976

> fisher.ca$cor[1]^2/(fisher.ca$cor[1]^2+fisher.ca$cor[2]^2+fisher.ca$cor[3]^2)
[1] 0.8655627

> fisher.ca$cor[2]^2/(fisher.ca$cor[1]^2+fisher.ca$cor[2]^2+fisher.ca$cor[3]^2)
[1] 0.1307035
Although the "linear" association is weak (Corr(X1,Y1)=0.446), the first two dimensions are adequate for describing whatever association exists.

Multiple Correspondence Analysis (MCA)

The following R commands perform MCA on the following data set.

The data are saved in the "mammals.txt" file that I read next.

> mammals<-read.table("mammals.txt",h=T)

Then apply MCA to the data by starting with a 5-D solution:

> mammals.mca<-mca(mammals,nf=5,abbrev=TRUE)

Check out the sigular values:

> mammals.mca$d

[1] 0.8559016 0.6164172 0.5245042 0.4678492 0.4193969

If we decide to look at the 2-D solution, do

> mammals.mca<-mca(mammals,nf=2,abbrev=TRUE)

Let us look at the fit of the solution

> mammals.mca

Multiple correspondence analysis of 66 cases of 8 factors 
Correlations 0.856 0.616 cumulative % explained 12.23 21.03 (the percentage of total inertia accounted)

and then make a picture of the results for the category quantifications of the variables:

> plot(mammals.mca,rows=F,cex=0.6)

It would be interesting to include also the objects in the picture, let's make a more clear picture:

> tt<-rbind(mammals.mca$rs,mammals.mca$cs) 
> plot(tt,type="n") 
> text(tt[1:66,],row.names(tt[1:66,]),cex=0.7,col="green") 
> text(tt[67:93,],row.names(tt[67:93,]),cex=0.7,col="red")

It will be interesting to make a 3D plot to display the respective frequency on each object location 
(since the same location can have different mammals). 
There are totally 27 distinguished object locations, check out the frequency for each location:

> table(tt[1:66,1]) 
I would suggest using Matlab to construct an informative 3-D plot including (categories, object locations) 
with the height to be the frequency on each object location. (Can you do this using R ?)

Also, how do you interpret the result ?