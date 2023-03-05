###############################################################################
##                           HW 1 Answer Sheet         			    		 ##
##            	        Name :陳昱行  NTU ID:R11922045  	    	     	 ##
###############################################################################

##############
# Question 1 #
##############
#(a)#

x <- c(1:150)

#(b)#

x[x > 135 | x <= 5]

#(c)#

x[ x > 70 & x < 90]

#(d)#

x[ x %% 4 == 0 & x %% 5 == 0]

##############
# Question 2 #
##############


#(a)#

X <- rnorm(150000, mean = 0, sd = 1)

#(b)#

# mean
mean(X)
# median max min
quantile(X, probs = c(0.5,1,0))
# variance
var(X)

#(c)#

Y <- sample(X,5000,replace=FALSE)

# mean of Y
mean(Y)

# Var of Y
var(Y)


#(d)#

Z <- sample(X,5000, replace=TRUE)

# mean
mean(Z)

# variance
var(Z)


#(e)#

quantile(X,probs=c(0.45))
z <-qnorm(0.45)

#(f)#

# Prob(x \in (-0.55,1.25] | x \in X)
length(X[ X > 0.55 & X<=1.25 ])/length(X)
# Prob(x \in (-0.55,1.25] | x ~ N(0,1))
pnorm(1.25) - pnorm(-0.55)


##############
# Question 3 #
##############
#(a)#

X  <- matrix(data=c(rep(1,6),seq(2,12,2),seq(1,16,3)),ncol=3)

#(b)#

Y <- matrix(c(1:6,9:4),ncol=2)

#(c)#

Z <- cbind(X[,1] + Y[,1],X[,2],X[,3]-2*Y[,2])

