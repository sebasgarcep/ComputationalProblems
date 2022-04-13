# Triangle Triples

Let $T(n)$ be the n<sup>th</sup> triangle number, so $T(n) = \dfrac{n(n + 1)}{2}$.

Let $dT(n)$ be the number of divisors of $T(n)$.<br />
E.g.: $T(7) = 28$ and $dT(7) = 6$.

Let $Tr(n)$ be the number of triples $(i, j, k)$ such that $1 \le i \lt j \lt k \le n$ and $dT(i) \gt dT(j) \gt dT(k)$.<br />
$Tr(20) = 14$, $Tr(100) = 5772$, and $Tr(1000) = 11174776$.

Find $Tr(60 000 000)$. <br />
Give the last 18 digits of your answer.

## Solution

Let $Tr(n, k, j)$ be the number of chains of length $k$ that end in $j$ that satisfy that the values of $dT$ for the elements in the chain are in strictly descending order. Then

$$
Tr(n) = \sum_{j=1}^n Tr(n, 3, j)
$$

Furthermore

$$
Tr(n, 1, j) = 1 \\
\begin{align*}
Tr(n, k, j)
&= \sum_{\substack{1 \le i \le j-1 \\ dT(i) > dT(j)}} Tr(n, k-1, i) \\
&= \sum_{\substack{1 \le i \le j-1 \\ dT(j) + 1 \le dT(i)}} Tr(n, k-1, i) \\
\end{align*}
$$

and just like in "Ascending Subsequences", this sum can be computed using a Fenwick tree.

Finally, note that $\gcd(n, n+1) = 1 \Rightarrow \sigma_0(\frac{n(n+1)}{2}) = \sigma_0(\frac{n}{2}) \cdot \sigma_0(n+1)$ if $n$ is even or $\sigma_0(\frac{n(n+1)}{2}) = \sigma_0(n) \cdot \sigma_0(\frac{n+1}{2})$ if $n$ is odd.