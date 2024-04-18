# Removing cubes

Starting from a positive integer $n$, at each step we subtract from $n$ the largest perfect cube not exceeding $n$, until $n$ becomes $0$.<br>
For example, with $n = 100$ the procedure ends in $4$ steps:
$$100 \xrightarrow{-4^3} 36 \xrightarrow{-3^3} 9 \xrightarrow{-2^3} 1 \xrightarrow{-1^3} 0.$$
Let $D(n)$ denote the number of steps of the procedure. Thus $D(100) = 4$.

Let $S(N)$ denote the sum of $D(n)$ for all positive integers $n$ <b>strictly less</b> than $N$.<br>
For example, $S(100) = 512$.

Find $S(10^{17})$.

## Solution

Redefine $S(N)$ to be the sum of $D(k)$ for $1 \le k \le N$. For all numbers in $[k^3,(k+1)^3-1]$ where $k > 1$, the largest cube that can be subtracted is $k^3$. Therefore:

$$
S((k+1)^3-1) - S(k^3 - 1) = S(3k^2 + 3k) + 3k^2 + 3k + 1
$$

Thus:

$$
\begin{align*}
S(M^3 - 1)
&= \sum_{k=1}^{M-1} S((k+1)^3-1) - S(k^3 - 1) \\
&= \sum_{k=1}^{M-1} S(3k^2 + 3k) + 3k^2 + 3k + 1 \\
\end{align*}
$$

since $S(0) = 0$. To calculate $S(N)$ for arbitrary $N$, let $M$ be the largest value such that $M^3 \le N$. Then:

$$
S(N) = [S(N) - S(M^3 - 1)] + S(M^3 - 1)
$$

where, and because $M^3$ is the largest cube that can be subtracted for all numbers in the range $[M^3, N]$:

$$
S(N) - S(M^3 - 1) = S(N - M^3) + N - M^3 + 1
$$


