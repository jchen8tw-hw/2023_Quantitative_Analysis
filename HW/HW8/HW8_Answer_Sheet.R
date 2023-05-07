###############################################################################
##                           HW 8 Answer Sheet         			    		 ##
##            	        Name :陳昱行   NTU ID:R11922045  	    	     	  ##
###############################################################################

##############
# Question 1 #
##############

#####
# (a)#
#####
rm(list = ls(all = T))
library(ISLR)
set.seed(1)
data(Auto)
attach(Auto)


# sample
train <- sample(nrow(Auto), nrow(Auto) %/% 2) # 50% sample

model1 <- lm(mpg ~ horsepower, subset = train)
model2 <- lm(mpg ~ horsepower + weight, subset = train)
model3 <- lm(mpg ~ horsepower + weight + acceleration, subset = train)

# Test MSE
mse1 <- mean((predict(model1, Auto) - mpg)[-train]^2)
mse2 <- mean((predict(model2, Auto) - mpg)[-train]^2)
mse3 <- mean((predict(model3, Auto) - mpg)[-train]^2)
min(mse1, mse2, mse3)
# Best model = model2
# Test MSE = 16.50505

#####
# (b)#
#####
rm(list = ls(all = T))
library(boot)
set.seed(1)
model1 <- glm(mpg ~ horsepower)
model2 <- glm(mpg ~ horsepower + weight)
model3 <- glm(mpg ~ horsepower + weight + acceleration)

LOOCV1 <- cv.glm(Auto, model1)
LOOCV2 <- cv.glm(Auto, model2)
LOOCV3 <- cv.glm(Auto, model3)

c(LOOCV1$delta[1], LOOCV2$delta[1], LOOCV3$delta[1])

# Best model = model2
# Test MSE = 18.11295

#####
# (c)#
#####
set.seed(1)
model1 <- glm(mpg ~ horsepower)
model2 <- glm(mpg ~ horsepower + weight)
model3 <- glm(mpg ~ horsepower + weight + acceleration)

kFCV1 <- cv.glm(Auto, model1, K = 10)
kFCV2 <- cv.glm(Auto, model2, K = 10)
kFCV3 <- cv.glm(Auto, model3, K = 10)

c(kFCV1$delta[1], kFCV2$delta[1], kFCV3$delta[1])



# Best model = model2
# Test MSE = 18.18335

##############
# Question 2 #
##############

#####
# (a)#
#####
rm(list = ls(all = T))
library(boot)
library(ISLR)
library(lmtest)
data(Auto)
attach(Auto)

B <- 1000
samples <- t(sapply(1:B, function(i) {
    set.seed(i)
    sample(nrow(Auto), nrow(Auto), replace = T)
}))

beta_1s <- apply(samples, 1, function(index) {
    model <- lm(mpg ~ horsepower, subset = index)
    return(coeftest(model)[2, 1])
})
sd(beta_1s)
# Paired Bootstrap estimation = 0.007306607

#####
# (b)#
#####

B <- 1000
samples <- t(sapply(1:B, function(i) {
    set.seed(i)
    sample(nrow(Auto), nrow(Auto), replace = T)
}))

model <- lm(mpg ~ horsepower)
u.hat <- residuals(model)
beta.hat <- model$coefficients[2]

beta_1s <- apply(samples, 1, function(index) {
    Y <- u.hat[index] + beta.hat * horsepower
    model <- lm(Y ~ horsepower)
    return(coeftest(model)[2, 1])
})

sd(beta_1s)


# Residual Bootstrap estimation = 0.006641035


