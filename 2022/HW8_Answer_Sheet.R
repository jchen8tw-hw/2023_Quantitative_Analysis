###############################################################################
##                           HW 8 Answer Sheet         			    		         ##
##            	        Name :ªL¯§Á¾   NTU ID:R10723079  	    	     	    	 ##
###############################################################################
rm(list=ls(all=T))
library(boot)
library(glmnet)
best.s1 = c()
best.s2 = c()
best.s3 = c()
best.s4 = c()
beta1 = matrix(0,nrow = 26,ncol = 100)
beta2 = matrix(0,nrow = 51,ncol = 100)
beta3 = matrix(0,nrow = 26,ncol = 100)
beta4 = matrix(0,nrow = 51,ncol = 100)
for (i in 1:100){

  X = matrix(rnorm(55*50),nrow = 55)
  e = matrix(rnorm(55))
  DGP1 = 2 + as.numeric(apply(X[,1:2], 1, sum)) + e
  DGP2 = 2 + as.numeric(apply(X[,1:20], 1, sum)) + e

  grid = seq(0,2,length = 100)
  ridge1.fit = glmnet(X[,1:25],DGP1,alpha = 0, lambda = grid)
  ridge2.fit = glmnet(X[,1:50],DGP1,alpha = 0, lambda = grid)
  ridge3.fit = glmnet(X[,1:25],DGP2,alpha = 0, lambda = grid)
  ridge4.fit = glmnet(X[,1:50],DGP2,alpha = 0, lambda = grid)

  ridge1.kfold = cv.glmnet(X[,1:25],DGP1,alpha=0, nfolds=10, lambda = grid)
  ridge2.kfold = cv.glmnet(X[,1:50],DGP1,alpha=0, nfolds=10, lambda = grid)
  ridge3.kfold = cv.glmnet(X[,1:25],DGP2,alpha=0, nfolds=10, lambda = grid)
  ridge4.kfold = cv.glmnet(X[,1:50],DGP2,alpha=0, nfolds=10, lambda = grid)
  
  for (j in 1:100){
    beta1[,j] = beta1[,j] + coef(ridge1.fit)[,j]
    beta2[,j] = beta2[,j] + coef(ridge2.fit)[,j]
    beta3[,j] = beta3[,j] + coef(ridge3.fit)[,j]
    beta4[,j] = beta4[,j] + coef(ridge4.fit)[,j]
  }

  
  best.s1[i] <- ridge1.kfold$lambda.min
  best.s2[i] <- ridge2.kfold$lambda.min
  best.s3[i] <- ridge3.kfold$lambda.min
  best.s4[i] <- ridge4.kfold$lambda.min
}
beta1 = beta1/100
beta2 = beta2/100
beta3 = beta3/100
beta4 = beta4/100


par(mfrow=c(2,2))
plot(ridge1.fit$lambda, beta1[2,], type="l", ylim = c(-1,1), xlim = c(0,2), col='red', xlab = '£f', ylab = 'beta', main = 'DGP1 25 regressors')
lines(ridge1.fit$lambda, beta1[3,], col='red')
for (i in 4:26){
  lines(ridge1.fit$lambda, beta1[i,])
}
abline(v=mean(best.s1), col='blue', lty=2)
text(1,0.8,c('signal'), col='red')
text(1,-0.1,c('noise'),)
text(0.7,-0.7,paste('£f = ',round(mean(best.s1),2)), col='blue')


plot(ridge2.fit$lambda, beta2[2,], type="l", ylim = c(-1,1), xlim = c(0,2), col='red', xlab = '£f', ylab = 'beta', main = 'DGP1 50 regressors')
lines(ridge2.fit$lambda, beta2[3,], col='red')
for (i in 4:51){
  lines(ridge2.fit$lambda, beta2[i,])
}
abline(v=mean(best.s2), col='blue', lty=2)
text(1.5,0.6,c('signal'), col='red')
text(1.5,-0.1,c('noise'),)
text(1.1,-0.7,paste('£f = ',round(mean(best.s2),2)), col='blue')

plot(ridge3.fit$lambda, beta3[2,], type="l", ylim = c(-1,1), xlim = c(0,2), col='red', xlab = '£f', ylab = 'beta', main = 'DGP2 25 regressors')
for (i in 3:21){
  lines(ridge3.fit$lambda, beta3[i,], col='red')
}
for (i in 22:26){
  lines(ridge3.fit$lambda, beta3[i,])
}
abline(v=mean(best.s3), col='blue', lty=2)
text(1,0.9,c('signal'), col='red')
text(1,-0.1,c('noise'),)
text(0.3,-0.7,paste('£f = ',round(mean(best.s3),2)), col='blue')

plot(ridge4.fit$lambda, beta4[2,], type="l", ylim = c(-1,1), xlim = c(0,2), col='red', xlab = '£f', ylab = 'beta', main = 'DGP2 50 regressors')
for (i in 3:21){
  lines(ridge4.fit$lambda, beta4[i,], col='red')
}
for (i in 22:51){
  lines(ridge4.fit$lambda, beta4[i,])
}
abline(v=mean(best.s4), col='blue', lty=2)
text(1,0.9,c('signal'), col='red')
text(1,-0.1,c('noise'),)
text(0.4,-0.7,paste('£f = ',round(mean(best.s4),2)), col='blue')
