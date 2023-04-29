###############################################################################
##                           Solution to HW 1          			    		         ##
##            	 Quantitative Analysis - 2022 Spring  2/14   		     	    	 ##
###############################################################################

##############
# Question 1 #
##############
#(a)# 
x=c(1:150)

#(b)# 
x[(x>135) | (x<=5)]

#(c)#
x[(x>70) & (x<90)]

#(d)# 
x[x%%4==0&x%%5==0]


##############
# Question 2 #
##############
#(a)# 
X=rnorm(150000)

#(b)# 
mean(X)
median(X)
max(X)
min(X)
var(X)

#(c)#
Y = sample(X, 5000)
mean(Y)
var(Y)

#(d)# 
Z = sample(X, 5000, replace = T) 
mean(Z)
var(Z)

#(e)# 
quantile(X,0.45) # 45 percentile in X
qnorm(p=0.45)    # z

#(f)# 
sum((X>-0.55) & (X<= 1.25))/length(X)
pnorm(q=1.25)-pnorm(q=-0.55)

##############
# Question 3 #
##############
#(a)#
a = rep(1,6)
b = seq(2,12,by=2)
c = seq(1,16,by=3)
X = cbind(a,b,c)

#(b)# 
d = seq(1:6)
e = seq(9,4,by=(-1))
Y =cbind(d,e)

#(c)# 
vec1 = X[,1]+Y[,1]
vec2 = X[,2]
vec3 = X[,3]-2*Y[,2]
Z = cbind(vec1,vec2,vec3)







