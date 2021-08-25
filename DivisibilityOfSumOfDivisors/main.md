# Divisibility of sum of divisors

Let $\sigma(n)$ be the sum of the divisors of $n$.<br />
E.g. the divisors of 4 are 1, 2 and 4, so $\sigma(4)=7$.

The numbers $n$ not exceeding 20 such that 7 divides  $\sigma(n)$ are:  4,12,13 and 20, the sum of these numbers being 49.

Let $S(n , d)$ be the sum of the numbers $i$ not exceeding $n$ such that $d$ divides $\sigma(i)$.<br />
So $S(20 , 7)=49$.

You are given: $S(10^6,2017)=150850429$ and $S(10^9 , 2017)=249652238344557$.

Find $S(10^{11} , 2017)$

## Solution

If $n = \prod_i p_i^{v_i}$ then $\sigma(n) = \prod_i \sigma(p_i^{v_i})$. Because $d = 2017$ is prime, $\sigma(n) \equiv 0$ modulo $p$ if and only if one of the $\sigma(p_i^{v_i}) \equiv 0$ for some $i$.

We can obtain the primes $p \leq \sqrt{N}$ using a sieve, and for each $p$ calculate which powers $p_i^{v_i} \leq N$ give $\sigma(p_i^{v_i}) = 1 + p_i + p_i^2 + \dots + p_i^{v_i} \equiv 0$ modulo $d$.

If $q > \sqrt{N}$, then $q^2 \nmid n$ for any $n \leq N$. Therefore we only have to consider $\sigma(q) = 1 + q \equiv 0$. In other words, $1 + q = kd$ for some integer $k$. Notice that if no prime smaller than $\sqrt{N}$ divides $q$ then $q$ is prime. On the other hand if $kd - 1$ is divisibly by $p$, then $(k + p)d - 1$ is also divisible by $p$. The following sieve-like algorithm exploits these properties to find the large primes of the form $kd - 1$

1. Initialize array $A[k]$ where $1 \leq k \leq (N + 1) / d$, with $1$ if $kd - 1 > \sqrt{N}$, $0$ otherwise.
2. For each prime $p \leq \sqrt{N}$ and $p \not= d$
    1. Let $k_0 = d^{-1}$ modulo $p$.
    2. For each $k = k_0, k_0 + p, k_0 + 2p, \dots \leq (N + 1) / d$, set $A[k] = 0$

Once we have all prime powers, we have to add the multiples of said prime power, ignoring multiples of the next prime power. The inclusion-exclusion principle gives us the formula

$$
S(N, d) =
\sum_{(p_i, k_i)} p_i^{k_i} \sum_{\substack{1 \leq n \leq N / p_i^{k_i} \\ \\ p_i \nmid n}} n
- \sum_{(p_i, k_i)} \sum_{\substack{(p_j, k_j) \\ \\ p_i < p_j}} p_i^{k_i} p_j^{k_j} \sum_{\substack{1 \leq n \leq N / p_i^{k_i} p_j^{k_j} \\ \\ p_i, p_j \nmid n}} n
+ \dots
$$

Finally, the sum of $n$ coprime to each $p_i$ can also be calculated using the inclusion-exclusion principle

$$
\sum_{\substack{1 \leq n \leq x \\ \\ p_1, \dots, p_m \nmid n}} n =
T(x) - \sum_{p_i} p_i \cdot T(x / p_i) + \sum_{p_i} \sum_{p_j} p_i p_j \cdot T(x / p_i p_j) - \dots
$$

where $T(x) = \sum_{1 \leq n \leq x} n$.