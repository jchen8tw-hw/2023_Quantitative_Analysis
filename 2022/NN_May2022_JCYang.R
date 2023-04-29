#################################################
#                                               #
#                   Neural Net                  #
#                                               #
#                 Jui-Chung Yang                #
#                                               #
#################################################


rm(list = ls())
cat("\014")

library(MASS)
data <- Boston

set.seed(500)
index <- sample(1:nrow(data), round(0.75*nrow(data)))
train <- data[index,]
test <- data[-index,]


# OLS

lm.fit <- lm(medv ~ ., data = train)
summary(lm.fit)
pr.lm <- predict(lm.fit, newdata = test)
MSE.lm <- sum((pr.lm - test$medv)^2) / nrow(test)
MSE.lm


# Random Forest

library(randomForest)

set.seed(500)
boston.forest = randomForest(medv ~ ., data = train)

pr.rf <- predict(boston.forest, newdata = test)
MSE.rf <- sum((pr.rf - test$medv)^2) / nrow(test)
MSE.rf


# Gradient Boosting

library(gbm)

set.seed(500)
boston.gbm.1 <- gbm(medv ~ ., data = train, 
                    distribution = "gaussian", n.trees = 5000, 
                    interaction.depth = 1, shrinkage = 0.01, 
                    bag.fraction = 0.5, cv.folds = 10)

pr.gb1 <- predict(boston.gbm.1, newdata = test)
MSE.gb1 <- sum((pr.gb1 - test$medv)^2) / nrow(test)
MSE.gb1


# Neural Net

# 1 hidden layer, 5 neurons

library(neuralnet)

maxs <- apply(data, 2, max) 
mins <- apply(data, 2, min)
scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins))
train_ <- scaled[index,]
test_ <- scaled[-index,]

set.seed(500)
n <- names(train_)
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))
boston.nn.1.5 <- neuralnet(f, data = train_, hidden = c(5), linear.output = T)

windows()
plot(boston.nn.1.5)

pr.nn.1.5 <- compute(boston.nn.1.5, test_[,1:13])
pr.nn.1.5_ <- pr.nn.1.5$net.result * (max(data$medv) - min(data$medv)) + min(data$medv)
MSE.nn.1.5 <- sum((pr.nn.1.5_ - test$medv)^2) / nrow(test)
MSE.nn.1.5

# 2 hidden layers, 5 and 3 neurons

set.seed(500)
boston.nn.2.5.3 <- neuralnet(f, data = train_, hidden = c(5,3), linear.output = T)

windows()
plot(boston.nn.2.5.3)

pr.nn.2.5.3 <- compute(boston.nn.2.5.3, test_[,1:13])
pr.nn.2.5.3_ <- pr.nn.2.5.3$net.result * (max(data$medv) - min(data$medv)) + min(data$medv)
MSE.nn.2.5.3 <- sum((pr.nn.2.5.3_ - test$medv)^2) / nrow(test)
MSE.nn.2.5.3


## Multilayer Network on the MNIST Digit Data

###
library(torch)
library(luz) # high-level interface for torch
library(torchvision) # for datasets and image transformation
library(torchdatasets) # for datasets we are going to use
library(zeallot)
torch_manual_seed(13)
###

###
train_ds_n <- mnist_dataset(root = ".", train = TRUE, download = TRUE)
test_ds_n <- mnist_dataset(root = ".", train = FALSE, download = TRUE)
str(train_ds_n[1])
str(test_ds_n[2])
length(train_ds_n)
length(test_ds_n)
max(train_ds_n[183]$x)
min(train_ds_n[183]$x)
mean(train_ds_n[183]$x)
###

###
train_ds_n[999]$x
train_ds_n[999]$y
windows()
image(1:28, 1:28, t(apply(train_ds_n[999]$x, 2, rev)))
###

###
transform <- function(x) {
  x %>%
    torch_tensor() %>%
    torch_flatten() %>%
    torch_div(255)
}
train_ds <- mnist_dataset(
  root = ".",
  train = TRUE,
  download = TRUE,
  transform = transform
)
test_ds <- mnist_dataset(
  root = ".",
  train = FALSE,
  download = TRUE,
  transform = transform
)

str(train_ds[1])
str(test_ds[2])
length(train_ds)
length(test_ds)

max(train_ds[183]$x)
min(train_ds[183]$x)
mean(train_ds[183]$x)
mean(train_ds_n[183]$x) / 255
###

###
modelnn <- nn_module(
  initialize = function() {
    self$linear1 <- nn_linear(in_features = 28*28, out_features = 256)
    self$linear2 <- nn_linear(in_features = 256, out_features = 128)
    self$linear3 <- nn_linear(in_features = 128, out_features = 10)
    
    self$drop1 <- nn_dropout(p = 0.4)
    self$drop2 <- nn_dropout(p = 0.3)
    
    self$activation <- nn_relu()
  },
  forward = function(x) {
    x %>%
      
      self$linear1() %>%
      self$activation() %>%
      self$drop1() %>%
      
      self$linear2() %>%
      self$activation() %>%
      self$drop2() %>%
      
      self$linear3()
  }
)
###

###
print(modelnn())
###

###
modelnn <- modelnn %>%
  setup(
    loss = nn_cross_entropy_loss(),
    optimizer = optim_rmsprop,
    metrics = list(luz_metric_accuracy())
  )
###

