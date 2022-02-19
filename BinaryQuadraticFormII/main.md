# Binary Quadratic Form II

Consider the following binary quadratic form:
$$
f(x,y)=x^2+5xy+3y^2
$$
A positive integer $q$ has a primitive representation if there exist positive integers $x$ and $y$ such that $q = f(x,y)$ and <span style="white-space:nowrap;">$\gcd(x,y)=1$.</span>

We are interested in primitive representations of perfect squares. For example:<br />
$17^2=f(1,9)$<br />
$87^2=f(13,40) = f(46,19)$

Define $C(N)$ as the total number of primitive representations of $z^2$ for $0 \lt z \leq N$.<br /> 
Multiple representations are counted separately, so for example $z=87$ is counted twice.

You are given $C(10^3)=142$ and $C(10^{6})=142463$ 

Find $C(10^{14})$.

## Solution

We are interested in solutions $(x, y, z)$ such that $z^2 = x^2 + 5xy + 3y^2$, $\gcd(x, y) = 1$ and $0 < z \leq N$. From "Symmetric Diophantine Equations" we have a method to find solutions to this equation. Divide the equation by $z^2$ and set $\alpha = x / z, \beta = y / z$. Then $1 = \alpha^2 + 5 \alpha \beta + 3 \beta^2$, where $\alpha, \beta \in \mathbb{Q}$. It is clear that $(\alpha_0, \beta_0) = (1, 0)$ is a rational solution to this equation. Therefore all other rational solutions will be of the form $\alpha_s = \alpha_0 + tu, \beta_s = \beta_0 + tv$ where $\gcd(u, v) = 1$ and $t \not= 0$. Substituting $\alpha_s, \beta_s$ into $1 = \alpha^2 + 5 \alpha \beta + 3 \beta^2$ we get

$$
t = -\frac{2u + 5v}{u^2 + 5uv + 3v^2}
$$

and therefore

$$
\alpha_s = \frac{3v^2 - u^2}{u^2 + 5uv + 3v^2} \\
\beta_s = -\frac{2uv + 5v^2}{u^2 + 5uv + 3v^2} \\
$$

Notice that if $(\alpha_s, \beta_s)$ is a solution, so it $(-\alpha_s, -\beta_s)$. Therefore let's consider the equations for the latter to remove the negative sign from the latter fraction.

$$
-\alpha_s = \frac{u^2 - 3v^2}{u^2 + 5uv + 3v^2} \\
-\beta_s = \frac{2uv + 5v^2}{u^2 + 5uv + 3v^2} \\
$$

Because the previous method generates all rational solutions for the equation $1 = \alpha^2 + 5 \alpha \beta + 3 \beta^2$ setting $x = u^2 - 3v^2, y = 2uv + 5v^2, z = u^2 + 5uv + 3v^2$ gives us all primitive solutions up to a scaling factor $\gcd(x, y, z)$. Let's study $\gcd(x, y, z)$.

Suppose $p$ is a prime distinct from 2, 13. Assume that $p$ divides $\gcd(x, y, z)$. Then $u^2 \equiv 3v^2 \pmod p, uv \equiv -2^{-1} \cdot 5v^2 \pmod p$. Therefore

$$
3v^2 + 5 (-2^{-1} \cdot 5v^2) + 3v^2 \equiv 0 \pmod p \\
\Rightarrow 6v^2 - 25v^2 + 6v^2 \equiv 0 \pmod p \\
\Rightarrow -13v^2 \equiv 0 \pmod p \\
\Rightarrow v^2 \equiv 0 \pmod p \\
\Rightarrow v \equiv 0 \pmod p \\
\Rightarrow u^2 \equiv 0 \pmod p \\
\Rightarrow u \equiv 0 \pmod p \\
$$

which contradicts the fact that $\gcd(u, v) = 1$. Therefore $p \not\mid \gcd(x, y, z)$.

Now suppose $2 \mid \gcd(x, y, z)$. Then $u^2 \equiv 3v^2 \equiv v^2 \pmod 2 \Rightarrow u \equiv v \pmod 2$. Because both can't be $0$ (otherwise $\gcd(u, v) \not= 1$) suppose both are $1$. But this implies that $2uv + 5v^2 \equiv 2 \cdot 1 \cdot 1 + 5 \cdot 1^2 \equiv 1 \equiv 0 \pmod 2$, a contradiction. Therefore $2 \not\mid \gcd(x, y, z)$.

Now let's prove that $13^2 \not\mid \gcd(x, y, z)$. Assume that it does. By a similar logic as before we can show that $-13v^2 \equiv 0 \pmod {13^2}$. Thus $v^2 \equiv 0 \pmod {13} \Rightarrow v \equiv 0 \pmod {13}$. But $u^2 \equiv 3v^2 \pmod {13^2}$ implies $u^2 \equiv 3v^2 \pmod {13}$, and the previous fact leads to $v^2 \equiv 0 \pmod {13} \Rightarrow u \equiv 0 \pmod {13}$, a contradiction.

If $(u, v) = (4, 1)$, then $\gcd(x, y, z) = 13$. So there are solutions that produce the case $13 \mid \gcd(x, y, z)$. Let's study when. Suppose $\gcd(x, y, z) = 13$. Then

$$
u^2 - 3v^2 \equiv u^2 - 16v^2 \equiv (u - 4v)(u + 4v) \equiv 0 \pmod {13}
$$

