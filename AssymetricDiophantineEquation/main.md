# Asymmetric Diophantine Equation


Consider the following Diophantine equation:
$$16x^2+y^4=z^2$$
where $x$, $y$ and $z$ are positive integers.


Let $S(N) = \displaystyle{\sum(x+y+z)}$ where the sum is over all solutions $(x,y,z)$ such that $1 \leq x,y,z \leq N$ and $\gcd(x,y,z)=1$. 


For $N=100$, there are only two such solutions: $(3,4,20)$ and $(10,3,41)$. So $S(10^2)=81$.


You are also given that $S(10^4)=112851$ (with 26 solutions), and $S(10^7)\equiv 248876211 \pmod{10^9}$.


Find $S(10^{16})$. Give your answer modulo $10^9$.


## Solution

Notice that $(4x, y^2, z)$ is a primitive pythagorean triple. Then there are $m > n > 0$ with $\text{gcd}(m, n) = 1$ and either $m$ or $n$ is even. Notice that for any solution $(x, y, z)$ we have $y^4 \equiv z^2 \pmod 4$. Therefore there are two cases:

### $y$ is odd

In this case

$$
4x = 2mn \\
y^2 = m^2 - n^2 \\
z = m^2 + n^2 \\
$$

Notice that these equations imply that either $m$ is even or $n$ is even but not both. Also $(n, y, m)$ is a primitive pythagorean triple (otherwise $\text{gcd}(m, n) \not= 1$). Then there are $u > v > 0$ with $\text{gcd}(u, v) = 1$ and either $u$ or $v$ is even. But because $y$ is odd we have the following equations

$$
n = 2uv \\
y = u^2 - v^2 \\
m = u^2 + v^2 \\
$$

But these equations also imply that either $u$ is even or $v$ is even but not both. Moreover $N \geq z \geq m^2 = (u^2 + v^2)^2$ which implies both $u^2 + v^2 \leq \sqrt{N}$ and $u \leq \sqrt[4]{N}$.

### $y$ is even

This implies that $z$ is even, which implies $x$ is odd. Therefore

$$
16 x^2 + (2 \cdot \frac{y}{2})^4 = z^2 \\
16 x^2 + 16 \cdot ( \frac{y}{2})^4 = z^2 \\
x^2 + ( \frac{y}{2})^4 = (\frac{z}{4})^2 \\
$$

which implies $(x, y^2/4, z/4)$ is a primitive pythagorean triple. Because $x$ is odd then there are $m > n > 0$ with $\text{gcd}(m, n) = 1$ and either $m$ or $n$ is even, such that

$$
x = m^2 - n^2 \\
\frac{y^2}{4} = 2mn \\
\frac{z}{4} = m^2 + n^2 \\
$$

Consider $y^2 = 8mn$. Because $\text{gcd}(m, n) = 1$ then either $m = 2u^2, n = v^2$ with $v$ odd or $m = u^2, n = 2v^2$ with $u$ odd and in both cases $\text{gcd}(u, v) = 1$. Therefore at least one of $u$ or $v$ has to be odd. If $u = v$, then $u = v = 1$ and we obtain the solution $(3, 4, 20)$. Now suppose $u > v$ without loss of generality. Moreover $N \geq z \geq 4(m^2 + n^2) \geq 4(u^4 + v^4)$ which implies both $u \leq \sqrt[4]{N}$ and $2u^2 v^2 \leq 2u^4 \leq 3u^4 + 3v^4 \Rightarrow (u^2 + v^2)^2 = u^4 + 2u^2 v^2 + v^4 \leq 4(u^4 + v^4) \leq N \Rightarrow u^2 + v^2 \leq \sqrt{N}$. Also $y^2 = 8mn = 16 u^2 v^2 \Rightarrow y = 4uv$. Because we assumed $u > v$ we are left with $3$ cases

- If $u$ is odd and $u^2 > 2v^2$ then $m = u^2, n = 2v^2$
- If $u$ is odd and $2u^2 > v^2$ then $m = 2u^2, n = v^2$
- If $v$ is odd then $m = 2u^2, n = v^2$ (as we always have $2u^2 > u^2 > v^2$)