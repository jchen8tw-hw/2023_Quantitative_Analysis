###############################################################################
##                           HW 9 Answer Sheet         			    		         ##
##            	        Name :陳昱行  NTU ID:R11922045  	    	     	    	 ##
###############################################################################
library(glmnet)
rm(list = ls(all = T))

N <- 55
R <- 100 # replicas
grid <- seq(2, 0, length = 100)
# N * 50 * R
X <- array(rnorm(N * 50 * R, mean = 0, sd = 1), dim = c(N, 50, R))
# N  * R
r <- array(rnorm(N * R, mean = 0, sd = 1), c(N, R))

# N * R
y_DGP1 <- 2 + X[, 1, ] + X[, 2, ] + r
y_DGP2 <- 2 + t(apply(X[, 1:20, ], 1, colSums)) + r

Result_ridge_1 <- 0
Result_ridge_2 <- 0
Result_ridge_3 <- 0
Result_ridge_4 <- 0
Lambda_1 <- 0
Lambda_2 <- 0
Lambda_3 <- 0
Lambda_4 <- 0


for (i in 1:R) {
    # DGP 1 (2 signal variables)
    # Model 1: 25 regressors

    ridge.fit_1 <- glmnet(X[, 1:25, i], y_DGP1[, i], alpha = 0, lambda = grid)
    Result_ridge_1 <- Result_ridge_1 + (1 / R) * coef(ridge.fit_1)[2:26, ]

    ridge.kfold_1 <- cv.glmnet(X[, 1:25, i], y_DGP1[, i], alpha = 0, nfolds = 10, lambda = grid)
    best.s1 <- ridge.kfold_1$lambda.min
    Lambda_1 <- Lambda_1 + (1 / R) * best.s1

    # DGP 2 (20 signal variables)
    # Model 1: 25 regressors

    ridge.fit_2 <- glmnet(X[, 1:25, i], y_DGP2[, i], alpha = 0, lambda = grid)
    Result_ridge_2 <- Result_ridge_2 + (1 / R) * coef(ridge.fit_2)[2:26, ]

    ridge.kfold_2 <- cv.glmnet(X[, 1:25, i], y_DGP2[, i], alpha = 0, nfolds = 10, lambda = grid)
    best.s2 <- ridge.kfold_2$lambda.min
    Lambda_2 <- Lambda_2 + (1 / R) * best.s2

    # DGP 1 (2 signal variables)
    # Model 2: 50 regressors

    ridge.fit_3 <- glmnet(X[, 1:50, i], y_DGP1[, i], alpha = 0, lambda = grid)
    Result_ridge_3 <- Result_ridge_3 + (1 / R) * coef(ridge.fit_3)[2:51, ]

    ridge.kfold_3 <- cv.glmnet(X[, 1:50, i], y_DGP1[, i], alpha = 0, nfolds = 10, lambda = grid)
    best.s3 <- ridge.kfold_3$lambda.min
    Lambda_3 <- Lambda_3 + (1 / R) * best.s3

    # DGP 2 (20 signal variables)
    # Model 2: 50 regressors

    ridge.fit_4 <- glmnet(X[, 1:50, i], y_DGP2[, i], alpha = 0, lambda = grid)
    Result_ridge_4 <- Result_ridge_4 + (1 / R) * coef(ridge.fit_4)[2:51, ]

    ridge.kfold_4 <- cv.glmnet(X[, 1:50, i], y_DGP2[, i], alpha = 0, nfolds = 10, lambda = grid)
    best.s4 <- ridge.kfold_4$lambda.min
    Lambda_4 <- Lambda_4 + (1 / R) * best.s4
}

#------------
#   plot
#------------
par(mfrow = c(2, 2), mar = c(5, 5, 2, 2))


# DGP 1 (2 signal variables)
# Model 1: 25 regressors

plot(grid, Result_ridge_1[1, ],
    type = "l", ylim = c(-1, 1), xlim = c(0, 2), col = "red",
    xlab = "λ", ylab = " ", main = "DGP 1: 2 signal variables; ridge regression with 25 regressors."
)
for (i in 2:2) {
    lines(grid, Result_ridge_1[i, ], col = "red")
}
for (j in (2 + 1):25) {
    lines(grid, Result_ridge_1[j, ], type = "l")
}
abline(v = Lambda_1, lty = 2)
legend("bottomright", legend = c("Signal variables", "Noise variables", paste("Averaged Optimal Lambda = ", Lambda_1)), lty = c(1, 1, 2), col = c("red", "black", "black"), cex = 0.9)



# DGP 2 (20 signal variables)
# Model 1: 25 regressors

plot(grid, Result_ridge_2[1, ],
    type = "l", ylim = c(-1, 1), xlim = c(0, 2), col = "red",
    xlab = "λ", ylab = " ", main = "DGP 2: 20 signal variables; ridge regression with 25 regressors."
)
for (i in 2:20) {
    lines(grid, Result_ridge_2[i, ], col = "red")
}
for (j in 21:25) {
    lines(grid, Result_ridge_2[j, ], type = "l")
}
abline(v = Lambda_2, lty = 2)
legend("bottomright", legend = c("Signal variables", "Noise variables", paste("Averaged Optimal Lambda = ", Lambda_2)), lty = c(1, 1, 2), col = c("red", "black", "black"), cex = 0.9)




# DGP 1 (2 signal variables)
# Model 2: 50 regressors

plot(grid, Result_ridge_3[1, ],
    type = "l", ylim = c(-1, 1), xlim = c(0, 2), col = "red",
    xlab = "λ", ylab = " ", main = "DGP 1: 2 signal variables; ridge regression with 50 regressors."
)
for (i in 2:2) {
    lines(grid, Result_ridge_3[i, ], col = "red")
}
for (j in 3:50) {
    lines(grid, Result_ridge_3[j, ], type = "l")
}
abline(v = Lambda_3, lty = 2)
legend("bottomright", legend = c("Signal variables", "Noise variables", paste("Averaged Optimal Lambda = ", Lambda_3)), lty = c(1, 1, 2), col = c("red", "black", "black"), cex = 0.8)




# DGP 2 (20 signal variables)
# Model 2: 50 regressors

plot(grid, Result_ridge_4[1, ],
    type = "l", ylim = c(-1, 1), xlim = c(0, 2), col = "red",
    xlab = "λ", ylab = " ", main = "DGP 2: 20 signal variables; ridge regression with 50 regressors."
)
for (i in 2:20) {
    lines(grid, Result_ridge_4[i, ], col = "red")
}
for (j in 21:50) {
    lines(grid, Result_ridge_4[j, ], type = "l")
}
abline(v = Lambda_4, lty = 2)
legend("bottomright", legend = c("Signal variables", "Noise variables", paste("Averaged Optimal Lambda = ", Lambda_4)), lty = c(1, 1, 2), col = c("red", "black", "black"), cex = 0.9)
