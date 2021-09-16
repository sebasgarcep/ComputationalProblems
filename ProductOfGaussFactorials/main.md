# Product of Gauss Factorials

The <b>Gauss Factorial</b> of a number $n$ is defined as the product of all positive numbers $\leq n$ that are relatively prime to $n$. For example $g(10)=1\times 3\times 7\times 9 = 189$. 
Also we define
$$\displaystyle G(n) = \prod_{i=1}^{n}g(i)$$
You are given $G(10) = 23044331520000$.

Find $G(10^8)$. Give your answer modulo $1\,000\,000\,007$.

## Solution

Applying the inclusion exclusion principle to $g(n)$ we get

$$
\begin{align*}
g(n)
&= \prod_{d \mid n} (\prod_{1 \leq k \leq n / d} dk)^{\mu(d)} \\
&= \prod_{d \mid n} d^{(n / d) \mu(d)} (\prod_{1 \leq k \leq n / d} k)^{\mu(d)} \\
&= \prod_{d \mid n} d^{(n / d) \mu(d)} (n / d)!^{\mu(d)} \\
\end{align*}
$$



$$
\begin{align*}
G(N)
&= \prod_{n = 1}^N g(n) \\
&= \prod_{n = 1}^N \prod_{d \mid n} d^{(n / d) \mu(d)} (n / d)!^{\mu(d)} \\
&= \prod_{d = 1}^N \prod_{n = 1}^{N / d} d^{n \cdot \mu(d)} n!^{\mu(d)} \\
&= \prod_{d = 1}^N d^{T(N / d) \cdot \mu(d)} (\prod_{n = 1}^{N / d} n!)^{\mu(d)} \\
\end{align*}
$$

where $T(N)$ is the $N$-th triangular number. We can optimize this algorithm by memoizing the factorials and the product of the first $k$ factorials.