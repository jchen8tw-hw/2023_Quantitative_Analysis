###############################################################################
##                           HW 5 Answer Sheet         			    		         ##
##            	        Name :ªL¯§Á¾   NTU ID:R10723079  	    	     	    	 ##
###############################################################################

##############
# Question 1 #
##############
library(AER)
data(HMDA)
HMDA
#(a)# 
HMDA$deny = as.numeric(HMDA$deny) - 1
denylogit <- glm(deny ~ hirat,family = binomial(link = "logit"), data = HMDA)
coeftest(denylogit, vcov. = vcovHC, type = "HC0")
#(b)# 
predict(denylogit,newdata = data.frame("hirat" = c(0.2)),type = "response")
#(c)#
predict(denylogit,newdata = data.frame("hirat" = c(0.8)),type = "response")
#(d)# 
denylogit2 <- glm(deny ~ hirat+afam,family = binomial(link = "logit"), data = HMDA)
coeftest(denylogit2, vcov. = vcovHC, type = "HC0")
#(e)#
predictions <- predict(denylogit2,newdata = data.frame("afam" = c("no", "yes"),"hirat" = c(0.2, 0.2)),type = "response")
diff(predictions)
#(f)#
predictions <- predict(denylogit2,newdata = data.frame("afam" = c("no", "yes"),"hirat" = c(0.8, 0.8)),type = "response")
diff(predictions)


