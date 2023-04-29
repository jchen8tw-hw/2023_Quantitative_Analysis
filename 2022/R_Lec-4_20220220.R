#########################################################################################
##                     R LECTURE 4: 1. ATE in a DID model                              ##
##                                  2. Testing with heteroskedasticity                 ##     
##    	             Quantitative Analysis - 2022 Spring  3/14   		     	             ##
#########################################################################################
#
#
###############################################################################
##                                Author                                     ##
##                            Spencer Wang                                   ##
##            	             ½²¦wª´ Amy Tsai       		    	    	           ##
###############################################################################


##############################################################
# Section 1:  ATE in a DID model                             #
##############################################################

#reference: https://dss.princeton.edu/training/

rm(list=ls(all=T))

# Getting sample data.
mydata = read.csv("C:\\Users\\User\\Desktop\\Panel101.csv",fileEncoding = "UTF-8-BOM")

# Create a dummy variable to indicate the time when the treatment started.(Denoted as "T" in our lecture slides)
# Lets assume that treatment started in 1994. In this case, years before 1994 will have a value of 0 and 1994+ a 1.
mydata$time = ifelse(mydata$year >= 1994, 1, 0)

# Create a dummy variable to identify the group exposed to the treatment. (Denoted as "D" in our lecture slides)
# Lets assumed that countries E, F and G were treated (=1).Countries A-D were not treated (=0).
mydata$treated = ifelse(mydata$country == "E" |
                          mydata$country == "F" |
                          mydata$country == "G", 1, 0)

# Create an interaction between time and treated. We will call this interaction ¡¥did¡¦. (Denoted as "J" in our lecture slides)
mydata$did = mydata$time * mydata$treated

mydata #Now we have added time(T), treated(D) and did(J) in our model

# Estimating the DID estimator
didreg = lm(outcome ~ treated + time + did, data = mydata)
summary(didreg) # The coefficient for ¡¥did¡¦(-2.520e+09) is the DID estimator. (Denoted as "£_" in our lecture slides)
#The effect is significant at 10% with the treatment having a negative effect.


####################################################################
# Section 2:  Testing with heteroskedasticity                      #
####################################################################
#------------
# Coef Tests 
#------------
rm(list=ls(all=T))

# constructing data

n=500
x = rnorm(n, mean=0, sd=1)
epsilon = abs(x)*rnorm(n, mean=0, sd=30) 
y = 2 + 5*x + epsilon  # Note that y (and epsilon) are no longer iid, in fact, they are heteroskedastic.


# Now in order to test the coefficients, we first has to install the package "lmtest"
library(lmtest) # call the package
lm.fit = lm(y~x)
coeftest(lm.fit) # IID assumptions

# Since we know the IID assumption no longer holds, we need the package "sandwich" to construct new estimators
library(sandwich)
coeftest(lm.fit, vcov = vcovHC, type = "HC0") # Ecker-White estimator 
vcovHC(lm.fit)                                # the Ecker-White covariance matrix

#---------------------------
# Testing linear hypothesis
#---------------------------

# we first construct the data
rm(list=ls(all=T))
# constructing data
n=500
x_1 = rnorm(n, mean=0, sd=10)
x_2 = rnorm(n, mean=0, sd=10)
x_3 = rnorm(n, mean=0, sd=10)
x_4 = rnorm(n, mean=0, sd=10)
epsilon = abs(x_1)*rnorm(n, mean=0, sd=30) 
y = 5 + 1*x_1 + 2*x_2 + 3*x_3 + 4*x_4 + epsilon
lm.fit = lm(y~x_1+x_2+x_3+x_4)

# First we need to install the package "car"
# Now we wish to test "b1=b2=b3=b4=1", the following code will do the trick
library(car)
library(sandwich)
linearHypothesis(lm.fit,c("x_1 = 1", "x_2 = 1", "x_3 = 1", "x_4 = 1")) # linear hypothesis with IID assumption
linearHypothesis(lm.fit,c("x_1 = 1", "x_2 = 1", "x_3 = 1", "x_4 = 1"),vcov = vcovHC, type = "HC0") #linear hypothesis with Ecker-White covariance matrix

# For the test "b1=1, b2=2, b3=3, b4=4"
linearHypothesis(lm.fit,c("x_1 = 1", "x_2 = 2", "x_3 = 3", "x_4 = 4")) #linear hypothesis with IID assumptions.
linearHypothesis(lm.fit,c("x_1 = 1", "x_2 = 2", "x_3 = 3", "x_4 = 4"),vcov = vcovHC, type = "HC0") #linear hypothesis with Ecker-White covariance matrix.

# For the test "b1+b2+b3 = 6"
linearHypothesis(lm.fit,c("x_1 + x_2 + x_3 = 6")) #linear hypothesis with IID assumptions.
linearHypothesis(lm.fit,c("x_1 + x_2 + x_3 = 6"), vcov = vcovHC, type = "HC0") #linear hypothesis with Ecker-White covariance matrix.
