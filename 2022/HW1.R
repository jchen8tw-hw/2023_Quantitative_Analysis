#1
#(a)
x = c(1 : 150)
#(b)
x[(x>135) | (x<=5)]
#(c)
x[(x>70) & (x<90)]
#(d)
x[(x%%4==0) & (x%%5==0)]

#2
#(a)
X = rnorm(n=150000, mean=0, sd=1)
#(b)
summary(X)
var(X)
#(c)
Y = sample(X, size=5000)
mean(Y)
var(Y)
#(d)
Z = sample(X, size=5000, replace=T)
mean(Z)
var(Z)
#(e)
quantile(X, 45/100)
z = qnorm(0.45)
z
#(f)
length(X[(X>-0.55) & (X<=1.25)])/length(X)
pnorm(1.25)-pnorm(-0.55)

#3
#(a)
x1 = rep(1,6)
x2 = seq(from=2, to=12, by=2)
x3 = seq(from=1, to=16, by=3)
X = cbind(x1, x2, x3)
X
#(b)
y1 <- 1:6
y2 <- 9:4
Y = cbind(y1, y2)
Y
#(c)
z1 = x1 + y1
z2 = x2
z3 = x3 - 2*y2
Z = cbind(z1, z2, z3)
Z
