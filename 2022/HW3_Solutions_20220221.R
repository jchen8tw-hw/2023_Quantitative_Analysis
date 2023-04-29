###############################################################################
##                           Solution to HW 3          			    		         ##
##            	 Quantitative Analysis - 2022 Spring        		     	    	 ##
###############################################################################

rm(list=ls(all=T))
data(mtcars)  # load the data set "mtcars" from R
mtcars        # use help(mtcars) to get help from the definition of this dataset in R
attach(mtcars)

##############
# Question 1 #
##############
rm(list=ls(all=T))


#(a)#
X = cbind(1,mtcars$wt,mtcars$hp,mtcars$qsec,mtcars$vs)
y = mtcars$drat
beta_hat = solve(t(X)%*%X)%*%t(X)%*%y
y_hat = X%*% beta_hat
sigma_hat_squared = sum((y-y_hat)^2)/(nrow(mtcars)-4-1) # note that n=nrow(mtcars), k=4
var_beta_hat = sigma_hat_squared*solve(t(X)%*%X)
t_statistic = beta_hat[2]/(var_beta_hat[2,2]^0.5)
t_statistic

#(b)#
summary(lm(drat~wt+hp+qsec+vs))$"coefficients"[2,3] #which is identical to (a)

# Or we can use the function all.equal(), which tests for ¡¥near equality¡¦
all.equal(t_statistic,summary(lm(drat~wt+hp+qsec+vs))$"coefficients"[2,3])

##############
# Question 2 #
##############
rm(list=ls(all=T))


#(a)#
R_ur = summary(lm(drat~wt+hp+qsec+vs))$r.squared #R-square for unconstrained model
R_r  = summary(lm(drat~qsec+vs))$r.squared #R-square for constrained model
F_R.square = ( (R_ur - R_r)/2 ) / ( (1-R_ur) / (nrow(mtcars)-4-1) ) 
F_R.square


#(b)#
e_ur = summary(lm(drat~wt+hp+qsec+vs))$residuals
e_r = summary(lm(drat~qsec+vs))$residuals

SSR_ur = sum(e_ur^2)
SSR_r = sum(e_r^2)

F_SSR = ( (SSR_r-SSR_ur)/2 )/ ( SSR_ur / (nrow(mtcars)-4-1) )
F_SSR #which is identical to (a)


#(c)# 
library(car)
library(sandwich)

result = linearHypothesis(lm(drat~wt+hp+qsec+vs),c("wt=0", "hp=0")) 
names(result)
result$F #which is identical to (a)
