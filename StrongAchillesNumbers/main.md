# Strong Achilles Numbers

A positive integer $n$ is <strong>powerful</strong> if $p^2$ is a divisor of $n$ for every prime factor $p$ in $n$.

A positive integer $n$ is a <strong>perfect power</strong> if $n$ can be expressed as a power of another positive integer.

A positive integer $n$ is an <strong>Achilles number</strong> if $n$ is powerful but not a perfect power. For example, $864$ and $1800$ are Achilles numbers: $864 = 2^5 \cdot 3^3$ and $1800 = 2^3 \cdot 3^2 \cdot 5^2$.

We shall call a positive integer $S$ a <dfn>Strong Achilles number</dfn> if both $S$ and $\phi(S)$ are Achilles numbers.<sup>1</sup><br>
For example, $864$ is a Strong Achilles number: $\phi(864) = 288 = 2^5 \cdot 3^2$. However, $1800$ isn't a Strong Achilles number because: $\phi(1800) = 480 = 2^5 \cdot 3^1 \cdot 5^1$.

There are $7$ Strong Achilles numbers below $10^4$ and $656$ below $10^8$.

How many Strong Achilles numbers are there below $10^{18}$?

<sup>1</sup> $\phi$ denotes <strong>Euler's totient function</strong>.

## Solution

Suppose $n$ is a strong Achilles Number such that $n \le N$.

Suppose $n = \prod_{i=1}^k p_i^{r_i}$. Then $r_i \ge 2$ and $\gcd(r_1, \dots, r_k) = 1$. Furthermore $\phi(n) = \prod_{i=1}^k (p_i - 1) \cdot p_i^{r_i - 1}$. So the factorization of $\phi(n)$ needs to satisfy the same conditions.

Note that for every prime number $p$ that divides $n$, we have that $p^2 \mid n$. This implies $p^2 \le N \Rightarrow p \le \sqrt{N}$.

Suppose $p$ is the largest prime of that divides $n$. Then $\phi(n)$ will replace one copy of every prime $q$ smaller than $p$ in the product of $n$ with $q-1$, which is also smaller than $p$, so there's no way these smaller primes can "complete" $p^2$. Thus $\nu_p(n) \ge 3$.

Furthermore, suppose $p$ is a prime such that $p^2 \mid n$ and $N^{1/3} \lt p \le \sqrt{N}$. Clearly $p^2$ is the largest power of $p$ that can divide $n$ since $N \lt p^3$. Also $N^{2/3} \lt p^2 \le N \Rightarrow n/p^2 \lt N^{1/3}$, which means that $p$ is the largest prime factor of $n$. But by the previous fact we know that the $p$-adic valuation of $p$ must be larger than $3$. Thus $\phi(n)$ is not an Achilles number, contradicting the fact that $n$ is a strong Achilles number. By way of contradiction, this implies $p \le N^{1/3}$.

These facts lead to the following approach:

1. Find all primes up to $N^{1/3}$ and factorize all numbers up to that limit.
2. Use a recursive search algorithm  to search all possible powerful numbers (prime exponents greater than $2$) not exceeding $N$ with the highest prime having a $p$-adic valuation greater than or equal to $3$.
3. During the recursive search keep track of the factors of the number, the GCD of the exponents, and the factors of the totient of the radical of the current number (i.e. $\prod_{p \text{ prime } \mid n} (p-1)$).
4. By construction the exponents will all be greater than $2$ so if we find a number whose GCD equals $1$ then that number is an Achilles number and a potential strong Achilles number. All that is missing is checking that the totient of that number is an Achilles number as well.
5. To check that the totient of the given number is an Achilles number we subtract $1$ from each exponent in the factorization of the number and merge this with the factorization for the totient of the radical. The result is the factorization of the totient of the number, and by checking that all exponents are larger or equal to $2$ and that the GCD of the exponents if $1$ is enough to prove whether the number in question is a string Achilles number or not.