Then either $u \equiv 4v \pmod {13}$ or $u \equiv -4v \pmod {13}$. Suppose the latter case is true. Then $2(-4v) + 5v^2 \equiv 0 \pmod {13} \Rightarrow -3v^2 \equiv 0 \pmod {13} \Rightarrow v \equiv 0 \pmod {13} \Rightarrow u \equiv 0 \pmod {13}$, a contradiction. Therefore $\gcd(x, y, z) = 13 \Rightarrow u \equiv 4v \pmod {13}$. Using substitution one can easily prove the other direction. Thus $\gcd(x, y, z) = 13 \iff u \equiv 4v \pmod {13}$.

Now let's study the bounds for $u, v$ given that $x, y, z > 0$. Note that we will only consider the case $\gcd(x, y, z) = 1$ in these calculations. To take into account the case $\gcd(x, y, z) = 13$, we just need to multiply $N$ by 13. Firstly, with some effort one can prove that $x, y, z > 0, u < 0, v > 0$ and $x, y, z > 0, u > 0, v < 0$ have no solutions. Moreover solutions $(u, v)$ in the space $x, y, z > 0, u < 0, v < 0$ are going to be equivalent to a solution of the form $(-u, -v)$. Thus we only need to consider $u, v > 0$. Secondly, because $x > 0 \Rightarrow u^2 > 3v^2$. Finally because $z \leq N$ then $u^2 + 5uv + 3v^2 \leq N$.

Let

$$
T(N) = \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N}} 1 \\
S(N) = \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N \\ \gcd(u, v) = 1}} 1 \\
T_1(N) = \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N \\ u \equiv 4v \pmod {13}}} 1 \\
S_1(N) = \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N \\ u \equiv 4v \pmod {13} \\ \gcd(u, v) = 1}} 1 \\
T_2(N) = \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N \\ u \not\equiv 4v \pmod {13}}} 1 \\
S_2(N) = \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N \\ u \not\equiv 4v \pmod {13} \\ \gcd(u, v) = 1}} 1 \\
$$

Then the number of solutions is given by $S_2(N) + S_1(13N)$. So let's compute efficient representations for each.

Firstly, it is clear that $T(N) = T_1(N) + T_2(N), S(N) = S_1(N) + S_2(N)$. Thus we only need to find efficient representations for $S(N), T(N), S_1(N), T_2(N)$. The following calculations

$$
\begin{align*}
T(N)
&= \sum_{k \geq 1} \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N \\ \gcd(u, v) = k}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{ku, kv > 0 \\ (ku)^2 \geq 3(kv)^2 \\ (ku)^2 + 5(ku)(kv) + 3(kv)^2 \leq N \\ \gcd(ku, kv) = k}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N/k^2 \\ \gcd(u, v) = 1}} 1 \\
&= \sum_{k \geq 1} S(N / k^2) \\
&= S(N) + \sum_{k > 1} S(N / k^2) \\
\end{align*}
$$

$$
\begin{align*}
T_1(N)
&= \sum_{k \geq 1} \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N \\ u \equiv 4v \pmod {13} \\ \gcd(u, v) = k}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{ku, kv > 0 \\ (ku)^2 \geq 3(kv)^2 \\ (ku)^2 + 5(ku)(kv) + 3(kv)^2 \leq N \\ ku \equiv k4v \pmod {13} \\ \gcd(ku, kv) = k}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N/k^2 \\ ku \equiv k4v \pmod {13} \\ \gcd(u, v) = 1}} 1 \\
&= \sum_{\substack{k \geq 1 \\ \gcd(k, 13) = 1}} \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N/k^2 \\ u \equiv 4v \pmod {13} \\ \gcd(u, v) = 1}} 1
+ \sum_{\substack{k \geq 1 \\ \gcd(k, 13) \not= 1}} \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N/k^2 \\ \gcd(u, v) = 1}} 1 \\
&= \sum_{\substack{k \geq 1 \\ \gcd(k, 13) = 1}} S_1(N / k^2)
+ \sum_{\substack{k \geq 1 \\ \gcd(k, 13) \not= 1}} S(N / k^2) \\
&= S_1(N) + \sum_{\substack{k > 1 \\ \gcd(k, 13) = 1}} S_1(N / k^2)
+ \sum_{\substack{k \geq 1 \\ \gcd(k, 13) \not= 1}} S(N / k^2) \\
\end{align*}
$$

give us efficient representations for $S(N), S_1(N)$ if we can find efficient representations for $T(N), T_1(N)$ and if we memoize $S$ and $S_1$. Let's compute an efficient representation for $T(N)$

$$
\begin{align*}
T(N)
&= \sum_{\substack{u, v > 0 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N}} 1 \\
&= \sum_{\substack{u \geq 1 \\ 9 u^2 \leq N}} \sum_{\substack{v \geq 1 \\ u^2 \geq 3v^2 \\ u^2 + 5uv + 3v^2 \leq N}} 1 \\
&= \sum_{\substack{u \geq 1 \\ 9 u^2 \leq N}} \sum_{\substack{v \geq 1 \\ v \leq u / \sqrt{3} \\ v \leq \frac{1}{6}(-5u + \sqrt{13u^2 + 12N})}} 1 \\
&= \sum_{\substack{u \geq 1 \\ 9 u^2 \leq N}} \min(\lfloor u / \sqrt{3} \rfloor, \lfloor \frac{1}{6}(-5u + \sqrt{13u^2 + 12N}) \rfloor) \\
\end{align*}
$$

which can be computed in $O(\sqrt{N})$ time. $T_1(N)$ can be computed in the same time using a similar logic, but once we have the minimum we divide the result by 13 and use the floor of the result. We will have to sometimes add 1, to account for the offset between 0 and the smallest value of $v$ that satisfies $u \equiv 4v \pmod {13}$.