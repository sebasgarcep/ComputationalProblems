# Investigating progressive numbers, n, which are also square

A positive integer, <i>n</i>, is divided by <i>d</i> and the quotient and remainder are <i>q</i> and <i>r</i> respectively. In addition <i>d</i>, <i>q</i>, and <i>r</i> are consecutive positive integer terms in a geometric sequence, but not necessarily in that order.
For example, 58 divided by 6 has quotient 9 and remainder 4. It can also be seen that 4, 6, 9 are consecutive terms in a geometric sequence (common ratio 3/2).<br />
We will call such numbers, <i>n</i>, progressive.
Some progressive numbers, such as 9 and 10404 = 102<sup>2</sup>, happen to also be perfect squares.<br /> The sum of all progressive perfect squares below one hundred thousand is 124657.
Find the sum of all progressive perfect squares below one trillion (10<sup>12</sup>).

## Solution

Suppose $(r, d, q)$ forms an ascending geometric sequence (not necessarily in that order). Then $r, d, q \not= 0$. Notice that $r < d$ by definition. Suppose $t \geq 1$ is the ratio of the geometric sequence. Then if $t = 1$ then $r = d$, which is not possible. Therefore we must have $t > 1$.

Now let's prove that $r < q$. Suppose $q < r \Rightarrow q < r < d$. Therefore $r = qt, d = qt^2 \Rightarrow n = q \times qt^2 + qt = qt(qt + 1) = r(r + 1)$. But $\text{gcd}(r, r + 1) = 1$ and $n$ is a square number. Therefore $r$ and $r+1$ are both square numbers, which is not possible for positive $r$. Thus $r < q$.

This implies that the formula for $n$ is $n = r^2 t^3 + r$. Because $rt \in \mathbb{N} \Rightarrow t \in \mathbb{Q}$, thus $t = \frac{a}{b}$ for $a > b$ and $\text{gcd}(a, b) = 1$. Moreover, because $r \frac{a^2}{b^2} \in \mathbb{N} \Rightarrow b^2 \mid r$. Therefore there is some $k \geq 1$ such that $r = b^2 k$. The formula for $n$ in terms of $a, b, k$ is

$$
n = a^3 b k^2 + b^2 k
$$

Thus, to find all square progressive numbers, we can iterate over all possible values of $a, b, k$ such that $n \leq N$ and $\text{gcd}(a, b) = 1$ and for each $n$ test if it is a square number.