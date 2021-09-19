# Skipping Squares

For some fixed $\rho \in [0, 1]$, we begin a sum $s$ at $0$ and repeatedly apply a process: With probability $\rho$, we add $1$ to $s$, otherwise we add $2$ to $s$.

The process ends when either $s$ is a perfect square or $s$ exceeds $10^{18}$, whichever occurs first. For example, if $s$ goes through $0, 2, 3, 5, 7, 9$, the process ends at $s=9$, and two squares $1$ and $4$ were skipped over.

Let $f(\rho)$ be the expected number of perfect squares skipped over when the process finishes.

It can be shown that the power series for $f(\rho)$ is $\sum_{k=0}^\infty a_k \rho^k$ for a suitable (unique) choice of coefficients $a_k$. Some of the first few coefficients are $a_0=1$, $a_1=0$, $a_5=-18$, $a_{10}=45176$.

Let $F(n) = \sum_{k=0}^n a_k$. You are given that $F(10) = 53964$ and $F(50) \equiv 842418857 \pmod{10^9}$.

Find $F(1000)$, and give your answer modulo $10^9$.

## Solution

Define an auxiliary process where $\rho$ gives the probability of moving one cell ahead and $1 - \rho$ gives the probability of moving two cells ahead, and we do not stop at square numbered cells. Let $P_{n}(\rho)$ the probability of getting to the $n$-th cell. Then $P_{n}(\rho) = \rho \cdot P_{n-1}(\rho) + (1 - \rho) \cdot P_{n-2}(\rho)$, with base cases $P_{-1}(\rho) = 0, P_{0}(\rho) = 1$.

Let $Q_k(\rho)$ be the probability of getting to the $k$-th cell for the original process (taking into account that the process stops when we reach a square numbered cell). Then

$$
f(\rho) = \sum_{i = 1}^{10^9} i \cdot Q_{(i + 1)^2}(\rho)
$$

as to skip exactly $i$ squares we need to land on $(i + 1)^2$. Now let's prove a recurrence for $Q_k(\rho)$. Notice that after a sufficiently large number of steps you will end up at either $i^2$ or $i^2 + 1$. Suppose you are at $i^2 + 1$. Then the probability of having arrived here is $Q_{i^2 + 1}(\rho)$. The number of steps between $i^2 + 1$ and $(i + 1)^2$ is $2i$. Notice that at no point between $i^2 + 1$ and $(i + 1)^2$ you will stop, therefore this subprocess than be modeled with $P_k$. Specifically, the probability of getting to $(i + 1)^2$ equals the probability of getting $2i$ cells ahead of $i^2 + 1$. Therefore

$$
Q_{(i + 1)^2}(\rho) = Q_{i^2 + 1}(\rho) \cdot P_{2i}(\rho)
$$

and thus as a complement we get

$$
Q_{(i + 1)^2 + 1}(\rho) = Q_{i^2 + 1}(\rho) \cdot (1 - P_{2i}(\rho))
$$

These recurrences have base case $Q_{2}(\rho) = 1 - \rho$.

Finally, to calculate $F(N)$ we can compute $f(\rho)$ in the polynomial ring with coefficients in $\mathbb{Z}/ m \mathbb{Z}$ (where $m = 10^9$) and where $x^{N + 1} \equiv 0$. If at some point in the calculation $Q_{i^2 + 1}(\rho) \equiv 0$, then all terms in the sum of $f(p)$ from that point forward are identically zero and we can stop iterating.