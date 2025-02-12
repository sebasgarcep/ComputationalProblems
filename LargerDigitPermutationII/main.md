# Larger Digit Permutation II

Let $B(n)$ be the smallest number larger than $n$ that can be formed by rearranging digits of $n$, or $0$ if no such number exists. For example, $B(245) = 254$ and $B(542) = 0$.

Define $a_0 = 0$ and $a_n = a_{n - 1}^2 + 2$ for $n > 0$.
Let $\displaystyle U(N) = \sum_{n = 1}^N B(a_n)$. You are given $U(10) \equiv 543870437 \pmod{10^9+7}$.

Find $U(10^{16})$. Give your answer modulo $10^9 + 7$.

## Solution

$$
k > j \\
d_k < d_j \\
B(a_n) - a_n = (d_j - d_k) 10^k + (d_k - d_j) 10^j \\
B(a_n) - a_n = (d_j - d_k) 10^k - (d_j - d_k) 10^j \\
B(a_n) - a_n = (d_j - d_k) \cdot (10^k - 10^j) \\
B(a_n) - a_n = 10^j (d_j - d_k) \cdot (10^{k-j} - 1) \\
$$

$$
\sum B(a_n) = \sum (B(a_n) - a_n) + \sum a_n \\
$$

The right-most sum on the RHS can be calculated easily. The left-most sum of the RHS can be calculated easily if the first $t$ digits are decreasing for all elements in the sum. If $t = 9$ then only the $a_n$ for $n = 429120 + 625000 k$ will not satisfy this requirement.
