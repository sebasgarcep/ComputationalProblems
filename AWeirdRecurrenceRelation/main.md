# A Weird Recurrence Relation

The function $f$ is defined for all positive integers as follows:
<ul><li>$f(1)=1$
</li><li>$f(3)=3$
</li><li>$f(2n)=f(n)$
</li><li>$f(4n + 1)=2f(2n + 1) - f(n)$
</li><li>$f(4n + 3)=3f(2n + 1) - 2f(n)$
</li>
</ul>The function $S(n)$ is defined as $\sum_{i=1}^{n}f(i)$.
$S(8)=22$ and $S(100)=3604$.
Find $S(3^{37})$. Give the last 9 digits of your answer.

## Solution

Let $S_{\text{odd}}(n)$ be the sum over the $f(i)$ with odd argument. Then

$$
\begin{align*}
S(n)
&= \sum_{i=1}^n f(i) \\
&= \sum_{\substack{1 \leq i \leq n \\ \\ 2 \mid i}} f(i) + \sum_{\substack{1 \leq i \leq n \\ \\ 2 \nmid i}} f(i) \\
&= \sum_{1 \leq i \leq n / 2} f(2i) + \sum_{\substack{1 \leq i \leq n \\ \\ 2 \nmid i}} f(i) \\
&= \sum_{1 \leq i \leq n / 2} f(i) + \sum_{\substack{1 \leq i \leq n \\ \\ 2 \nmid i}} f(i) \\
&= S(n/2) + S_{\text{odd}}(n) \\
\end{align*}
$$

On the other hand

$$
\begin{align*}
S_{\text{odd}}(n)
&= \sum_{\substack{1 \leq i \leq n \\ \\ 2 \nmid i}} f(i) \\
&= \sum_{i} [ f(4i + 1) + f(4i + 3) ] + R(n) \\
&= 5 \sum_{i} f(2i + 1) - 3 \sum_{i} f(i) + R(n) \\
&= 5 \cdot S_{\text{odd}}(n / 2) - 3 \cdot S_{\text{odd}}(n / 4) + R(n) \\
\end{align*}
$$

where $R(n)$ is a correction term that adds and subtracts a small number of $f$ terms and a constant value in order to make the calculation exact. This correction term can be easily found, and thus we leave it implied. Finally, the required values of $f(n)$ can be calculated directly, using recursion and memoization.

Notice that the arguments to $S, S_{\text{odd}}$ is always $n$ divided by a power of $2$. Therefore we only need to know the value of these functions at $n = N, N/2, N/4, N/8, \dots$. Using dynamic programming we can efficiently calculate $S(N)$ by building up from the smallest possible value.