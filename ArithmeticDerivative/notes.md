# Arithmetic Derivative

<p>The <strong>arithmetic derivative</strong> is defined by</p>
<ul><li><var>p'</var> = 1 for any prime <var>p</var></li>
<li>(<var>ab</var>)<var>'</var> = <var>a'b</var> + <var>ab'</var> for all integers <var>a</var>, <var>b</var> (Leibniz rule)</li>
</ul><p>For example, 20<var>'</var> = 24.</p>

<p>Find <span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> <strong>gcd</strong>(<var>k</var>,<var>k'</var>) for 1 &lt; <var>k</var> ≤ 5×10<sup>15</sup>.</p>

<p><span style="font-size:smaller;">Note: <strong>gcd</strong>(<var>x</var>,<var>y</var>) denotes the greatest common divisor of <var>x</var> and <var>y</var>.</span></p>

## Notes

If $p$ is prime then:

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

---

Let's calculate a simpler sum than the one we are interested in:

$$
S(N) = \sum_{x = 1}^N g_x
$$

Let

$$
Q(N) = \sum_{\substack{1 \leq x \leq N \\ \text{$x$ is square-free}}} 1
$$

And from the inclusion-exclusion principle we have:

$$
Q(N) = \sum_{1 \leq x^2 \leq N} \mu(x) \lfloor N / x^2 \rfloor
$$

Let

$$
S_d(N) = \sum_{\substack{1 \leq x \leq N \\ d \mid x}} g_x \\
$$

---

Suppose $d$ is a square-free number. Now consider the following sum:

$$
\begin{align*}
S_{d^2}(N) &= \sum_{\substack{1 \leq x \leq N \\ d^2 \mid x}} g_x \\
&= \sum_{\substack{1 \leq x \leq N / d \\ d \mid x}} g_{d x} \\
&= \sum_{\substack{1 \leq x \leq N / d \\ d \mid x}} d g_x \\
&= d \sum_{\substack{1 \leq x \leq N / d \\ d \mid x}} g_x \\
&= d \cdot S_d(\lfloor N / d \rfloor)
\end{align*}
$$

Hypothesis: Suppose $d$ is a square-free number. Then

$$
S_d(N) = \sum_{u \mid d} [ \prod_{\substack{p \mid u \\ \text{$p$ is prime}}} (p - 1)] \cdot S_u(\lfloor N / d \rfloor) = \sum_{u \mid d} \varphi(u) \cdot S_u(\lfloor N / d \rfloor)
$$

where clearly $S_1 \equiv S$.

Now let's test whether these results actually hold up and whether this is an improvement computationally speaking, before proving the hypothesis.

Note that the previous hypothesis can probably be proven using the fact that:

$$
\begin{align*}
p_1 p_2 \dots p_n &= (1 + (p_1 - 1)) (1 + (p_2 - 1)) \dots (1 + (p_n - 1)) \\
&= \sum_{u \mid p_1 p_2 \dots p_n} \prod_{p_i \mid u} (p_i - 1)
\end{align*}
$$

---

Let's see if we can calculate $S(N)$ another way.

$$
\begin{align*}
S(N) &= \sum_{x = 1}^N g_x \\
&= \sum_{\substack{1 \leq x \leq N \\ \mu(x) \not= 0}} g_x + \sum_{\substack{1 \leq x \leq N \\ \mu(x) = 0}} g_x \\
&= \sum_{\substack{1 \leq x \leq N \\ \mu(x) \not= 0}} 1 + \sum_{\substack{1 \leq x \leq N \\ \mu(x) = 0}} g_x \\
&= Q(N) + \sum_{\substack{1 \leq x \leq N \\ \mu(x) = 0}} g_x \\
&= Q(N) + \sum_{2 \leq d^2 \leq N} (-\mu(d)) S_{d^2}(N) \\
&= Q(N) - \sum_{2 \leq d^2 \leq N} \mu(d) d S_d(\lfloor N / d \rfloor) \\
\end{align*}
$$

This seems more efficient.

---

Let $u = p_1^{v_1} p_2^{v_2} \dots p_m^{v_m}$. Define $u_r = p_1 p_2 \dots p_m$. Then:

$$
\sum_{d \mid u} \mu(d) d = \sum_{d \mid u_r} \mu(d) d = (1 - p_1) (1 - p_2) \cdots (1 - p_m) = (-1)^m (p_1 - 1) (p_2 - 1) \cdots (p_m - 1) = \mu(u_r) \varphi(u_r)
$$

Also:

$$
\varphi(u_r) \cdot g_u = \varphi(u_r) \cdot \frac{u}{u_r} = (p_1 - 1) (p_2 - 1) \cdots (p_m - 1) \cdot p_1^{v_1 - 1} p_2^{v_2 - 1} \dots p_m^{v_m - 1} = \varphi(u) \\
$$

---

Now let's try the more complicated sum. Let

$$
S(N) = \sum_{x = 1}^N \text{gcd}(x, x') \\
S_d(N) = \sum_{\substack{1 \leq x \leq N \\ d \mid x}} \text{gcd}(x, x') \\
$$

where clearly $S_1 \equiv S$. Now notice that: 

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

---

Suppose $x = p_1^{a_1} \dots p_m^{a_m}$. Then $\text{gcd}(x, x') = \dots p_i^{a_i} \dots$ if $p_i \mid a_i$. But $x \leq N$, thus this can only happen for a limited number of values of $p_i, a_i$. We can find these values by studying the following inequality:

$$
p_i^{k p_i} \leq N \\
k p_i \leq \log_{p_i}(N) \\
k \leq \log_{p_i}(N) / p_i \\
$$

For $N = 5 \times 10^{15}$, the possible values are $(p_i, k) = (), (5, 1), (5, 2), (5, 3), (5, 4), (7, 1), (7, 2), (11, 1), (13, 1)$

$$
p_i = 2, a_i = 2, 4, \dots, 52 \\
p_i = 3, a_i = 3, 6, \dots, 30 \\
p_i = 5, a_i = 5, 10, 15, 20 \\
p_i = 7, a_i = 7, 14 \\
p_i = 11, a_i = 11 \\
p_i = 13, a_i = 13 \\
$$

Therefore, if $d$ is not divisible by any of these primes, we can ignore its contribution to the $\prod_{p_i \mid a_i} p_i$ part of the term. Then we have:

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

If $d$ is divisible by at least one of these primes we get:

TODO: Calculate this

---

Suppose $d$ is not divisible by any of the special primes. Let's consider a special case $d = p$, prime:

$$
\begin{align*}
S_p(N)
&= \sum_{\substack{x = 1 \\ p \mid x}}^N g_x \prod_{p_i \mid a_i} p_i \\
&= \sum_{x = 1}^{\lfloor N / p \rfloor} g_{p x} \prod_{p_i \mid a_i} p_i \\
&= \sum_{\substack{x = 1 \\ p \nmid x}}^{\lfloor N / p \rfloor} g_{p x} \prod_{p_i \mid a_i} p_i + \sum_{\substack{x = 1 \\ p \mid x}}^{\lfloor N / p \rfloor} g_{p x} \prod_{p_i \mid a_i} p_i \\
&= \sum_{\substack{x = 1 \\ p \nmid x}}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i + \sum_{\substack{x = 1 \\ p \mid x}}^{\lfloor N / p \rfloor} p \cdot g_x \prod_{p_i \mid a_i} p_i \\
&= \sum_{\substack{x = 1 \\ p \nmid x}}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i + p \sum_{\substack{x = 1 \\ p \mid x}}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i \\
&= \sum_{x = 1}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i + (p - 1) \sum_{\substack{x = 1 \\ p \mid x}}^{\lfloor N / p \rfloor} g_x \prod_{p_i \mid a_i} p_i \\
&= S_{1}(\lfloor N / p \rfloor) + (p - 1) S_{p}(\lfloor N / p \rfloor)
\end{align*}
$$

Hypothesis: Suppose $d$ is not divisible by any of the special primes. Then:

$$
S_{d}(N) = \sum_{u \mid d} \varphi(u) S_{u}(\lfloor N / d \rfloor)
$$

Now let $d$ be divisible by at least one of these special primes.

TODO: Complete this

---

Let $d = \prod_{i = 1}^m p_i$ be a square-free number. Then

$$
\begin{align*}
S_{d}(N)
&= \sum_{\substack{x = 1 \\ \forall i, \: p_i \mid x}}^N \text{gcd}(x, x') \\
&= \sum_{\substack{x = 1 \\ \forall i, \: p_i \mid x \\ \forall i, \: p_i^{p_i} \nmid x}}^N \text{gcd}(x, x')
+ \sum_{\substack{x = 1 \\ \forall i, \: p_i \mid x \\ \exists i, \: p_i^{p_i} \mid x}}^N \text{gcd}(x, x') \\
&= \sum_{1 \leq a_1 \leq p_1 - 1} \cdots \sum_{1 \leq a_m \leq p_m - 1} \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}(x, x') \\
&- \sum_{\substack{u \mid d \\ u > 1}} \mu(u) \cdots \sum_{a_i \geq 1 + (p_i - 1) \cdot \mathbb{1}_{p_i \mid u}} \cdots \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}(x, x') \\
\end{align*}
$$

Let's analyze the first sum

$$
\begin{align*}
\sum_{1 \leq a_1 \leq p_1 - 1} \cdots \sum_{1 \leq a_m \leq p_m - 1} \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}(x, x')
&= \sum_{1 \leq a_1 \leq p_1 - 1} \cdots \sum_{1 \leq a_m \leq p_m - 1} \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N [ \prod_{i = 1}^m p_i^{a_i - 1} ] \cdot \text{gcd}((x / \prod_{i = 1}^m p_i^{a_i}), (x / \prod_{i = 1}^m p_i^{a_i})') \\
&= \sum_{1 \leq a_1 \leq p_1 - 1} \cdots \sum_{1 \leq a_m \leq p_m - 1} [ \prod_{i = 1}^m p_i^{a_i - 1} ] \cdot \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}((x / \prod_{i = 1}^m p_i^{a_i}), (x / \prod_{i = 1}^m p_i^{a_i})') \\
&= \sum_{1 \leq a_1 \leq p_1 - 1} \cdots \sum_{1 \leq a_m \leq p_m - 1} [ \prod_{i = 1}^m p_i^{a_i - 1} ] \cdot \sum_{\substack{x = 1 \\ p_i \nmid x}}^{N / \prod_{i = 1}^m p_i^{a_i}} \text{gcd}(x, x') \\
&= \sum_{1 \leq a_1 \leq p_1 - 1} \cdots \sum_{1 \leq a_m \leq p_m - 1} [ \prod_{i = 1}^m p_i^{a_i - 1} ] \cdot \sum_{u \mid d} \mu(u) S_{u}(N / \prod_{i = 1}^m p_i^{a_i}) \\
\end{align*}
$$

Let's analyze the second sum. Take a single $u \mid d$, with $u > 1$. Separate the indexes such that $a_j$ represents the prime $p_j$ that does not divide $u$ and $a_k$ represents the prime $p_k$ that does divide $u$. Then

$$
\begin{align*}
\cdots \sum_{a_i \geq 1 + (p_i - 1) \cdot \mathbb{1}_{p_i \mid u}} \cdots \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}(x, x')
&= \cdots \sum_{a_j \geq 1} \cdots \sum_{a_k \geq p_k} \cdots \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}(x, x') \\
&= \cdots \sum_{a_j \geq 1} \cdots \sum_{a_k \geq p_k} \cdots \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N [ \prod_{k} p_k^{p_k} ] \cdot \text{gcd}((x / \prod_{k} p_k^{p_k}), (x / \prod_{k} p_k^{p_k})') \\
&= \cdots \sum_{a_j \geq 1} \cdots \sum_{a_k \geq p_k} \cdots [ \prod_{k} p_k^{p_k} ] \cdot \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}((x / \prod_{k} p_k^{p_k}), (x / \prod_{k} p_k^{p_k})') \\
&= \cdots \sum_{a_j \geq 1} \cdots \sum_{a_k \geq 0} \cdots [ \prod_{k} p_k^{p_k} ] \cdot \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^{N / \prod_{k} p_k^{p_k}} \text{gcd}(x, x') \\
&= \cdots \sum_{a_j \geq 1} \cdots [ \prod_{k} p_k^{p_k} ] \cdot \sum_{\substack{x = 1 \\ p_j^{a_j} \mid x \\ p_j^{a_j + 1} \nmid x}}^{N / \prod_{k} p_k^{p_k}} \text{gcd}(x, x') \\
&= [ \prod_{k} p_k^{p_k} ] \: \cdots \sum_{a_j \geq 1} \cdots \sum_{\substack{x = 1 \\ p_j^{a_j} \mid x \\ p_j^{a_j + 1} \nmid x}}^{N / \prod_{k} p_k^{p_k}} \text{gcd}(x, x') \\
&= [ \prod_{k} p_k^{p_k} ] \cdot S_{d / u}(N / \prod_{k} p_k^{p_k}) \\
\end{align*}
$$

---

Calculating recurrence relations for $S_{d^2}(N)$ can be done similarly to $S_{d}(N)$ by noticing that $S_{d^2}(N)$ can be written as:

$$
S_{d^2}(N)
= \sum_{2 \leq a_1} \cdots \sum_{2 \leq a_m} \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}(x, x') \\
$$

which is similar to the form of $S_{d}(N)$

$$
S_{d}(N)
= \sum_{1 \leq a_1} \cdots \sum_{1 \leq a_m} \sum_{\substack{x = 1 \\ p_i^{a_i} \mid x \\ p_i^{a_i + 1} \nmid x}}^N \text{gcd}(x, x') \\
$$

Then the same recurrence relations we obtained for $S_{d}(N)$ work for $S_{d^2}(N)$, except that the lower bound for $a_i$ is $2$ instead of $1$ in all calculations. Doing them we obtain the expression for the first term

$$
\sum_{2 \leq a_1 \leq p_1 - 1} \cdots \sum_{2 \leq a_m \leq p_m - 1} [ \prod_{i = 1}^m p_i^{a_i - 1} ] \cdot [ S(N / \prod_{i = 1}^m p_i^{a_i}) - S_{d}(N / \prod_{i = 1}^m p_i^{a_i}) ]
$$

And the expression associated with the second term is

$$
[ \prod_{k} p_k^{p_k} ] \: \cdots \sum_{a_j \geq 2} \cdots \sum_{\substack{x = 1 \\ p_j^{a_j} \mid x \\ p_j^{a_j + 1} \nmid x}}^{N / \prod_{k} p_k^{p_k}} \text{gcd}(x, x') = [ \prod_{k} p_k^{p_k} ] \cdot S_{(d / u)^2}(N / \prod_{k} p_k^{p_k})
$$

---

Define $\gamma$ for a square-free number $d$ to be:

$$
\gamma(d) = \prod_{p | d} p^{p}
$$

where the product is over the primes that divide $d$.

---

Is there a special case for $S_{d^2}(N)$ when $d$ is even ?

Probably $S_{d^2}(N) = 4 S_{(d / 2)^2}(N / 4)$.