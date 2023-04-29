###############################################################################
##                           HW 7 Answer Sheet         			    		         ##
##            	        Name :ªL¯§Á¾    NTU ID:R10723079	    	     	    	 ##
###############################################################################

##############
# Question 1 #
##############

#####
#(a)# 
#####
rm(list=ls(all=T))
library(ISLR)

attach(Auto)
set.seed(1)
nrow(Auto)
train = sample(392,196) 

lm.fit= lm(mpg ~ horsepower, subset = train) 
summary(lm.fit)
mean((predict(lm.fit, Auto) - mpg)[-train]^2) 

lm.fit2 = lm(mpg ~ horsepower + weight, subset = train)
summary(lm.fit2)
mean((predict(lm.fit2, Auto) - mpg)[-train]^2)

lm.fit3 = lm(mpg ~ horsepower + weight + acceleration, subset = train)
summary(lm.fit3)
mean((predict(lm.fit3, Auto) - mpg)[-train]^2)
#Best model = Model 2
#Test MSE = 16.50505

#####
#(b)# 
##### 
library(boot)
lm.fit1 = glm(mpg ~ horsepower)
lm.fit2 = glm(mpg ~ horsepower + weight)
lm.fit3 = glm(mpg ~ horsepower + weight + acceleration)

LOOCV1 = cv.glm(Auto, lm.fit1)
LOOCV2 = cv.glm(Auto, lm.fit2)
LOOCV3 = cv.glm(Auto, lm.fit3)

c(LOOCV1$delta[1], LOOCV2$delta[1], LOOCV3$delta[1]) 

#Best model = Model 2
#Test MSE = 18.11295

#####
#(c)# 
#####
set.seed(1)

lm.fit1 = glm(mpg ~ horsepower)
lm.fit2 = glm(mpg ~ horsepower + weight)
lm.fit3 = glm(mpg ~ horsepower + weight + acceleration)

KFCV1 = cv.glm(Auto, lm.fit1, K = 10)
KFCV2 = cv.glm(Auto, lm.fit2, K = 10)
KFCV3 = cv.glm(Auto, lm.fit3, K = 10)

c(KFCV1$delta[1], KFCV2$delta[1], KFCV3$delta[1]) 
#Best model = Model 2
#Test MSE = 18.18335

##############
# Question 2 #
##############

#####
#(a)# 
#####
library("lmtest")
beta1 = NULL
for (i in 1:1000) {
  set.seed(i)
  index = sample(nrow(Auto),nrow(Auto), replace = T)
  a = lm(mpg ~ horsepower, subset = index)
  beta1 = c(beta1, coeftest(a)[2,1])
}
sd(beta1)
#Paired Bootstrap estimation = 0.007306607


#####
#(b)# 
#####
beta1 = NULL
lm1 = lm(mpg ~ horsepower)

for (i in 1:1000) {
  set.seed(i)
  index = sample(resid(lm1),nrow(Auto), replace = T)
  y = predict(lm1, Auto) + index
  a = lm(y ~ horsepower)
  beta1 = c(beta1, coeftest(a)[2,1])
}
sd(beta1)

#Residual Bootstrap estimation = 0.006641035




