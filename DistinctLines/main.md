## Distinct Lines

<p>
Consider all lattice points (a,b,c) with 0 ≤ a,b,c ≤ N.
</p>
<p>
From the origin O(0,0,0) all lines are drawn to the other lattice points.<br />
Let D(N) be the number of <i>distinct</i> such lines.
</p>
<p>
You are given that D(1 000 000) = 831909254469114121.
</p><p>
Find D(10<sup>10</sup>). Give as your answer the first nine digits followed by the last nine digits.
</p>

## Solution

Notice that two points $(a_1, b_1, c_1), (a_2, b_2, c_2)$, such that all elements in the tuple are not zero, are part of the same line if and only if $(a_1, b_1, c_1) / \text{gcd}(a_1, b_1, c_1) = (a_2, b_2, c_2) / \text{gcd}(a_2, b_2, c_2)$. Therefore, each of these line can be represented by the tuple $(a, b, c)$ where $\text{gcd}(a, b, c) = 1$. Now suppose that exactly one element is null. Then the same logic as before can be applied to the other two elements $(a, b)$. But there are $3$ distinct ways to choose the null element. Therefore $(a, b)$ generates $3$ distinct lines. Finally, if exactly two elements are null, then the line is one of the $3$ axes. Therefore

$$
D(N) = \sum_{\substack{1 \leq a, b, c \leq N \\ \\ \text{gcd}(a, b, c) = 1}} 1 + 3 \sum_{\substack{1 \leq a, b \leq N \\ \\ \text{gcd}(a, b) = 1}} 1 + 3
$$

Let

$$
R(N) = \sum_{\substack{1 \leq a, b, c \leq N \\ \\ \text{gcd}(a, b, c) = 1}} 1 \\
S(N) = \sum_{\substack{1 \leq a, b \leq N \\ \\ \text{gcd}(a, b) = 1}} 1 \\
$$

Then

$$
D(N) = R(N) + 3 S(N) + 3
$$

### Calculating $S(N)$

Notice that

$$
\begin{align*}
N^3
&= \sum_{1 \leq a, b \leq N} 1 \\
&= \sum_{k = 1}^N \sum_{\substack{1 \leq a, b \leq N \\ \\ \text{gcd}(a, b) = k}} 1 \\
&= \sum_{k = 1}^N \sum_{\substack{1 \leq ak, bk \leq N \\ \\ \text{gcd}(ak, bk) = k}} 1 \\
&= \sum_{k = 1}^N \sum_{\substack{1 \leq a, b \leq N / k \\ \\ \text{gcd}(a, b) = 1}} 1 \\
&= \sum_{k = 1}^N S(N /k) \\
\end{align*}
$$

Therefore 

$$
S(N) = N^2 - \sum_{k = 2}^N S(N /k)
$$

This sum can be further optimized using the trick from Hexagonal Orchards

$$
S(N) = N^2 - \sum_{k = 2}^{\sqrt{N}} S(N /k) - \sum_{u} S(u) \cdot ( \lfloor N/u \rfloor - \lfloor N / (u + 1) \rfloor )
$$

where $u$ runs from $1$ to $\sqrt{N}$ as long as $u \not= \lfloor N / u \rfloor$.

### Calculating $R(N)$

Notice that

$$
\begin{align*}
N^3
&= \sum_{1 \leq a, b, c \leq N} 1 \\
&= \sum_{k = 1}^N \sum_{\substack{1 \leq a, b, c \leq N \\ \\ \text{gcd}(a, b, c) = k}} 1 \\
&= \sum_{k = 1}^N \sum_{\substack{1 \leq ak, bk, ck \leq N \\ \\ \text{gcd}(ak, bk, ck) = k}} 1 \\
&= \sum_{k = 1}^N \sum_{\substack{1 \leq a, b, c \leq N / k \\ \\ \text{gcd}(a, b, c) = 1}} 1 \\
&= \sum_{k = 1}^N R(N /k) \\
\end{align*}
$$

Therefore 

$$
R(N) = N^3 - \sum_{k = 2}^N R(N /k)
$$

This sum can be further optimized using the trick from Hexagonal Orchards

$$
R(N) = N^3 - \sum_{k = 2}^{\sqrt{N}} R(N /k) - \sum_{u} R(u) \cdot ( \lfloor N/u \rfloor - \lfloor N / (u + 1) \rfloor )
$$

where $u$ runs from $1$ to $\sqrt{N}$ as long as $u \not= \lfloor N / u \rfloor$.