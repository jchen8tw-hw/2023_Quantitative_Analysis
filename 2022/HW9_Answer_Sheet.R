###############################################################################
##                           HW 9 Answer Sheet         			    		         ##
##            	        Name :ªL¯§Á¾   NTU ID:R10723079  	    	     	    	 ##
###############################################################################
rm(list=ls(all=T))

library(ISLR)
attach(Wage)
##############
# Question 1 #
##############
library(boot)
cv.error=rep(0,5)
for(i in 1:5){
  set.seed(i)
  fit = glm(wage~poly(age,i,raw=T), data=Wage)
  cv.error[i] = cv.glm(Wage, fit, K=50)$delta[1]
}
#plot(seq(1:5),cv.error[1:5])
min(cv.error)
which.min(cv.error)
# optimal degree = 5

##############
# Question 2 #
##############

#####
#(a)# 
#####
library(splines)
agelims = range(age)
age.grid = seq(from = agelims[1], to = agelims[2])
cv.error=rep(0,5)
for(i in 1:5){
  set.seed(i)
  fit = glm(wage~bs(age,df=3+i,degree = 3), data=Wage)
  cv.error[i] = cv.glm(Wage, fit, K=10)$delta[1]
}
#plot(seq(1:5),cv.error[1:5])
min(cv.error)
which.min(cv.error)

# number of optimal interior knots = 2

#####
#(b)# 
#####
fit = lm(wage~bs(age,df=3+2,degree = 3), data=Wage)
pred=predict(fit,newdata=list(age=age.grid),se=T)
plot(age,wage,col="gray")
lines(age.grid,pred$fit,lwd=2,col="blue")

##############
# Question 3 #
##############

#####
#(a)# 
#####
agelims = range(age)
age.grid = seq(from = agelims[1], to = agelims[2])
cv.error=rep(0,4)

for(i in 1:4){
  set.seed(i)
  knots_x <- quantile(age, probs=c(.05*i, 1-.05*i))
  fit = glm(wage~ns(age,df=4,Boundary.knots = knots_x), data=Wage)
  cv.error[i] = cv.glm(Wage, fit, K=10)$delta[1]
}
#plot(seq(1:4),cv.error[1:4])
min(cv.error)
n = which.min(cv.error)
c(.05*n, 1-.05*n)
quantile(age, probs=c(.05*n, 1-.05*n))
# Optimal boundary quantiles = 0.05 0.95
# Location of the boundary knots = 24 61

#####
#(b)# 
#####
fit2 = glm(wage~ns(age,df=4,Boundary.knots = c(24,61)), data=Wage)
attr(terms(fit2), "predvars")
pred2=predict(fit2,newdata=list(age=age.grid),se=T)
plot(age,wage,col="gray")
lines(age.grid,pred2$fit,lwd=2,col="red")
lines(age.grid,pred$fit,lwd=2,col='blue')
