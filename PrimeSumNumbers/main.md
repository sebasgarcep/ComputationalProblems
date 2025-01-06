# Prime Sum Numbers

Define function $P(n, k) = 1$ if $n$ can be written as the sum of $k$ prime numbers (with repetitions allowed), and $P(n, k) = 0$ otherwise.

For example, $P(10,2) = 1$ because $10$ can be written as either $3 + 7$ or $5 + 5$, but $P(11,2) = 0$ because no two primes can sum to $11$.

Let $S(n)$ be the sum of all $P(i,k)$ over $1 \le i,k \le n$.

For example, $S(10) = 20$, $S(100) = 2402$, and $S(1000) = 248838$.

Let $F(k)$ be the $k$th Fibonacci number (with $F(0) = 0$ and $F(1) = 1$).

Find the sum of all $S(F(k))$ over $3 \le k \le 44$.

## Solution

Note that

1. $P(i, 1) = 1 \iff i \text{ is prime}$. Then $\sum_{i = 1}^n P(i, 1) = \pi(n)$.
2. By Goldbach's strong conjecture, if $i > 2$ is even then $P(i, 2) = 1$. If $i > 1$ is odd then one term needs to be $2$ and therefore $P(i, 2) = 1 \iff i - 2 \text{ is prime}$. Therefore $\sum_{i = 1}^n P(i, 2) = \left\lfloor \frac{n}{2} \right\rfloor - 1 +\pi(n - 2) - 1_{n \ge 4}$, where the $1_{n \ge 4}$ term comes from the fact that we want to ignore $2$ as it is the only odd prime, but only when we count it, which happens when $n \ge 4$.
3. By Goldbach's weak conjecture if $i > 5$ is odd then $P(i, 3) = 1$. If $i > 4$ is even then $P(i, 3) = 1 \iff P(i - 2, 2)= 1$ which is true due to Goldbach's strong conjecture.
4. We will now prove using induction that $P(i, k) = 1 \iff i \ge 2k$ for $k \ge 3$. Note that this is true for the base case $k = 3$. Now assume it is true for an arbitrary $k$. Then $P(i, k + 1) = 1 \iff P(i - 2, k) = 1 \iff i - 2 \ge 2k \iff i \ge 2(k + 1)$.
5. For $k \ge 3$ we have $\sum_{i = 1}^n P(i, k) = \max(0, n - (2k - 1))$. Therefore

$$
\begin{align*}
\sum_{k = 3}^n \sum_{i = 1}^n P(i, k)
&= \sum_{k = 3}^n \max(0, n - (2k - 1)) \\
&= \sum_{k = 3}^{\left\lfloor n/2 \right\rfloor} [ n - (2k - 1) ] \\
&= (n + 1) \sum_{k = 3}^{\left\lfloor n/2 \right\rfloor} 1 - 2 \sum_{k = 3}^{\left\lfloor n/2 \right\rfloor} k \\
&= (n + 1) (\left\lfloor n/2 \right\rfloor - 3 + 1) - 2 ( \frac{\left\lfloor n/2 \right\rfloor (\left\lfloor n/2 \right\rfloor + 1)}{2} - 3) \\
&= (n + 1) (\left\lfloor n/2 \right\rfloor - 2) - \left\lfloor n/2 \right\rfloor (\left\lfloor n/2 \right\rfloor + 1) + 6 \\
\end{align*}
$$
