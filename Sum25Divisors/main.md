# Sum 25 Divisors

The number $13521270961$ is the first number that has exactly $25$
divisors and the sum of those divisors is divisible by $25$.

Find the sum of all numbers less than $10^{15}$ that have exactly
$25$ divisors and the sum of those divisors is divisible by $25$.

## Solution

Let's solve the problem for a general $N$. Then the solution occurs when $N = 10^{15}$.

Suppose $n \le N$. Factor it as $n = \prod_{i=1}^k p_i^{e_i}$. Then $\sigma_0(n) = \prod_{i=1}^k (e_i + 1)$. Solving $\sigma_0(n) = 25 = 5^2$ leads to two cases:

1. $n = p^{24} \Rightarrow p \le N^{1/24}$
2. $n = p^4 q^4 \Rightarrow pq \le N^{1/4}$

where $p, q$ are primes. So we only need to know the primes up to $N^{1/4}$ and we can brute-force the problem (given $\sigma_1(n)$ is multiplicative).
