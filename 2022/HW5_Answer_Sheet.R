###############################################################################
##                           HW 5 Answer Sheet         			    		         ##
##            	        Name :ªL¯§Á¾   NTU ID:R10723079  	    	     	    	 ##
###############################################################################

install.packages("ivreg")
library(ivreg)
data("SchoolingReturns", package = "ivreg")
attach(SchoolingReturns)

##############
# Question 1 #
##############
wage = cbind(SchoolingReturns[,c('wage')])
edu = cbind(SchoolingReturns[,c('education')])
exp = cbind(SchoolingReturns[,c('experience')])
near = cbind(SchoolingReturns[,c('nearcollege')])
age = cbind(SchoolingReturns[,c('age')])
eth = SchoolingReturns[,c('ethnicity')]
eth<-ifelse(eth=="afam",1,0)
smsa = SchoolingReturns[,c('smsa')]
smsa<-ifelse(smsa=="yes",1,0)
south = SchoolingReturns[,c('south')]
south<-ifelse(south=="yes",1,0)
en = cbind(edu,exp,exp^2)
iv = cbind(near,age,age^2)
ex = cbind(eth,smsa,south)

#(a)# 
lm.stage1 = lm(en~iv+ex)
x.hat = fitted.values(lm.stage1)
#(b)# 
lm.stage2 = lm(log(wage)~x.hat+ex)
summary(lm.stage2)
lm.stage2$coefficients[2]
#(c)#
library(ivpack)
ivr = ivreg(log(wage) ~ en + ex | ex + iv)
ivr$coefficients[2]

