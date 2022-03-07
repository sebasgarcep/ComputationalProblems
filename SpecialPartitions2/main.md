# Special partitions 2

An <b>integer partition</b> of a number $n$ is a way of writing $n$ as a sum of positive integers. Partitions that differ only by the order of their summands are considered the same.

We call an integer partition <i>special</i> if 1) all its summands are distinct, and 2) all its even summands are also divisible by 4. <br />For example, the special partitions of $10$ are: \[10 = 1+4+5=3+7=1+9\]
The number $10$ admits many more integer partitions (a total of 42), but only those three are special.

Let be $P(n)$ the number of special integer partitions of $n$. You are given that $P(1) = 1$, $P(2) = 0$, $P(3) = 1$, $P(6) = 1$, $P(10)=3$, $P(100) = 37076$ and $P(1000)=3699177285485660336$.

Find $\displaystyle \sum_{i=1}^{10^7}{P(i)}$. Give the result modulo $10^9+7$.

## Solution

Let $P(0) = 1$. Then it is clear that

$$
\sum_{n = 0}^\infty P(n) x^n = \prod_{1 \le n} (1 + x^{4n-3}) (1 + x^{4n-1}) (1 + x^{4n})
$$

It is also clear that

$$
\prod_{1 \le n} (1 - x^{8n-6}) (1 - x^{8n-2}) (1 - x^{8n})
= \prod_{1 \le n} (1 - x^{4n-3}) (1 - x^{4n-1}) (1 - x^{4n}) \prod_{1 \le n} (1 + x^{4n-3}) (1 + x^{4n-1}) (1 + x^{4n})
$$

We have already proven Jacobi's triple product identity

$$
\prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n - 1} z^2) (1 + x^{2n - 1} z^{-2}) = 1 + \sum_{1 \le n}^{\infty} (z^{2n} + z^{-2n}) x^{n^2}
$$

which holds for $|x| < 1$ and all $z$. Because we don't care about the value of $x$ we can consider it as an expression in terms of a formal variable $x$.

Applying the map $x \rightarrow x^2, z^2 \rightarrow -x$ we get

$$
\prod_{1 \le n} (1 - x^{4n}) (1 - x^{4n-1}) (1 - x^{4n-3})
= 1 + \sum_{1 \le n} (-1)^n (x^n + x^{-n}) x^{2n^2}
$$

On the other hand, applying the map $x \rightarrow x^4, z^2 \rightarrow -x^2$ we get

$$
\prod_{1 \le n} (1 - x^{8n}) (1 - x^{8n-2}) (1 - x^{8n-6})
= 1 + \sum_{1 \le n} (-1)^n (x^{2n} + x^{-2n}) x^{4n^2}
$$

Notice that

$$
(\sum_{n = 0}^\infty P(n) x^n) \cdot (1 + \sum_{1 \le n} (-1)^n (x^n + x^{-n}) x^{2n^2}) = 1 + \sum_{1 \le n} (P(n) + \sum_{1 \le k} (-1)^k P(n - (2k^2 \pm k))) x^n
$$

Therefore, for $1 \le n$

$$
P(n) + \sum_{1 \le k} (-1)^k P(n - (2k^2 \pm k)) = \sigma(n)
$$

where

$$
\sigma(n) =
\begin{cases}
(-1)^k & \text{if } n = 4k^2 \pm 2k \text{ for some } k \in \mathbb{N} \\
0 & \text{ otherwise} \\
\end{cases}
$$

This allows us to calculate $P(n)$ in $O(n^{1/2})$ time given the values for $P(0), \dots, P(n-1)$.