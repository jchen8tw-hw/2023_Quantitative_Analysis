###############################################################################
##                           Solution to HW 4           		                 ##
##                  	 Quantitative Analysis - 2023 Spring       	           ##
###############################################################################

# DGP1 : {y_i}~N(0,1)
# DGP2 : {y_i}~t(4)
# DGP3 : {y_i}~t(1)
# sample size n = {10,500}
# moment functions = {y, y^3, sin(y), cos(y)}
# Number of replications: B = 1000 times
# requirements:
# (1) For the total of 2*3*4=24 ways to construct M_N, plot their corresponding histogram.
# (2) Compute the empirical frequencies of the events: (M_N)^2 > 3.8414588 and (M_N)^2 > 6.6348966 for each simulations
# (3) Add the Gaussian kernel density estimate (KDE) of M_N as well as the probability density function (PDF) of N(0,1) for each simulation graph.

###############################################################################
rm(list=ls(all=T))

quartz(width=10,height=10) #open a new window and plot on it
par(mfrow=c(6,4))

n = c(10,500)
B = 1000
M = c()
names_n =c("10","500")
names_DGP = c("N(0,1)","t(4)","t(1)")
names_mf =c("y","y^3","sin(y)","cos(y)")

DGP = function(dist,n){                          #function for choosing DGP
  if (dist==1) {
    return(rnorm(n))
  }else if (dist==2) {
    return (rt(df=4,n=n))
  }else if (dist==3) {
    return (rt(df=1,n=n))
  }
}

M_N = function(n,y){                             #function for the statistic M_N
  sigma_square = 1/n*sum((y-1/n*sum(y))^2)
  result = 1/((sigma_square*n)^(1/2))*sum(y)
  return(result)
}

mf = function(k,y){                              #function for choosing moment functions
  if (k==1) {
    return(y)
  }else if (k==2) {
    return (y^3)
  }else if (k==3) {
    return (sin(y))
  }else if (k==4) {
    return (cos(y))
  }  
}

for (i in 1:2) {           # i for n
  for (j in 1:3) {         # j for DGP
    for (k in 1:4) {       # k for mf
      for (b in 1:B) {     # replicates B times
        y = DGP(j,n=n[i])
        M[b] = M_N(n=n[i],mf(k,y))
      }
      L.95 = length(M[(M<(-1.96))|M>1.96])/B      #(M_N)^2 > 3.8414588 
      L.99 = length(M[(M<(-2.575))|M>2.575])/B    #(M_N)^2 > 6.6348966
      hist(M,breaks=100,freq = F, 
           xlim = c(min(quantile(M,0.025),qnorm(0.005)),max(quantile(M,0.975),qnorm(0.995))), ylim = c(0,0.4),
           xlab= paste("pr(>3.8)=",round(L.95,3),"/ pr(>6.6)=",round(L.99,3)),
           main = paste("N =",names_n[i], names_DGP[j], names_mf[k]))
      lines(density(M),lwd=2, col="blue")
      lines(seq(-4, 4, length=100), dnorm(seq(-4, 4, length=100)), lwd=2, col="red")
    }
  }
}
  
  
  
  