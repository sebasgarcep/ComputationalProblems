# Almost right-angled triangles I

<p>Let us call an integer sided triangle with sides <var>a</var> ≤ <var>b</var> ≤ <var>c</var> <i>barely acute</i> if the sides satisfy <br /><var>a</var><sup>2</sup> + <var>b</var><sup>2</sup> = <var>c</var><sup>2</sup> + 1.</p>

<p>How many barely acute triangles are there with perimeter ≤ 25,000,000?</p>

## Solution

Let the bound on the perimeter be $N$ for generality. Then $a+b+c \le N \Rightarrow a \le N/3$. Suppose we know $a$. Then $a^2-1 = c^2-b^2 = (c-b)(c+b)$. Because both $c-b, c+b \in \mathbb{N}$ then they are a factors of $a^2-1$ if $a^2-1 \gt 0$. Let's split the problem into two cases:

### $a = 1$

This implies $b = c$. Then we only need to check the triangle inequality for all $b$ that satisfy $1+2b \le N$. Because $c$ is the largest side then the sides must satisfy $a + b > c \iff 1 + b > b$ which is always true. Therefore all $b$ that satisfy $1+2b \le N$ form valid triangles.

### $a \gt 1$

Given $a$ we find all ways to factorize $a^2-1$ as $pq$. We then set $c-b=p, c+b=q$ and solve for $b,c$. Therefore $c=\frac{1}{2}(p + q), b = \frac{1}{2}(q-p)$. Thus $p \equiv q \pmod 2$ and $q > p$ where the last inequality implies $a^2-1 > p^2$. Clearly $b \le c$. Now we only need to check that $a \le b, \: a+b > c, \: a+b+c \le N$.

To speed up the factorization of $a^2-1$ notice that $a^2-1=(a-1)(a+1)$. Therefore we can factorize $a-1$ and $a+1$ independently and then join the factorizations. Notice that $\gcd(a-1,a+1) \in \{1,2\}$. Therefore we can remove the factors of $2$ from each of the $a-1, a+1$ and then the factorization of both is mutually exclusive. From that, generating the factors should be straightforward. 