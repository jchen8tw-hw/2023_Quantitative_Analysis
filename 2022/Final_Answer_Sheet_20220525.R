###############################################################################
##                          Final Exam Answer Sheet                          ##
###############################################################################

##############
# Question 1 # +10
##############

set.seed(1)
X = rnorm(100,10,1)
set.seed(2)
Y = rnorm(100,10,1)
set.seed(1)

Z = NULL
for (i in 1:10000) {
  set.seed(i)
  index = sample(100,100, replace = T)
  X_bar = mean(X[index])
  Y_bar = mean(Y[index])
  Z[i] = X_bar^5 / (X_bar+Y_bar)^2
  
}
sd(Z)
## Estimated variance of hat.z = 10.21034


##############
# Question 2 #
##############

#####
# a # +5
#####
library(glmnet)
rm(list=ls(all=T))


n = 55
R = 100
grid = seq(0,2,length = 100)
Result_lasso_1 = 0
Lambda_1 = 0
count = NULL
summary.fit = NULL
for (r in 1:R) {
  
  # generate dataset X
  X = matrix(nrow = n, ncol = 50)
  set.seed(r)
  X = matrix(rnorm(55*50),nrow = 55)

  # generate residuals
  set.seed(r)
  e = rnorm(n)
  
  y_DGP1 = 2 + X[,1] + X[,2] + e
  data = data.frame(X,y_DGP1)
  lasso.fit_1 = glmnet(X[,1:50],y_DGP1, alpha = 1, lambda = grid)
  Result_lasso_1 = Result_lasso_1 + (1/R)*coef(lasso.fit_1)[2:51,]
  if (coef(lasso.fit_1)[2,] != 0){
    count[r]=1
  }else{
    count[r]=0
  }
  lasso.kfold_1 = cv.glmnet(X[,1:50],y_DGP1,alpha=0, nfolds=10, lambda = grid)  
  best.s1 = lasso.kfold_1$lambda.min
  Lambda_1 = Lambda_1 + (1/R)*best.s1
  backward.fit = regsubsets(y_DGP1~.,data,nvmax=50,method = "backward")
  a = which.min(summary(backward.fit)$bic)
  summary.fit[r] = coef(backward.fit,a)
}
sum(count)/100
#LASSO selection rate for x1 = 43%

#####
# b # +5
#####
library(leaps)
backward.fit = regsubsets(y_DGP1~.,data,nvmax=50,method = "backward")
summary(backward.fit)
a = which.min(summary(backward.fit)$bic)
summary.fit = coef(backward.fit,a)
summary.fit
#Backward selection rate for x1 = ______%


#####
# c # +5
#####

#Bias for LASSO = ______
#Bias for Backward = ______ 
#Bias for OLS = ______


#Variance for LASSO = ______ 
#Variance for Backward = ______ 
#Variance for OLS = ______


#MSE for LASSO =   
#MSE for Backward = 
#MSE for OLS = 



##############
# Question 3 #
##############
library(ISLR)
attach(Wage)
library(splines)
#####
# a # +5
#####
test=Wage[,"wage"]
age = Wage[,"age"]
ns.fit=glm(wage~ns(age,knots=c(25,40,60),df=6,Boundary.knots = c(10,70) ),data=Wage) # Here we fit a natural spline with "i+1" degrees of freedom (which is a natural cubic spline with "i" knots)
sum(ns.fit$residuals^2)
## RSS for this model = 4774436

#####
# b # +5
#####
fit=loess(wage~age,span=.5,data=Wage) 
sum(fit$residuals^2)

## RSS for this model = 4760377

#####
# c # +5
#####
library(gam)
mid = median(year)
gam.3d=gam(wage~ns(year,knots = c(mid))+cut(age,breaks = 5),data=Wage) 
sum(gam.3d$residuals^2)

## RSS for this model = 4855532


##############
# Question 4 #
##############
library(kmed)
attach(heart)
heart$class = as.factor(ifelse(heart$class==0,0,1))
heart$sex = as.factor(ifelse(heart$sex=='TRUE',1,0))
heart$fbs = as.factor(ifelse(heart$fbs=='TRUE',1,0))
heart$exang = as.factor(ifelse(heart$exang=='TRUE',1,0))


#####
# a # +5
#####
library(tree)
set.seed(1)
tree.heart=tree(class~.,heart, split = "gini")
set.seed(1)
cv.heart=cv.tree(tree.heart, FUN=prune.misclass ,K = 10) 
cv.heart
names(cv.heart)
plot(cv.heart)
## The optimal number of nodes = 5or7

#####
# b # +10
#####
library(randomForest)

set.seed(1)
rf.2=randomForest(class~., data=heart, mtry=2,importance=TRUE)
set.seed(1)
rf.4=randomForest(class~., data=heart, mtry=4,importance=TRUE)
set.seed(1)
rf.10=randomForest(class~., data=heart, mtry=10,importance=TRUE)
set.seed(1)
rf.13=randomForest(class~., data=heart, mtry=13,importance=TRUE)


plot(rf.2$err.rate[,1], type = "l", xlab = "Number of Trees", ylab = "OOB error", cex.lab = 1.2, col="blue")
a =length(rf.4$err.rate[,1])
lines(seq(from = 1,to = a, length =a), rf.4$err.rate[,1], col = "red") 
a1=length(rf.10$err.rate[,1])
lines(seq(from = 1,to = a1, length =a1), rf.10$err.rate[,1], col = "green")
a2=length(rf.13$err.rate[,1])
lines(seq(from = 1,to = a2, length =a2), rf.13$err.rate[,1], col = "yellow")
legend("topright",legend = c("2", "4","10", "13"),col = c("blue", "red","green", "yellow"), lty = c(1, 1))






##############
# Question 5 #
##############




#####
# a # +5
#####
library(MASS)
attach(Boston)
library(glmnet)

X = model.matrix(medv~.,Boston)[,-1] #design matrix without intercept.
Y= Boston$medv

library(glmnet)
grid = seq(0,1,length = 100)
set.seed(1)
lasso.fit = glmnet(X,Y,alpha = 1, lambda = grid)
set.seed(1)
lasso.kfold = cv.glmnet(X,Y,alpha=1, nfolds=10, lambda = grid)
best.s = lasso.kfold$lambda.min 
best.s 

predict(lasso.fit, type = "coefficients", s=best.s)
## Optimal lambda = 0.03030303

#####
# b # +5
#####
set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)
fit = lm(medv~crim+zn+chas+nox+rm+dis+rad+tax+ptratio+black+lstat,subset = train)
mean((predict(fit, Boston) - medv)[-train]^2)


## test MSE = 26.85842

#####
# c # +5
#####
data = Boston
n <- names(data)
set.seed(1)
index = sample(1:nrow(Boston), nrow(Boston)/2)
maxs <- apply(data, 2, max)
mins <- apply(data, 2, min)
scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins)) 
set.seed(1)
train_ <- scaled[index,]
test_ <- scaled[-index,]

library(neuralnet)
n <- names(train_)
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + "))) 
nn <- neuralnet(formula=f,data=train_,hidden=c(5,4,3,2),linear.output=T)
windows()
plot(nn)

pr.nn <- compute(x = nn, covariate = test_[,1:13]) 
pr.nn_ <- pr.nn$net.result*( max(data$medv)-min(data$medv) ) + min(data$medv) 
MSE.nn <- sum((test_$medv - pr.nn_)^2)/nrow(test_)
MSE.nn




## test MSE = 569.7118