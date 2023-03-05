# Quantitative Analysis

##### R11922045 陳昱行

# Part one:

## P1.

Define the sum of square error of given $\beta_0$ and $\beta_1$,  $Q_n(\beta_0,\beta_1) = \sum_{i=1}^{n} u_i^2$

We want to minimize $Q_n$. Therefore, $\beta_0$ and $\beta_1$ must satisfiy the following FOCs.

$$
\begin{align}
\frac{\partial Q_n}{\partial \beta_0} = -2 \sum_{i=1}^{n}(y_i-\beta_0-\beta_1x_i) = 0 \\
\frac{\partial Q_n}{\partial \beta_1} = -2 \sum_{i=1}^{n}(y_i-\beta_0-\beta_1x_i)x_i = 0
\end{align}
$$

Simplifying the first derivative:

$$
-2 \sum_{i=0}^{n}(y_i-\beta_0-\beta_1x_i) = 0 \\
\Rightarrow -2\sum_{i=1}^{n}y_i+2n\beta_0+ 2\beta_1 \sum_{i=0}^{n}x_i = 0
$$

Solve for $\beta_0$

$$
\beta_0 = \frac{1}{n}\left(\sum_{i=1}^{n}y_i - \beta_1\sum_{i=1}^{n}x_i\right)
$$

Now simplify $(2)$

$$
\begin{align*}
&-2\sum\limits_{i=1}^{n}(y_i - \beta_0 - \beta_1x_i)x_i = 0 \\
\Rightarrow& -2\sum\limits_{i=1}^{n}(x_iy_i - \beta_0x_i - \beta_1x_i^2) = 0 \\
\Rightarrow& \sum\limits_{i=1}^{n} x_iy_i - \beta_0\sum\limits_{i=1}^{n} x_i - \beta_1\sum\limits_{i=1}^{n} x_i^2 = 0
\end{align*}
$$

Substituting the expression for $\beta_0$ obtained earlier, we get:

$$
\sum\limits_{i=1}^{n} x_iy_i - \left(\dfrac{1}{n}\sum\limits_{i=1}^{n} y_i - \beta_1\dfrac{1}{n}\sum\limits_{i=1}^{n} x_i\right)\sum\limits_{i=1}^{n} x_i - \beta_1\sum\limits_{i=1}^{n} x_i^2 = 0
$$

Simplifying the above expression and solving for $\beta_1$:

$$
\beta_1 = \dfrac{\sum\limits_{i=1}^{n} x_i y_i - \dfrac{1}{n}\sum\limits_{i=1}^{n} x_i \sum\limits_{i=1}^{n} y_i}{\sum\limits_{i=1}^{n} x_i^2 - \dfrac{1}{n}\left(\sum\limits_{i=1}^{n} x_i\right)^2} \\
=\frac{\sum\limits_{i=1}^{n}(y_i-\bar{y})(x_i-\bar{x})}{\sum\limits_{i=1}^{n}(xi-\bar{x})^2} \\
$$

This gives us the expression for the OLS estimator of $\beta_1$. Finally, we can use the expression for $\beta_0$ obtained earlier to get the OLS estimator for $\beta_0$:

$$
\beta_0 = \dfrac{1}{n}\sum\limits_{i=1}^{n} y_i - \beta_1\dfrac{1}{n}\sum\limits_{i=1}^{n} x_i \\
= \bar{y} - \beta_1 \bar{x}
$$

## P2.

From `P1` we know that:

$$
\beta_1 = \frac{\sum\limits_{i=1}^{n}(y_i-\bar{y})(x_i-\bar{x})}{\sum\limits_{i=1}^{n}(xi-\bar{x})^2} \\
\beta_0 = \bar{y} - \beta_1\bar{x}
$$

And for $\alpha_0$ and $\alpha_1$ , we need to solve the following partial derivatives.

