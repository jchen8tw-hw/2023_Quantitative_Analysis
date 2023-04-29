###############################################################################
##                           Midterm Answer Sheet      			    		         ##
##              	   Quantitative Analysis - 2022 Spring        		         ##
###############################################################################

rm(list=ls(all=T))

#############################
# Question 1                # 
#############################
library(ISLR)
data("Carseats")
attach(Carseats)
Urban = as.numeric(Carseats$Urban)-1
US = as.numeric(Carseats$US)-1

#####
#(a)# +2
#####
Sales=Carseats$Sales
Price=Carseats$Price
model = lm(Sales~Price+Urban+US)
summary(model)
#####
#(b)# +2
#####
X = cbind(1,Price,Urban,US)
y = Sales
beta_hat = solve(t(X)%*%X)%*%t(X)%*%y
y_hat = X%*% beta_hat
sigma_hat_squared = sum((y-y_hat)^2)/(nrow(Carseats)-3-1) 
var_beta_hat = sigma_hat_squared*solve(t(X)%*%X)
t0 = beta_hat[1]/(var_beta_hat[1,1]^0.5)
t0
t1 = beta_hat[2]/(var_beta_hat[2,2]^0.5)
t1
t2 = beta_hat[3]/(var_beta_hat[3,3]^0.5)
t2
t3 = beta_hat[4]/(var_beta_hat[4,4]^0.5)
t3
#the statistic to test the hypothesis (H0 : b0 = 0) = 20.03567________
#the statistic to test the hypothesis (H0 : b1 = 0) = -10.38923________
#the statistic to test the hypothesis (H0 : b2 = 0) = -0.08067781________
#the statistic to test the hypothesis (H0 : b3 = 0) = 4.634673________

#####
#(c)# +2
#####
model1 = lm(Sales~Price+US)
summary(model1)

#####
#(d)# +2
#####
X = cbind(1,Price,Urban,US)
y = Sales
beta_hat = solve(t(X)%*%X)%*%t(X)%*%y
y_hat = X%*% beta_hat
SSRur = sum((y-y_hat)^2)


X = cbind(1,Urban)
y = Sales
beta_hat = solve(t(X)%*%X)%*%t(X)%*%y
y_hat = X%*% beta_hat
SSRr = sum((y-y_hat)^2)

(SSRr-SSRur)/2/(SSRur/(nrow(Carseats)-3-1))

#the statistic = 62.21627_________

#####
#(e)# +2
##### 
result = linearHypothesis(lm(Sales~Price+Urban+US),c("Price=0", "US=0")) 
names(result)
result$F

##############
# Question 2 # 
##############
library(ISLR)
data(Wage)

#####
#(a)# +3
#####
all = Wage
age = Wage$age
wage = Wage$wage
length(all[(age==45) & (wage>200),])


#How many man = 5_________

#####
#(b)# +3
#####
Divorced = as.numeric(Wage$maritl)
Divorced = ifelse (Divorced == 4, 1, 0)
sum(Divorced)/length(Divorced)

#Divorced rate = 0.09266667_________

#####
#(c)# +4
#####
logit <- glm(Divorced ~ wage,family = binomial(link = "logit"))
coeftest(logit, vcov. = vcovHC, type = "HC0")


#coefficient for wage =  -0.0069978_________

##########################
# Question 3             #     +10
##########################

windows(width=10,height=10) #open a new window and plot on it


par(mfrow=c(6,4))
L = seq(-10, 10, length=1000)

for (j in 1:2){
  if (j == 1){
    k = 10
  } else{
    k = 500
  }  
  M_1 = c()
  for (d in 1:1) {
    
    for (i in 1:1000) {
      
      if (d == 1) {
        s = rnorm(n = k, mean = 0, sd = 5)
        dgp = 'N(0,5)'

      }
      
      for (l in 1:1) {
        if (l == 1) {
          y = (s+5)^3

        }
        
        M = sum(y) / sum((y - sum(y) / k) ^ 2) ^ 0.5
        switch(l,
               M_1[i] <- M,
)
        
        
        
        
      }   
    }
    
    
    hist(M_1, breaks=50,xlim = c(-2,14),freq=F,xlab='',
         main=substitute(paste(N == k,' ', dgp,' y'), list(k = k, dgp = dgp)),
         sub=substitute(paste('pr(>3.8)' == pr1,' /pr(>6.6)=', pr2), list(pr1 = length(M_1[M_1^2>=3.8414588])/length(M_1), pr2 = length(M_1[M_1^2>=6.6348966])/length(M_1))))
    lines(density(M_1),col="blue",lwd=2)
    lines(L, dnorm(L,0,1),col="red",lwd=2)
    

    
  }
}