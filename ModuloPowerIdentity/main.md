# Modulo power identity

<p>
Let S(<var>n</var>) be the sum of all positive integers <var>m</var> not exceeding <var>n</var> having the following property:<br /><var>a</var> <sup><var>m</var>+4</sup> ≡ <var>a</var> (mod <var>m</var>) for all integers <var>a</var>.
</p>
<p>
The values of <var>m</var> ≤ 100 that satisfy this property are 1, 2, 3, 5 and 21, thus S(100) = 1+2+3+5+21 = 32.<br />
You are given S(10<sup>6</sup>) = 22868117.
</p>
<p>
Find S(10<sup>12</sup>).
</p>

## Solution

First let's prove that $m$ must be squarefree. Suppose $m$ satisfies the property and there is a positive integer $k > 1$ such that $k^2 \mid m$. Let $r = m/k^2$. Then $(rk)^2 \equiv r \cdot rk^2 \equiv 0 \pmod m$. Therefore $(rk)^{m+4} \equiv (rk)^{m+2} \cdot (rk)^2 \equiv 0 \pmod m$. But $rk \not\equiv 0 \pmod m$, which implies a contradiction.

---

### Lemma 1: Generalization of Euler's Theorem

For any squarefree $n$ and any integer $a$

$$
a^{\varphi(n) + 1} \equiv a \pmod n
$$

### Proof

If $\gcd(a, n) = 1$ this has already been proven. Suppose $\gcd(a, n) = k > 1$. Let $r = a/k$. Then $\gcd(r, n) = 1$. Therefore

$$
\begin{align*}
a^{\varphi(n) + 1}
&\equiv r^{\varphi(n) + 1} k^{\varphi(n) + 1} \pmod n \\
&\equiv r k^{\varphi(n) + 1} \pmod n \\
\end{align*}
$$

Therefore we only need to show that $k^{\varphi(n) + 1} \equiv k \pmod n$. Let $s = n/k$. Then $\gcd(s, k) = 1$ (as $n$ is squarefree), which implies

$$
\begin{align*}
k^{\varphi(n) + 1}
&\equiv k^{\varphi(s)\varphi(k) + 1} \pmod s \\
&\equiv (k^{\varphi(s)})^{\varphi(k)} \cdot k \pmod s \\
&\equiv 1^{\varphi(k)} \cdot k \pmod s \\
&\equiv k \pmod s \\
k^{\varphi(n) + 1}
&\equiv 0 \pmod k \\
\end{align*}
$$

and by the Chinese Remainder Theorem $k^{\varphi(n) + 1} \equiv k \pmod n$, which concludes the proof.

### Lemma 2

For any squarefree $n$ and any integer $a$

$$
a^{\lambda(n) + 1} \equiv a \pmod n
$$

where $\lambda(n)$ is the Carmichael function of $n$.

### Proof

Almost the same as for Lemma 1, but replacing $\varphi(n)$ with $\lambda(n)$. The only difference, is where we use $\varphi(n) = \varphi(s) \cdot \varphi(k)$ we replace it with $\lambda(n) = \text{lcm}(\lambda(s), \lambda(k)) = \lambda(s) \cdot M$, where $M$ is clearly an integer.

---

Because $\lambda(m) + 1 \lt m + 4$ it must be that $\lambda(m) \mid m + 3$. If $m$ is prime then $m - 1 \mid m + 3$ which implies that $m - 1 \mid 4 \Rightarrow m = 2, 3, 5$. Therefore assume from now on that $m$ is composite. If $m = p_1 \dots p_k$, then $\lambda(m) = \text{lcm}(p_1 - 1, \dots, p_k - 1)$. Because at least one the primes must be odd, then $2 \mid \lambda(m) \Rightarrow 2 \mid m + 3$. Therefore $m$ must be odd.

Notice also that if $p$ is a prime such that $p \mid m$ then $p - 1 \mid m + 3 \Rightarrow p - 1 \mid (m + 3) - (p - 1) m/p = m/p + 3$. Therefore $p - 1 \le m/p + 3$ which implies that $p \le \sqrt{m + 4} + 2$.

