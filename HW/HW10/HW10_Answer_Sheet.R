###############################################################################
##                           HW 10 Answer Sheet         			    		       ##
##            	        Name :______   NTU ID:________  	    	     	    	 ##
###############################################################################
rm(list=ls(all=T))


##############
# Question 1 #
##############


#####
# a #
#####


#####
# b #
#####

# The optimal tree for m=1 is : 


# The optimal tree for m=2 is :


# The optimal tree for m=3 is :


# The optimal tree for m=4 is :


#####
# c #
#####



# The smallest 10-fold cv error is the model with m = 


##############
# Question 2 #
##############
rm(list=ls(all=T))
library(kmed)
heart$class = as.factor(ifelse(heart$class==0,0,1))
heart$sex = as.factor(ifelse(heart$sex=='TRUE',1,0))
heart$fbs = as.factor(ifelse(heart$fbs=='TRUE',1,0))
heart$exang = as.factor(ifelse(heart$exang=='TRUE',1,0))

#####
# a #
#####



## The optimal number of nodes = 
#####
# b #
#####





