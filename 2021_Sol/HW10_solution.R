###############################################################################
##                           HW 10 Solution            			    		         ##
###############################################################################
rm(list=ls(all=T))


##############
# Question 1 #
##############

p = seq(0, 1, 0.001)
gini = p * (1 - p) * 2
entropy = -(p * log(p) + (1 - p) * log(1 - p))
class.err = 1 - pmax(p, 1 - p)

plot(p, entropy, type = "l", xlab = "proportion of x in the second class", ylab=" Qm(T)", cex.lab = 1.2, col="blue", ylim=c(0,1)) 
lines(p, gini, col = "red") 
lines(p, class.err, col = "green") 
legend("topright",legend = c("Cross Entropy", "Gini Index", "Misclassification Error"),col = c("blue", "red", "green"), lty = c(1, 1, 1))

##############
# Question 2 #
##############
rm(list=ls(all=T))
library(MASS)
library(tree)
High=ifelse(Boston$medv<=22,"No","Yes") 
Boston=data.frame(Boston,High) 

#####
# a #
#####
tree.boston=tree(medv~.-High,Boston) # "medv" is the median value of owner-occupied homes in $1000s.
plot(tree.boston)
text(tree.boston,pretty=0)

set.seed(1)
cv.boston=cv.tree(tree.boston, K=10) 
cv.boston
plot(cv.boston$size,cv.boston$dev,type='b') # Here we see that the most complex tree is chosen, which has 9 terminal nodes. So the original tree is already optimal.

#The optimal number of nodes is 9

#####
# b #
#####
tree.boston=tree(High~.-medv,Boston, split = "gini") 

plot(tree.boston, type = "uniform") 
text(tree.boston,pretty=0)

## Tree pruning
set.seed(1)
cv.boston=cv.tree(tree.boston, FUN=prune.misclass ,K = 10) 

cv.boston
plot(cv.boston) 
plot(cv.boston$size,cv.boston$dev,type='b') 
# Here we can see that the optimal tree has "5" terminal nodes.


prune.boston = prune.misclass(tree.boston,best=5) # We now create the pruned tree with 5 leaves (terminal nodes), which is shown to have the smallest cv error rate.
plot(prune.boston, type = "uniform")
text(prune.boston,pretty=0)

#The optimal number of nodes is 5




