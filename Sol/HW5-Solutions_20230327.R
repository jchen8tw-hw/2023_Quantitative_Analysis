###############################################################################
##                           Solution to HW 5          			    		         ##
##            	  Quantitative Analysis - 2023 Spring     	    	     	     ##
###############################################################################

install.packages("ivreg")
library(ivreg)
data("SchoolingReturns", package = "ivreg")
attach(SchoolingReturns)

##############
# Question 1 #
##############

#(a)# 
exper_sqr =  experience^2
age_sqr = age^2
lm.stage1_1 = lm(education ~ nearcollege + age + age_sqr + ethnicity + smsa + south, data = SchoolingReturns)
x_1.hat = fitted.values(lm.stage1_1)
lm.stage1_2 = lm(experience ~ nearcollege + age + age_sqr + ethnicity + smsa + south, data = SchoolingReturns)
x_2.hat = fitted.values(lm.stage1_2)
lm.stage1_3 = lm(exper_sqr ~ nearcollege + age + age_sqr + ethnicity + smsa + south, data = SchoolingReturns)
x_3.hat = fitted.values(lm.stage1_3)

#(b)# 
lm.stage2 = lm(log(wage)~ x_1.hat + x_2.hat + x_3.hat + ethnicity + smsa + south, data = SchoolingReturns)
lm.stage2$coefficients[2]

#(c)#
lm.iv = ivreg(log(wage) ~ education + experience + exper_sqr + ethnicity + smsa + south |
                nearcollege +  age + age_sqr + ethnicity + smsa + south,
              data = SchoolingReturns)
lm.iv$coefficients[2]




