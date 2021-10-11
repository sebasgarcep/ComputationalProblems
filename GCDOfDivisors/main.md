# GCD of Divisors

Every divisor <var>d</var> of a number <var>n</var> has a <b>complementary divisor</b> <var>n</var>/<var>d</var>.

Let <var>f</var>(<var>n</var>) be the sum of the <b>greatest common divisor</b> of <var>d</var> and <var>n</var>/<var>d</var> over all positive divisors <var>d</var> of <var>n</var>, that is
$f(n)=\displaystyle\sum\limits_{d|n}\, \text{gcd}(d,\frac n d)$.

Let <var>F</var> be the summatory function of <var>f</var>, that is
$F(k)=\displaystyle\sum\limits_{n=1}^k \, f(n)$.

You are given that <var>F</var>(10)=32 and <var>F</var>(1000)=12776.

Find <var>F</var>(10<sup>15</sup>).

## Solution

Notice that

$$
\begin{align*}
F(N)
&= \sum_{n = 1}^N f(n) \\
&= \sum_{n = 1}^N \sum_{d \mid n} \text{gcd}(d, \frac{n}{d}) \\
&= \sum_{d = 1}^N \sum_{n = 1}^{N / d} \text{gcd}(d, n) \\
&= \sum_{\substack{1 \leq i, j \leq N \\ ij \leq N}} \text{gcd}(i, j) \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq i, j \leq N \\ ij \leq N \\ \text{gcd}(i, j) = k}} k \\
&= \sum_{k \geq 1} k \sum_{\substack{1 \leq ki, kj \leq N \\ ki \cdot kj \leq N \\ \text{gcd}(ki, kj) = k}} 1 \\
&= \sum_{k \geq 1} k \sum_{\substack{1 \leq i, j \leq N / k \\ ij \leq N / k^2 \\ \text{gcd}(i, j) = 1}} 1 \\
&= \sum_{k \geq 1} k \sum_{\substack{1 \leq i, j \leq N / k^2 \\ ij \leq N / k^2 \\ \text{gcd}(i, j) = 1}} 1 \\
&= \sum_{k \geq 1} k S(N / k^2) \\
\end{align*}
$$

where

$$
S(N) = \sum_{\substack{1 \leq i, j \leq N \\ ij \leq N \\ \text{gcd}(i, j) = 1}} 1
$$

Let

$$
T(N) = \sum_{\substack{1 \leq i, j \leq N \\ ij \leq N}} 1
$$

Then

$$
\begin{align*}
T(N)
&= \sum_{\substack{1 \leq i, j \leq N \\ ij \leq N}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq i, j \leq N \\ ij \leq N \\ \text{gcd}(i, j) = k}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq ki, kj \leq N \\ ki \cdot kj \leq N \\ \text{gcd}(ki, kj) = k}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq i, j \leq N / k^2 \\ ij \leq N / k^2 \\ \text{gcd}(i, j) = 1}} 1 \\
&= \sum_{k \geq 1} S(N / k^2) \\
\end{align*}
$$

Therefore $S(N) = T(N) - \sum_{k \geq 2} S(N / k^2)$. Thus we only need to find an efficient formula for $T(N)$:

$$
T(N) = \sum_{\substack{1 \leq i, j \leq N \\ ij \leq N}} 1 = \sum_{j = 1}^N \sum_{i = 1}^{N / j} 1 = \sum_{j = 1}^N \lfloor N / j \rfloor
$$

which can be computed efficiently by splitting along $\sqrt{N}$.