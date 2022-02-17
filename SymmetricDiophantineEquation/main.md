# Symmetric Diophantine Equation

Consider the following Diophantine equation:

$$15  (x^2 + y^2 + z^2) = 34  (xy + yz + zx)$$

where $x$, $y$ and $z$ are positive integers.

Let $S(N)$ be the sum of all solutions, $(x,y,z)$, of this equation such that, $1 \le x \le y \le z \le N$ and $\gcd(x, y, z) = 1$.

For $N = 10^2$, there are three such solutions - $(1, 7, 16), (8, 9, 39), (11, 21, 72)$. So $S(10^2) = 184$.

Find $S(10^9)$.

## Solution

Rewriting the equation as a quadratic polynomial in terms of $z$ we get

$$
15 z^2 - 34 (x + y) z + (15 x^2 + 15 y^2 - 34 xy) = 0
$$

Therefore the roots will be of the form

$$
\begin{align*}
z
&= \frac{34 (x + y) \pm \sqrt{34^2 (x + y)^2 - 4 \cdot 15 \cdot (15 x^2 + 15 y^2 - 34 xy)}}{2 \cdot 15} \\
&= \frac{17 (x + y) \pm \sqrt{17^2 (x + y)^2 - 15 \cdot (15 x^2 + 15 y^2 - 34 xy)}}{15} \\
&= \frac{17 (x + y) \pm \sqrt{64 (x^2 + y^2) + 1088 xy}}{15} \\
&= \frac{17 (x + y) \pm 8 \sqrt{x^2 + y^2 + 17 xy}}{15} \\
\end{align*}
$$

Thus there are only integer solutions for $z$ when there is an integer $n$ such that $x^2 + 17xy + y^2 = n^2$. Dividing both sides by $n^2$ and setting $\alpha = x / n, \beta = y / n$ we get $\alpha^2 + 17 \alpha \beta + \beta^2 = 1$. Thus, if we can find the set of all positive rational roots $R$ to the previous equation, we can obtain the integer solutions to the original diophantine equation.

By simple substitution one can confirm that $(\alpha_0, \beta_0) = (1, 0)$ is a solution to the previous equation. The slope between $(\alpha_0, \beta_0)$ and any rational solution $(\alpha_s, \beta_s)$ distinct to the previous one and not in the same vertical line as it will be rational. Thus, if we pick the right rational number we can go from one to the other by constructing a line at $(\alpha_0, \beta_0)$ with appropiate slope.

Moreover, because the line between $(\alpha_0, \beta_0)$ and $(\alpha_s, \beta_s)$ can have at most two intersections with the hyperbola $\alpha^2 + 17 \alpha \beta + \beta^2 = 1$, there is a bijection between $R \setminus \{ (\alpha_0, \beta) : \beta \in \mathbb{R} \}$ and the set of rational numbers that produce a secant line. Finding the set of rational numbers that produce a tangent line involves substituting $\beta = m (\alpha - \alpha_0) + \beta_0$ into the hyperbolic equation and finding the rational set of values of $m$ which produce a quadratic with null discriminant. In our case we get that $m = -\frac{2}{17}$.

Pick a rational number $v / u$ with $\gcd(u, v) = 1, u \not= 0$. Then there is a rational $t$ such that

$$
\alpha_s = \alpha_0 + tu \\
\beta_s = \beta_0 + tv \\
$$

To find the value of $t$ we can substitute the previous equations into $\alpha^2 + 17 \alpha \beta + \beta^2 = 1$ and solve for $t$. We obtain

$$
t = -\frac{2u + 17v}{u^2 + 17 u v + v^2}
$$

Plugging it back into the equations for $\alpha_s, \beta_s$ we get

$$
\alpha_s = 1 - u \frac{2u + 17v}{u^2 + 17 u v + v^2} = \frac{v^2 - u^2}{u^2 + 17 u v + v^2} \\
\beta_s = 0 - v \frac{2u + 17v}{u^2 + 17 u v + v^2} = - \frac{2uv + 17v^2}{u^2 + 17 u v + v^2} \\
$$

But instead of using the rational solution $(\alpha_s, \beta_s)$ we will use $(-\alpha_s, -\beta_s)$, which gives us the nice equations

$$
x = u^2 - v^2 \\
y = 2uv + 17v^2 \\
n = u^2 + 17 u v + v^2 \\
$$

And because $x, y, z > 0$ we must have $u > v$. Given these equations we also get

$$
\begin{align*}
z &= \frac{17(x + y) \pm 8n}{15} \\
&= \frac{17(u^2 - v^2 + 2uv + 17v^2) \pm 8(u^2 + 17 u v + v^2)}{15} \\
\end{align*} \\
z = \frac{25 u^2 + 170 u v + 280 v^2}{15} \lor z = \frac{9 u^2 - 102 u v + 264 v^2}{15} \\
z = \frac{5 u^2 + 34 u v + 56 v^2}{3} \lor z = \frac{3 u^2 - 34 u v + 88 v^2}{5} \\
$$

It is not hard to prove that the system

$$
\frac{3u^2-34uv+88v^2}{5} \geq 2uv+17v^2 \geq u^2-v^2 > 0 \\
u, v > 0 \\
$$

