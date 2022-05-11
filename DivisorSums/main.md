# Divisor Sums

Let $D(m,n)=\displaystyle\sum_{d|m}\sum_{k=1}^n\sigma_{\small 0}(kd)$ where $d$ runs through all divisors of $m$ and $\sigma_{\small 0}(n)$ is the number of divisors of $n$.<br />
You are given $D(3!,10^2)=3398$ and $D(4!,10^6)=268882292$.

Find $D(200!,10^{12}) \text{ mod } (10^9 + 7)$.

## Solution

Let

$$
D(m, n, a)
= \sum_{d \mid m} \sum_{\substack{1 \le k \le n \\ p_1, \dots p_a \nmid k}} \sigma_0(kd)
$$

Then $D(m, n) = D(m, n, 0)$. Now suppose $t = \nu_{p_{a+1}}(m)$. Then

$$
\begin{align*}
D(m, n, a)
&= \sum_{d \mid m} \sum_{\substack{1 \le k \le n \\ p_1, \dots p_a \nmid k}} \sigma_0(kd) \\
&= \sum_{d \mid m} \sum_{r \ge 0} \sum_{\substack{1 \le k \le n \\ p_1, \dots p_a \nmid k \\ p_{a+1}^r \mid k \\ p_{a+1}^{r+1} \nmid k}} \sigma_0(kd) \\
&= \sum_{s = 0}^t \sum_{d \mid m/p_{a+1}^t} \sum_{r \ge 0} \sum_{\substack{1 \le k \le n / p_{a+1}^r \\ p_1, \dots p_{a+1} \nmid k}} \sigma_0(kd \cdot p_{a+1}^{r+s}) \\
&= \sum_{r \ge 0} \sum_{s = 0}^t \sum_{d \mid m/p_{a+1}^t} \sum_{\substack{1 \le k \le n / p_{a+1}^r \\ p_1, \dots p_{a+1} \nmid k}} \sigma_0(kd) \cdot \sigma_0(p_{a+1}^{r+s}) \\
&= \sum_{r \ge 0} \sum_{s = 0}^t \sigma_0(p_{a+1}^{r+s}) \sum_{d \mid m/p_{a+1}^t} \sum_{\substack{1 \le k \le n / p_{a+1}^r \\ p_1, \dots p_{a+1} \nmid k}} \sigma_0(kd) \\
&= \sum_{r \ge 0} \sum_{s = 0}^t (r + s + 1) \sum_{d \mid m/p_{a+1}^t} \sum_{\substack{1 \le k \le n / p_{a+1}^r \\ p_1, \dots p_{a+1} \nmid k}} \sigma_0(kd) \\
&= \sum_{r \ge 0} \sum_{s = 0}^t (r + s + 1) D(m/p_{a+1}^t, n / p_{a+1}^r, a + 1) \\
&= \sum_{r \ge 0} D(m/p_{a+1}^t, n / p_{a+1}^r, a + 1) \sum_{s = 0}^t (r + s + 1) \\
&= \sum_{r \ge 0} D(m/p_{a+1}^t, n / p_{a+1}^r, a + 1) \left( \frac{t(t+1)}{2} + (r + 1)(t + 1) \right) \\
\end{align*}
$$

After sufficiently many iterations $m = 1, t = 0$. Notice that if $p_{a+1}^3 \gt n \iff a = \pi(\sqrt[3]{n})$, then all the $1 \le k \le n$ that are not divisible by $p_1, \dots, p_a$ are prime, squares of primes, products of two distinct primes or the number $1$. Thus

$$
\begin{align*}
D(1, n, a)
&= \sum_{\substack{1 \le k \le n \\ p_1, \dots p_a \nmid k}} \sigma_0(k) \\
&= 1 + \sum_{x = a + 1}^c \sigma_0(p_x) + \sum_{x = a + 1}^b \sigma_0(p_x^2) + \sum_{\substack{a \lt x \lt y \le c \\ p_x p_y \le n}} \sigma_0(p_x p_y) \\
&= 1 + 2 (c - a) + 3 (b - a) + 4 \sum_{x = a + 1}^b \sum_{y = x + 1}^{\pi(n/p_x)} 1 \\
&= 1 + 2 (c - a) + 3 (b - a) + 4 \sum_{x = a + 1}^b \max(0, \pi(n/p_x) - x) \\
\end{align*}
$$

where $b = \pi(\sqrt{n}), c = \pi(n)$.