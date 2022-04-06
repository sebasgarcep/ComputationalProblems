# Square root smooth Numbers

A positive integer is called <i>square root smooth</i> if all of its prime factors are strictly less than its square root.<br />
Including the number $1$, there are $29$ square root smooth numbers not exceeding $100$.

How many square root smooth numbers are there not exceeding $10\,000\,000\,000$?

## Solution

Suppose $x$ is not a square root smooth number. Then there is a prime $p$ such that $p \mid x$ and $p \ge \sqrt{x}$. Therefore $p^2 \ge x = kp \Rightarrow p \ge k$.

Notice that there is no prime $q \not= p$ such that $q \mid x$ and $q \ge \sqrt{x}$. One can prove this by contradiction. Suppose such $q$ exists. Then $pq \mid x \Rightarrow pq \le x$ and $pq \ge \sqrt{x} \cdot \sqrt{x} = x$. Therefore $pq = x, p = \sqrt{x}, q = \sqrt{x}$. But then $p = q$, a contradiction.

Therefore there is a bijection between $x$ that is not a square root smooth number and a tuple $(p, k)$ where $p$ is a prime and $k$ is an integer such that $1 \le k \le p$.

Suppose $F(N)$ is the amount of square root smooth numbers not exceeding $N$. Then

$$
\begin{align*}
F(N)
&= N - \sum_{p \le N} \sum_{k = 1}^{\min(p, \left\lfloor N / p \right\rfloor)} 1 \\
&= N - \sum_{p \le N} \min(p, \left\lfloor N / p \right\rfloor) \\
&= N - \sum_{p^2 \le N} p - \sum_{\sqrt{N} \lt p \le N} \left\lfloor N/p \right\rfloor \\
\end{align*}
$$

The first sum can be calculated efficiently using a prime sieve up to $\sqrt{N}$. Let's figure an efficient way of computing the second sum.

Suppose $u = \left\lfloor N / p \right\rfloor$. Then $u \le N / p \lt u+1 \Rightarrow N/(u+1) \lt p \le N/u$. Therefore

$$
\begin{align*}
\sum_{\sqrt{N} \lt p \le N} \left\lfloor N/p \right\rfloor
&= \sum_{u = 1}^L u \cdot (\pi(N/u) - \pi(N/(u+1))) \\
&= \sum_{u = 1}^L u \cdot \pi(N/u) - \sum_{u = 1}^L u \cdot \pi(N/(u+1)) \\
&= \sum_{u = 1}^L u \cdot \pi(N/u) - \sum_{u = 2}^{L+1} (u-1) \cdot \pi(N/u) \\
&= \sum_{u = 2}^L u \cdot \pi(N/u) - \sum_{u = 2}^L (u-1) \cdot \pi(N/u) + \pi(N) - L \cdot \pi(N/(L+1)) \\
&= \sum_{u = 2}^L \pi(N/u) + \pi(N) - L \cdot \pi(N/(L+1)) \\
\end{align*}
$$

Where $L$ is given by $u < \left\lfloor N/u \right\rfloor$ and $\pi$ can be computed using the Meissel-Lehmer algorithm.