$$
\begin{align*}
\frac{\partial}{\partial \alpha_0} \sum_{i=1}^{n}(y_i - \alpha_0 - \alpha_1(x_i-\bar{x}))^2 &= -2\sum_{i=1}^{n}(y_i - \alpha_0 - \alpha_1(x_i-\bar{x})) = 0 \\
\frac{\partial}{\partial \alpha_1} \sum_{i=1}^{n}(y_i - \alpha_0 - \alpha_1(x_i-\bar{x}))^2 &= -2\sum_{i=1}^{n}(y_i - \alpha_0 - \alpha_1(x_i-\bar{x}))(x_i-\bar{x}) = 0
\end{align*}
$$

Simplify the first equation we get:

$$
\sum_{i=1}^ny_i = n\alpha_0 + \alpha_1\sum_{i=1}^n(x_i-\bar{x}) \\
\implies \alpha_0 = \bar{y}
$$

Now the second equation,

$$
\sum_{i=1}^ny_i(x_i-\bar{x}) = \alpha_0\sum_{i=1}^n(x_i-\bar{x}) 
+ \alpha_1\sum_{i=1}^n(x_i-\bar{x})^2
$$

Since $\sum_{i=1}^n(x_i-\bar{x}) = 0$ . The first term on the RHS could be eliminated.

$$
\sum_{i=1}^ny_i(x_i-\bar{x})  = \alpha_1\sum_{i=1}^n(x_i-\bar{x})^2 \\
\implies \alpha_1 = \frac{\sum_{i=1}^ny_ix_i-n\bar{x}\bar{y}}{\sum_{i=1
}^n(x_i-\bar{x})^2} \\
= \frac{\sum\limits_{i=1}^{n}(y_i-\bar{y})(x_i-\bar{x})}{\sum\limits_{i=1}^{n}(x_i-\bar{x})^2}
$$

So the estimators of $\alpha_0$ and $\beta_0$ are not identical. But the estimators of $\alpha_1$ and $\beta_1$ are identical.

Comparing the variances:

$$
Var(\beta_0) = \sigma^2\frac{\sum_{i=1}^nx_i^2/n}{\sum_{i=1}^n(x_i-\bar{x})^2}
$$

and for $\alpha_0$

$$
Var(\alpha_0) = Var(\bar{y})
$$

under classical assumption,

$$
Var(\alpha_0) = \frac{\sigma^2}{n}
$$

Since

$$
\frac{\sum x_i^2}{\sum(x_i-\bar{x})^2} > 1 \\
\implies Var(\alpha_0) < Var(\beta_0)
$$

For $\beta_1$ and $\alpha_1$ , since they are identical, their variances are also identical.

## P3

### (a)

$$
SST = \sum\limits_{i=1}^n(y_i-\bar{y})^2 \\
SSR = \sum_{i=1}^{n}u_i^2 \\
SSE = \sum_{i=1}^{n}(\hat{y}_i - \bar{y})^2 \\


$$

$$
SST = \sum_{i=1}^n(y_i-\bar{y})^2 = \sum_{i=1}^n(u_i+\hat{y}_i-\bar{y})62 \\
= \sum_{i=1}^nu_i^2 +2\sum_{i=1}^nu_i(\hat{y}_i-\bar{y}) + \sum_{i=1}^n(\hat{y}
-\bar{y})^2
$$

For the second term, under classical assumption

$$
\sum_{i=1}^nu_i(\hat{y}_i-\bar{y}) = \sum_{i=1}^nu_i\hat{y}_i - \sum_{i=1}^nu_i\bar{y} \\
=\beta_0\sum_{i=1}^nu_i + \beta_1\sum_{i=1}^nu_ix_i - \bar{y}\sum_{i=1}^nu_i \\
= 0
$$

Therfore,

$$
SST = \sum\limits_{i=1}^n(y_i-\bar{y})^2 = 
\sum_{i=1}^{n}u_i^2 + \sum_{i=1}^{n}(\hat{y}_i - \bar{y})^2 = SSR + SSE
$$

### (b)

Since we know that

$$
\sum_{i=1}^nu_ix_i
$$

need not to be zero if the model has no intersept term. The above term cannot be eliminated. Therefore,

$$
SST \neq SSR + SSE
$$
