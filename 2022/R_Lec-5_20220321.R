###############################################################################
##                   R LECTURE 5: Instrumental Variable Estimation    	     ##
##            	 Quantitative Analysis - 2022 Spring  3/21   		             ##
###############################################################################


###############################################################################
##                                 Author		                                 ##
##            	                 Amy Tsai     		          	               ##
###############################################################################

rm(list=ls(all=T))

########################################################
# Section 1:  2SLS  method                             #
########################################################

rm(list=ls(all=T))

# Consider the model y = a + bx + e that includes an endogeneous regressor x :
# cor(x,e)=0.3 -> endogeneous
# cor(x,z)=0.7, cor(z,e)=0 -> z is a good IV for x

#import data
data = read.csv("D:\\­p¶q¤ÀªR\\2SLS_Lec 5.csv") 
attach(data)
y = 10 +2*x + e  # Specify the true data generating process and generate explained variable y
# 2SLS estimator for x should be close to 2

#-----------
# OLS method
#-----------

#First we try OLS method
lm.ols = lm(y~x)
summary(lm.ols) 
lm.ols$coefficients[2] #the estimated coefficient for x using OLS is 2.28943

#-------------
# 2SLS method
#-------------

# Stage 1: regress x on z
lm.stage1 = lm(x~z)
x.hat = fitted.values(lm.stage1)

# Stage 2: regress y on x.hat
lm.stage2 = lm(y~x.hat)
summary(lm.stage2)
lm.stage2$coefficients[2] #the estimated coefficient for x using 2SLS is 2.032495


# Or we can use the package "ivpack"
library(ivpack)
iv = ivreg(y ~ x | z, data = data)  # the general set-up is ivreg(Y ~ X + W | W + Z) where X is endogenous, W is exogenous and Z is the IV.
summary(iv)
iv$coefficients[2] #which is exactly what we just got above
