# Perfect right-angled triangles

Consider the right angled triangle with sides a=7, b=24 and c=25.
The area of this triangle is 84, which is divisible by the perfect numbers 6 and 28.<br />
Moreover it is a primitive right angled triangle as gcd(a,b)=1 and gcd(b,c)=1.<br />
Also c is a perfect square.

We will call a right angled triangle perfect if<br />
-it is a primitive right angled triangle<br />
-its hypotenuse is a perfect square

We will call a right angled triangle super-perfect if<br />
-it is a perfect right angled triangle and<br />
-its area is a multiple of the perfect numbers 6 and 28.

How many perfect right-angled triangles with c≤10<sup>16</sup> exist that are not super-perfect?

## Solution

The area of the triangles will be $\frac{ab}{2}$. This cannot be a multiple of $\text{lcm}(6, 28) = 84$. Therefore $ab \not\equiv 0 \pmod{168}$. Moreover $(a, b, c)$ is a primitive pythagorean triple, which has the following parametrization:

$$
a = m^2 - n^2 \\
b = 2mn \\
c = m^2 + n^2 \\
$$

Let $c = d^2$. Then $(m, n, d)$ is also a pythagorean triple. Thus it has parametrization

$$
m = u^2 - v^2 \\
n = 2uv \\
d = u^2 + v^2 \\
$$

assuming $u^2 - v^2 \ge 2uv$. It is well known that $\gcd(a, b, c) = 1 \iff \gcd(m, n) = 1 \text{ and } m \not\equiv n \pmod 2$. On the other hand $\gcd(m, n, d) = 1 \iff \gcd(u, v) = 1 \text{ and } u \not\equiv v \pmod 2$. Notice that $\gcd(m, n, d) = 1 \iff \gcd(m, n) = 1$. Moreover, $m \equiv n \pmod 2 \iff u^2 - v^2 \equiv 0 \pmod 2 \iff u \equiv v \pmod 2$. Therefore $ \iff \gcd(u, v) = 1 \text{ and } u \not\equiv v \pmod 2$.

$$
\begin{align*}
\gcd(a, b, c) = 1
&\iff \gcd(m, n) = 1 \text{ and } m \not\equiv n \pmod 2 \\
&\iff \gcd(m, n, d) = 1 \text{ and } m \not\equiv n \pmod 2 \\
&\iff \gcd(u, v) = 1 \text{ and } u \not\equiv v \pmod 2 \\
\end{align*}
$$

Now let's study $ab$. Notice that

$$
\begin{align*}
ab
&= (m^2 - n^2) \cdot 2mn \\
&= \pm ((u^2 - v^2)^2 - (2uv)^2) \cdot 2 \cdot (u^2 - v^2) \cdot (2uv) \\
&= \pm 4 uv (u^2 - v^2) (u^2 - v^2 - 2uv) (u^2 - v^2 + 2uv) \\
\end{align*}
$$

Because either $u$ or $v$ is even then $ab$ is a multiple of $8$. If $u$ or $v$ is a multiple of $3$ then $ab$ is also. If not then $u^2 \equiv v^2 \equiv 1 \pmod 3$. Thus $u^2 - v^2 \equiv (u-v)(u+v) \equiv 0 \pmod 3$ and $ab$ is also a multiple of $3$. One can also check that $uv (u^2 - v^2) (u^2 - v^2 - 2uv) (u^2 - v^2 + 2uv)$ is always a multiple of $7$ therefore $ab$ is always a multiple of $7$.

Because $ab$ is a multiple of $8, 3, 7$ then $ab$ is a multiple of $168$. Thus there are no perfect right-angled triangles that are not super-perfect.