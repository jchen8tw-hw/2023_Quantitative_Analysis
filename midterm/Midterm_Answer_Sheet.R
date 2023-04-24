###############################################################################
##                           Midterm Answer Sheet      			    		 ##
##              	   Quantitative Analysis - 2023 Spring        		     ##
###############################################################################

rm(list = ls(all = T))

#############################
# Question 1                #
#############################
library(MASS)
data("Boston")
attach(Boston)

#####
# (a)# +2
#####

X <- cbind(1, as.matrix((data.frame(zn, nox, chas, age))))
y <- medv
beta_hat <- solve(t(X) %*% X) %*% t(X) %*% y
y_hat <- X %*% beta_hat
sigma_hat_squared <- sum((y - y_hat)^2) / (nrow(X) - 4 - 1) # note that n=nrow(mtcars), k=4
var_beta_hat <- sigma_hat_squared * solve(t(X) %*% X)

t_statistic <- numeric(5)

for (i in 1:5) {
    t_statistic[i] <- beta_hat[i] / (var_beta_hat[i, i]^0.5)
}
t_statistic
# the statistic to test the hypothesis (H0 : b0 = 0) = 17.071776
# the statistic to test the hypothesis (H0 : b1 = 0) = 3.546468
# the statistic to test the hypothesis (H0 : b2 = 0) = -5.271913
# the statistic to test the hypothesis (H0 : b3 = 0) = 5.606649
# the statistic to test the hypothesis (H0 : b4 = 0) = -1.306486

#####
# (b)# +2
#####


model_medv <- lm(medv ~ zn + nox + chas + age)
coef(summary(model_medv))[, 3]


#####
# (c)# +2
#####

model_medv_sig <- lm(medv ~ zn + nox + chas)
coef(summary(model_medv_sig))[, 3]

#####
# (d)# +2
#####

R <- matrix(c(0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1), byrow = TRUE, nrow = 3)
beta_hat_sig <- as.matrix(coef(summary(model_medv_sig))[, 1])
X_sig <- cbind(1, zn, nox, chas)
y_hat_sig <- X_sig %*% beta_hat_sig
sigma_hat_squared_sig <- sum((medv - y_hat_sig)^2) / (nrow(X_sig) - 3 - 1) # note that n=nrow(mtcars), k=4
F <- t(R %*% beta_hat_sig) %*% solve(R %*% solve(t(X_sig) %*% X_sig) %*% t(R)) %*% (R %*% beta_hat_sig) / (sigma_hat_squared_sig * 3)
F

# the statistic = 57.31698

#####
# (e)# +2
#####

library(sandwich)
library(car)
linearHypothesis(model_medv_sig, R)$F


##############
# Question 2 #
##############
rm(list = ls(all = T))

library(ISLR)
data("Carseats")
attach(Carseats)

#####
# (a)# +2
#####

D_i1 <- as.numeric((ShelveLoc == "Good"))
D_i2 <- as.numeric((ShelveLoc == "Bad"))

Carseats <- data.frame(Carseats, D_i1, D_i2)
names(Carseats)[12] <- "Good"
names(Carseats)[13] <- "Bad"
attach(Carseats)


#####
# (b)# +2
#####

model_carseats <- lm(Sales ~ Good + Bad + Advertising + I(Advertising * Good) + I(Advertising * Bad))


#####
# (c)# +3
#####

linearHypothesis(model_carseats, c("I(Advertising * Good)=0", "I(Advertising * Bad)=0"))$F

# the statistic = 0.1775198

#####
# (d)# +3
#####

linearHypothesis(model_carseats, c("I(Advertising * Good)=I(Advertising * Bad)"))$F

# the statistic = 0.1890268

##########################
# Question 3             #     +10
##########################
rm(list = ls(all = T))
# quartz(width = 10, height = 10)
windows(width=10,height=10) #open a new window and plot on it
par(mfrow = c(1, 2))


moment_func_list <- list( # contains moment functions and their names
    list((function(y) {
        exp(y+5)
    }), "exp(y + 5)")
)

dgp_list <- list(
    list((function(n) {
        runif(n,-1,1)
    }), "U(-1,1)")
)

sigma_N_square <- function(y, moment_func) {
    moment_y <- moment_func(y)
    avg_moment <- rowSums(moment_y) / dim(y)[2] # dim(y)[2] = sample size
    return(rowSums((moment_y - avg_moment)^2) / dim(y)[2])
}

M_N_stat <- function(y, moment_func) {
    sum_moment <- rowSums(moment_func(y))
    return(1 / (sqrt(sigma_N_square(y, moment_func)) * sqrt(dim(y)[2])) * sum_moment)
}

plot_func <- function(sample_size, dgp_pair, moment_func_pair, number_rep = 2000) {
    dgp <- dgp_pair[[1]]
    dgp_name <- dgp_pair[[2]]
    moment_func <- moment_func_pair[[1]]
    moment_func_name <- moment_func_pair[[2]]

    y <- matrix(dgp(sample_size * number_rep),
        nrow = number_rep,
        ncol = sample_size, byrow = TRUE
    ) # each row is a replica
    M_N <- M_N_stat(y, moment_func)
    five_per <- length(M_N[M_N^2 > 3.8414588]) / number_rep
    one_per <- length(M_N[M_N^2 > 6.6348966]) / number_rep
    hist(M_N,
        breaks = 100, freq = FALSE,
        main = paste("N =", sample_size, dgp_name, moment_func_name),
        xlab = paste("pr(>3.8)=", round(five_per, 3), "/ pr(>6.6)=", round(one_per, 3)),
        xlim = c(min(quantile(M_N, 0.025), qnorm(0.005)), max(quantile(M_N, 0.975), qnorm(0.995))),
        ylim = c(0, max(dnorm(0.5) + 0.1, density(M_N)$y[which.max(density(M_N)$y)] + 0.1))
    )
    lines(density(M_N, kernel = "gaussian"), lwd = 2, col = "blue")
    lines(seq(-4, 4, length = 100), dnorm(seq(-4, 4, length = 100)), lwd = 2, col = "red")
}

# main
for (sample_size in c(20, 500)) {
    for (dgp_pair in dgp_list) {
        for (moment_func_pair in moment_func_list) {
            plot_func(sample_size, dgp_pair, moment_func_pair)
        }
    }
}













