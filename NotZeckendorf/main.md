# Not Zeckendorf

Consider the Fibonacci sequence $\{1,2,3,5,8,13,21,\ldots\}$.

We let $f(n)$ be the number of ways of representing an integer $n\ge 0$ as the sum of different Fibonacci numbers.<br />
For example, $16 = 3+13 = 1+2+13 = 3+5+8 = 1+2+5+8$ and hence $f(16) = 4$. 
By convention $f(0) = 1$.

Further we define
$$\displaystyle S(n) = \sum_{k=0}^n f(k)$$
You are given $S(100) = 415$ and $S(10^4) = 312807$.

Find $\displaystyle S(10^{13})$.

## Solution

Let $T_L = \{ F_n \mid 1 \leq n \leq L \}$ where $F_n$ is the $(n + 1)$-th fibonacci number. Let $\sigma(U)$ be the sum of the elements of a set $U$. Notice then that

$$
f(k) = |\{ U \in \mathcal{P}(T_\infty) \mid \sigma(U) = k \}|
$$

Fix a value of $N$. Let $L$ be the maximum value possible such that $T_L \cap [1, N] = T_L$. Then for $k \leq N$ we have

$$
f(k) = |\{ U \in \mathcal{P}(T_L) \mid \sigma(U) = k \}|
$$

And we can rewrite

$$
\begin{align*}
S(N)
&= \sum_{k = 0}^N f(k) \\
&= \sum_{k = 0}^N \sum_{\substack{U \in \mathcal{P}(T_L) \\ \sigma(U) = k}} 1 \\
&= \sum_{\substack{U \in \mathcal{P}(T_L) \\ \sigma(U) \leq N}} 1 \\
\end{align*}
$$

Now define an auxiliary function

$$
S(N, L) = \sum_{\substack{U \in \mathcal{P}(T_L) \\ \sigma(U) \leq N}} 1
$$

Therefore $S(N) = S(N, L)$. Notice that if $\sigma(T_L) \leq N$, then

$$
S(N, L) = 2^{|T_L|}
$$

on the other hand if $N < 0$ then

$$
S(N, L) = 0
$$

and if $L = 0$ then

$$
S(N, L) = 1
$$

Finally, a recurrence for $S(N, L)$ arises naturally

$$
\begin{align*}
S(N)
&= \sum_{\substack{U \in \mathcal{P}(T_L) \\ \sigma(U) \leq N}} 1 \\
&= \sum_{\substack{U \in \mathcal{P}(T_L) \\ F_L \not\in U \\ \sigma(U) \leq N}} 1
+ \sum_{\substack{U \in \mathcal{P}(T_L) \\ F_L \in U \\ \sigma(U) \leq N}} 1 \\
&= \sum_{\substack{U \in \mathcal{P}(T_{L-1}) \\ \sigma(U) \leq N}} 1
+ \sum_{\substack{U \in \mathcal{P}(T_{L-1}) \\ \sigma(U) \leq N - F_L}} 1 \\
&= S(N, L - 1) + S(N - F_L, L - 1)
\end{align*}
$$