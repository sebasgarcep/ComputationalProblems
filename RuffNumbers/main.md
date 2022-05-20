# Ruff Numbers

Let $S_k$ be the set containing 2 and 5 and the first $k$ primes that end in 7. For example, $S_3 = \{2,5,7,17,37\}$.

Define a $k$-<i>Ruff</i> number to be one that is not divisible by any element in $S_k$.

If $N_k$ is the product of the numbers in $S_k$ then define $F(k)$ to be the sum of all $k$-Ruff numbers less than $N_k$ that have last digit 7. You are given $F(3) = 76101452$.

Find $F(97)$, give your answer modulo $1\,000\,000\,007$.

## Solution

Let $2, 5, p_1, \dots, p_k \in S_k$ be the distinct elements of $S_k$. Let $\phi(N, a, d)$ be the amount of numbers not exceeding $N$ that are not divisible by $2, 5, p_1, \dots, p_a$ with last digit $d$. Similarly let $\gamma(N, a, d)$ be the sum of the numbers not exceeding $N$ that are not divisible by $2, 5, p_1, \dots, p_a$ with last digit $d$. Then $F(k) = \gamma(N_k, k, 7)$. We have initial values

$$
N_0 = 10 \\
\phi(N_0, 0, d) =
\begin{cases}
0 & \text{if d = 0, 2, 4, 5, 6, 8} \\
1 & \text{otherwise}
\end{cases} \\
\gamma(N_0, 0, d) =
\begin{cases}
0 & \text{if d = 0, 2, 4, 5, 6, 8} \\
d & \text{otherwise}
\end{cases} \\
$$


Note that

$$
\begin{align*}
\phi(N_k, k-1, d) - \phi(N_k, k, d)
&= \sum_{\substack{1 \le x \le N_k \\ p_1, \dots, p_{k-1} \nmid x \\ p_k \mid x \\ x \equiv d \pmod {10}}} 1 \\
&= \sum_{\substack{1 \le x \le N_k/p_k \\ p_1, \dots, p_{k-1} \nmid x  \\ x \equiv 3d \pmod {10}}} 1 \\
&= \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid x  \\ x \equiv 3d \pmod {10}}} 1 \\
&= \phi(N_{k-1}, k-1, 3d) \\
\end{align*}
$$

as $p_k^{-1} \equiv 3 \pmod {10}$ and where the last argument to $\phi$ is considered modulo $10$. On the other hand

$$
\begin{align*}
\phi(N_k, k-1, d)
&= \sum_{\substack{1 \le x \le N_k \\ p_1, \dots, p_{k-1} \nmid x \\ x \equiv d \pmod {10}}} 1 \\
&= \sum_{i = 0}^{p_k - 1} \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid i \cdot N_{k-1} + x \\ i \cdot N_{k-1} + x \equiv d \pmod {10}}} 1 \\
&= \sum_{i = 0}^{p_k - 1} \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid x \\ x \equiv d \pmod {10}}} 1 \\
&= \sum_{i = 0}^{p_k - 1} \phi(N_{k-1}, k-1, d) \\
&= p_k \cdot \phi(N_{k-1}, k-1, d) \\
\end{align*}
$$

which implies

$$
\phi(N_k, k, d) = p_k \cdot \phi(N_{k-1}, k-1, d) - \phi(N_{k-1}, k-1, 3d)
$$

Now let's compute a recursion for $\gamma$

$$
\begin{align*}
\gamma(N_k, k-1, d) - \gamma(N_k, k, d)
&= \sum_{\substack{1 \le x \le N_k \\ p_1, \dots, p_{k-1} \nmid x \\ p_k \mid x \\ x \equiv d \pmod {10}}} x \\
&= p_k \sum_{\substack{1 \le x \le N_k/p_k \\ p_1, \dots, p_{k-1} \nmid x \\ x \equiv 3d \pmod {10}}} x \\
&= p_k \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid x \\ x \equiv 3d \pmod {10}}} x \\
&= p_k \cdot \gamma(N_{k-1}, k-1, 3d) \\
\end{align*}
$$

where again the last argument is considered modulo $10$. On the other hand

$$
\begin{align*}
\phi(N_k, k-1, d)
&= \sum_{\substack{1 \le x \le N_k \\ p_1, \dots, p_{k-1} \nmid x \\ x \equiv d \pmod {10}}} x \\
&= \sum_{i = 0}^{p_k - 1} \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid i \cdot N_{k-1} + x \\ i \cdot N_{k-1} + x \equiv d \pmod {10}}} (i \cdot N_{k-1} + x) \\
&= \sum_{i = 0}^{p_k - 1} \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid i \cdot N_{k-1} + x \\ x \equiv d \pmod {10}}} i \cdot N_{k-1} + \sum_{i = 0}^{p_k - 1} \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid i \cdot N_{k-1} + x \\ x \equiv d \pmod {10}}} x \\
&= N_{k-1} \sum_{i = 0}^{p_k - 1} i \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid x \\ x \equiv d \pmod {10}}} 1 + \sum_{i = 0}^{p_k - 1} \sum_{\substack{1 \le x \le N_{k-1} \\ p_1, \dots, p_{k-1} \nmid x \\ x \equiv d \pmod {10}}} x \\
&= N_{k-1} \cdot \phi(N_{k-1}, k - 1, d) \sum_{i = 0}^{p_k - 1} i + \gamma(N_{k-1}, k-1, d) \sum_{i = 0}^{p_k - 1} 1 \\
&= N_{k-1} \cdot \frac{(p_k - 1) p_k}{2} \cdot \phi(N_{k-1}, k - 1, d) + p_k \cdot \gamma(N_{k-1}, k-1, d) \\
\end{align*}
$$

which implies

$$
\gamma(N_k, k, d) = N_{k-1} \cdot \frac{(p_k - 1) p_k}{2} \cdot \phi(N_{k-1}, k - 1, d) + p_k \cdot \gamma(N_{k-1}, k-1, d) - p_k \cdot \gamma(N_{k-1}, k-1, 3d)
$$

These formulas allow us to compute $F(k)$ using DP.