# Numbers with a given prime factor sum

Consider the numbers 15, 16 and 18:<br />
$15=3\times 5$ and $3+5=8$.<br />
$16 = 2\times 2\times 2\times 2$ and $2+2+2+2=8$.<br />
$18 = 2\times 3\times 3$ and $2+3+3=8$.<br /> 

15, 16 and 18 are the only numbers that have 8 as sum of the prime factors (counted with multiplicity).

We define $S(k)$ to be the sum of all numbers $n$ where the sum of the prime factors (with multiplicity)  of $n$ is $k$.<br />
Hence $S(8) = 15+16+18 = 49$.<br />
Other examples: $S(1) = 0$, $S(2) = 2$, $S(3) = 3$, $S(5) = 5 + 6 = 11$.

The Fibonacci sequence is $F_1 = 1, F_2 = 1, F_3 = 2, F_4 = 3, F_5 = 5$, ....<br />
Find the last nine digits of $\displaystyle\sum_{k=2}^{24}{S(F_k)}$.

## Solution

Let $S(0) = 1$. Then it is easy to convince oneself that $S(k)$ has the following generating function:

$$
\sum_{0 \le k} S(k) x^k = \prod_p (1 + p x^p + p^2 x^{2p} + \dots)
$$

where the product $p$ is over the prime numbers. Then

$$
\sum_{0 \le k} S(k) x^k = \prod_p \frac{1}{1 - p x^p}
$$

Thus

$$
(\sum_{0 \le k} S(k) x^k) \cdot \prod_p (1 - p x^p) = 1
$$

Let $R(k)$ be the coefficient of $x^k$ in the expansion of $\prod_p (1 - p x^p)$. Then

$$
(\sum_{0 \le k} S(k) x^k) \cdot (\sum_{0 \le k} R(k) x^k) = 1
$$

Comparing coefficients we get the following equation for $1 \le k$

$$
S(k) + \sum_{1 \le i \le k} R(i) S(k - i) = 0
$$

Thus

$$
S(k) = -\sum_{1 \le i \le k} R(i) S(k - i)
$$
