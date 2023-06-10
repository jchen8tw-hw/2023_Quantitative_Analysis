###############################################################################
##                           HW 10 Solution            			    		         ##
###############################################################################
rm(list=ls(all=T))


##############
# Question 1 #
##############
library(MASS)
library(gbm)
library(tree)


#####
# a #
#####
tree.boston=tree(medv~.,Boston) # "medv" is the median value of owner-occupied homes in $1000s.
plot(tree.boston)
text(tree.boston,pretty=0)

set.seed(1)
cv.boston=cv.tree(tree.boston, K=100)
cv.boston
plot(cv.boston$size,cv.boston$dev,type='b') # Here we see that the most complex tree is chosen, which has 9 terminal nodes. So the original tree is already optimal.


#####
# b #
#####
set.seed(1)
boost.boston1 = gbm(medv~., data=Boston, distribution="gaussian", n.trees=1000, interaction.depth=1, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)

set.seed(1)
boost.boston2 = gbm(medv~., data=Boston, distribution="gaussian", n.trees=1000, interaction.depth=2, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)

set.seed(1)
boost.boston3 = gbm(medv~., data=Boston, distribution="gaussian", n.trees=1000, interaction.depth=3, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)

set.seed(1)
boost.boston4 = gbm(medv~., data=Boston, distribution="gaussian", n.trees=1000, interaction.depth=4, shrinkage = 0.1, bag.fraction = 1, cv.folds=10)

m1 = which.min(boost.boston1$cv.error)
m2 = which.min(boost.boston2$cv.error)
m3 = which.min(boost.boston3$cv.error)
m4 = which.min(boost.boston4$cv.error)

# The optimal tree for m=1 is :
m1

# The optimal tree for m=2 is :
m2

# The optimal tree for m=3 is :
m3

# The optimal tree for m=4 is :
m4


#####
# c #
#####

boost.boston1$cv.error[m1]
boost.boston2$cv.error[m2]
boost.boston3$cv.error[m3]
boost.boston4$cv.error[m4]

# The smallest 10-fold cv error is the model with m = 3


##############
# Question 2 #
##############
rm(list=ls(all=T))

High=as.factor(ifelse(Boston$medv<=22,"No","Yes"))
Boston=data.frame(Boston,High)

#####
# a #
#####

tree.boston=tree(High~.-medv,Boston, split = "gini")

plot(tree.boston, type = "uniform")
text(tree.boston,pretty=0)

## Tree pruning
set.seed(1)
cv.boston=cv.tree(tree.boston, FUN=prune.misclass ,K = 100)

cv.boston
plot(cv.boston)
plot(cv.boston$size,cv.boston$dev,type='b')
# Here we can see that the optimal tree has "5" terminal nodes.


prune.boston = prune.misclass(tree.boston,best=5) # We now create the pruned tree with 5 leaves (terminal nodes), which is shown to have the smallest cv error rate.
plot(prune.boston, type = "uniform")
text(prune.boston,pretty=0)


#####
# b #
#####
library(randomForest)

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




