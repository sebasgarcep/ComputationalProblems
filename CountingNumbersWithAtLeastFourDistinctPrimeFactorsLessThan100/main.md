# Counting numbers with at least four distinct prime factors less than 100

<p>It can be verified that there are 23 positive integers less than 1000 that are divisible by at least four distinct primes less than 100.</p>

<p>Find how many positive integers less than 10<sup>16</sup> are divisible by at least four distinct primes less than 100.</p>

## Solution

Let $\delta_k(n) = 1$ if $n$ is divisible by at least $k$ distinct primes less than $100$, $\delta(n) = 0$ otherwise. Notice that $\delta_0(n) = 1$ for all $n$. Let

$$
C_k(N) = \sum_{\substack{1 \leq n \leq N \\ \\ \delta_k(n) = 1}} 1 \\
$$

Let $p_1, p_2, \dots$ be the primes in ascending order. Define an auxiliary function

$$
C_k(N, a) = \sum_{\substack{1 \leq n \leq N \\ \\ \delta_k(n) = 1 \\ \\ p_1, \dots, p_a \nmid n}} 1 \\
$$

Let $b = \pi(100)$. Notice that if $a \geq b$ and $k > 0$ then $C_k(N, a) = 0$. Moreover, if $k = 0$, we get $C_k(N, a) = \phi(N, a)$, where $\phi$ is the function as defined by Lehmer in his paper about the Meissel-Lehmer algorithm. Thus the following recurrence allows us to compute $\phi$ efficiently

$$
\phi(N, a) = \phi(N, a - 1) - \phi(N / p_a, a - 1)
$$

Finally, let's compute a recurrence for $C_k(N, a)$ when $a < b$ and $k > 0$

$$
\begin{align*}
C_k(N, a)
&= \sum_{\substack{1 \leq n \leq N \\ \\ \delta_k(n) = 1 \\ \\ p_1, \dots, p_a \nmid n}} 1 \\
&= \sum_{v \geq 0} \sum_{\substack{1 \leq n p_{a + 1}^v \leq N \\ \\ \delta_k(n p_{a + 1}^v) = 1 \\ \\ p_1, \dots, p_{a + 1} \nmid n}} 1 \\
&= \sum_{\substack{1 \leq n \leq N \\ \\ \delta_k(n) = 1 \\ \\ p_1, \dots, p_{a + 1} \nmid n}} 1
+ \sum_{v \geq 1} \sum_{\substack{1 \leq n \leq N / p_{a + 1}^v \\ \\ \delta_{k - 1}(n) = 1 \\ \\ p_1, \dots, p_{a + 1} \nmid n}} 1 \\
&= C_k(N, a + 1)
+ \sum_{v \geq 1} C_{k-1}(N/p_{a+1}^v, a + 1) \\
\end{align*}
$$

Notice that with this algorithm we do not need to know the primes past $100$, as $C_k$ increases the value of $a$ and $\phi$ decreases it. The solution to this problem is $C_4(10^{16}, 0)$. Finally, the algorithm can be optimized by memoizing $\phi$ for all possible $a$ and all $x \leq L$.