###############################################################################
##                           HW 10 Answer Sheet         			    		       ##
##            	        Name :ªL¯§Á¾   NTU ID:R10723079  	    	     	    	 ##
###############################################################################
rm(list=ls(all=T))
library(tree)
library(MASS)
attach(Boston)
##############
# Question 1 #
##############


#####
# a #
#####
set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston=tree(medv~.,Boston,subset=train) # "medv" is the median value of owner-occupied homes in $1000s.
set.seed(1)
cv.boston=cv.tree(tree.boston, K=100)
cv.boston
plot(cv.boston$size,cv.boston$dev,type='b')
set.seed(1)
plot(tree.boston)
text(tree.boston,pretty=0)
#####
# b #
#####
library(gbm)
library(MASS)

set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)

set.seed(1)
boost.boston1 = gbm(medv~., data=Boston[train,], distribution="gaussian", n.trees=1000, interaction.depth=1, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)
A1 = which.min(boost.boston1$cv.error)
A1

set.seed(1)
boost.boston2 = gbm(medv~., data=Boston[train,], distribution="gaussian", n.trees=1000, interaction.depth=2, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)
A2 = which.min(boost.boston2$cv.error)
A2

set.seed(1)
boost.boston3 = gbm(medv~., data=Boston[train,], distribution="gaussian", n.trees=1000, interaction.depth=3, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)
A3 = which.min(boost.boston3$cv.error)
A3

set.seed(1)
boost.boston4 = gbm(medv~., data=Boston[train,], distribution="gaussian", n.trees=1000, interaction.depth=4, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)
A4 = which.min(boost.boston4$cv.error)
A4
# The optimal tree for m=1 is : 999
# The optimal tree for m=2 is : 976
# The optimal tree for m=3 is : 620
# The optimal tree for m=4 is : 513


#####
# c #
#####
B1=min(boost.boston1$cv.error)
B2=min(boost.boston2$cv.error)
B3=min(boost.boston3$cv.error)
B4=min(boost.boston4$cv.error)
which.min(c(B1,B2,B3,B4))

# The smallest 10-fold cv error is the model with m = 4


##############
# Question 2 #
##############
rm(list=ls(all=T))


#####
# a #
#####
High=as.factor(ifelse(medv<=22,"No","Yes"))
Boston=data.frame(Boston,High)
set.seed(1)
tree.boston=tree(High~.-medv,Boston, split = "gini", mincut = 5)
set.seed(1)
cv.boston = cv.tree(tree.boston, FUN = prune.misclass, K = 100)
cv.boston
plot(cv.boston$size,cv.boston$dev,type='b')
prune.boston = prune.misclass(tree.boston, best = 5)
plot(prune.boston)
text(prune.boston,pretty=0)
#####
# b #
#####
library(randomForest)

set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)

set.seed(1)
bag.boston=randomForest(High~.-medv, data=Boston, mtry=(ncol(Boston)-2), ntree=500,importance=TRUE)

set.seed(1)
rf.boston=randomForest(High~.-medv,data=Boston,mtry=3,importance=TRUE)

plot(bag.boston$err.rate[,1], type = "l", xlab = "Number of Trees", ylab = "OOB error", cex.lab = 1.2, col="blue", ylim=c(0.08, 0.2)) # OOB error for bagging
a =length(rf.boston$err.rate[,1])
lines(seq(from = 1,to = a, length =a), rf.boston$err.rate[,1], col = "red") # OOB error for random forest
legend("topright",legend = c("Bagging", "Random Forest"),col = c("blue", "red"), lty = c(1, 1))
