# Recursive Sequence Summation

The sequence $a_n$ is defined by $a_1=1$, and then recursively for $n\geq1$:

$$
\begin{align*}
a_{2n}  &=2a_n\\
a_{2n+1} &=a_n-3a_{n+1}
\end{align*}
$$

The first ten terms are $1, 2, -5, 4, 17, -10, -17, 8, -47, 34$.<br>

Define $\displaystyle S(N) = \sum_{n=1}^N a_n$. You are given $S(10) = -13$<br>
Find $S(10^{12})$.

## Solution

Let

$$
S_O(N) = \sum_{\substack{1 \le n \le N \\ 2 \nmid n}} a_n
$$

Notice that

$$
\begin{align*}
S(N)
&= \sum_{\substack{1 \le n \le N}} a_n \\
&= \sum_{j \ge 0} \sum_{\substack{1 \le 2^j n \le N \\ 2 \nmid n}} a_{2^j n} \\
&= \sum_{j \ge 0} \sum_{\substack{1 \le n \le N / 2^j \\ 2 \nmid n}} 2^j a_{n} \\
&= \sum_{j \ge 0} 2^j S_O(N/2^j) \\
\end{align*}
$$

Also, notice that for $N \ge 1$

$$
\begin{align*}
S_O(N)
&= \sum_{\substack{1 \le n \le N \\ 2 \nmid n}} a_n \\
&= \sum_{\substack{0 \le n \le q(N)}} a_{2n+1} \\
&= a_1 + \sum_{\substack{1 \le n \le q(N)}} a_{2n+1} \\
&= a_1 + \sum_{\substack{1 \le n \le q(N)}} (a_n - 3 a_{n+1}) \\
&= a_1 + a_1 - 3 a_{q(N) + 1} - 2 \sum_{\substack{2 \le n \le q(N)}} a_n \\
&= 2 a_1 - 3 a_{q(N) + 1} + 2 a_1 - 2 \sum_{\substack{1 \le n \le q(N)}} a_n \\
&= 4 a_1 - 3 a_{q(N) + 1} - 2 \sum_{\substack{1 \le n \le q(N)}} a_n \\
&= 4 - 3 a_{q(N) + 1} - 2 \cdot S(q(N)) \\
\end{align*}
$$

where 

$$
q(N) = \lfloor (N-1) / 2 \rfloor
$$