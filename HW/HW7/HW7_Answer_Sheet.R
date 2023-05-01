###############################################################################
##                           HW 7 Answer Sheet         			    		 ##
##            	        Name :陳昱行   NTU ID:R11922045  	    	     	  ##
###############################################################################
rm(list = ls(all = T))
##############
# Question 1 #
##############
library(AER)
data(HMDA)
summary(HMDA)
attach(HMDA)


#(a)#

bin_deny <- as.numeric(deny) - 1

denylogit <- glm(bin_deny ~ hirat, family = binomial(link = "logit"))
coeftest(denylogit, vcov. = vcovHC, type = "HC0")


#(b)#

predict(denylogit, newdata = data.frame("hirat" = c(0.3)), type = "response")

#(c)#

predict(denylogit, newdata = data.frame("hirat" = c(0.7)), type = "response")

#(d)#

denylogit2 <- glm(bin_deny ~ hirat + afam, family = binomial(link = "logit"))

#(e)#

predictions <- predict(denylogit2, newdata = data.frame("afam" = c("no", "yes"), "hirat" = c(0.3, 0.3)), type = "response")
diff(predictions)

#(f)#

predictions <- predict(denylogit2, newdata = data.frame("afam" = c("no", "yes"), "hirat" = c(0.7, 0.7)), type = "response")
diff(predictions)
