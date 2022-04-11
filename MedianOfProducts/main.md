# Median of Products

Let $S_i$ be an integer sequence produced with the following pseudo-random number generator:

- $S_0 = 290797$
- $S_{i+1} = S_i ^2 \bmod 50515093$

Let $M(n)$ be the median of the pairwise products $ S_i S_j $ for $0 \le i \lt j \lt n$.

You are given $M(3) = 3878983057768$ and $M(103) = 492700616748525$.

Find $M(1\,000\,003)$.

## Solution

Fix a value of $n$. Let $L_n = \{ S_i \cdot S_j : 0 \le i \lt j \lt n \}$. We are going to assume that no elements of the sequence $S_i$ are repeated and that no two products generate the same values. Notice that $|L_n| = \frac{n(n-1)}{2}$ and therefore for $n \equiv 2, 3 \pmod 4$, the median is an element of $L_n$ and not the average of two elements.

Let $f(n, m) = |\{ k \in L_n : k \le m \}|$. If $M$ is the median of $L_n$ then $f(n, M) = \frac{n(n-1)}{4} + 1$ and $f(n, M-1) = \frac{n(n-1)}{4}$. To find $M$ let's start with $a, b$ such that $f(n, a) \lt \frac{n(n-1)}{4} + 1$ and $f(n, b) \gt \frac{n(n-1)}{4} + 1$. Then $M$ must lie in the middle of $a, b$ and can be found using binary search to look for a number that satifies $f(n, M) = \frac{n(n-1)}{4} + 1$ and $f(n, M-1) = \frac{n(n-1)}{4}$.

Finally, $f(n, m)$ can be calculated by iterating over all $j$ and using binary search to find the largest $1 \le i \lt j$ such that $S_i \cdot S_j \le m$. Then $f(n, m)$ is the sum over all such $i$, if they exist.