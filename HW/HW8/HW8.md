# Quantitative Analysis HW8

##### R11922045 陳昱行

## 1.

### Method A:

Uses LOOCV since the testing MSE is always the same. LOOCV does not depends on random sampling.

### Method B:

Probably uses the 10-fold CV approach since the variance of the losses is much less than Method C.

### Method C:

Probably uses the validation set approach since the losses has the greatest variance.

## 2.

### (a)

$$
P(j\neq i|i) = 1 - P(j=i|i) = 1- \frac{P(j=i \cap i)}{P(i)} = 
\frac{1/N^2}{1/N} = 1/N
$$

the answer does not depend on $i$ or $j$.

### (b)

$$
(1-1/N)^N
$$

### (c)

$$
(1-1/5)^5 = 0.32768 \\
(1-1/5000)^{5000} = 0.3678427
$$

### (d)

as $N \to \infty$

$$
\lim_{N\to\infty}(1-1/N)^N = e^{-1}
$$
