# Exponent Difference

For any integer $n \gt 0$ and prime number $p,$ define $\nu_p(n)$ as the greatest integer $r$ such that $p^r$ divides $n$. 

Define $$D(n, m)  = \sum_{p \text{ prime}} \left| \nu_p(n) - \nu_p(m)\right|.$$ For example, $D(14,24) = 4$.

Furthermore, define $$S(N) = \sum_{1 \le n, m \le N} D(n, m).$$ You are given $S(10) = 210$ and $S(10^2) = 37018$.

Find $S(10^{12})$. Give your answer modulo $1\,000\,000\,007$.

## Solution

Notice that

$$
\begin{align*}
S(N)
&= \sum_{a = 1}^N \sum_{b = 1}^N \sum_{\substack{p \text{ prime} \\ p \le N}} |\nu_p(a) - \nu_p(b)| \\
&= \sum_{\substack{p \text{ prime} \\ p \le N}} \sum_{a = 1}^N \sum_{b = 1}^N |\nu_p(a) - \nu_p(b)| \\
\end{align*}
$$

Choose a prime $p$ such that $p \gt \sqrt{N}$. Then $\nu_p(n) \le 1$ for all $n \le N$. Therefore $|\nu_p(a) - \nu_p(b)| = 1$ if and only if $p$ divides either $a$ or $b$ but not both. Otherwise $|\nu_p(a) - \nu_p(b)| = 0$. Therefore

$$
\begin{align*}
\sum_{a = 1}^N \sum_{b = 1}^N |\nu_p(a) - \nu_p(b)|
&= \sum_{\substack{1 \le a \le N \\ p \mid a}} \sum_{\substack{1 \le b \le N \\ p \not\mid b}} 1 + \sum_{\substack{1 \le a \le N \\ p \not\mid a}} \sum_{\substack{1 \le b \le N \\ p \mid b}} 1 \\
&= 2 \sum_{\substack{1 \le a \le N \\ p \mid a}} \sum_{\substack{1 \le b \le N \\ p \not\mid b}} 1 \\
&= 2 \sum_{i = 1}^{\left\lfloor N/p \right\rfloor} \sum_{j = 1}^{N - \left\lfloor N/p \right\rfloor} 1 \\
&= 2 \left\lfloor N/p \right\rfloor \cdot (N - \left\lfloor N/p \right\rfloor) \\
\end{align*}
$$

Therefore

$$
\begin{align*}
\sum_{\substack{p \text{ prime} \\ \sqrt{N} \lt p \le N}} \sum_{a = 1}^N \sum_{b = 1}^N |\nu_p(a) - \nu_p(b)|
&= \sum_{\substack{p \text{ prime} \\ \sqrt{N} \lt p \le N}} 2 \left\lfloor N/p \right\rfloor \cdot (N - \left\lfloor N/p \right\rfloor) \\
&= \sum_{u = 1}^L 2u \cdot (N - u) \cdot (\pi(N/u) - \pi(N/(u+1))) \\
\end{align*}
$$

where $L$ is given by $u < \left\lfloor N/u \right\rfloor$ and $\pi$ can be computed using the Meissel-Lehmer algorithm.

Now choose a prime $p$ such that $p \le \sqrt{N}$. Let

$$
\begin{align*}
f_{p,r}(N)
&= \sum_{\substack{1 \le n \le N \\ \nu_p(n) = r}} 1 \\
&= \left\lfloor N/p^r \right\rfloor - \left\lfloor N/p^{r+1} \right\rfloor
\end{align*}
$$

Then

$$
\begin{align*}
\sum_{a = 1}^N \sum_{b = 1}^N |\nu_p(a) - \nu_p(b)|
&= \sum_{x \ge 0} \sum_{y \ge 0} \sum_{\substack{1 \le a \le N \\ v_p(a) = x}} \sum_{\substack{1 \le b \le N \\ v_p(b) = y}} |\nu_p(a) - \nu_p(b)| \\
&= \sum_{x \ge 0} \sum_{y \ge 0} \sum_{\substack{1 \le a \le N \\ v_p(a) = x}} \sum_{\substack{1 \le b \le N \\ v_p(b) = y}} |x - y| \\
&= \sum_{x \ge 0} \sum_{y \ge 0} |x - y| \cdot \left(\sum_{\substack{1 \le a \le N \\ v_p(a) = x}} 1 \right) \cdot \left( \sum_{\substack{1 \le b \le N \\ v_p(b) = y}} 1 \right)  \\
&= \sum_{x \ge 0} \sum_{y \ge 0} |x - y| \cdot f_{p,x}(N) \cdot f_{p,y}(N) \\
&= 2 \sum_{1 \le x} \sum_{0 \le y \le x-1} (x - y) \cdot f_{p,x}(N) \cdot f_{p,y}(N) \\
\end{align*}
$$

Therefore

$$
\sum_{\substack{p \text{ prime} \\ p \le \sqrt{N}}} \sum_{a = 1}^N \sum_{b = 1}^N |\nu_p(a) - \nu_p(b)| = \sum_{\substack{p \text{ prime} \\ p \le \sqrt{N}}} 2 \sum_{1 \le x} \sum_{0 \le y \le x-1} (x - y) \cdot f_{p,x}(N) \cdot f_{p,y}(N)
$$

And the final result is obtained by adding both parts of the sum.