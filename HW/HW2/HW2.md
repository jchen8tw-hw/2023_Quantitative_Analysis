# Quantitative Analysis HW2

##### R11922045 陳昱行

### (1)

Let $\hat{r}_{i,1}$ be the OLS residual of regressing $x_1$ on the constant $1$ and $x_2, x_3, ... x_k$

We can write the Regression model as:

$$
x_{i,1} = \beta_0 + \beta_2x_{i,2} + \beta_3x_{i,3} + ... \beta_kx_{i,k} + r_{i,1}
$$

let $\hat{\beta}_0,\hat{\beta}_1,...\hat{\beta}_k$ and $\hat{r}_{i,1}$ be the OLS estimates of this model.

By the FOCs of OLS algebraic properties

$$
\sum \hat{r}_{i,1}^2 = \sum \hat{r}_{i,1}.\hat{r}_{i,1} \\
=\sum \hat{r}_{i,1}(x_{i,1}-\hat{\beta}_0.1-\hat{\beta}_2x_2-...\hat{\beta}_kx_k) \\
= \sum \hat{r}_{i,1}x_{i,1} - \hat{\beta}_0\sum \hat{r}_{i,1} - \hat{\beta}_2\sum 
\hat{r}_{i,1} x_2- ... \hat{\beta}_k \sum \hat{r}_{i,1} x_k \\
= \sum \hat{r}_{i,1}x_{i,1} - 0 - 0 -...0 \\
=\sum _{i,1}x_{i,1}
$$

## (2)

If we observe the first two columns of this matrix, it is obvious that there exist multicollinearity among regressors. That is,

$$
\textbf{X}_{i,2} = 2\textbf{X}_{i,1}\ , \quad \forall i \in 1,2,3,4
$$

Since $\textbf{X}$ is not full rank, we cannot solve the inverse matrix of $(\textbf{X}'\textbf{X})$ and thus we can not calculate the OLS estimators.

## (3)

### (a)

From the first order condition of OLS esitmators with special condition $\tilde{\beta}_0 = 0$

$$
\frac{\partial \sum(y_i - \tilde{\beta}_1x_i)^2}{\partial\tilde{\beta_1}} = 0 \\
\implies \sum (y_i-\tilde{\beta}_1x_i)x_i = 0 \\
\implies \sum y_ix_i - \tilde{\beta}_1\sum x_i^2 = 0 \\
\implies \tilde{\beta}_1 = \frac{\sum y_ix_i}{\sum x_i^2} \\
\implies \tilde{\beta}_1 = \frac{\sum (\beta_0+\beta_1x_i + u_i)x_i}{\sum x_i^2} \\
\implies \mathbb{E}[\tilde{\beta}_1] = \frac{\sum(\beta_0+\beta_1x_i)x_i}{\sum x_i^2} \\
\implies \mathbb{E}[\tilde{\beta}_1] = \frac{\sum\beta_0x_i}{\sum x_i^2} + \beta_1
$$

### (b)

Obviously, if $\beta_0 \neq 0$ , $\mathbb{E}[\tilde{\beta}_1] \neq \beta_1$. Therefore, $\tilde{\beta_1}$ is not an unbiased estimator.

### (c)

$$
Var(\tilde{\beta_1}) =  Var\left(\frac{\sum y_ix_i}{\sum x_i^2}\right) \\
= \frac{\sum Var(y_i)x_i^2}{(\sum x_i^2)^2} \\
= \sigma^2 \frac{\sum x_i^2}{(\sum x_i^2)^2} \\
= \sigma^2\frac{1}{\sum x_i^2}
$$

### (d)

Yes, in general

$$
Var(\tilde{\beta_1}) \le Var(\hat{\beta}_1)
$$

given that

$$
\frac{1}{\sum(x_i-\bar{x})^2} \ge \frac{1}{\sum x_i^2}
$$

and they only equals when $\bar{x} = 0$.

### (e)

No, it doesn't violates the Gauss-Markov Theorem since the theorem states that $\hat{\beta_1}$ is the best linear unbiased estimator (BLUE), whereas $\tilde{\beta_1}$ is a biased estimator of $\beta_1$.
