# Quantitative Analysis HW6

##### R11922045 陳昱行

## 1.

### (a)

Given PDF of exponential distribution and $\{y_i\}_{i=1}^{n}$ independent variables.

The joint log-likelihood function is then given by:

$$
L_n(\theta) = \ln\left(\prod_{i=1}^{n}\frac{1}{\theta}
e^{-\frac{1}{\theta}y_i}\right) = 
\sum_{i=1}^{n}\ln\left(\frac{1}{\theta}
e^{-\frac{1}{\theta}y_i}\right) \\
= \sum_{i=1}^{n}-\ln(\theta) - \left(\frac{1}{\theta}y_i\right) \\
= -n\ln\theta - \frac{1}{\theta}\sum_{i=1}^{n}y_i
$$

To obtain $\tilde{\theta}$, we need to  solve $\theta$ that maximize the log-likelihood function. Thus it must satisfy the FOC given by:

$$
\frac{\partial L_n(\theta)}{\partial\theta} = 0 = 
-\frac{n}{\theta} + \frac{1}{\theta^2} \sum_{i=1}^{n}y_i \\
\implies \theta n = \sum_{i=1}^{n}y_i \\
\implies \theta = \frac{1}{n}\sum_{i=1}^{n}y_i
$$

Finally, the maximum likelihood estimator $\tilde\theta = \frac{1}{n}\sum_{i=1}^{n}y_i$

which is the mean of $y_i$ .

### (b)

Let

$$
H(\theta) = \mathbb{E}\left[\frac{\partial^2L_n(\theta)}{\partial\theta^2}
\right] \\ 
= \mathbb{E}\left[\frac{n}{\theta^2} - \frac{2}{\theta^3} \sum_{i=1}^{n}y_i\right] \\
= \frac{n}{\theta^2} - \frac{2n}{\theta^2} \\
= \frac{-n}{\theta^2}
$$

if the information equality holds,

$$
\sqrt{n}(\tilde{\theta} -\theta) \overset{D}{\to} \mathcal{N}(0,-H(\theta)^{-1}) \\
\implies \lim_{n\to\infty}var(\sqrt{n}(\tilde{\theta} -\theta)) \overset{p}{\to}
-H(\theta)^{-1} = \frac{\theta^2}{n} \to 0
$$
