# Quantitative Analysis HW4

##### R11922045 陳昱行

## 1.

The above blue solid line is the line of $D_i = 1$

![img](/Users/Mac/github/2023_Quantitative_Analysis/HW/HW4/P1.png)

## 2.

### (a)

The OLS estimator of $\tilde{\beta}_1$ is calculated by:

$$
\tilde{\beta}_1 = \frac{\sum (x_{1i}-\bar{x}_1)y_i}{\sum(x_{1i}-\bar{x}_1)^2} \\
=\frac{\sum (x_{1i}-\bar{x}_1)(\beta_0 + \beta_1x_{1i}+\beta
_2x_{2i}+u_i)}{\sum(x_{i1}-\bar{x}_1)^2} \\
= 0 + \beta_1 + \beta_2\frac{\sum (x_{1i}-\bar{x}_1)x_{2i}}{\sum(x_{i1}-\bar{x}_1)^2}
+ \frac{\sum (x_{1i}-\bar{x}_1)u_i}{\sum(x_{i1}-\bar{x}_1)^2} \\
= \beta_1 + \beta_2\frac{\sum (x_{1i}-\bar{x}_1)x_{2i}}{\sum(x_{i1}-\bar{x}_1)^2}
+ \frac{\sum (x_{1i}-\bar{x}_1)u_i}{\sum(x_{i1}-\bar{x}_1)^2} \\
$$

Under Modern Assumption I

$$
\begin{align}
&\frac{1}{n}\sum (x_{1i}-\bar{x}_1)u_i = \frac{1}{n}\sum x_{1i}u_i - 
\frac{1}{n}\bar x_1\sum u_i \overset{p}{\to}
\mathbb{E}(x_{1}u) + \mu_{x_1}\mathbb{E}(u) = 0 \\
&\frac{1}{n}\sum(x_{1i}-\bar{x}_1)^2 \overset{p}{\to}Var(x_1) = \sigma_{x_1}^2 \\
&\frac{1}{n}\sum(x_{1i}-\bar{x}_1)x_{2i} =
\frac{1}{n}\sum(x_{1i}-\bar{x}_1)(x_{2i}-\bar{x}_2) \overset{p}{\to}Cov(x_1,x2) = 
\sigma_{x_1x_2}
\end{align}
$$

With `(1)(2)(3)` ,

We can derive,

$$
\tilde{\beta}_1 \overset{p}{\to}\beta_1+ \frac{\sigma_{x_1x_2}}{\sigma_{x_1
}^2}\beta_2
$$

Therefore, $\tilde{\beta}_1$ is not consistent.

### (b)

It depends on the sign of $\beta_2$, if  $\beta_2 > 0$ ,  $\tilde{\beta}_1$ overestimate $\beta_1$ by $\frac{\sigma_{x_1x_2}}{\sigma_{x_1
}^2}\beta_2$

as $n \to \infty$. On the other hand, if $\beta_2 <0$ , $\tilde{\beta}_1$ underestimates $\beta_1$ by $\frac{\sigma_{x_1x_2}}{\sigma_{x_1
}^2}\beta_2$.

### (c)

Since $\tilde{\beta}_1$ is not a consistent estimator of $\beta_1$ ,

$$
\tilde{\beta}_1 - \beta_1 \overset{p}{\to} \frac{\sigma_{x_1x_2}}{\sigma_{x_1
}^2}\beta_2 \neq 0
$$

Therefore,

$$
\sqrt{n} (\tilde{\beta}_1 - \beta_1) \to \infty
$$

as $n \to \infty$. This statistic diverges and does not converge to a distribution.

## 3.

Let $\{x_i\}_{i=1}^n$ be i.i.d random variables with a distribution that exist finite second moment.

### (a) False

we can estimate $\mu_x$ of the distribution by a biased estimator $\frac{1}{n} \sum x_i + \frac{1}{n}$

The estimator is biased clearly. However, as $n \to \infty$

$$
\frac{1}{n} \sum x_i + \frac{1}{n} \overset{p}{\to} \mathbb{E}[x] + 0 = \mu_x
$$

therefore the estimator is biased but consistent.

### (b) False

We can estimate $\mu_x$ with an unbiased estimator given by

$$
\hat{\mu}_x = \left\{
\begin{aligned}
\mu_x +1,\ p = 0.5 \\
\mu_x -1,\ p=0.5
\end{aligned}
\right.
$$

Though $\hat{\mu}_x$ does not depend on $x_i$, it is still an unbiased estimator of $\mu_x$ since

$$
\mathbb{E}[\hat{\mu}_x]= \mu_x
$$

but clearly, as $n \to \infty$,

$$
\hat{\mu}_x \overset{p}{\nrightarrow} \mu_x
$$

since it does not depend on $x_i$.

Therefore, the estimator is unbiased but not consitent.
