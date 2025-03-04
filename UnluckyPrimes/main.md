# Unlucky Primes

We define the <i>unlucky prime</i> of a number $n$, denoted $u(n)$, as the smallest prime number $p$ such that the remainder of $n$ divided by $p$ (i.e. $n \bmod p$) is not a multiple of seven.<br>
For example, $u(14) = 3$, $u(147) = 2$ and $u(1470) = 13$.

Let $U(N)$ be the sum $\sum_{n = 1}^N u(n)$.<br>
You are given $U(1470) = 4293$.

Find $U(10^{17})$.

## Solution

Note that if $n \pmod 2 \not\equiv 0$ then $u(n) = 2$. Similarly if $n \pmod 2 \equiv 0$ and $n \pmod 3 \not\equiv 0$ then $u(n) = 3$. So we can use a sieving approach to find all values of $n$ that satisfy $u(n) = p$.

Let $p_1, p_2, \dots$ be the prime numbers. Then

$$
\begin{align*}
U(N)

&= \sum_{k \ge 1} p_k \sum_{\substack{1 \le n \le N  \\ \\ n \equiv 7u_1 \pmod {p_1} \\ \vdots \\ \\ n \equiv 7u_{k-1} \pmod {p_{k-1}} \\ \\ n \not\equiv 7u_k \pmod {p_k}}} 1 \\

&= \sum_{k \ge 1} p_k \left( \sum_{\substack{1 \le n \le N  \\ \\ n \equiv 7u_1 \pmod {p_1} \\ \vdots \\ \\ n \equiv 7u_{k-1} \pmod {p_{k-1}}}} 1 - \sum_{\substack{1 \le n \le N  \\ \\ n \equiv 7u_1 \pmod {p_1} \\ \vdots \\ \\ n \equiv 7u_{k-1} \pmod {p_{k-1}} \\ \\ n \equiv 7u_k \pmod {p_k}}} 1 \right) \\

&= 2N + \sum_{k \ge 1} (p_{k+1} - p_k) \sum_{\substack{1 \le n \le N  \\ \\ n \equiv 7u_1 \pmod {p_1} \\ \vdots \\ \\ n \equiv 7u_k \pmod {p_k}}} 1  \\
\end{align*}
$$
