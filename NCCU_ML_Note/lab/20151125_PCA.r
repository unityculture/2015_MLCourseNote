PCA in R
The following R commands perform PCA on the following data set (you can download it from the "Data Sets" folder). 
The data give crime rates per 100,000 people for the 72 largest US cities in 1994. 
The variables are: 
  1) Murder 
  2) Rape 
  3) Robbery 
  4) Assault 
  5)  Burglary 
  6) Larceny 
  7) Motor Vehicle Thefts 
 

The data are saved in the "citycrime.txt" file that I read next.

> crime<-read.table("citycrime.txt")

We can then look at the scatterplot matrix

> pairs(crime)

Load next the multivariate analysis library.

> library(stats)

Then apply PCA on the correlation matrix by rescaling and centering the data using the R function princomp

> pca.crime<-princomp(scale(crime,scale=TRUE,center=TRUE),cor=TRUE)

Look at the results

> summary(pca.crime)

                                        Comp. 1   Comp. 2   Comp. 3    Comp. 4     Comp. 5 
Standard deviation       1.948024 1.0950164 0.8771129 0.71434047 0.57690506 
Proportion of Variance 0.542114 0.1712944 0.1099039 0.07289747 0.04754564 
Cumulative Proportion 0.542114 0.7134084 0.8233123 0.89620976 0.94375539

                                       Comp. 6    Comp. 7 
Standard deviation       0.4617666 0.42483396 
Proportion of Variance 0.0304612 0.02578341 
Cumulative Proportion 0.9742166 1.00000000

Calculate the loadings. Note that it defines loadings without multiplying by the sqrt of lambda - this is not unique to R, SAS gives similar results also.  Be aware that people use the term in both ways.

> loadings(pca.crime) 
  
                    Comp.1      Comp.2        Comp.3            Comp.4         Comp.5         Comp.6 
Murder   -0.3703162  -0.3393305  -0.20197401    0.716536320   -0.27667317    0.2195058 
Rape       -0.2494347    0.4665068  -0.78285390  -0.158647300     0.09801765    0.2666223 
Robbery  -0.4260252  -0.3878604  -0.07906463  -0.022205333     0.19425099  -0.1467357 
Assault   -0.4340165    0.0424326     0.28183161    0.004121735     0.76699528    0.1184636 
Burglary -0.4497241    0.2382532   -0.01503743  -0.054744947  -0.24207660  -0.7940676 
Larceny  -0.2759217    0.6055442     0.49241798     0.209243512  -0.26414901    0.3028892 
MVT      -0.3903791  -0.3025585     0.13403135   -0.643519086  -0.39931631    0.3505418 
                   Comp.7 
Murder     0.26224431 
Rape       -0.03781056 
Robbery  -0.77592380 
Assault     0.35786553 
Burglary   0.22049052 
Larceny  -0.33076964 
MVT        0.20407887

Calculate the PCs.

> pcs.crime<-predict(pca.crime)

Check out the screeplot. 
> eigen<-eigen(cor(crime)) 
> plot(eigen$values,type="h")

Plot the first 2 PCs. 
> plot(pcs.crime[,1:2],type="n",xlab='1st PC',ylab='2nd PC') 
> text(pcs.crime[,1:2],row.names(crime))

Plot also the biplot.

> biplot(pca.crime,scale=1) 
  
 





         Murder Rape  Robbery Assault Burglary Larceny MVT
