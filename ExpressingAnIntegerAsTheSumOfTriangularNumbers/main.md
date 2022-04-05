# Expressing an integer as the sum of triangular numbers

Gauss famously proved that every positive integer can be expressed as the sum of three <b>triangular numbers</b> (including 0 as the lowest triangular number).  In fact most numbers can be expressed as a sum of three triangular numbers in several ways.

Let $G(n)$ be the number of ways of expressing $n$ as the sum of three triangular numbers, regarding different arrangements of the terms of the sum as distinct.

For example, $G(9) = 7$, as 9 can be expressed as:  3+3+3, 0+3+6, 0+6+3, 3+0+6, 3+6+0, 6+0+3, 6+3+0.<br />  
You are given $G(1000) = 78$ and $G(10^6) = 2106$.

Find $G(17 526 \times 10^9)$.

## Solution

Let $f(x) = \sum_{n \ge 0} x^{n(n+1)/2}$. Then $\sum_{n \ge 0} G(n) x^n = f(x)^3$. Now define functions $F_1, F_2: \mathbb{N}_0 \rightarrow \mathbb{Z}$ such that $f(x) = \sum_{n \ge 0} F_1(n) x^n, f(x)^2 = \sum_{n \ge 0} F_2(n) x^n$. Then

$$
G(n) = \sum_{k = 0}^n F_1(k) F_2(n - k)
$$

But $F_1(k)$ is only $1$ if $k$ is a triangular number, otherwise it is $0$. Therefore

$$
G(n) = \sum_{0 \le k(k+1)/2 \le n} F_2(n - k(k+1)/2)
$$

So the problem reduces to efficiently computing coefficients of $f^2$. Let's find $F_2(n)$. Let $T_k = k(k+1)/2$. Suppose $T_u + T_v = n$. Then

$$
u^2 + u + v^2 + v = 2n \\
\Rightarrow 4u^2 + 4u + 1 + 4v^2 + 4v + 1 = 8n + 2 \\
\Rightarrow (2u+1)^2 + (2v+1)^2 = 8n + 2 \\
$$

Notice that $8n+2 \equiv 2 \pmod 4$ therefore $x^2 + y^2 = 8n+2 \iff x \equiv y \equiv 1 \pmod 2$. Thus all solutions of the general case ($x^2 + y^2 = 8n+2$) are solutions of the equation above. Thus the number of solutions to $T_u + T_v = n$ is the number of ways to express $8n + 2$ as a sum of squares ignoring signs. In other words $F_2(n) = r_2(8n+2)/4$.