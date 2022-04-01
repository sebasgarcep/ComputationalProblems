# Almost right-angled triangles II

<p>Let us call an integer sided triangle with sides <var>a</var> ≤ <var>b</var> ≤ <var>c</var> <i>barely obtuse</i> if the sides satisfy <br /><var>a</var><sup>2</sup> + <var>b</var><sup>2</sup> = <var>c</var><sup>2</sup> - 1.</p>

<p>How many barely obtuse triangles are there with perimeter ≤ 75,000,000?</p>

## Solution

Clearly $c > 1$.

Notice that $a^2 + b^2 = (a+bi)(a-bi) = c^2 - 1 = (c-1)(c+1)$. Therefore we want to find all representations as sum of squares of $c^2 - 1$. Start by factorizing $c-1, c+1$ in the Gaussian integers and joining the results. Notice that $\gcd(c-1, c+1) \in \{1,2\}$, therefore we can extract the factors of two from $c-1, c+1$ and the factorizations of the resulting terms are coprime. To split $c^2 - 1$ into conjugate factors we need to split the primes in the factorization of $c^2-1$ as follows:

- $2^v$ is equivalent to $(1+i)^{2v}$ up to multiplication by an unit. Therefore each conjugate factor gets a contribution of $(1+i)^v$.
- $p^{2v}$ where $p$ is a prime of the form $4k+3$ gets split into each conjugate factor evenly. Therefore each conjugate factor gets a contribution of $p^v$.
- $p^v$ where $p$ is a prime of the form $4k+1$ has an unique representation as $(a^2+b^2)^v = (a+bi)^v (a-bi)^v$. We have to give $v$ factors to each conjugate term. Therefore we have $v + 1$ choices in how to split these factors between the conjugate terms.

Once we have generated all the choices we have to make sure that we haven't generated equivalent choices up to multiplication by an unit or conjugation.

Notice that if $c$ is even then $c^2 - 1 \equiv -1 \equiv 3 \pmod 4$, which has no representations as a sum of squares. Thus $c$ has to be odd. Finally notice that for $(a, b, c)$ to be a triangle we must have $c < a + b \Rightarrow 2c < a + b + c \le N$, which gives a bound for $c$.