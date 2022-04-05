# Prime cube partnership

There are some prime values, <i>p</i>, for which there exists a positive integer, <i>n</i>, such that the expression <i>n</i><sup>3</sup> + <i>n</i><sup>2</sup><i>p</i> is a perfect cube.

For example, when <i>p</i> = 19, 8<sup>3</sup> + 8<sup>2</sup>×19 = 12<sup>3</sup>.

What is perhaps most surprising is that for each prime with this property the value of <i>n</i> is unique, and there are only four such primes below one-hundred.

How many primes below one million have this remarkable property?

## Solution

First of all note that $m^3 = n^3 + n^2 p > n^3 \Rightarrow m^3 > n^3 \Rightarrow m > n$.

Now let's prove that $n$ has to be a cube. Suppose $p \mid n$. Then $p \mid m$. Let $m = k_m p, n = k_n p$ where $k_m, k_n \in \mathbb{N}$. Clearly $k_m > k_n$ follows from $m > n$. Then $k_n^3 p^3 + k_n^2 p^3 = k_m^3 p^3 \Rightarrow k_n^3 + k_n^2 = k_m^3$ But this implies $k_n^2 = k_m^3 - k_n^3 = (k_m - k_n) (k_m^2 + k_m k_n + k_n^2) \gt k_n^2$, which is a contradiction. Therefore $p \not\mid n$. Now pick a prime $q \not= p$ and suppose $q \mid n$. Then there is $e \in \mathbb{N}$ such that $q^e \mid n$ but $q^{e+1} \not\mid n$. Moreover $q \not\mid n+p$. Then $q^{2e} \mid m^3$ but $q^{2e+1} \not\mid m^3$. Then $q \mid m$ which implies the existence of some $f$ such that $q^f \mid m$ but $q^{f+1} \not\mid m$. This implies that $2e = 3f$ and therefore $3 \mid e$. Thus $n$ has to be cube.

Let $n = a^3$. Then $a^9 + a^6 p = m^3 \Rightarrow a^3 + p = \left( \frac{m}{a^2} \right)^3$. Because the LHS is a natural number then the RHS must also be a natural number. This implies the existence of $b \in \mathbb{N}$ such that $m = b a^2$. This leads to the equation $a^3 + p = b^3 \Rightarrow p = (b - a)(b^2 + ab + a^2)$. Because $a, b \gt 0$ then $b^2 + ab + a^2 \gt 0$. Thus $b - a > 0$. Moreover $b^2 + ab + a^2 \ge 3 \gt 1$. Thus, because $p$ is prime it must be the case that $b - a = 1$ and $b^2 + ab + a^2 = p$. Substituting $b$ in the second equation we get $(a+1)^2+a(a+1)+a^2=p \Rightarrow 3a^2 + 3a + 1 - p = 0$. Solving for $a$ we get

$$
a = \frac{\sqrt{12p - 3} - 3}{6}
$$

So whenever $a$ is a natural number we will have a solution.