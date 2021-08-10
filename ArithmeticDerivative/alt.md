# Arithmetic Derivative

<p>The <strong>arithmetic derivative</strong> is defined by</p>
<ul><li><var>p'</var> = 1 for any prime <var>p</var></li>
<li>(<var>ab</var>)<var>'</var> = <var>a'b</var> + <var>ab'</var> for all integers <var>a</var>, <var>b</var> (Leibniz rule)</li>
</ul><p>For example, 20<var>'</var> = 24.</p>

<p>Find <span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> <strong>gcd</strong>(<var>k</var>,<var>k'</var>) for 1 &lt; <var>k</var> ≤ 5×10<sup>15</sup>.</p>

<p><span style="font-size:smaller;">Note: <strong>gcd</strong>(<var>x</var>,<var>y</var>) denotes the greatest common divisor of <var>x</var> and <var>y</var>.</span></p>

## Fast Solution

### Dirichlet convolution

The Dirichlet convolution for two multiplicative functions $f$, $g$ is defined as:

$$
(f * g)(n) = \sum_{d \mid n} f(d) \cdot g(n / d)
$$

This operator is clearly commutative and associative. The identity function for the Dirichlet convolution is $\epsilon(1) = 1$, $\epsilon(n) = 0$ for $n > 1$. We can also easily show that $\mu * 1 = \epsilon$:

$$
(\mu * 1)(1) = \mu(1) = 1 \\
(\mu * 1)(n) = \sum_{d \mid n} \mu(d) = 0 \\
$$

### Mobius inversion formula

If $f$ and $g$ are multiplicative functions, then

$$
g(n) = \sum_{d \mid n} f(d) \iff f(n) = \sum_{d \mid n} \mu(d) \cdot g(n / d)
$$

#### Proof

$$
g \equiv 1 * f \iff \mu * g \equiv \mu * 1 * f \iff \mu * g = f
$$

Additionally, if you apply the Mobius inversion formula to $g$ to define $f$, then $f$ is multiplicative. To see this assume $\text{gcd}(a, b) = 1$. Then

$$
\begin{align*}
f(a b)
&= \sum_{d_a \mid a} \sum_{d_b \mid b} \mu(d_a d_b) \cdot g(ab / (d_a d_b)) \\
&= \sum_{d_a \mid a} \sum_{d_b \mid b} \mu(d_a d_b) \cdot g((a / d_a) \times (b /d_b)) \\
&= \sum_{d_a \mid a} \sum_{d_b \mid b} \mu(d_a) \mu(d_b) \cdot g(a / d_a) g(b / d_b) \\
&= [\sum_{d_a \mid a} \mu(d_a) \cdot g(a / d_a)] \cdot [\sum_{d_b \mid b} \mu(d_b) \cdot g(b / d_b)] \\
&= f(a) \cdot f(b) \\
\end{align*}
$$

Thus $f$ is multiplicative. In a similar fashion, if you apply the Mobius inversion formula to $f$ to define $g$, then $g$ is multiplicative.

### Calculating $f$

Let $g(x) = \text{gcd}(x, x')$. From the calculation of $\text{gcd}(x, x')$ in the slow solution we can trivially see that $g$ is multiplicative. Let $f = \mu * g$ be $g$'s mobius transform. Then

$$
f(n) = \sum_{d \mid n} \mu(d) \cdot g(n / d)
$$

Let's compute $f$. First assume a prime $p$. Then

$$
f(p) = \mu(1) \cdot g(p) + \mu(p) \cdot g(1) = 1 - 1 = 0
$$

Now assume $k > 1$. Then

$$
\begin{align*}
f(p^k)
&= \mu(1) \cdot g(p^k) + \mu(p) \cdot g(p^{k - 1}) + \mu(p^2) \cdot g(p^{k - 2}) + \dots \\
&= g(p^k) - g(p^{k - 1}) \\
\end{align*}
$$

Because $f$ is multiplicative we have two cases:

1. If a prime $p$ divides $n$ and $p^2$ does not then $f(n) = 0$.
2. Otherwise $f(n) \not= 0$.

### Powerful numbers

A powerful number is a number $n$ that can be expressed as $n = a^2 b^3$. Notice that if $n$ is powerful, then $f(n) \not= 0$ as each prime has to appear at least two or three times in the factorization of $n$. On the other hand, if $f(n) \not= 0$, then each prime in the factorization of $n$ appears at least two times. If that prime appears an even number of times it can be lumped into $a$. If that prime appears an odd number of times, then we can take three copies of that primes and lump themp into $b$. We will then be left with an even number of copies of that primes, and these can be lumped into $a$. Thus $n$ is powerful. To summarize

$$
\text{$n$ is powerful} \iff \text{$f(n) \not= 0$}
$$


### Calculating $S$ using $f$

Because $f$ is the mobius transform of $g$, we have that:

$$
g(n) = \sum_{d \mid n} f(d)
$$

And thus

$$
\begin{align*}
S(N)
&= \sum_{n = 1}^N g(n) \\
&= \sum_{n = 1}^N \sum_{d \mid n} f(d) \\
&= \sum_{d = 1}^N \lfloor \frac{N}{d} \rfloor f(d) \\
&= \sum_{\substack{1 \leq d \leq N \\ \text{$d$ is powerful}}} \lfloor \frac{N}{d} \rfloor f(d) \\
\end{align*}
$$

### Implementation

Notice that powerful numbers have the form $n = a^2 b^3$. Therefore $a \leq \sqrt{N}$ and $b \leq \sqrt[3]{N}$. Therefore all factors of $n$ are smaller than $\sqrt{N}$. Thus we can generate all powerful numbers by finding all primes up to $\sqrt{N}$ and using them to construct all numbers that either do not have that prime, or have at least two copies of it. If we know the number of copies of a prime $p$ in $n$ we can calculate the contribution of that prime to $f(n)$ by computing $g(p^k) - g(p^{k - 1})$. Notice that $g(p^k)$ can be computed incrementally, which reduces the amount of multiplications we have to do. Finally, our recurrence relation arises from the following identity.

$$
\begin{align*}
S(N; p_a, p_{a + 1}, \dots, p_m)
&= \sum_{\substack{n \leq N \\ \text{$n$ is powerful} \\ \text{only $p_i, i = a, \dots, m$ can divide $n$}}} f(n) \\
&= \sum_{\substack{n \leq N \\ \text{$n$ is powerful} \\ \text{only $p_i, i = a + 1, \dots, m$ can divide $n$}}} f(n) + \sum_{k \geq 2} \sum_{\substack{n \leq N / p_a^k \\ \text{$n$ is powerful} \\ \text{only $p_i, i = a + 1, \dots, m$ can divide $n$}}} f(p_a^k n) \\
&= S(N; p_{a + 1}, \dots, p_m) + \sum_{k \geq 2} \sum_{\substack{n \leq N / p_a^k \\ \text{$n$ is powerful} \\ \text{only $p_i, i = a + 1, \dots, m$ can divide $n$}}} f(p_a^k) f(n) \\
&= S(N; p_{a + 1}, \dots, p_m) + \sum_{k \geq 2} f(p_a^k) \sum_{\substack{n \leq N / p_a^k \\ \text{$n$ is powerful} \\ \text{only $p_i, i = a + 1, \dots, m$ can divide $n$}}} f(n) \\
&= S(N; p_{a + 1}, \dots, p_m) + \sum_{k \geq 2} f(p_a^k) \cdot S(N / p_a^k; p_{a + 1}, \dots, p_m) \\
\end{align*}
$$