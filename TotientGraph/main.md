# Totient Graph

For a positive integer $n$ construct a graph using all the divisors of $n$ as the vertices. An edge is drawn between $a$ and $b$ if $a$ is divisible by $b$ and $a/b$ is prime, and is given weight $\phi(a)-\phi(b)$, where $\phi$ is the Euler totient function.<br> Define $t(n)$ to be the total weight of this graph.<br>
The example below shows that $t(45) = 52$

<img src="https://projecteuler.net/resources/images/0931_totientgraph.png?1738586879" alt="0931_totientgraph.png">

Let $T(N)=\displaystyle\sum_{n=1}^{N} t(n)$. You are given $T(10)=26$ and $T(10^2)=5282$.

Find $T(10^{12})$. Give your answer modulo $715827883$.

## Solution

Let $G_n$ be the graph for $n$. Suppose $p$ is a prime that divides $n$. Then the node for $n$ in $G_n$ is going to have vertices to $n/p$. We know that $\varphi(n) = \varphi(n/p^{\nu_p(n)}) \cdot p^{\nu_p(n)} \cdot (1 - 1/p)$. Therefore

$$
\begin{align*}
\varphi(n) - \varphi(n/p)

&= \varphi(n/p^{\nu_p(n)}) \cdot \varphi(p^{\nu_p(n)}) - \varphi(n/p^{\nu_p(n)}) \cdot \varphi(p^{\nu_p(n) - 1}) \\

&= \varphi(n/p^{\nu_p(n)}) \cdot (\varphi(p^{\nu_p(n)}) - \varphi(p^{\nu_p(n) - 1})) \\

&=
\begin{cases}
(p - 2) \cdot \varphi(n/p) & \text{ if } \nu_p(n) = 1 \\
(p^{\nu_p(n)} - p^{\nu_p(n) - 1} - p^{\nu_p(n) - 1} + p^{\nu_p(n)-2}) \cdot \varphi(n/p^{\nu_p(n)}) & \text{ otherwise} \\
\end{cases} \\

&=
\begin{cases}
(p - 2) \cdot \varphi(n/p) & \text{ if } \nu_p(n) = 1 \\
p^{\nu_p(n)-2} \cdot (p^2 - 2p + 1) \cdot \varphi(n/p^{\nu_p(n)}) & \text{ otherwise} \\
\end{cases} \\

&=
\begin{cases}
(p - 2) \cdot \varphi(n/p) & \text{ if } \nu_p(n) = 1 \\
p^{\nu_p(n)-2} \cdot (p - 1)^2 \cdot \varphi(n/p^{\nu_p(n)}) & \text{ otherwise} \\
\end{cases} \\

&=
\begin{cases}
(p - 2) \cdot \varphi(n/p) & \text{ if } \nu_p(n) = 1 \\
\varphi(p^{\nu_p(n)-1}) \cdot (p - 1) \cdot \varphi(n/p^{\nu_p(n)}) & \text{ otherwise} \\
\end{cases} \\

&=
\begin{cases}
(p - 2) \cdot \varphi(n/p) & \text{ if } \nu_p(n) = 1 \\
(p - 1) \cdot \varphi(n/p) & \text{ otherwise} \\
\end{cases} \\
\end{align*}
$$

Suppose $\nu_p(n) = k$. Then $G_n$ is formed by $k+1$ copies of $G_{n/p^k}$, with each copy having its nodes multiplied by a distinct power $p$ up to the $k$-th power, and for the first $k$ copies each node $m$ has an extra edge that goes from $mp$ to $m$. Therefore

$$
\begin{align*}
t(n)
&= \sum_{i = 0}^k t(n/p^k) \varphi(p^i) + \sum_{i = 1}^{k-1} \sum_{d \mid n/p^k} (p - 1) \varphi(d \cdot p^i) + (p - 2) \sum_{d \mid n/p^k} \varphi(d) \\

&= t(n/p^k) \sum_{i = 0}^k \varphi(p^i) + (p - 1) \sum_{i = 1}^{k-1} \varphi(p^i) \sum_{d \mid n/p^k} \varphi(d) + (p - 2) \cdot n/p^k \\

&= t(n/p^k) \sum_{d \mid p^k} \varphi(d) + (p - 1) \cdot n/p^k \sum_{i = 1}^{k-1} \varphi(p^i) + (p - 1) \cdot n/p^k - n/p^k \\

&= t(n/p^k) \cdot p^k + (p - 1) \cdot n/p^k \sum_{i = 0}^{k-1} \varphi(p^i) - n/p^k \\

&= t(n/p^k) \cdot p^k + (p - 1) \cdot n/p^k \sum_{d \mid p^{k-1}} \varphi(d) - n/p^k \\

&= t(n/p^k) \cdot p^k + (p - 1) \cdot n/p^k \cdot p^{k-1} - n/p^k \\

