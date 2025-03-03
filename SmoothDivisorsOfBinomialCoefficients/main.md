# Smooth Divisors of Binomial Coefficients

An integer is called <strong><var>B</var>-smooth</strong> if none of its prime factors is greater than $B$.

Let $S_B(n)$ be the largest $B$-smooth divisor of $n$.<br>
Examples:<br>
$S_1(10)=1$<br>
$S_4(2100) = 12$<br>
$S_{17}(2496144) = 5712$
Define $\displaystyle F(n)=\sum_{B=1}^n \sum_{r=0}^n S_B(\binom n r)$. Here, $\displaystyle \binom n r$ denotes the binomial coefficient.<br>
Examples:<br>
$F(11) = 3132$<br>
$F(1111) \mod 1\,000\,000\,993 = 706036312$<br>
$F(111\,111) \mod 1\,000\,000\,993 = 22156169$

Find $F(11\,111\,111)  \mod 1\,000\,000\,993$.

## Solution

Let $p_i$ be the $i$-prime number. Suppose $\binom{n}{r}$ factors as $\prod_{i=1}^{\pi(n)} p_i^{k_i(r)}$ where $k_i(r) = \nu_{p_i} \binom{n}{r}$. Then

$$
\begin{align*}
F(n)
&= \sum_{B=1}^n \sum_{r=0}^n S_B(\binom{n}{r}) \\

&= n + 1 + (n - p_{\pi(n)} + 1) \sum_{r=0}^n S_{p_{\pi(n)}}(\binom{n}{r}) + \sum_{i=1}^{\pi(n) - 1} (p_{i+1} - p_i) \sum_{r=0}^n S_{p_i}(\binom{n}{r}) \\

&= n + 1 + (n - p_{\pi(n)} + 1) \sum_{r=0}^n \binom{n}{r} + \sum_{i=1}^{\pi(n) - 1} (p_{i+1} - p_i) \sum_{r=0}^n S_{p_i}(\binom{n}{r}) \\

&= n + 1 + (n - p_{\pi(n)} + 1) \cdot 2^n + \sum_{i=1}^{\pi(n) - 1} (p_{i+1} - p_i) \sum_{r=0}^n S_{p_i}(\binom{n}{r}) \\

&= n + 1 + (n - p_{\pi(n)} + 1) \cdot 2^n + \sum_{i=1}^{\pi(n) - 1} (p_{i+1} - p_i) \sum_{r=0}^n \prod_{j=1}^i p_j^{k_j(r)} \\

&= n + 1 + (n - p_{\pi(n)} + 1) \cdot 2^n + \sum_{r=0}^n \sum_{i=1}^{\pi(n) - 1} (p_{i+1} - p_i) \cdot \prod_{j=1}^i p_j^{k_j(r)} \\

&= n + 1 + (n - p_{\pi(n)} + 1) \cdot 2^n + \sum_{r=0}^n \sum_{i=1}^{\pi(n) - 1} \prod_{j=1}^i  \left( p_j^{k_j(r)} \cdot \frac{p_{j+1} - p_j}{p_j - p_{j-1}} \right) \\
\end{align*}
$$

where $p_0 = 1$. Note that from $r$ to $r+1$ only a small amount of $p_j^{k_j(r)} \cdot \frac{p_{j+1} - p_j}{p_j - p_{j-1}}$ terms will actually change. So if we can come up with a data structure that keeps track of $\sum_{i=1}^k \prod_{j=1}^i x_j$ for $1 \le k \le n$ as the values of $x_j$ change then we are good.

Note also that $\binom{n}{r}=\binom{n}{n-r}$ and we can exploit this symmetry to reduce the amount of updates to this data structure.

## Multiplicative Fenwick Trees

Suppose we have an array of values and we want to keep track of the running product. Consider the Fenwick tree. Then by replacing all additions to/from the tree with multiplications we get a Fenwick tree that tracks running products.

## Sum-Product Fenwick Tree

Note that the Fenwick tree is a data structure that keeps $\sum_{i={n - \text{lsb}(n) + 1}}^n x_i$ stored in position $n$. We'll take inspiration from this to define the following data structure: Suppose the values we want to track are $x_i$ for $1 \le i \le n$. Let $x_{a,b} = \sum_{i=a}^b \prod_{j=a}^i x_j$. In position $n$ of the array we will store $x_{n-\text{lsb}(n)+1, n}$. Now we need to find out algorithms for construction, querying and updating the tree.

Let $y_{a,b} = \prod_{i=a}^b x_i$ (which we can keep track of efficiently using the Multiplicative Fenwick tree). Then $x_{a,c} = x_{a,b} + y_{a,b} \cdot x_{b+1,c}$. We will use this identity for the following algorithms.

### Construction

Note that $x_{1,k} = x_{1,k-\text{lsb}(k)} + y_{1,k-\text{lsb}(k)} \cdot x_{k-\text{lsb}(k)+1,k}$. We can construct $x_{1,k}$ iteratively using the identity $x_{1,k} = x_{1,k-1} + y_{1,k}$ with $x_{1,0} = 0$. Also we use the querying algorithm to calculate $x_{1,k-\text{lsb}(k)}$. Solving for $x_{k-\text{lsb}(k)+1,k}$ gives us the initial value for position $k$.

### Querying

Note that $x_{1,k} = x_{1,k-\text{lsb}(k)} + y_{1,k-\text{lsb}(k)} \cdot x_{k-\text{lsb}(k)+1,k}$. We know that $x_{k-\text{lsb}(k)+1,k}$ is in position $k$, so it remains to find the value of $x_{1,k-\text{lsb}(k)}$ which can be found by applying the same formula again. This leads to a recursive implementation naturally, which can be optimized by replacing it with a while loop.

### Updating

The update algorithm for the base Fenwick tree tells us which ranges need to be updated. Suppose we need to update $x_d$ to $x'_d$. Then applying the identity to the affected range $[a,b]$ we get

$$
x_{a,b} = x_{a,d-1} + y_{a,d-1} \cdot x_{d,b}
$$

Note that only $x_{d,b}$ will change. Furthermore, every element of the sum in $x_{d,b}$ is multiplied by $x_d$. So the update to $x_{d,b}$ is $x'_{d,b} = x_{d,b} \cdot \frac{x'd}{x_d}$. So for each range we can isolate $x_{d,b}$, then we can compute $x'_{d,b}$ and finally we need to replace the value in this range with

$$
x'_{a,b} = x_{a,d-1} + y_{a,d-1} \cdot x'_{d,b}
$$

## Sources
- https://en.wikipedia.org/wiki/Fenwick_tree
