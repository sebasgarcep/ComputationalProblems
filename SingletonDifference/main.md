# Singleton difference

<p>The positive integers, <i>x</i>, <i>y</i>, and <i>z</i>, are consecutive terms of an arithmetic progression. Given that <i>n</i> is a positive integer, the equation, <i>x</i><sup>2</sup> − <i>y</i><sup>2</sup> − <i>z</i><sup>2</sup> = <i>n</i>, has exactly one solution when <i>n</i> = 20:</p>
<p class="center">13<sup>2</sup> − 10<sup>2</sup> − 7<sup>2</sup> = 20</p>
<p>In fact there are twenty-five values of <i>n</i> below one hundred for which the equation has a unique solution.</p>
<p>How many values of <i>n</i> less than fifty million have exactly one solution?</p>

## Solution

Because $n > 0$ we must have $x > y, z$. Suppose $z < y < x$. Let $z = a, y = a + k, x = a + 2k$ for some values $a > 0, k > 0$. Then

$$
\begin{align*}
n
&= x^2 - y^2 - z^2 \\
&= (a + 2k)^2 - (a + k)^2 - a^2 \\
&= a^2 + 4ak + 4k^2 - a^2 - 2ak - k^2 - a^2 \\
&= 3k^2 + 2ak - a^2 \\
&= (a + k) \cdot (3k - a) \\
\end{align*}
$$

And because $a + k > 0$ we must have $3k - a > 0$. Let $n < N = 50 \times 10^6$. Then

$$
\begin{align*}
& (a + k) \cdot (3k - a) < N \\
&\Rightarrow a + k < N \\
&\Rightarrow a < N \\
\end{align*}
$$

The lower limit for $k$ given $a$ is

$$
k > a / 3
$$

Finally, the solution to ths problem will be:

1. Initialize the number of solutions for all $n < N$ at $0$
2. Generate all possible values of $1 < a < N$
3. For each value of $a$ initialize $k$ at $\lfloor a / 3 \rfloor + 1$
4. Let $n = (a + k) \cdot (3k - a)$
5. Increment the number of solutions for $n$ by $1$
6. Increment $k$ by $1$ and recalculate $n$. If $n > N$, stop iterating over $k$ and move to the next value of $a$
7. Once all values of $a$ have been iterated over, count the number of $n$ which have exactly one solution