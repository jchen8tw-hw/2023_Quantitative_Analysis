###############################################################################
##                           HW 3 Answer Sheet         			    		         ##
##            	        Name :ªL¯§Á¾  NTU ID:R10723079  	    	     	    	 ##
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
wt = cbind(mtcars[,c("wt")])
hp = cbind(mtcars[,c("hp")])
qsec = cbind(mtcars[,c("qsec")])
vs = cbind(mtcars[,c("vs")])
x1 = cbind(wt,hp,qsec,vs)
x = cbind(rep(1),x1)
drat = cbind(mtcars[,c("drat")])
beta = solve(t(x)%*%x)%*%t(x)%*%drat
beta_1 = beta[2,]
#partialling out
p = cbind(rep(1),hp,qsec,vs)
beta_p = solve(t(p)%*%p)%*%t(p)%*%wt

s = (sum((drat-x %*% beta)^2)/27)
se=(s/sum((wt - p %*% beta_p)^2))^0.5
t = beta_1/se
t
#(b)#
r1 = lm(drat~x1)
summary(r1)[["coefficients"]][2, "t value"]

##############
# Question 2 #
##############
rm(list=ls(all=T))


#(a)#
x1 = cbind(wt,hp,qsec,vs)
x2 = cbind(qsec,vs)
restricted = lm(drat~x2)
unrestricted = lm(drat~x1)
r = summary(restricted)$ r.squared
ur = summary(unrestricted)$ r.squared
f = ((ur - r)/2)/((1-ur)/27)
f
#(b)#
r = summary(restricted)$residuals^2
SSRr = sum(r)
ur = summary(unrestricted)$residuals^2
SSRur = sum(ur)
f = ((SSRr - SSRur)/2)/(SSRur/27)
f
#(c)# 
install.packages('car')
library('car')
model = lm(drat~wt+hp+qsec+vs)
linearHypothesis(model, c('wt=0', 'hp=0'))
