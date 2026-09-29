# Modified Euclidean Algorithm

In a modified Euclidean algorithm for two numbers $a, b$, at each step we perform <strong>Euclidean division</strong> of the larger number by the smaller number and then replace the larger number with the integer <b>quotient</b> (rather than the <b>remainder</b>, as in the normal Euclidean algorithm).<br>
This operation is repeatedly performed until one of the two numbers becomes $1$; when this happens, the value of the other number is denoted $f(a, b)$.

For example, $f(123, 456) = 3$ as shown below:
$$(123, 456) \to (123, 3) \to (41, 3) \to (13, 3) \to (4, 3) \to (1, 3) \mapsto 3.$$


Let $E(N)$ be the sum $\sum\limits_{1 \le a, b \lt N} f(a, b)$.<br>
You are given $E(10) = 343$ and $E(100) = 269288$.

Find $E(3\,000\,000)$.

## Solution

Define $P(N) := E(N + 1)$ and $L(N, a) := \min(N, a^2 + a - 1)$ (where $L(N, a)$ is motivated by the fact that $\lfloor (a^2 + a - 1) / a \rfloor = a$ and $\lfloor (a^2 + a) / a \rfloor = a + 1$). Then

Thus

$$
\begin{align*}
P(N)

&= \sum\limits_{1 \le a, b \le N} f(a, b) \\

&= \sum_{a=1}^N \sum_{b=1}^N f(a, b) \\

&= 2 \sum_{a=1}^N \sum_{b=a}^N f(a, b) - \sum_{a=1}^N f(a, a) \\

&= 2 \sum_{a=1}^N \sum_{b=a}^N f(a, \lfloor b/a \rfloor) - \sum_{a=1}^N a \\

&= 2 \sum_{a=1}^N \sum_{u=1}^{\lfloor N/a \rfloor} f(a, u) \sum_{\substack{a \le b \le N \\ \lfloor b/a \rfloor = u}} 1 - \frac{N(N+1)}{a} \\

\end{align*}
$$

So we've reduced it to $O(N^{3/2})$ computations of $f$. Finally, if $u < \lfloor N/a \rfloor$

$$
\sum_{\substack{a \le b \le N \\ \lfloor b/a \rfloor = u}} 1 = a
$$

otherwise if $u = \lfloor N/a \rfloor$

$$
\sum_{\substack{a \le b \le N \\ \lfloor b/a \rfloor = u}} 1 = (N \bmod a) + 1
$$
