# Sum of Squares

For a positive integer, $n$, define $g(n)$ to be the maximum perfect square that divides $n$.<br />
For example, $g(18) = 9$, $g(19) = 1$.

Also define
$$\displaystyle	S(N) = \sum_{n=1}^N g(n)$$

For example, $S(10) = 24$ and $S(100) = 767$.

Find $S(10^{14})$. Give your answer modulo $1\,000\,000\,007$.

## Solution

Any number $n$ has an unique representation $n = a^2 b$, with $b$ squarefree. Then $g(n) = a^2$. Therefore

$$
\begin{align*}
S(N)
&= \sum_{n = 1}^N g(n) \\
&= \sum_{a = 1}^{\sqrt{N}} \sum_{\substack{b = 1 \\ \\ \mu(b) \not= 0}}^{N / a^2} g(a^2 b) \\
&= \sum_{a = 1}^{\sqrt{N}} \sum_{\substack{b = 1 \\ \\ \mu(b) \not= 0}}^{N / a^2} a^2 \\
&= \sum_{a = 1}^{\sqrt{N}} a^2 \sum_{\substack{b = 1 \\ \\ \mu(b) \not= 0}}^{N / a^2} 1 \\
&= \sum_{a = 1}^{\sqrt{N}} a^2 \cdot Q(N / a^2) \\
\end{align*}
$$

where $Q$ is the squarefree counting function. Clearly $Q$ can be computed in $O(N^{1/2})$ time. Moreover, it can be memoized for values not greater than $\sqrt{N}$.