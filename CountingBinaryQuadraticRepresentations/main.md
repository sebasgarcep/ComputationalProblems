# Counting Binary Quadratic Representations

Let $g(n)$ denote the number of ways a positive integer $n$ can be represented in the form: $$x^2+xy+41y^2$$ where $x$ and $y$ are integers. For example, $g(53)=4$ due to $(x,y) \in \{(-4,1),(-3,-1),(3,1),(4,-1)\}$.

Define $\displaystyle T(N)=\sum_{n=1}^{N}g(n)$. You are given $T(10^3)=474$ and $T(10^6)=492128$.

Find $T(10^{16})$.

## Solution

Note that

$$
\begin{align*}
T(N)
&= \sum_{n=1}^N g(n) \\
&= \sum_{n=1}^N \sum_{n = x^2 + xy + 41y^2} 1 \\
&= \sum_{x^2 + xy + 41y^2 \le N} 1 \\
\end{align*}
$$

Also

$$
\begin{align*}
& x^2 + xy + 41 y^2 \le N \\
\Rightarrow \, & 4x^2 + 4xy + 164 y^2 \le 4N \\
\Rightarrow \, & (2x + y)^2 + 163 y^2 \le 4N \\
\end{align*}
$$

Let $z = 2x + y$. Then $z^2 + 163y^2 \le 4N$ with $x = \frac{z - y}{2}$, which implies that $z$ and $y$ must have the same parity.

## Case 1: $z, y$ are even

Solving the case where both $z, y$ are even involves solving for $(2z)^2 + 163 \cdot (2y)^2 \le 4N \Rightarrow z^2 + 163y^2 \le N$. If $z = 0$ then there are $2 \left\lfloor \sqrt{N/163} \right\rfloor$ possible $y$. If $y = 0$ then there are $2 \left\lfloor \sqrt{N} \right\rfloor$ possible $z$. 

From now on assume $z, y \not= 0$. Notice that the inequality implies $|z| \le \sqrt{N - 163 y^2}$. The number of solutions to this inequality can be calculated with $4 \sum_{y \gt 0} \left\lfloor \sqrt{N - 163y^2} \right\rfloor$.

## Case 2: $z, y$ are odd

Note that this case involves solving the inequality $|z| \le \sqrt{4N - 163 y^2}$ for odd $z, y$. The number of solutions can be calculated with $4 \sum_{y \gt 0, \, y \text{ odd}} f(\left\lfloor \sqrt{4N - 163y^2} \right\rfloor)$, where $f(m)$ gives the amount of positive, odd integers not exceeding $m$.