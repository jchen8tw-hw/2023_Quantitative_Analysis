###############################################################################
##                           HW 7 Solution            			    		         ##
###############################################################################
rm(list=ls(all=T))

library(ISLR)
fix(Hitters)
names(Hitters)
dim(Hitters) 
sum(is.na(Hitters$Salary)) #There are 59 samples with missing information.
Hitters=na.omit(Hitters)
dim(Hitters) #The remaining 263 samples with full information.



##############
# Question 1 #
##############

library(leaps)
ncol(Hitters)
best.fit = regsubsets(Salary~.,Hitters,nvmax=19) 
summary.fit = summary(best.fit)  
which.min(summary.fit$bic)
coef(best.fit,6) 


##############
# Question 2 #
##############

backward.fit = regsubsets(Salary~.,Hitters,nvmax=19,method = "backward") 
summary.fit = summary(backward.fit) 
which.min(summary.fit$bic)
coef(backward.fit,8) 

##############
# Question 3 #
##############

forward.fit = regsubsets(Salary~.,Hitters,nvmax=19,method = "forward") 
summary.fit = summary(forward.fit) 
which.min(summary.fit$bic)
coef(forward.fit,6) 

##############
# Question 4 #
##############
library(boot)

lm.fit.best = glm(Salary~AtBat+Hits+Walks+CRBI+Division+PutOuts , data = Hitters)
lm.fit.backward = glm(Salary~AtBat+Hits+Walks+CRBI+Division+PutOuts +CRuns +CWalks , data = Hitters)
lm.fit.forward = glm(Salary~AtBat+Hits+Walks+CRBI+Division+PutOuts , data = Hitters)

set.seed(1)
KFCV.best=cv.glm(Hitters,lm.fit.best,K=10) 
set.seed(1)
KFCV.backward=cv.glm(Hitters,lm.fit.backward,K=10)
set.seed(1)
KFCV.forward=cv.glm(Hitters,lm.fit.forward,K=10)

c(KFCV.best$delta[2],KFCV.backward$delta[2], KFCV.forward$delta[2]) 

# which model is better: Backward stepwise.

##############
# Question 5 #
##############

#####
#(a)# 
#####

X = model.matrix(Salary~.,Hitters)[,-1] #design matrix without intercept.
Y= Hitters$Salary
library(glmnet) 

ridge.fit = glmnet(X,Y,alpha = 0) 


ridge.LOOCV = cv.glmnet(X,Y,alpha=0, nfolds=nrow(X))#Choosing the optimal lambda with LOOCV.
best.s = ridge.LOOCV$lambda.min 
best.s 

#Best lambda = 25.52821

#####
#(b)# 
#####

predict(ridge.fit, type = "coefficients", s=best.s) # Fitted values for optimal lambda.

# Coefficient for "Hits" = 2.772312


##############
# Question 6 #
##############

#####
#(a)# 
#####

LASSO.fit = glmnet(X,Y,alpha = 1) 

LASSO.LOOCV = cv.glmnet(X,Y,alpha=1, nfolds=nrow(X))
best.s = LASSO.LOOCV$lambda.min 
best.s 

#Best lambda = 2.674375


#####
#(b)# 
#####

predict(LASSO.fit, type = "coefficients", s=best.s) # Fitted values for optimal lambda.

# How many variables are forced to zero = 6
