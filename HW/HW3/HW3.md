# HW3

##### R11922045 陳昱行

## 1.

### (a)

Let $\hat{r}_{i,r}^2$ and $\hat{r}_{i,ur}^2$ be the residuals from the model restricted model and the unrestricted model respectively.

$$
\hat{\sigma}^2_r = \frac{\sum_{i=1}^n \hat{r}_{i,r}^2}{n-k-1+q} = \frac{SSR_r}{n-(k+1-q)}\\
\hat{\sigma}^2_{ur} = \frac{\sum_{i=1}^n \hat{r}_{i,ur}^2}{n-k-1} = 
\frac{SSR_{ur}}{n-k-1}
$$

Since we have,

$$
\frac{(n-k-1+q)\hat{\sigma}_r^2}{\sigma^2} - \frac{(n-k-1)\hat{\sigma}_
{ur}^2}{\sigma^2} \sim \chi^2(q) \\
\implies \frac{SSR_r-SSR_{ur}}{\sigma^2} \sim \chi^2(q)
$$

and also we know that,

$$
\frac{SSR_{ur}}{\sigma^2} \sim \chi^2(n-k-1)
$$

Given $(SSR_r-SSR_{ur})$ and $SSR_{ur}$ are independent. We can rewrite the given statistic

$$
\frac{(SSR_r-SSR_{ur})/q}{SSR_{ur}/(n-k-1)} = 
\frac{(SSR_r-SSR_{ur})/(q\sigma^2)}{SSR_{ur}/[(n-k-1)\sigma^2]} \\
\sim \frac{\chi^2(q)/q}{\chi^2(n-k-1)/(n-k-1)} \sim F(q,n-k-q)
$$

### (b)

From `(a)` we know that

$$
F = \frac{(SSR_r-SSR_{ur})/q}{SSR_{ur}/(n-k-1)} = 
\frac{(\frac{SSR_r}{SST}-\frac{SSR_{ur}}{SST})/q}{\frac{SSR_{ur}}{SST}/(n-k-1)} \\
= \frac{(1-R^2_r-1+R_{ur}^2)/q}{1-R^2_{ur}/(n-k-1)} \\
= \frac{(R_{ur}^2-R^2_r)/q}{(1-R_{ur}^2)/(n-k-1)}
$$

## 2.

### (a)

From $E[y]$ of non-smokers, we know that

$$
\beta_0 + \beta_10 = \alpha_0 + \alpha_1 \\
\implies \beta_0 = \alpha_0 + \alpha_1
$$

on the other hand, from $E[y]$ of smokers,

$$
\beta_0 + \beta_1 = \alpha_0 + \alpha_10\\
\implies \beta_1 + \alpha_0 + \alpha_1 = \alpha_0 \\
\implies \beta_1 = -\alpha_1
$$

### (b)

Yes, since both model minimized the residual sum of squares, they must be the same model. Given condition of smokers or non-smokers, it outputs the same $\hat{y}$.

### (c)

No, his statement is not true.

Since

$$
x_1 + x_2 = 1
$$

for all given samples.

This causes multicollinearity in his model.

## 3.

### (a)

Increasing $expendA$ in $1\%$ will cause $voteA$ to increase $0.01\beta_1$ unit in average.

## (b)

$$
H_0 : \beta_1 = -\beta_2 \\
\implies \beta_1 + \beta_2 = 0
$$

### (c)

Let $R = (0,1,1,0)'$ and $\hat{\bm{\beta}} = (\hat{\beta_0},\hat{\beta_1},\hat{\beta_2},\hat{\beta_3})'$

Under the null hypothesis, we can construct our test statistics $T$ with $t$ distribution by:

$$
T = \frac{\bm{R}\hat{\bm{\beta}}}{\sqrt{\bm{R}(X'X)^{-1}\bm{R}'}} \sim t(n-4)
$$

### (d)

$$
H_0 : \beta_1 = \beta_2 = 0
$$

## (e)

Let $R = \begin{bmatrix}  
0 & 1 & 0 & 0 \\  
0 & 0 & 1 & 0  
\end{bmatrix}$ and $\hat{\bm{\beta}} = ( \beta_0, \beta_1,\beta_2,\beta_3)$ 

We can construct the test statistic $F$ :

$$
F = \frac{(\bm{R}\hat{\bm{\beta}})'[R(X'X)^{-1}R']^{-1}(\bm{R}\hat{\bm{\beta}})}
{2\hat{\sigma}^2} \sim F(2,n-4)
$$
