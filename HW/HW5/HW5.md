# Quantitative Analysis HW5

##### R11922045 陳昱行

## 1.

$$
\bm{R}\bm{\tilde{D}}\bm{R}' = \\
\begin{bmatrix}
0 & 1 & 0 & 0 & 0 & \dots & 0 \\
0 & 0 & 1 & 0 & 0 & \dots & 0 \\
0 & 0 & 0 & 1 & 0 & \dots & 0 \\
\end{bmatrix}
\begin{bmatrix}
d_{11} & d_{12} & \dots & d_{1(k+1)} \\
d_{21} & d_{22} & \dots & d_{1(k+1)} \\
\vdots & \vdots & \ddots & \vdots \\
d_{(k+1)1} & d_{(k+1)2} & \dots & d_{(k+1)(k+1)} \\
\end{bmatrix}
\begin{bmatrix}
0 & 0 & 0 \\
1 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 1 \\
\vdots & \vdots & \vdots \\
0 & 0 & 0
\end{bmatrix} \\
=
\begin{bmatrix}
d_{21} & d_{22} & d_{23} & d_{24} & d_{25} & \dots & d_{2(k+1)} \\
d_{31} & d_{32} & d_{33} & d_{34} & d_{35} & \dots & d_{3(k+1)} \\
d_{41} & d_{42} & d_{43} & d_{44} & d_{45} & \dots & d_{4(k+1)} \\
\end{bmatrix}
\begin{bmatrix}
0 & 0 & 0 \\
1 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 1 \\
\vdots & \vdots & \vdots \\
0 & 0 & 0
\end{bmatrix} \\
=
\begin{bmatrix}
d_{22} & d_{23} & d_{24} \\
d_{32} & d_{33} & d_{34} \\
d_{42} & d_{43} & d_{44} \\
\end{bmatrix}
$$

Obviously, $\bm{R}\bm{\tilde{D}}\bm{R}$ is a $3 \times 3$ matrix but not a diagonal matirx.

## 2.

In a two-stage least squares (2SLS) method estimating $\beta_1$ using instrumental variable $z_i$ , we first regress $x_i$ on $z_i$ with the following regression.

$$
x_i = \alpha_0 + \alpha_1z_i + v_i
$$

We can easily solve $\hat{\alpha}_1$ that minimize the residual sum of squares.

$$
\hat{\alpha}_1 = \frac{\sum(x_i-\bar{x})(z_i-\bar{z})}{\sum(z_i-\bar{z})^2}
$$

Let the estimated value of $x_i$ using $z_i$ be $\hat{x}_i$. We can know that

$$
\hat{x}_i = \hat{\alpha}_0 + \hat{\alpha}_1z_i
$$

we then plug  $\hat{x}_i$ into the original simple regression.

$$
y_i = \beta_0 + \beta_1\hat{x}_i + \varepsilon_i
$$

$\hat{\beta}_{1,IV}$ is then given by

$$
\hat{\beta}_{1,IV} = \frac{\sum(y_i-\bar{y})(\hat{\alpha}_0+\hat{\alpha_1}z_i
-\hat{\alpha}_0-\hat{\alpha}_1\bar{z})}{\sum(\hat{\alpha}_0+\hat{\alpha_1}z_i
-\hat{\alpha}_0-\hat{\alpha}_1\bar{z})^2} \\
= \frac{\hat{\alpha}_1\sum(y_i-\bar{y})(z_i-\bar{z})}{{\hat{\alpha}_1}^2\sum(z_i-
\bar{z})^2} \\
= \frac{\sum(y_i-\bar{y})(z_i-\bar{z})}{\hat{\alpha}_1\sum(z_i-
\bar{z})^2} \\
$$

and the denominator of this fraction can be simplified to:

$$
\hat{\alpha}_1\sum(z_i-\bar{z})^2 \\
= \frac{\sum(x_i-\bar{x})(z_i-\bar{z})}{\sum(z_i-\bar{z})^2} \times \sum(z_i-
\bar{z})^2 \\
= \sum(x_i-\bar{x})(z_i-\bar{z})
$$

we can get

$$
\hat{\beta}_{1,IV} = \frac{\sum(y_i-\bar{y})(z_i-\bar{z})}{\sum(x_i-\bar{x})(z_i-\bar{z})}
$$

## 3.

By  WLLN:

$$
\bm{X'Z}/n \overset{\bm{P}}{\to}\mathbb{E}(\bm{x}_i\bm{z}_i')=:\bm{M}_{xz}\\
\bm{Z'X}/n \overset{\bm{P}}{\to}\mathbb{E}(\bm{z}_i\bm{x}_i')=:\bm{M}_{zx}\\
\bm{Z'Z}/n \overset{\bm{P}}{\to}\mathbb{E}(\bm{z}_i\bm{z}_i')=:\bm{M}_{zz}\\
\bm{Z'}\varepsilon/n \overset{\bm{P}}{\to}\mathbb{E}(\bm{z}_i\varepsilon_i')= \bm{0}
$$

And assuming CLT,

$$
\bm{V}^{-1/2}\frac{1}{\sqrt{n}}\sum_{i}z_i\varepsilon_i \overset{D}{\to}
\mathcal{N}(\bm{0},\bm{I})
$$

We can know that as $n\to \infty$,

$$
\sqrt{n}(\bm{\hat{\beta}}_{GMM}-\bm{b}_o) = [(\bm{X'Z}/n)\widehat{W}
(\bm{Z'X}/n)]^{-1}[(\bm{X'Z}/n)\widehat{W}(\bm{Z'}\varepsilon/\sqrt{n})] \\
\overset{D}{\to}(\bm{M}_{xz}\bm{W}\bm{M}_{zx})^{-1}\bm{M}_{xz}\bm{W}\bm{V}
^{1/2}\mathcal{N}(\bm{0},\bm{I}) \\
\overset{d}{=}\mathcal{N}(\bm{0},\bm{D}_o)
$$

where

$$
\bm{D}_o = (\bm{M}_{xz}\bm{W}\bm{M}_{zx})^{-1}(\bm{M}_{xz}\bm{W}\bm{V}\bm{WM}_
{zx})(\bm{M}_{xz}\bm{W}\bm{M}_{zx})^{-1}
$$






