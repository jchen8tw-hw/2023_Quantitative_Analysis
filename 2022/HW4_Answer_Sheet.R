###############################################################################
##                           HW 4 Answer Sheet         			    		         ##
##            	        Name :ªL¯§Á¾   NTU ID:R10723079  	    	     	    	 ##
###############################################################################

# DGP1 : {y_i}~N(0,1)
# DGP2 : {y_i}~t(4)
# DGP3 : {y_i}~t(1)
# sample size n = {10,500}
# moment functions = {y, y^3, sin(y), cos(y)}
# Number of replications: B = 1000 times
# requirements:
# (1) For the total of 2*3*4=24 ways to construct M_N, plot their corresponding histogram.
# (2) Compute the empirical frequencies of the events: (M_N)^2 > 3:8414588 and (M_N)^2 > 6:6348966 for each simulation graph.
# (3) Add the Gaussian kernel density estimate (KDE) of M_N as well as the probability density function (PDF) of N(0,1) for each simulation graph.

###############################################################################
rm(list=ls(all=T))
windows(width=10,height=10) #open a new window and plot on it
par(mfrow=c(6,4))
L = seq(-10, 10, length=1000)

for (j in 1:2){
  if (j == 1){
    k = 10
  } else{
    k = 500
  }  
  M_1 = c()
  M_3 = c()
  M_sin = c()
  M_cos = c()  
  for (d in 1:3) {
    
    for (i in 1:1000) {
      
      if (d == 1) {
        s = rnorm(n = k, mean = 0, sd = 1)
        dgp = 'N(0,1)'
      } else if (d == 2) {
        s = rt(n = k, df = 4)
        dgp = 't(4)'
      } else{
        s = rt(n = k, df = 1)
        dgp = 't(1)'
      }

      for (l in 1:4) {
        if (l == 1) {
          y = s
        } else if (l == 2) {
          y = s^3
        } else if (l == 3) {
          y = sin(s)
        } else{
          y = cos(s)
        }
        
        M = sum(y) / sum((y - sum(y) / k) ^ 2) ^ 0.5
        switch(l,
               M_1[i] <- M,
               M_3[i] <- M,
               M_sin[i] <- M,
               M_cos[i] <- M)
        
        
        
        
      }   
    }
  
  
    hist(M_1, breaks=50,xlim = c(-3,3),freq=F,xlab='',
         main=substitute(paste(N == k,' ', dgp,' y'), list(k = k, dgp = dgp)),
         sub=substitute(paste('pr(>3.8)' == pr1,' /pr(>6.6)=', pr2), list(pr1 = length(M_1[M_1^2>=3.8414588])/length(M_1), pr2 = length(M_1[M_1^2>=6.6348966])/length(M_1))))
    lines(density(M_1),col="blue",lwd=2)
    lines(L, dnorm(L,0,1),col="red",lwd=2)
    
    hist(M_3, breaks=50,xlim = c(-3,3),freq=F,xlab='',
         main=substitute(paste(N == k,' ', dgp,' y^3'), list(k = k, dgp = dgp)),
         sub=substitute(paste('pr(>3.8)' == pr1,' /pr(>6.6)=', pr2), list(pr1 = length(M_3[M_3^2>=3.8414588])/length(M_3), pr2 = length(M_3[M_3^2>=6.6348966])/length(M_3))))
    lines(density(M_3),col="blue",lwd=2)
    lines(L, dnorm(L,0,1),col="red",lwd=2)
    
    hist(M_sin, breaks=50,xlim = c(-3,3),freq=F,xlab='',
         main=substitute(paste(N == k,' ', dgp,' sin(y)'), list(k = k, dgp = dgp)),
         sub=substitute(paste('pr(>3.8)' == pr1,' /pr(>6.6)=', pr2), list(pr1 = length(M_sin[M_sin^2>=3.8414588])/length(M_sin), pr2 = length(M_sin[M_sin^2>=6.6348966])/length(M_sin))))
    lines(density(M_sin),col="blue",lwd=2)
    lines(L, dnorm(L,0,1),col="red",lwd=2)
    
    hist(M_cos, breaks=50,xlim = c(-2,40),freq=F,xlab='',
         main=substitute(paste(N == k,' ', dgp,' cos(y)'), list(k = k, dgp = dgp)),
         sub=substitute(paste('pr(>3.8)' == pr1,' /pr(>6.6)=', pr2), list(pr1 = length(M_cos[M_cos^2>=3.8414588])/length(M_cos), pr2 = length(M_cos[M_cos^2>=6.6348966])/length(M_cos))))
    lines(density(M_cos),col="blue",lwd=2)
    lines(L, dnorm(L,0,1),col="red",lwd=2)
  
  }
}


