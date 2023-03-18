###############################################################################
##                           HW 3 Answer Sheet         			    		 ##
##            	        Name :陳昱行   NTU ID:R11922045  	    	     	  ##
###############################################################################

rm(list = ls(all = T))
data(mtcars) # load the data set "mtcars" from R
mtcars # use help(mtcars) to get help from the definition of this dataset in R
attach(mtcars)

##############
# Question 1 #
##############
rm(list = ls(all = T))


# (a)#

X <- as.matrix(data.frame(1, wt, hp, qsec, vs))
Y <- drat
beta.hat <- as.vector(solve(t(X) %*% X) %*% t(X) %*% Y)
epsilon.hat <- Y - t(beta.hat) %*% X
sigma2.hat <- (t(epsilon.hat) %*% (epsilon.hat)) / (dim(X)[1] - 4 - 1)

R <- t(as.vector(c(0, 1, 0, 0, 0)))

T <- R %*% beta.hat / (sqrt(sigma2.hat) * sqrt(R %*% solve(t(X) %*% X) %*% t(R)))
T

# (b)#

model <- lm(drat ~ wt + hp + qsec + vs)
coef(summary(model))["wt", ]["t value"]


##############
# Question 2 #
##############
rm(list = ls(all = T))


# (a)#
X <- as.matrix(data.frame(1, wt, hp, qsec, vs))
constraint.model <- lm(drat ~ qsec + vs)
unconstraint.model <- lm(drat ~ wt + hp + qsec + vs)

R2.ur <- summary.lm(unconstraint.model)$r.square
R2.r <- summary.lm(constraint.model)$r.square


F <- ((R2.ur - R2.r) / 2) / ((1 - R2.ur) / (dim(X)[1] - 5))
F

# (b)#

SSR.r <- sum(constraint.model$residuals**2)
SSR.ur <- sum(unconstraint.model$residuals**2)

F <- (SSR.r - SSR.ur) / 2 / SSR.ur * (dim(X)[1] - 5)
F

# (c)#

library(car)
R <- matrix(c(0, 1, 0, 0, 0, 0, 0, 1, 0, 0), byrow = TRUE, nrow = 2)
F <- linearHypothesis(unconstraint.model, R)$F[2]
F
