###############################################################################
##                           HW 9 Solution            			    		         ##
###############################################################################
rm(list=ls(all=T))


##############
# Question 1 #
##############

library(boot)
library(ISLR)
data(Wage)
attach(Wage)

#####
#(a)# 
#####
library(splines)

cv.error=rep(0,5)
for(i in 1:5){
  set.seed(1)
  fit=glm(wage~bs(age,df=3+i,degree = 3), data=Wage)
  cv.error[i] = cv.glm(Wage, fit, K=10)$delta[2]
}
plot(seq(1:5),cv.error[1:5])
min(cv.error)
which.min(cv.error) 

# number of optimal interior knots = 2

#####
#(b)# 
#####
agelims = range(age)
age.grid = seq(from = agelims[1], to = agelims[2]) # this is a grid from 18 to 80.

fit=glm(wage~bs(age,df=3+2,degree = 3), data=Wage)
attr(terms(fit), "predvars")
pred.bs=predict(fit,newdata=list(age=age.grid),se=T) # These are the fitted values for each age (from 18 to 80).
plot(age,wage,col="gray")
lines(age.grid,pred.bs$fit,lwd=2,col='blue') # The fitted line

##############
# Question 2 #
##############

#####
#(a)# 
#####
cv.error=rep(0,4)
for(i in 1:4){
  set.seed(i)
  qSmall = quantile(Wage$age,.05*i)
  qLarge = quantile(Wage$age,1-.05*i)  
  ns.fit=glm(wage~ns(age,df=(4),Boundary.knots = c(qSmall,qLarge) ),data=Wage) # Here we fit a natural spline with "i+1" degrees of freedom (which is a natural cubic spline with "i" knots)
  cv.error[i] = cv.glm(Wage, ns.fit, K=10)$delta[2]
}
plot(seq(1:4),cv.error[1:4])
min(cv.error)
which.min(cv.error) 

qSmall = quantile(Wage$age,.05*1)
qLarge = quantile(Wage$age,1-.05*1)
ns.fit=glm(wage~ns(age,df=4,Boundary.knots = c(qSmall,qLarge) ),data=Wage)
attr(terms(ns.fit), "predvars")

# Optimal boundary quantiles = 5%, 95%
# Location of the boundary knots = 24, 61


#####
#(b)# 
#####
agelims = range(age)
age.grid = seq(from = agelims[1], to = agelims[2]) # this is a grid from 18 to 80.

pred.ns=predict(ns.fit,newdata=list(age=age.grid),se=T) # These are the fitted values for each age (from 18 to 80).
pred.bs=predict(fit,newdata=list(age=age.grid),se=T)
plot(age,wage,col="gray")
lines(age.grid,pred.ns$fit,lwd=2,col='red') # The fitted line
lines(age.grid,pred.bs$fit,lwd=2,col='blue') # The fitted line

