# Admissible paths through a grid

Let's call a lattice point (<var>x</var>, <var>y</var>) <i>inadmissible</i> if <var>x</var>, <var>y</var> and <var>x</var> + <var>y</var> are all positive perfect squares.<br />
For example, (9, 16) is inadmissible, while (0, 4), (3, 1) and (9, 4) are not.

Consider a path from point (<var>x</var><sub>1</sub>, <var>y</var><sub>1</sub>) to point (<var>x</var><sub>2</sub>, <var>y</var><sub>2</sub>) using only unit steps north or east.<br />
Let's call such a path <i>admissible</i> if none of its intermediate points are inadmissible.

Let P(<var>n</var>) be the number of admissible paths from (0, 0) to (<var>n</var>, <var>n</var>).<br />
It can be verified that P(5) = 252, P(16) = 596994440 and P(1000) mod 1 000 000 007 = 341920854.

Find P(10 000 000) mod 1 000 000 007.

## Solution

Notice that inadmissible points satisfy $x = a^2, y = b^2, x + y = c^2$, for some $a, b, c \in \mathbb{N}$. Therefore $(x, y, x + y)$ is a pythagorean triple. These can be found efficiently using the formulas

$$
a = k \cdot (u^2 - v^2) \\
b = k \cdot (2uv) \\
c = k \cdot (u^2 + v^2) \\
$$

where $k \geq 1, u > v > 0$, $\text{gcd}(u, v) = 1$, and $u, v$ are not both odd. Because $x, y \leq N$ Then

$$
x + y = (u^2 + v^2)^2 \leq 2N \Rightarrow u \leq \sqrt[4]{2N}
$$

which gives us a nice upper bound for the iteration on $u$.

Fix a value of $n$. Now suppose we have a set $L$ of inadmissible points for that $n$. Define a function $E(x, y)$ which gives us the number of admissible paths between $(x, y)$ and $(n, n)$. It is easy to see that there are ${2n - x - y \choose n - x}$ total paths between $(x, y)$ and $(n, n)$. But those paths that go through any element in $L$ are inadmissible. Therefore we need to subtract these paths. Suppose $(u, v) \in L$ with $x \leq u, y \leq v$ and $(x, y) \not= (u, v)$. Then there are ${u + v - x - y \choose u - x}$ paths between $(x, y)$ and $(u, v)$. Moreover there are $E(u, v)$ admissible paths between $(u, v)$ and $(n, n)$. Thus we need to subtract ${u + v - x - y \choose u - x} \cdot E(u, v)$ paths from the total. Thus,

$$
E(x, y) = {2n - x - y \choose n - x} - \sum_{\substack{(u, v) \in L \setminus \{ (x, y) \} \\ \\ x \leq u , y \leq v}} {u + v - x - y \choose u - x} \cdot E(u, v)
$$

To optimize the calculation we can cache all factorials from $0$ to $2n$ and use a memoized version of $E(x, y)$.