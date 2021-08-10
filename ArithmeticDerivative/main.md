# Arithmetic Derivative

<p>The <strong>arithmetic derivative</strong> is defined by</p>
<ul><li><var>p'</var> = 1 for any prime <var>p</var></li>
<li>(<var>ab</var>)<var>'</var> = <var>a'b</var> + <var>ab'</var> for all integers <var>a</var>, <var>b</var> (Leibniz rule)</li>
</ul><p>For example, 20<var>'</var> = 24.</p>

<p>Find <span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> <strong>gcd</strong>(<var>k</var>,<var>k'</var>) for 1 &lt; <var>k</var> ≤ 5×10<sup>15</sup>.</p>

<p><span style="font-size:smaller;">Note: <strong>gcd</strong>(<var>x</var>,<var>y</var>) denotes the greatest common divisor of <var>x</var> and <var>y</var>.</span></p>

## Slow solution

### Defining $S(N)$

Let

$$
S(N) = \sum_{x = 1}^N \text{gcd}(x, x')
$$

with $\text{gcd}(x, x') = 1$. Then we want to find $S(5 \times 10^{15}) - 1$.

### Calculating $\text{gcd}(x, x')$

First let's compute $\text{gcd}(x, x')$. If $p$ is prime then:

$$
(p^n)' = p' \cdot p^{n - 1} + p' \cdot p^{n - 1} + \dots + p' \cdot p^{n - 1} = p^{n - 1} + \dots + p^{n - 1} = n p^{n - 1}
$$

Let $x$ be a natural number with prime decomposition

$$
x = p_1^{a_1} p_2^{a_2} \cdots p_m^{a_m}
$$

Then

$$
x' = (p_1^{a_1} p_2^{a_2} \dots p_m^{a_m})' = a_1 p_1^{a_1 - 1} p_2^{a_2} \cdots p_m^{a_m} + a_2 p_1^{a_1} p_2^{a_2 - 1} \cdots p_m^{a_m} + \dots + a_m p_1^{a_1} p_2^{a_2} \cdots p_m^{a_m - 1}
$$

Let

$$
g_x = p_1^{a_1 - 1} p_2^{a_2 - 1} \dots p_m^{a_m - 1}
$$

Then

$$
\frac{x}{g_x} = p_1 p_2 \cdots p_m \\
\frac{x'}{g_x} = a_1 p_2 \cdots p_m + p_1 a_2 \cdots p_m + \dots + p_1 p_2 \cdots a_m
$$

Suppose $a_i \equiv 0 \: (\text{mod } p_i)$. Then

$$
\frac{x'}{g_x} \equiv a_1 p_2 \cdots p_m + p_1 a_2 \cdots p_m + \dots + p_1 p_2 \cdots a_m \equiv 0 \: (\text{mod } p_i)
$$

Conversely, if $a_i \not\equiv 0 \: (\text{mod } p_i)$ then

$$
\frac{x'}{g_x} \equiv a_1 p_2 \cdots p_m + p_1 a_2 \cdots p_m + \dots + p_1 p_2 \cdots a_m \equiv p_1 \dots p_{i - 1} a_i p_{i + 1} \dots p_m \not\equiv 0 \: (\text{mod } p_i)
$$

Therefore

$$
\text{gcd}(x, x') = g_x \cdot \prod_{p_i \mid a_i} p_i
$$

From this we can easily prove that

$$
\text{gcd}(p^p x, (p^p x)') = p^p \text{gcd}(x, x')
$$

as $p \mid a \iff p \mid (a - p)$.

### Defining $S_{d}(N)$

Let

$$
S_d(N) = \sum_{\substack{1 \leq x \leq N \\ d \mid x}} \text{gcd}(x, x') \\
$$

Clearly $S_{1}(N) = S(N)$.

### Recurrence relation for $S(N)$

Notice that $\text{gcd}(x, x') = 1$ for squarefree numbers. Then we can split $S(N)$ as follows:

$$
\begin{align*}
S(N)
&= \sum_{x = 1}^N \text{gcd}(x, x') \\
&= \sum_{\substack{x = 1 \\ \mu(x) \not= 0}}^N \text{gcd}(x, x') + \sum_{\substack{x = 1 \\ \mu(x) = 0}}^N \text{gcd}(x, x') \\
&= \sum_{\substack{x = 1 \\ \mu(x) \not= 0}}^N g_x \cdot \prod_{p_i \mid a_i} p_i + \sum_{\substack{x = 1 \\ \mu(x) = 0}}^N \text{gcd}(x, x') \\
&= \sum_{\substack{x = 1 \\ \mu(x) \not= 0}}^N 1 + \sum_{\substack{x = 1 \\ \mu(x) = 0}}^N \text{gcd}(x, x') \\
&= Q(N) + \sum_{\substack{x = 1 \\ \mu(x) = 0}}^N \text{gcd}(x, x') \\
&= Q(N) - \sum_{2 \leq d^2 \leq N} \mu(d) \cdot \sum_{\substack{x = 1 \\ d^2 \mid x}}^N \text{gcd}(x, x') \\
&= Q(N) - \sum_{2 \leq d^2 \leq N} \mu(d) \cdot S_{d^2}(N) \\
\end{align*}
$$

where $Q(N)$ is the function that counts square-free numbers. Notice that the summation is essentially done over all squarefree $d$ as squarefull $d$ will be cancelled by $\mu(d)$. Therefore all following calculation will use the fact that $d$ is squarefree.

### Calculating $Q(N)$

Let

$$
Q(N) = \sum_{\substack{1 \leq x \leq N \\ \text{$x$ is square-free}}} 1
$$

From the inclusion-exclusion principle we have:

$$
Q(N) = \sum_{1 \leq x^2 \leq N} \mu(x) \lfloor N / x^2 \rfloor
$$

### Defining "special primes"

Fix a value of $N$. Then we wil call all primes $p$ that satisfy $p^p > N$ "normal primes". Otherwise they will be called "special primes". Take a "normal prime" $p_i$ and a number $x \leq N$ divisible by said primes. If $a_i$ is the exponent of $p_i$ in $x$, then we clearly have that $p_i \nmid a_i$, otherwise $p_i^{p_i} \leq N$ which is a contradiction. Therefore the contribution of $p_i^{a_i}$ to $\text{gcd}(x, x')$ is $p_i^{a_i - 1}$. With "special primes" the contribution can either be $p_i^{a_i}$ or $p_i^{a_i - 1}$. Therefore "normal primes" are better behaved in a sense.

### Main idea

The main idea of this programs will be to reduce $S_{d}$, where $d$ has "special primes" in its factorization, into $S_{\hat{d}}$ where $\hat{d}$ has no "special primes" in its factorization. Once we get rid of "special primes" we can use simpler recurrence relations, as "normal primes" are better behaved. Let's start by proving the simpler recurrences

### Recurrence relation for $S_{d^2}(N)$ under "normal primes"

Suppose $d$ is squarefree and only divisible by "normal primes". Then

$$
\begin{align*}
S_{d^2}(N)
&= \sum_{\substack{x = 1 \\ d^2 \mid x}}^N g_x \prod_{p_i \mid a_i} p_i \\
&= \sum_{\substack{x = 1 \\ d \mid x}}^{\lfloor N / d \rfloor} g_{d x} \prod_{p_i \mid a_i} p_i \\
&= \sum_{\substack{x = 1 \\ d \mid x}}^{\lfloor N / d \rfloor} d g_x \prod_{p_i \mid a_i} p_i \\
&= d \sum_{\substack{x = 1 \\ d \mid x}}^{\lfloor N / d \rfloor} g_x \prod_{p_i \mid a_i} p_i \\
&= d \cdot S_{d}(\lfloor N / d \rfloor) \\
\end{align*}
$$

### Recurrence relation for $S_{d}(N)$ under "normal primes"

Suppose $p$ is a "normal prime". Then

$$
\begin{align*}
S_p(N)
&= \sum_{\substack{x = 1 \\ p \mid x}}^N g_x \prod_{p_i \mid a_i} p_i \\
&= \sum_{x = 1}^{\lfloor N / p \rfloor} g_{p x} \prod_{p_i \mid a_i} p_i \\
&= \sum_{\substack{x = 1 \\ p \nmid x}}^{\lfloor N / p \rfloor} g_{p x} \prod_{p_i \mid a_i} p_i + \sum_{\substack{x = 1 \\ p \mid x}}^{\lfloor N / p \rfloor} g_{p x} \prod_{p_i \mid a_i} p_i \\
&= \sum_{\substack{x = 1 \\ p \nmid x}}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i + \sum_{\substack{x = 1 \\ p \mid x}}^{\lfloor N / p \rfloor} p \cdot g_x \prod_{p_i \mid a_i} p_i \\
&= \sum_{\substack{x = 1 \\ p \nmid x}}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i + p \sum_{\substack{x = 1 \\ p \mid x}}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i \\
&= \sum_{x = 1}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i + (p - 1) \sum_{\substack{x = 1 \\ p \mid x}}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i \\
&= S_{1}(\lfloor N / p \rfloor) + (p - 1) S_{p}(\lfloor N / p \rfloor) \\
&= S_{1}(\lfloor N / p \rfloor) + \varphi(p) S_{p}(\lfloor N / p \rfloor)
\end{align*}
$$

An inductive argument then shows that for any squarefree $d$ that is only divisible by "normal primes" we get

$$
S_{d}(N) = \sum_{u \mid d} \varphi(u) S_{u}(\lfloor N / d \rfloor)
$$

### Recurrence relation for $S_{4k}(N)$

Let $k$ be any odd number. Then

$$
\begin{align*}
S_{4k}(N)
&= \sum_{\substack{1 \leq x \leq N \\ 4k \mid x}} \text{gcd}(x, x') \\
&= \sum_{\substack{1 \leq x \leq N / 4 \\ k \mid x}} 4 \cdot \text{gcd}(x, x') \\
&= 4 \sum_{\substack{1 \leq x \leq N / 4 \\ k \mid x}} \text{gcd}(x, x') \\
&= 4 \cdot S_{k}(N / 4)
\end{align*}
$$

This means we can get rid of "special prime" $2$ right away as a first step in reducing $S_{d^2}$.

### Recurrence relation for $S_{p^{b} k}$ where $p$ is special

Let $p$ be a "special prime", $b = 1, 2$, and $\text{gcd}(p, k) = 1$. This procedure works for arbitrary $b$ and large enough $p$, but we don't have to worry about those cases, so let's restrict ourselves to these values. Then

$$
\begin{align*}
S_{p^b k}(N)
&= \sum_{b \leq a \leq p - 1} \sum_{\substack{1 \leq x \leq N \\ p^a k \mid x \\ p^{a + 1} \nmid x}} \text{gcd}(x, x') + \sum_{\substack{1 \leq x \leq N \\ p^p k \mid x}} \text{gcd}(x, x') \\
&= \sum_{b \leq a \leq p - 1} \sum_{\substack{1 \leq x \leq N / p^a \\ k \mid x \\ p \nmid x}} p^{a - 1} \text{gcd}(x, x') + \sum_{\substack{1 \leq x \leq N / p^p \\ k \mid x}} p^p \text{gcd}(x, x') \\
&= \sum_{b \leq a \leq p - 1} p^{a - 1} \sum_{\substack{1 \leq x \leq N / p^a \\ k \mid x \\ p \nmid x}} \text{gcd}(x, x') + p^p \sum_{\substack{1 \leq x \leq N / p^p \\ k \mid x}} \text{gcd}(x, x') \\
&= \sum_{b \leq a \leq p - 1} p^{a - 1} [ \sum_{\substack{1 \leq x \leq N / p^a \\ k \mid x}} \text{gcd}(x, x') - \sum_{\substack{1 \leq x \leq N / p^a \\ k \mid x \\ p \mid x}} \text{gcd}(x, x') ] + p^p \sum_{\substack{1 \leq x \leq N / p^p \\ k \mid x}} \text{gcd}(x, x') \\
&= \sum_{b \leq a \leq p - 1} p^{a - 1} [ S_{k}(N / p^a) - S_{pk}(N / p^a) ] + p^p S_{k}(N / p^p) \\
\end{align*}
$$

After a certain number of iterations of this procedure we are left with one of two results: either the argument is so small that we are left with an empty sum, or we've removed all "special primes" from the factorization of the subscript.

Notice that once we've removed all "special primes" we are left with a remainder of squared "normal" primes. We can calculate this quantity using the recurrence relation we found for $S_{d^2}(N)$ under "normal primes".

### Notes

The final algorithm runs in $12$ mins in a relatively powerful machine, and takes about $12$ GBs of RAM as it caches values of $S(N)$ to speed up computation.