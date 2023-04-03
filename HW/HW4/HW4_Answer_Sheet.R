###############################################################################
##                           HW 4 Answer Sheet         			    		 ##
##            	        Name :陳昱行   NTU ID:R11922045  	    	     	  ##
###############################################################################

# DGP1 : {y_i}~N(0,1)
# DGP2 : {y_i}~t(4)
# DGP3 : {y_i}~t(1)
# sample size n = {10,500}
# moment functions = {y, y^3, sin(y), cos(y)}
# Number of replications: B = 1000 times
# requirements:
# (1) For the total of 2*3*4=24 ways to construct M_N, plot their corresponding histogram.
# (2) Compute the empirical frequencies of the events: (M_N)^2 > 3.8414588 and (M_N)^2 > 6.6348966 for each simulation graph.
# (3) Add the Gaussian kernel density estimate (KDE) of M_N as well as the probability density function (PDF) of N(0,1) for each simulation graph.

###############################################################################
rm(list = ls(all = T))
quartz(width = 10, height = 10)
# windows(width=10,height=10) #open a new window and plot on it
par(mfrow = c(6, 4))


moment_func_list <- list( # contains moment functions and their names
    list((function(y) {
        y
    }), "y"),
    list((function(y) {
        y^3
    }), "y^3"),
    list((function(y) {
        sin(y)
    }), "sin(y)"),
    list((function(y) {
        cos(y)
    }), "cos(y)")
)

dgp_list <- list(
    list((function(n) {
        rnorm(n, 0, 1)
    }), "N(0,1)"),
    list((function(n) {
        rt(n, 4)
    }), "t(4)"),
    list((function(n) {
        rt(n, 1)
    }), "t(1)")
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

plot_func <- function(sample_size, dgp_pair, moment_func_pair, number_rep = 1000) {
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
        ylim = c(0, max(dnorm(0.5) + 0.1, density(M_N)$y[which.max(density(M_N)$y)]+0.1))
    )
    lines(density(M_N, kernel = "gaussian"), lwd = 2, col = "blue")
    lines(seq(-4, 4, length = 100), dnorm(seq(-4, 4, length = 100)), lwd = 2, col = "red")
}

# main
for (sample_size in c(10, 500)) {
    for (dgp_pair in dgp_list) {
        for (moment_func_pair in moment_func_list) {
            plot_func(sample_size, dgp_pair, moment_func_pair)
        }
    }
}



# plot_func(
#     sample_size = 10,
#     dgp = dgp_list[[1]], moment_func = moment_func_list[[1]]
# )

