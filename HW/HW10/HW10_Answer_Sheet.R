###############################################################################
##                           HW 10 Answer Sheet         			    	##
##            	        Name :陳昱行   NTU ID:R11922045  	    	     	  ##
###############################################################################
rm(list = ls(all = T))


##############
# Question 1 #
##############
library(MASS)
library(gbm)
library(tree)
data(Boston)
attach(Boston)

#####
# a #
#####

tree.boston <- tree(medv ~ ., Boston) # "medv" is the median value of owner-occupied homes in $1000s.
plot(tree.boston)
text(tree.boston, pretty = 0)
set.seed(1)
cv.boston <- cv.tree(tree.boston, K = 100)
cv.boston
plot(cv.boston$size, cv.boston$dev, type = "b") # Here we see that the most complex tree is chosen, which has 9 terminal nodes. So the original tree is already optimal.


#####
# b #
#####

m <- c(1, 2, 3, 4)

f <- function(m) {
    set.seed(1)
    boost.model <- gbm(medv ~ ., data = Boston, distribution = "gaussian", n.trees = 1000, interaction.depth = m, shrinkage = 0.1, bag.fraction = 1, cv.folds = 10)
    return(boost.model)
}

models <- sapply(m, f)


# The optimal tree for m=1 is :
which.min(models[, 1]$cv.error)

# The optimal tree for m=2 is :
which.min(models[, 2]$cv.error)

# The optimal tree for m=3 is :
which.min(models[, 3]$cv.error)

# The optimal tree for m=4 is :
which.min(models[, 4]$cv.error)

#####
# c #
#####

models[, 1]$cv.error[which.min(models[, 1]$cv.error)]
models[, 2]$cv.error[which.min(models[, 2]$cv.error)]
models[, 3]$cv.error[which.min(models[, 3]$cv.error)]
models[, 4]$cv.error[which.min(models[, 4]$cv.error)]

# The smallest 10-fold cv error is the model with m = 3


##############
# Question 2 #
##############
rm(list = ls(all = T))
library(kmed)
attach(heart)
heart$class <- as.factor(ifelse(heart$class == 0, 0, 1))
heart$sex <- as.factor(ifelse(heart$sex == "TRUE", 1, 0))
heart$fbs <- as.factor(ifelse(heart$fbs == "TRUE", 1, 0))
heart$exang <- as.factor(ifelse(heart$exang == "TRUE", 1, 0))

#####
# a #
#####


tree.heart <- tree(class ~ ., heart, split = "gini")

plot(tree.heart, type = "uniform")
text(tree.heart, pretty = 0)

## Tree pruning
set.seed(1)
cv.heart <- cv.tree(tree.heart, FUN = prune.misclass, K = 10)

cv.heart
plot(cv.heart)
plot(cv.heart$size, cv.heart$dev, type = "b")
# Here we can see that the optimal tree has "5" terminal nodes.


prune.heart <- prune.misclass(tree.heart, best = 5) # We now create the pruned tree with 5 leaves (terminal nodes), which is shown to have the smallest cv error rate.
plot(prune.heart, type = "uniform")
text(prune.heart, pretty = 0)





## The optimal number of nodes = 5


#####
# b #
#####
library(randomForest)
# quartz()
# window()
par(mfrow = c(2, 2), mar = c(5, 5, 2, 2))
m <- c(2, 4, 8, 13)

rf.func <- function(m) {
    set.seed(1)
    return(randomForest(class ~ ., data = heart, mtry = m, ntree = 500))
}


rfs.heart <- sapply(m, rf.func)

plot.func <- function(rf) {
    plot(rf$err.rate[, 1], type = "l", xlab = "Number of Trees", ylab = "OOB error", cex.lab = 1.2, col = "red", main = paste("m = ", rf$mtry))
}

plot.func(rfs.heart[,1])
plot.func(rfs.heart[,2])
plot.func(rfs.heart[,3])
plot.func(rfs.heart[,4])
