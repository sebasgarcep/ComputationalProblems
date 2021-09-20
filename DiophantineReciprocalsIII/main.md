# Diophantine reciprocals III

In the following equation <var>x</var>, <var>y</var>, and <var>n</var> are positive integers.
$$\dfrac{1}{x} + \dfrac{1}{y} = \dfrac{1}{n}$$
For a limit <var>L</var> we define F(<var>L</var>) as the number of solutions which satisfy <var>x</var> &lt; <var>y</var> ≤ <var>L</var>.

We can verify that F(15) = 4 and F(1000) = 1069.<br />
Find F(10<sup>12</sup>).

## Solution

Suppose $(x, y, n)$ is a solution to the diophantine equation and $g = \text{gcd}(x, y), x = g x', y = g y'$. Then

$$
n = \frac{xy}{x + y} = \frac{g^2 x' y'}{g (x' + y')}
$$

But $g (x' + y') \mid g^2 x' y' \Rightarrow x' + y' \mid g x' y'$. Suppose $p$ is a prime such that $p \mid x' + y'$. But $\text{gcd}(x', y') = 1$, therefore $p \nmid x', y' \Rightarrow p \mid g$. Thus $x' + y' \mid g$. Thus all solutions are of the form

$$
x = k \cdot (x' + y') \cdot x' \\
y = k \cdot (x' + y') \cdot y' \\
$$

where $k$ is a positive integer and $\text{gcd}(x', y') = 1$. Because $x < y \leq L$, the number of solutions is given by the maximum possible value for $k$ for $y$, which is $\lfloor L / ((x' + y') y') \rfloor$. Therefore the function that counts the number of solutions is given by the following formula

$$
F(L) = \sum_{\substack{x' < y' \\ \\ \text{gcd}(x', y') = 1}} \lfloor L / ((x' + y') y') \rfloor
$$

Let

$$
T(L) = \sum_{x' < y'} \lfloor L / ((x' + y') y') \rfloor
$$

Then

$$
\begin{align*}
T(L)
&= \sum_{x' < y'} \lfloor L / ((x' + y') y') \rfloor \\
&= \sum_{k \geq 1} \sum_{\substack{x' < y' \\ \\ \text{gcd}(x', y') = k}} \lfloor L / ((x' + y') y') \rfloor \\
&= \sum_{k \geq 1} \sum_{\substack{kx' < ky' \\ \\ \text{gcd}(kx', ky') = k}} \lfloor L / ((kx' + ky') ky') \rfloor \\
&= \sum_{k \geq 1} \sum_{\substack{x' < y' \\ \\ \text{gcd}(x', y') = 1}} \lfloor (L / k^2) / ((x' + y') y') \rfloor \\
&= \sum_{k \geq 1} F(L / k^2) \\
\end{align*}
$$

Therefore

$$
\begin{align*}
F(L)
&= T(L) - \sum_{k \geq 2} F(L / k^2) \\
&= T(L) - \sum_{k = 2}^{\sqrt{L}} F(L / k^2) \\
\end{align*}
$$

So we just need to find an efficient way of computing $T(L)$. Notice that

$$
\begin{align*}
T(L)
&= \sum_{x' < y'} \lfloor L / ((x' + y') y') \rfloor \\
&= \sum_{y' = 2}^{\sqrt{L}} \sum_{x' = 1}^{y' - 1} \lfloor L / ((x' + y') y') \rfloor \\
\end{align*}
$$

Now let's optimize the inner sum of $T(L)$. Notice that we can split the sum along the line $(x' + y') y' \leq \sqrt{L}$

$$
\sum_{\substack{1 \leq x' \leq y' - 1 \\ \\ (x' + y') y' \leq \sqrt{L}}} \lfloor L / ((x' + y') y') \rfloor
+ \sum_{\substack{1 \leq x' \leq y' - 1 \\ \\ (x' + y') y' > \sqrt{L}}} \lfloor L / ((x' + y') y') \rfloor
$$

The first part of the inner sum can be computed directly. The second part can be optimized by setting $u = \lfloor L / ((x' + y') y') \rfloor$ and noticing that $u \leq \sqrt{L}$ and that $u$ can appear repeated more than once in the sum. Specifically if $x'$ satisfies

$$
\begin{align*}
\frac{L}{(u + 1) y'} - y' < &x' \leq \frac{L}{u y'} - y' \\
0 < &x' \leq y' - 1 \\
\end{align*}
$$

then it maps to $u$. Therefore

$$
\sum_{\substack{1 \leq x' \leq y' - 1 \\ \\ (x' + y') y' > \sqrt{L}}} \lfloor L / ((x' + y') y') \rfloor
= \sum_{u} u \cdot C(u)
$$

where $u \not= \lfloor L / u \rfloor, u \leq L / y'^2$ and $C(u)$ counts the $x'$ that map to $u$.