&= t(n/p^k) \cdot p^k + (p - 1) \cdot n/p - n/p^k \\
&= t(n/p^k) \cdot p^k + p^{k-1} (p - 1) \cdot n/p^k - n/p^k \\
&= t(n/p^k) \cdot p^k + (\varphi(p^k) - 1) \cdot n/p^k \\
\end{align*}
$$

where the first sum is adding the values of the edges for the $k+1$ copies of $G_{n/p^k}$ and the second sum is adding the values for the extra edges between copies. Note that we are multiplying $t(n/p^k)$ by $\varphi(p^i)$ since if we pick an edge it will have a value of $C \cdot \varphi(d'/q) = C \cdot \varphi(d/q \cdot p^i) = C \cdot \varphi(d/q) \cdot \varphi(p^i)$ where $d \mid n/p^k$, $q \not= p$ is a prime that divides $d$ and $d' = d \cdot p^i$ since this edge is in the $i$-th copy of $G_{n/p^k}$. Note that $C \cdot \varphi(d/q)$ corresponds to the value of the matching edge in the base $G_{n/p^k}$, so we can multiply $t(n/p^k) \cdot \varphi(p^i)$ to obtain the sum of the edges for this copy of $G_{n/p^k}$.

The previous formula allows us to prove the following statement using induction

$$
\begin{align*}
t(n)
&= \sum_{\substack{p \mid n \\ p \text{ prime}}} \frac{n}{p^{\nu_p(n)}} \cdot (\varphi(p^{\nu_p(n)}) - 1) \\

&= \sum_{\substack{p \mid n \\ p \text{ prime}}} \frac{n}{p^{\nu_p(n)}} \cdot (p^{\nu_p(n)} - p^{\nu_p(n) - 1} - 1) \\

&= \sum_{\substack{p \mid n \\ p \text{ prime}}} (n - \frac{n}{p} - \frac{n}{p^{\nu_p(n)}}) \\
\end{align*}
$$

Calculating the desired formula we get

$$
\begin{align*}
T(N)
&= \sum_{1 \le n \le N} t(n) \\
&= \sum_{1 \le n \le N} \sum_{\substack{p \mid n \\ p \text{ prime}}} (n - \frac{n}{p} - \frac{n}{p^{\nu_p(n)}}) \\
&= \sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \sum_{1 \le n \cdot p \le N} (np - n - \frac{n}{p^{\nu_p(n) - 1}}) \\
\end{align*}
$$

Looking at the first sum

$$
\begin{align*}
\sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \sum_{1 \le n \cdot p \le N} np
&= \sum_{\substack{1 \le p \le N \\ p \text{ prime}}} p \sum_{1 \le n \cdot p \le N} n \\
&= \sum_{\substack{1 \le p \le N \\ p \text{ prime}}} p \cdot \Sigma_1(N/p) \\
\end{align*}
$$

Looking at the second sum

$$
\begin{align*}
\sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \sum_{1 \le n \cdot p \le N} n
&= \sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \Sigma_1(N/p)
\end{align*}
$$

Looking at the third sum

$$
\begin{align*}
\sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \sum_{1 \le n \cdot p \le N} \frac{n}{p^{\nu_p(n) - 1}}
&= \sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \sum_{k \ge 1} \sum_{\substack{1 \le n \cdot p^k \le N \\ p \nmid n}} n \\
&= \sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \sum_{k \ge 1} \sum_{\substack{1 \le n \le N / p^k \\ p \nmid n}} n \\
&= \sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \sum_{k \ge 1} \left[ \sum_{\substack{1 \le n \le N / p^k}} n - \sum_{\substack{1 \le n \le N / p^k \\ p \mid n}} n \right] \\
&= \sum_{\substack{1 \le p \le N \\ p \text{ prime}}} \sum_{k \ge 1} \left[ \Sigma_1(N/p^k) - p \cdot \Sigma_1(N/p^{k+1}) \right] \\
\end{align*}
$$

We can split these sums along $\sqrt{N}$ and calculate them explicitly for primes not greater than this limit and for primes larger than this limit we can group them according to which primes map to the same value of $\left\lfloor N/p \right\rfloor$. Note also that for these primes $p^2 > N$ and therefore we only have to consider $k = 1$ in the third sum.

Suppose $u = \left\lfloor N/p \right\rfloor$. Therefore $\frac{N}{u+1} \lt p \le \frac{N}{u}$. Thus there are $\pi(N/u) - \pi(N/(u+1))$ primes in this range. This allows us to compute the second sum. The first sum can be computed by noting that $\Sigma_1(u)$ is constant in this range and the sum of primes in this range is $\Sigma(N/u) - \Sigma(N/(u+1))$. The first part of the third sum is actually equal to the second sum, so we can just subtract that value twice.

Finally, the fourth sum

$$
\sum_{\substack{\sqrt{N} \lt p \le N \\ p \text{ prime}}} p \cdot \Sigma_1(N/p^2) = 0
$$

as $p^2 > N$.