Suppose $m = p_1 p_2$ with $p_1 < p_2$. Because $p_2 - 1 \mid p_1 p_2 + 3 \Rightarrow p_2 - 1 \mid p_1 + 3$, therefore there is an integer $k$ such that $k (p_2 - 1) = p_1 + 3$. Then

$$
p_2 - 1 \le k (p_2 - 1) = p_1 + 3 \Rightarrow p_2 - p_1 \le 4
$$

But $1 \le p_2 - p_1$. Because both $p_1, p_2$ are odd then $p_2 = p_1 + 2$ or $p_2 = p_1 + 4$. If the first equation holds then $k (p_1 + 1) = p_1 + 3 \Rightarrow k = (p_1 + 3)/(p_1 + 1)$. If $p_1 > 2$ then $1 \lt k \lt 2$, which is a contradiction. Now assume the second equation holds. Because $p_1 - 1 \mid p_2 + 3 = p_1 + 7$ then $p_1 - 1 \mid 8$. Therefore $p_1 - 1 = 1, 2, 4, 8 \Rightarrow p_1 = 2, 3, 5, 9$. Clearly $p_1 \not= 2, 9$. Furthermore, if $p_1 = 5$ then $p_2 = 9$, which is not prime. Thus the only case left is $p_1 = 3, p_2 = 7 \Rightarrow m = 21$ which satisfies the condition.

These facts motive the following algorithm. First let's do DFS for the first $k - 1$ primes in the factorization of $m$ (where $m$ has $k$ prime factors). If $p_i$ is the $i$-th prime in the factorization of $m$ (with $p_1 \lt \dots \lt p_k$) then $p_1 \dots p_{k-2} p_{k-1}^2 \le n$. Let $x = p_k$. Then

$$
p_1 \dots p_{k-2} p_{k-1} x + 3 \equiv 0 \pmod {(p_i - 1)}
$$

for all $1 \le i \le k - 1$. Then

$$
p_1 \dots p_{k-2} p_{k-1} x + 3 = \text{lcm}(p_1 - 1, \dots, p_{k-1} - 1) \cdot t
$$

which we can use to generate the values of $m$ by iterating over the possible $t \ge 1$ and performing all the following checks on $x$:

- $x \le \sqrt{n + 4} + 2$
- $x$ is prime
- $p_1 \dots p_{k-2} p_{k-1} x \le n$
- $p_{k-1} \lt x$
- $x - 1 \mid p_1 \dots p_{k-2} p_{k-1} x + 3$

Define the following:

- $b := \sqrt{n + 4} + 2$
- $m' := p_1 \dots p_{k-2} p_{k-1}$
- $l := \text{lcm}(p_1 - 1, \dots, p_{k-1} - 1)$

Then we get the following conditions

- $m' x + 3 = lt$
- $x \le b$
- $x$ is prime
- $m' x \le n$
- $p_{k-1} \lt x$
- $x - 1 \mid m' x + 3$

For $x$ to be an integer it must be that $m' \mid lt - 3$. Suppose $g = \gcd(m', l)$. Then

$$
lt \equiv 3 \pmod {m'} \\
\Rightarrow \frac{l}{g} \cdot t \equiv \frac{3}{g} \pmod {\frac{m'}{g}} \\
\Rightarrow t \equiv \left( \frac{l}{g} \right)^{-1} \cdot \frac{3}{g} \pmod {\frac{m'}{g}} \\
$$

which also requires $g = 1, 3$. This implies that $t$ is of the form

$$
t = t_{\text{min}} + \frac{m'}{g} \cdot t'
$$

where $t_{\text{min}}$ is the solution to the modular equation above and $t'$ is any non-negative integer. This allows us to skip a plenty of values of $x$. Finally we need to set an upper bound on $t$:

$$
x \le b \\
\Rightarrow m' x + 3 \le m' b + 3 \\
\Rightarrow lt \le m' b + 3 \\
\Rightarrow t \le (m' b + 3)/l \\
$$