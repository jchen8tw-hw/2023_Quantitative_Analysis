###############################################################################
##                           Solution to HW 2          			    		         ##
##            	 Quantitative Analysis - 2022 Spring        		     	    	 ##
###############################################################################

##############
# Question 1 #
##############
#(a)# 
X = cbind(c(1,1,1,1,1),c(7,4,9,0,5), c(2,6,2,9,3), c(3,7,0,0,5))
Y = c(6,2,4,2,1)
b_hat = solve(t(X)%*%X)%*%(t(X)%*%Y)

#(b)# 
x=c(1,0,4,3)
y_hat = t(x)%*%b_hat


##############
# Question 2 #
##############
rm(list=ls(all=T))
data(mtcars)  # load the data set "mtcars" from R
mtcars        # use help(mtcars) to get help from the definition of this dataset in R
attach(mtcars)

#(a)# 
mtcars["Camaro Z28",] 

#(b)#
mtcars$wt

#(c)#
mtcars[mtcars$gear==3,]
  #or
subset(mtcars,gear==3) 

#(d)# 
subset(mtcars,mpg>10 & cyl==6 & hp<110 & hp>90)

#(e)#
X = cbind(rep(1,nrow(mtcars)), mtcars$wt, mtcars$hp, mtcars$qsec, mtcars$vs)
Y = mtcars$drat
b_hat = solve(t(X)%*%X)%*%(t(X)%*%Y)
b_hat

#(f)#
summary(lm(drat~wt+hp+qsec+vs,data = mtcars))$"coefficients"
      