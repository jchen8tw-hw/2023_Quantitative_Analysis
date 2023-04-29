###############################################################################
##                           HW 2 Answer Sheet         			    		         ##
##            	        Name :______   NTU ID:________  	    	     	    	 ##
###############################################################################

##############
# Question 1 #
##############
#(a)# 
X = cbind(rep(1),c(7,4,9,0,5),c(2,6,2,9,3),c(3,7,0,0,5))
Y = cbind(c(6,2,4,2,1))
beta_hat = solve(t(X)%*%X)%*%t(X)%*%Y
beta_hat
#(b)# 
y = c(1,0,4,3)%*%beta_hat
y
##############
# Question 2 #
##############
rm(list=ls(all=T))
data(mtcars)  # load the data set "mtcars" from R
mtcars        # use help(mtcars) to get help from the definition of this dataset in R
attach(mtcars)

#(a)# 
mtcars[c("Camaro Z28"),]

#(b)#
mtcars[c("wt")]

#(c)#
mtcars[c(gear==3),]

#(d)# 
mtcars[c(mpg>10 & cyl==6 & hp>=90 & hp <=110),]

#(e)#
wt = cbind(mtcars[,c("wt")])
hp = cbind(mtcars[,c("hp")])
qsec = cbind(mtcars[,c("qsec")])
vs = cbind(mtcars[,c("vs")])
x1 = cbind(wt,hp,qsec,vs)
x = cbind(rep(1),x1)
drat = cbind(mtcars[,c("drat")])
beta = solve(t(x)%*%x)%*%t(x)%*%drat
beta_0 = beta[1,]
beta_1 = beta[2,]
beta_2 = beta[3,]
beta_3 = beta[4,]
beta_4 = beta[5,]
beta_0
beta_1
beta_2
beta_3
beta_4
#(f)#
lm(drat~x1)