###
system.time(
  fitted <- modelnn %>%
    fit(
      data = train_ds,
      epochs = 5,
      valid_data = 0.2,
      dataloader_options = list(batch_size = 256),
      verbose = TRUE
    )
)
###

###
accuracy <- function(pred, truth) {
  mean(pred == truth) }

# gets the true classes from all observations in test_ds.
truth <- sapply(seq_along(test_ds), function(x) test_ds[x][[2]])

fitted %>%
  predict(test_ds) %>%
  torch_argmax(dim = 2) %>%  # the predicted class is the one with higher 'logit'.
  as_array() %>% # we convert to an R object
  accuracy(truth)
###

fitted %>%
  predict(test_ds) %>%
  torch_argmax(dim = 2) %>%  # the predicted class is the one with higher 'logit'.
  as_array() -> pred.test.nn

accuracy(pred.test.nn,truth)

pred.test.nn[1:30]
truth[1:30]

windows()
image(1:28, 1:28, t(apply(test_ds_n[10]$x, 2, rev)))




# Convolutional Neural Networks

# slides: https://hastie.su.domains/ISLR2/Slides/Ch10_Deep_Learning.pdf
# R script: https://hastie.su.domains/ISLR2/Labs/R_Labs/Ch10-deeplearning-lab-torch.R

library(torch)
library(luz) # high-level interface for torch
library(torchvision) # for datasets and image transformation
library(torchdatasets) # for datasets we are going to use
library(zeallot)

transform <- function(x) {
transform_to_tensor(x)
}

# The CIFAR-100 dataset consists of 60000 32x32 color images in 100 classes.
# There are 500 training images and 100 testing images per class.

train_ds <- cifar100_dataset(
  root = "./", 
  train = TRUE, 
  download = TRUE, 
  transform = transform
)

test_ds <- cifar100_dataset(
  root = "./", 
  train = FALSE, 
  transform = transform
)

length(train_ds)
length(test_ds)

train_ds$classes

# str: Compactly Display the Structure of an Arbitrary R Object
str(train_ds[1]) 

# 

windows()
par(mar = c(0, 0, 0, 0), mfrow = c(5, 5))
for (i in 1:25) plot(as.raster(as.array(train_ds[i][[1]]$permute(c(2,3,1)))))

train_ds$classes[train_ds$y[1:25]]


#

conv_block <- nn_module(
  initialize = function(in_channels, out_channels) {
    self$conv <- nn_conv2d(
      in_channels = in_channels, 
      out_channels = out_channels, 
      kernel_size = c(3,3), 
      padding = "same"
    )
    self$relu <- nn_relu()
    self$pool <- nn_max_pool2d(kernel_size = c(2,2))
  },
  forward = function(x) {
    x %>% 
      self$conv() %>% 
      self$relu() %>% 
      self$pool()
  }
)

model <- nn_module(
  initialize = function() {
    self$conv <- nn_sequential(
      conv_block(3, 32),
      conv_block(32, 64),
      conv_block(64, 128),
      conv_block(128, 256)
    )
    self$output <- nn_sequential(
      nn_dropout(0.5),
      nn_linear(2*2*256, 512),
      nn_relu(),
      nn_linear(512, 100)
    )
  },
  forward = function(x) {
    x %>% 
      self$conv() %>% 
      torch_flatten(start_dim = 2) %>% 
      self$output()
  }
)

print(model())

(9*3+1)*32 + (9*32+1)*64 + (9*64+1)*128 + (9*128+1)*256
(1024+1)*512 + (512+1)*100

#

fitted10 <- model %>% 
  setup(
    loss = nn_cross_entropy_loss(),
    optimizer = optim_rmsprop, 
    metrics = list(luz_metric_accuracy())
  ) %>% 
  set_opt_hparams(lr = 0.001) %>% 
  fit(
    train_ds,
    epochs = 10, #30,
    valid_data = 0.2,
    dataloader_options = list(batch_size = 64) # 128
  )

fitted10 %>%
  predict(test_ds) %>%
  torch_argmax(dim = 2) %>%  # the predicted class is the one with higher 'logit'.
  as_array() -> pred10.test.nn

windows()
par(mar = c(0, 0, 0, 0), mfrow = c(5, 5))
for (i in 1:25) plot(as.raster(as.array(test_ds[i][[1]]$permute(c(2,3,1)))))

cbind(test_ds$classes[pred10.test.nn[1:25]], test_ds$classes[test_ds$y[1:25]])

#

fitted30 <- model %>% 
  setup(
    loss = nn_cross_entropy_loss(),
    optimizer = optim_rmsprop, 
    metrics = list(luz_metric_accuracy())
  ) %>% 
  set_opt_hparams(lr = 0.001) %>% 
  fit(
    train_ds,
    epochs = 30, #30,
    valid_data = 0.2,
    dataloader_options = list(batch_size = 64) # 128
  )

fitted30 %>%
  predict(test_ds) %>%
  torch_argmax(dim = 2) %>%  # the predicted class is the one with higher 'logit'.
  as_array() -> pred30.test.nn

windows()
par(mar = c(0, 0, 0, 0), mfrow = c(5, 5))
for (i in 1:25) plot(as.raster(as.array(test_ds[i][[1]]$permute(c(2,3,1)))))

cbind(test_ds$classes[pred30.test.nn[1:25]], test_ds$classes[test_ds$y[1:25]])
