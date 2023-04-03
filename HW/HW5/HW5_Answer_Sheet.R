###############################################################################
##                           HW 5 Answer Sheet         			    		 ##
##            	        Name :陳昱行   NTU ID:R11922045  	    	     	  ##
###############################################################################
rm(list = ls(all = T))
# install.packages("ivreg",dependencies=TRUE)
library(ivreg)
data("SchoolingReturns", package = "ivreg")
attach(SchoolingReturns)

##############
# Question 1 #
##############
# (a)#

education.stage1 <- lm(education ~ ethnicity + smsa + south + nearcollege + age + I(age^2))
education.hat <- fitted.values(education.stage1)
experience.stage1 <- lm(experience ~ ethnicity + smsa + south + nearcollege + age + I(age^2))
experience.hat <- fitted.values(experience.stage1)
experience.square.stage1 <- lm(I(experience^2) ~ ethnicity + smsa + south + nearcollege + age + I(age^2))
experience.square.hat <- fitted.values(experience.square.stage1)

# (b)#

log.wage.stage2 <- lm(I(log(wage)) ~ education.hat + experience.hat + experience.square.hat + ethnicity + smsa + south)
coef(log.wage.stage2)


# (c)#

log.wage.iv <- ivreg(log(wage) ~ ethnicity + smsa + south | education + experience + I(experience^2) | nearcollege + age + I(age^2))
coef(log.wage.iv)

