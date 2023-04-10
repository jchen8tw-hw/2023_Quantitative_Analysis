###############################################################################
##                           HW 11 Solution            			    		         ##
###############################################################################
rm(list=ls(all=T))

##############
# Question 1 #
##############
library(MASS)
library(tree)
High=ifelse(Boston$medv<=22,"No","Yes") 
Boston=data.frame(Boston,High) 

#####
# a #
#####
library(randomForest)

set.seed(1)
bag.boston=randomForest(High~.-medv, data=Boston, mtry=13, ntree=500,importance=TRUE)

bag.boston

importance(bag.boston)
varImpPlot(bag.boston,type=2) 

# the variable that decrease the Gini index the most (hence most important) according to this model is: lstat


#####
# b #
#####

set.seed(1)
bag.boston=randomForest(High~.-medv, data=Boston, mtry=13, ntree=500)

set.seed(1)
rf.boston=randomForest(High~.-medv, data=Boston, mtry=3, ntree=500)

bag.boston$err.rate[,1] # These are the OOB error of bagging for each given number of trees.
rf.boston$err.rate[,1] # These are the OOB error of random forest for each given number of trees.


plot(rf.boston$err.rate[,1], type = "l", xlab = "Number of Trees", ylab = "OOB error", cex.lab = 1.2, col="red") 
a =length(bag.boston$err.rate[,1])
lines(seq(from = 1,to = a, length =a), bag.boston$err.rate[,1], col = "blue") 
legend("topright",legend = c("Bagging", "Random Forest"),col = c("blue", "red"), lty = c(1, 1))


#####
# c #
#####
rm(list=ls(all=T))
library(gbm)
library(MASS)

set.seed(1)
boost.boston1 = gbm(medv~., data=Boston, distribution="gaussian", n.trees=1000, interaction.depth=1, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)

set.seed(1)
boost.boston2 = gbm(medv~., data=Boston, distribution="gaussian", n.trees=1000, interaction.depth=2, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)

set.seed(1)
boost.boston3 = gbm(medv~., data=Boston, distribution="gaussian", n.trees=1000, interaction.depth=3, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)

set.seed(1)
boost.boston4 = gbm(medv~., data=Boston, distribution="gaussian", n.trees=1000, interaction.depth=4, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)

d1 = which.min(boost.boston1$cv.error)
d2 = which.min(boost.boston2$cv.error)
d3 = which.min(boost.boston3$cv.error)
d4 = which.min(boost.boston4$cv.error)

# The optimal tree for d=1 is : 
d1

# The optimal tree for d=2 is :
d2

# The optimal tree for d=3 is :
d3

# The optimal tree for d=4 is :
d4


#####
# d #
#####

boost.boston1$cv.error[d1]
boost.boston2$cv.error[d2]
boost.boston3$cv.error[d3]
boost.boston4$cv.error[d4]

# The smallest 10-fold cv error is the model with d = 3