New-York  21.3   36.3   988.8   814.5  1204.6  2859.9  1300.7
LA        23.8   43.8   868.0  1123.4  1226.2  3120.5  1434.3
Chicago   33.1   40.0  1210.5  1440.9  1563.6  4323.4  1427.9
Houston   21.3   53.0   567.7   665.5  1451.5  3239.2  1287.2
Philly    25.9   46.2   814.2   436.2   903.9  2588.3  1620.0
San-Diego   9.7   34.5   329.0   704.8  1102.8  3012.0  1371.8
Phoenix   21.5   40.7   320.7   697.6  1983.7  5063.9  1920.3
Dallas    27.8   90.4   666.0   805.2  1680.7  4542.1  1664.9
Detroit   52.9  109.2  1249.4  1275.8  2167.3  4120.2  2892.4
San-Antonio  19.4   56.5   278.1   293.1  1642.0  5491.5   987.7
Honolulu   4.0   30.2   120.1   132.7  1137.5  4831.7   650.3
San-Jose   4.0   46.0   136.0   539.5   714.3  2490.1   554.6
Las-Vegas  14.0   76.3   505.6   655.6  1548.9  3900.1  1027.8
San-Fran  12.3   39.4   893.2   516.5  1086.2  4547.0  1247.2
Baltimore  43.4   86.2  1525.3  1179.4  2150.6  5736.4  1830.8
Jacksonville  15.5   94.5   499.7   910.2  2089.2  5023.9   990.7
Columbus  15.4  104.8   555.5   367.8  2019.9  4596.1  1037.3
Milwaukee  22.1   68.2   638.9   314.4  1345.7  4060.8  1699.6
Memphis   25.3  110.6   793.8   638.6  2503.4  3834.7  1863.7
Washingt  70.0   43.7  1107.2  1441.8  1760.9  5205.8  1448.6
El-Paso    7.8   41.2   192.2   708.8   756.7  4762.2   690.7
Boston    15.3   81.4   762.5  1056.4  1221.3  4378.3  2019.0
Seattle   12.8   58.9   469.4   669.1  1515.2  6803.7  1188.9
Charlotte  16.5   66.4   514.7  1129.2  1958.9  5400.8   599.5
Nashville  14.0   97.4   508.7  1178.2  1600.2  5520.6  1145.8
Austin     7.2   48.7   301.4   277.7  1377.2  5160.1   768.7
Denver    15.8   71.6   335.4   498.0  1518.1  3272.1  1222.1
Cleveland  26.1  148.0   775.1   580.6  1581.7  2554.4  1790.3
New-Orleans  85.8   88.3   976.1   736.7  2037.3  4431.3  1734.2
Fort-Worth  27.9   87.4   503.7   658.7  1756.3  5020.7  1134.5
Portland  10.8   86.4   506.2  1298.7  1727.8  6125.0  2060.8
Oklahoma  14.1  118.4   379.0   891.4  2233.2  7308.8  1060.3
Long-Beach  17.9   37.4   767.3   594.1  1453.0  3057.0  1603.6
Tucson     8.4   65.5   229.3   802.9  1632.3  7976.6  1539.9
Kansas-City  32.3  116.6   848.8  1442.5  2723.4  5718.4  1674.4
Virginia-Beach  7.7   33.9   142.5    86.8   759.8  3713.9   221.3
Atlanta   46.4  102.6  1299.4  2122.5  2951.3  7511.6  2084.6
St-Louis  63.5   77.9  1543.1  2066.1  3207.2  7105.9  2286.9
Sacramento  15.9   44.7   588.5   557.2  2073.7  4775.4  2271.4
Fresno    22.0   50.2   734.3   813.5  2001.5  4871.2  3548.4
Tulsa     11.0   77.6   280.6   846.3  1715.8  3289.0  1180.4
Miami     30.5   58.2  1537.2  1787.7  2967.8  8064.9  2730.7
Oakland   36.9   85.1  1021.1  1050.8  1850.4  4688.0  1900.7
Minneapolis  16.7  155.9   928.7   806.3  2387.6  5738.1  1133.7
Pittsburgh  17.4   70.8   669.8   355.7  1176.1  3409.7  1449.3
Cicinnati  10.4  104.1   580.7   627.9  1640.5  4577.2   472.0
Toledo    12.1  107.3   523.0   462.1  1985.6  4849.5  1191.0
Buffalo   27.7   86.3  1007.8  1002.3  2247.2  3774.6  1406.2
Wichita   13.3   70.7   334.8   323.4  2053.2  5328.9  1083.9
Mesa       5.4   38.0   129.0   576.9  1582.8  4863.4  1100.3
Colorado   4.5   73.0   128.5   275.5   971.7  4865.1   349.2
Tampa     21.0  101.1  1146.4  2214.1  2964.1  7297.5  3736.8
Santa-Ana  25.3   27.3   604.4   393.8   836.8  2864.0  1271.6
Arlington   6.3   50.2   228.1   567.4  1210.1  4325.1   865.9
Anaheim    8.6   32.3   406.2   500.9  1175.6  3201.7  1229.4
Corpus-Cristi   4.7   64.3   177.7   609.7  1534.2  6939.8   487.2
Louisville  18.8   51.4   473.0   461.4  1593.5  2945.3   887.1
St-Paul   10.6   98.1   318.0   568.9  1485.7  3881.0   738.8
Newark    35.4   76.4  2130.8  1598.0  2375.4  4118.8  3492.3
Burmingham  49.8  100.7   730.7  1563.6  2392.4  6009.7  1344.8
Norfolk   23.5   60.4   460.3   371.3  1199.8  4823.1   696.1
Anchorage   8.7   78.1   287.4   602.8   897.2  4619.0   863.7
Aurora     5.9   58.1   246.4  1137.5  1193.7  4667.9   504.3
St-Peter   9.4   87.5   619.7  1537.9  1931.8  5067.2   591.4
Riverside  15.2   55.2   502.6  1053.8  2068.9  3894.4  1613.2
Lexington   9.7   48.9   294.4   627.5  1300.9  4235.8   282.6
Rochester  26.4   61.7   710.0   356.3  2272.5  5272.9   913.4
Jersey-City  16.0   32.0   969.6   847.5  1854.8  2803.6  1595.9
Raleigh   13.2   39.0   361.7   537.5  1554.6  4292.6   445.0
Baton-Rouge  28.2   79.4   648.7  1693.3  2362.8  7254.8  1985.0
Akron     10.2   86.6   360.5   503.4  1350.4  3879.9   911.8
Stockton  19.7   54.2   641.4   893.3  2041.3  4991.3  1853.8