has no solutions. Therefore

$$
z = \frac{5 u^2 + 34 u v + 56 v^2}{3}
$$

Because $z$ is an integer then

$$
5 u^2 + 34 u v + 56 v^2 \equiv 0 \pmod 3 \\
\Rightarrow 2u^2 + uv + 2v^2 \equiv 0 \pmod 3 \\
\Rightarrow 2 \cdot (2u^2 + uv + 2v^2) \equiv 0 \pmod 3 \\
\Rightarrow u^2 + 2uv + v^2 \equiv 0 \pmod 3 \\
\Rightarrow (u + v)^2 \equiv 0 \pmod 3 \\
\Rightarrow u + v \equiv 0 \pmod 3
$$

This also implies $u^2 - v^2 \equiv 2uv + 17v^2 \equiv 0 \pmod 3, 5 u^2 + 34 u v + 56 v^2 \equiv 0 \pmod 9$. Therefore we can rewrite our solution as

$$
(x, y, z) = (\frac{u^2 - v^2}{3g}, \frac{2uv + 17v^2}{3g}, \frac{5 u^2 + 34 u v + 56 v^2}{9g})
$$

where $g$ is a scaling factor. Let's study $g$. Suppose a prime $p \not= 2, 3, 19$ that divides $g$. Then

$$
u^2 \equiv v^2 \pmod p
$$

And

$$
2uv + 17v^2 \equiv 0 \pmod p \\
\Rightarrow uv \equiv -2^{-1} \cdot 17 v^2 \pmod p \\
$$

Thus

$$
5 u^2 - 34 \cdot 2^{-1} \cdot 17 v^2 + 56 v^2 \equiv 0 \pmod p \\
\Rightarrow 10 v^2 - 34 \cdot 17 v^2 + 112 v^2 \equiv 0 \pmod p \\
\Rightarrow -456 v^2 \equiv 0 \pmod p \\
\Rightarrow v \equiv 0 \pmod p \\
\Rightarrow u \equiv 0 \pmod p \\
$$

which contradicts the fact that $\gcd(u, v) = 1$. Thus, $p \not\mid g$. Now let's figure the largest power of each of $2, 3, 19$ that can divide $g$.

### p = 2

If $p \mid g$ then $u \equiv v \equiv 0, 1 \pmod p$. If $u \equiv v \equiv 0 \pmod p$, then $\gcd(u, v) \not= 1$, a contradiction. If $u \equiv v \equiv 1 \pmod p$ then $2uv + 17v^2 \not\equiv 0 \pmod p$, which contradicts $p \mid g$. Thus $p \not\mid g$.

### p = 3

We already know $p \mid g$ if $u + v \pmod 3$. Now let's prove $p^2 \not\mid g$. Clearly, $u^2 \equiv v^2 \pmod {p^2}$. Moreover $2uv + 17v^2 \equiv 0 \pmod {p^2} \Rightarrow 2uv + 8v^2 \equiv 0 \pmod {p^2} \Rightarrow uv + 4v^2 \equiv 0 \pmod {p^2} \Rightarrow uv \equiv -4v^2 \pmod {p^2}$. This implies

$$
5 u^2 + 34 u v + 56 v^2 \equiv 5 v^2 + 34 (-4v^2) + 56 v^2 \equiv 6v^2 \equiv 0 \pmod {p^2} \\
\Rightarrow 3v^2 \equiv 0 \pmod {p^2} \\
\Rightarrow v^2 \equiv 0 \pmod {p} \\
\Rightarrow u \equiv v \equiv 0 \pmod {p} \\
$$

a contradiction. Therefore $p^2 \not\mid g$.

### p = 19

Let $p \mid g$. If $u \equiv v \equiv 0 \pmod p$, then $\gcd(u, v) \not= 1$, a contradiction. Assume that $u, v \not\equiv 0 \pmod p$. Then $2uv + 17v^2 \equiv v(2u + 17v) \equiv v(2u - 2v) \equiv 2v(u - v) \equiv 0 \pmod p \Rightarrow u \equiv v \pmod p$. Now let's show that $p^2 \not\mid g$. Assume that it does. Then $2uv + 17v^2 \equiv 2v^2 + 17v^2 \equiv 19v^2 \equiv 0 \pmod {p^2} \Rightarrow v^2 \equiv 0 \pmod p \Rightarrow u \equiv v \equiv 0 \pmod p$, a contradiction. Therefore $p^2 \not\mid g$.

Finally, because we are already taking into account the factor of 3, then 3 cannot divide $g$. Therefore $g = 1, 19$. Particularly $g = 19$ if $u \equiv v \pmod {19}$, otherwise $g = 1$.

On a final note, our solution set is not exhaustive if $\gcd(u, v) = 1$, due to the denominator in $z$. This produces cases where the common factor of $3$ between $x, y$ is divided on $z$, producing a solution that satisfies $\gcd(x, y, z) = 1$. Therefore we need to include the case $\gcd(u, v) = 3$ as well, but check that the given solution satisfies $\gcd(x, y, z) = 1$.