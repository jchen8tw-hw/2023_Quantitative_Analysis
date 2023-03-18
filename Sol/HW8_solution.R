###############################################################################
##                           HW 8 Solution            			    		         ##
###############################################################################
rm(list=ls(all=T))


##############
# Question 1 #
##############

library(boot)
library(ISLR)
data(Wage)
Wage

#####
#(a)# 
#####
candidateK = 10
cv.error=rep(candidateK)
for(i in 1:candidateK){
  poly.fit = glm(wage~poly(age,i), data =  Wage)
  cv.error[i] = cv.glm(Wage, poly.fit, K=10)$delta[2]
}
plot(seq(1:candidateK),cv.error[1:candidateK])
min(cv.error)
which.min(cv.error) 

# optimal degree = 10

#####
#(b)# 
#####
agelims = range(Wage$age)
age.grid = seq(from = agelims[1], to = agelims[2])
poly.fit = glm(wage~poly(age,10), data =  Wage)
pred = predict(poly.fit,newdata = list(age=age.grid))
plot(Wage$age,Wage$wage)
lines(age.grid,pred,col='red',lwd=3)



##############
# Question 2 #
##############

#####
#(a)# 
#####
candidateCutpoint = 15
cv.error=rep(0,candidateCutpoint)
for(i in 1:candidateCutpoint){
  ageCut <- cut(Wage$age,i+1)
  data = data.frame(ageCut,Wage$wage)
  step.fit=glm(Wage.wage~ageCut, data=data)
  cv.error[i] = cv.glm(data, step.fit, K=10)$delta[2]
}
plot(seq(1:candidateCutpoint),cv.error[1:candidateCutpoint])
min(cv.error)
which.min(cv.error) 

# optimal cutpoint = 15

#####
#(b)# 
#####
step.fit=glm(wage~cut(age,breaks = 15+1),data=Wage)
agelims = range(Wage$age)
age.grid = seq(from = agelims[1], to = agelims[2])
pred = predict(step.fit, newdata = list(age=age.grid))
plot(Wage$age,Wage$wage)
lines(age.grid,pred,col='red',lwd=3)
