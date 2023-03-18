###############################################################################
##                           HW 2 Answer Sheet         			    		 ##
##            	        Name :陳昱行   NTU ID:R11922045  	    	     	  ##
###############################################################################

##############
# Question 1 #
##############
#(a)#

X <- matrix(c(7,2,3,4,6,7,9,2,0,0,9,0,5,3,5),nrow=5,byrow=TRUE)
Y <- as.vector(c(6,2,4,2,1))

beta.hat <- solve(t(X) %*% X) %*% t(X) %*% Y
beta.hat

#(b)#

x.star <- t(as.vector(c(0,4,3)))
y.hat <-  x.star %*% beta.hat
y.hat

##############
# Question 2 #
##############
rm(list=ls(all=T))
data(mtcars)  # load the data set "mtcars" from R
mtcars        # use help(mtcars) to get help from the definition of this dataset in R
attach(mtcars)

#(a)#

mtcars["Duster 360",]

#(b)#

data.frame(row.names=row.names(mtcars),qsec)

#(c)#

mtcars[cyl == 6,]

#(d)#

row.names(mtcars)[mpg > 15 & vs == 1 & hp <= 150 & hp >=50]

#(e)#

raw.X <- data.frame(1,wt,hp,qsec,vs,row.names=row.names(mtcars))
raw.Y <- data.frame(drat,row.names=row.names(mtcars))

X <- as.matrix(raw.X)
Y <- as.matrix(raw.Y)

beta.hat <- as.vector(solve(t(X) %*% X) %*% t(X) %*% Y)
names(beta.hat) <- c("(Intercept)", "wt","hp","qsec","vs" )
beta.hat

#(f)#

model <- lm(drat ~ wt + hp + qsec + vs)
coef(model)
