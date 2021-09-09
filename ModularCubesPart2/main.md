# Modular Cubes Part 2

<p>
For a positive number <var>n</var>, define C(<var>n</var>) as the number of the integers <var>x,</var> for which 1&lt;<var>x</var>&lt;<var>n</var> and<br /><var>x</var><sup>3</sup>≡1 mod <var>n</var>.
</p>
<p>
When <var>n</var>=91, there are 8 possible values for <var>x</var>, namely : 9, 16, 22, 29, 53, 74, 79, 81.<br />
Thus, C(91)=8.</p>
<p>
Find the sum of the positive numbers <var>n</var>≤10<sup>11</sup> for which C(<var>n</var>)=242.</p>

## Solution

### Lemma 1

Consider polynomials in $\mathbb{F}_p[x]$. Then

$$
\text{gcd}(x^{p^n} - x, x^{p^d} - x) = x^{p^{\text{gcd}(n, d)}} - x
$$

#### Proof

If $n = d$, then the result is trivially true. Assume without loss of generality that $n > d$. Then

$$
\begin{align*}
x^{p^n} - x
&= x (x - 1) (1 + x + \dots + x^{p^n - 2}) \\
&= x (x - 1) (1 + x + \dots + x^{p^n - 1 \text{ (mod $p^d - 1$)}} + (1 + x + \dots + x^{p^d - 2}) \cdot f(x)) \\
&= x (x - 1) (1 + x + \dots + x^{p^n - 1 \text{ (mod $p^d - 1$)}}) + x (x - 1) (1 + x + \dots + x^{p^d - 2}) \cdot f(x) \\
&= (x^{p^n - 1 \pmod {p^d - 1}} - x) + (x^{p^d} - x) \cdot f(x) \\
\end{align*}
$$

where $f(x)$ is chosen to make the equation exact. Let $g(x) = \text{gcd}(x^{p^n} - x, x^{p^d} - x)$. Notice that $g(x) \mid x^{p^n} - x, x^{p^d} - x \Rightarrow g(x) \mid x^{p^n - 1 \pmod {p^d - 1}} - x$. Moreover $\text{gcd}(x^{p^d} - x, x^{p^n - 1 \pmod {p^d - 1}} - x) \mid x^{p^n} - x$. Therefore $g(x) = \text{gcd}(x^{p^d} - x, x^{p^n - 1 \pmod {p^d - 1}} - x)$. Now consider $p^n - 1$ modulo $p^d - 1$

$$
\begin{align*}
p^n - 1
&\equiv (p - 1) (1 + p + \dots + p^{n - 1}) \\
&\equiv (p - 1) (1 + p + \dots + p^{n \pmod d} + (1 + p + \dots + p^{d - 1}) \cdot f_p(x)) \\
&\equiv (p - 1) (1 + p + \dots + p^{n \pmod d}) + (p - 1) (1 + p + \dots + p^{d - 1}) \cdot f_p(x) \\
&\equiv (p^{n \pmod d} - 1) + (p^d - 1) \cdot f_p(x) \\
&\equiv p^{n \pmod d} - 1 \\
\end{align*}
$$

where $f_p(x)$ is chosen to make the equation exact. Therefore

$$
g(x) = \text{gcd}(x^{p^d} - x, x^{p^{n \pmod d}} - x)
$$

Notice that this is essentially the Euclidean algorithm occurring over the exponent of $p$. Therefore

$$
g(x) = x^{p^{\text{gcd}(n, d)}} - x
$$

### Lemma 2

For $n \geq 1$ the polynomial

$$
x^{p^n} - x \in \mathbb{F}_p[x]
$$

is the product of all monic irreducible polynomials in $\mathbb{F}_p[x]$ whose degree divides $n$.

#### Proof

Suppose $f(x)$ is an irreducible monic polynomial of degree $d$. Now consider the field $F =\mathbb{F}_p[x] / (f(x))$. All polynomials in $F$ can be reduced to polynomials of degree  $d-1$. Because the choice of coefficients for polynomials of degree not greater than $d-1$ is free, the order of this field is $p^d$. Therefore if $y \in F \Rightarrow y^{p^d} \equiv y$. Because $x \in F \Rightarrow x^{p^d} - x \equiv 0$ in $F$. Therefore $f(x) \mid x^{p^d} - x$. If $d \mid n$ then $f(x) \mid x^{p^n} - x$.

Now let's prove that if $f(x) \mid x^{p^n} - x$ then $d \mid n$. Notice that, if $f(x) \mid x^{p^n} - x$, then $f(x) \mid \text{gcd}(x^{p^n} - x, x^{p^d} - x) = x^{p^{\text{gcd}(n, d)}} - x$. If $n = 1$ then $d = \text{gcd}(n, d) = 1$ and thus $d \mid n$. Suppose $n > 1$ and that the statement is true for $1, 2, \dots, n - 1$. Notice that if $d = n$ the result is trivially true. Assume that $d < n$. Then $\text{gcd}(n, d) < n$. By the induction hypothesis, because $f(x) \mid x^{p^{\text{gcd(n, d)}}} - x$ we have that $d \mid \text{gcd}(n, d)$. But $\text{gcd}(n, d) \mid n$. Therefore $d \mid n$.

Finally we need to show that $x^{p^n} - x$ is squarefree. Let $g(x) = x^{p^n} - x$. Then $g'(x) = p^n \cdot x^{p^n - 1} - 1 = -1$ as coefficients are in $\mathbb{F}_p$. Then $\text{gcd}(g, g') = 1$. Suppose $a(x), b(x) \in \mathbb{F}_p[x]$ such that $g(x) = a(x)^2 b(x)$. Therefore $a(x) \mid g(x)$. Then $g'(x) = 2 a(x) a'(x) b(x) + a(x)^2 b'(x)$. Thus $a(x) \mid g'(x)$. Therefore $a(x) \mid \text{gcd}(g, g')$. But because $\text{gcd}(g, g') = 1 \Rightarrow a(x) = 1$. Therefore $x^{p^n} - x$ is squarefree.

### Rabin's test for irreducibility

Let $f(x)$ be a polynomial of degree $n$ over $\mathbb{F}_p$. Then $f$ is irreducible over $\mathbb{F}_p$ if and only if

- $f(x)$ divides $x^{p^n} - x$, and
- $\text{gcd}(f(x), x^{p^{n/q}} - x) = 1$ for each prime factor $q$ of $n$

#### Proof

$\Rightarrow$] The first condition is a corollary of Lemma 2. Because $f$ is irreducible it cannot have a common factor with any other polynomial. Therefore, the second condition must hold.

$\Leftarrow$] The first condition tells us that $f(x)$ has a subset of the factorization of $x^{p^n} - x$. Thus, by Lemma 2, $f(x)$ is a product of irreducible polynomials of degree that divides $n$. Suppose there is an irreducible polynomial $g(x)$ of degree $m < n$ in the factorization of $f(x)$. Then $m \mid n$ by Lemma 2. But because $m < n$ there is a prime $q$ in the factorization of $n$ such that $m \mid n / q$. But then $g(x)$ is in the factorization of $x^{p^{n/q}} - x$ which implies $\text{gcd}(f(x), x^{p^{n/q}} - x) \not= 1$, a contradiction. Therefore $f(x)$ must be irreducible.

### Note on Hensel's Lemma

Note that Hensel's lemma does not cover the case when $f(r) \equiv 0 \pmod {p^{m+1}}$ and $f'(r) \not\equiv 0 \pmod p$. The proof of Hensel's lemma in "Polynomial Modulo Square of Prime" shows that $f(r + t p^m) \equiv f(r) + t p^m f'(r) \pmod {p^{m+1}}$, where $0 \leq t \leq p - 1$. Assume $t > 0$, as when $t = 0$ we obtain the root $r$. Then $f(r + t p^m) \equiv 0 \pmod p^{m+1}$ implies $f(r) + t p^m f'(r) \equiv 0 \pmod {p^{m+1}}$. But $f(r) \equiv 0 \pmod {p^{m+1}}$, therefore $t p^m f'(r) \equiv 0 \pmod {p^{m+1}}$. This implies $t f'(r) \equiv 0 \pmod p$. But $t, f'(r) \not\equiv 0 \pmod p$. Therefore only one root can be lifted in this case: $r$ itself.

### Analysis of the problem

Notice that $1$ is the trivial solution to $x^3 \equiv 1$ modulo $n$. Therefore finding $C(n)$ is equivalent to finding $T(n)-1$, where $T(n)$ is the number of roots of the polynomial $f(x) = x^3 - 1$ modulo $n$. Thus, let's solve for $T(n)=243=3^5$. Suppose that $n = \prod_{i} p_i^{v_i}$. Then by the Chinese Remainder Theorem $T(n)=\prod_{i} T(p_i^{v_i})$.

To calculate $T(2^k)$ for $k \geq 1$ notice that $2^k \mid x^3 - 1 \Rightarrow 2 \mid x^3 - 1$. Therefore $x$ has to be odd. But this implies that $1 + x + x^2$ is odd. Therefore $2^k \mid x - 1$. Thus $x \equiv 1$ modulo $2^k$ is the only solution root of $f(x)$ modulo $2^k$. Therefore $T(2^k) = 1$.

Additionally, it is trivially true that $T(3) = 1$. Moreover $f'(r) \equiv 3r^2 \equiv 0 \pmod 3$. Because $f(1) \equiv 0 \pmod {p^{m+1}}$ for all $m$, then Hensel's lemma tells us that the solutions for $T(3^2)$ are $1, 4, 7$.

Now we want to prove that $T(3^k)=3$ for $k \geq 2$. We've already proven it for $k = 2$. Now assume $k \geq 3$ and the statement is true for $2, \dots, k - 1$. Notice that $1$ is a solution for $k-1$ and $k$. Therefore by Hensel's lemma it generates $3$ solutions for $k$ and it must generate the $3$ solutions of $k - 1$. Thus the $3$ solutions for $k-1$ are of the form $1, 1 + 3^{k-2}, 1 + 2 \cdot 3^{k-2}$. But

$$
\begin{align*}
f(1 + 3^{k-2})
&\equiv (1 + 3^{k-2})^3 - 1 \\
&\equiv 1 + 3 \cdot 3^{k-2} + 3 \cdot 3^{2k-4} + 3^{3k-6} - 1 \\
&\equiv 3^{k-1} + 3^{k + k - 3} + 3^{k + 2k - 6} \\
&\equiv 3^{k-1} \not\equiv 0 \pmod {3^k} \\
f(1 + 2 \cdot 3^{k-2})
&\equiv (1 + 2 \cdot 3^{k-2})^3 - 1 \\
&\equiv 1 + 2 \cdot 3 \cdot 3^{k-2} + 4 \cdot 3 \cdot 3^{2k-4} + 8 \cdot 3^{3k-6} - 1 \\
&\equiv 2 \cdot 3^{k-1} + 4 \cdot 3^{k + k - 3} + 8 \cdot 3^{k + 2k - 6} \\
&\equiv 2 \cdot 3^{k-1} \not\equiv 0 \pmod {3^k} \\
\end{align*}
$$

Therefore, by Hensel's lemma, $1 + 3^{k-2}, 1 + 2 \cdot 3^{k-2}$ generate no solutions. Thus the only solutions are the ones that are generated by $1$ which implies $T(3^k)=3$ for $k \geq 2$.

To calculate $T(p_i)$ with odd $p_i > 3$ notice that $x^3 - 1 = (x - 1) (x^2 + x + 1)$. Thus we need to find the roots of $x^2 + x + 1$. We can rewrite this expression modulo $p_i$ as:

$$
\begin{align*}
x^2 + x + 1
&\equiv x^2 + (p + 1) x + 1 \\
&\equiv x^2 + 2 \cdot \frac{p + 1}{2} x + (\frac{p + 1}{2})^2 - (\frac{p + 1}{2})^2 + 1 \\
&\equiv (x + \frac{p + 1}{2})^2 - (\frac{p + 1}{2})^2 + 1 \\
\end{align*}
$$

And a pair of solutions $x_1, x_2$ can be found, if they exist, by obtaining the square root using Tonelli-Shanks. Solutions to $T(p_i^{v_i})$ can be found inductively using Hensel lifting.

Let's consider the base case for the Hensel lifting: $T(p)$. By the previous logic $T(p) = 1$ if $x^2 + x + 1$ is irreducible in the finite field $\mathbb{F}_{p}$, otherwise $T(p) = 3$. First let's explore when $x^2 + x + 1$ divides $x^{p^2} - x$. Notice that $x^{p^2} - x = x (x - 1) (1 + x + \dots + x^{p^2 - 2})$. Therefore $x^2 + x + 1 \mid x^{p^2} - x \iff x^2 + x + 1 \mid 1 + x + \dots + x^{p^2 - 2} \iff 3 \mid p^2 - 1 = (p - 1) (p + 1)$. But because $p > 3 \Rightarrow 3 \nmid p$, then either $p - 1$ or $p + 1$ is divisible by $3$. Therefore this condition is always satisfied.

Now let's explore when $\text{gcd}(x^2 + x + 1, x^p - x) = 1$. Notice that if $\text{gcd}(x^2 + x + 1, x^p - x) \not= 1$, then $x^2 + x + 1 \mid x^p - x$ or $x^2 + x + 1 \equiv (x - k)^2$ modulo $p$ for some $k \in \{ 0, 1, \dots, p - 1 \}$ (if the two roots of $x^2 + x + 1$ are distinct then $x^2 + x + 1 \mid x^p - x$, as $x^p - x$ has all numbers modulo $p$ as roots with multiplicity $1$). Suppose $x^2 + x + 1 \mid x^p - x$. Notice that $x^p - x = x (x - 1) (1 + x + \dots + x^{p - 2})$. Therefore $x^2 + x + 1 \mid x^p - x \iff x^2 + x + 1 \mid 1 + x + \dots + x^{p - 2} \iff 3 \mid p - 1 \iff p \equiv 1 \text{ (mod 3)}$.

Now suppose $x^2 + x + 1 \equiv (x - k)^2 \text{ (mod p)}$. Then there is $z$ such that $z^2 \equiv (\frac{p + 1}{2})^2 - 1 \text{ (mod p)}$. Then the roots of $x^2 + x + 1$ are $x_1 = - \frac{p + 1}{2} + z, x_2 = - \frac{p + 1}{2} - z$. But because $x^2 + x + 1$ has only one root with multiplicity $2$, then $- \frac{p + 1}{2} + z \equiv - \frac{p + 1}{2} - z \text{ (mod p)} \Rightarrow z \equiv -z \text{ (mod p)} \Rightarrow z \equiv 0 \text{ (mod p)} \Rightarrow (\frac{p + 1}{2})^2 \equiv 1 \text{ (mod p)} \Rightarrow \frac{p + 1}{2} \equiv \pm 1 \text{ (mod p)}$. But if $3 < p \Rightarrow 4 < p + 1 \Rightarrow 2 < \frac{p + 1}{2}$. On the other hand $3 < p \Rightarrow p + 3 < 2p \Rightarrow p + 1 < 2p - 2 \Rightarrow \frac{p + 1}{2} < p - 1$. Therefore $1 < \frac{p + 1}{2} < p - 1$. Thus $\frac{p + 1}{2} \not\equiv \pm 1 \text{ (mod p)}$, which implies that this case can never occur.

Therefore $x^2 + x + 1$ is irreducible in $\mathbb{F}_p[x]$ if and only if $p \equiv 2 \text{ (mod 3)}$.

Suppose $p \equiv 2 \pmod 3$. Then $T(p) = 1$ has only the trivial solution $x \equiv 1 \pmod p$. Notice that $f(1) \equiv 0 \pmod {p^{m + 1}}$ and $f'(1) \equiv 3 \not\equiv 0 \pmod p$. Therefore by an inductive argument and the note on Hensel's Lemma one can show that $T(p^k)=1$ for $k \geq 1$.

Now suppose $p \equiv 1 \pmod 3$. Then $T(p) = 3$. Now let's consider the roots for $k \geq 2$. Suppose $f(r) \equiv 0 \pmod {p^k}$. Then $r \not\equiv 0 \pmod {p^k}$ which implies $f'(r) \equiv 3r^2 \not\equiv 0 \mod p$. By Hensel's Lemma and the note on Hensel's Lemma, then each root of $f$ modulo $p^k$ generates exactly $1$ root modulo $p^{k+1}$. Thus $T(p^{k+1}) = T(p^k)$. Therefore $T(p^k) = 3$.

### Closed form of the solution

Let's summarize what we have until this point:

- $T(1) = 1$
- $T(2^k) = 1$ for $k \geq 1$
- $T(3) = 1$ and $T(3^k) = 3$ for $k \geq 2$
- If $p$ is an odd prime such that $p \equiv 1 \pmod 3$ then $T(p^k) = 3$ for $k \geq 1$
- If $p$ is an odd prime such that $p \equiv 2 \pmod 3$ then $T(p^k) = 1$ for $k \geq 1$

Let

$$
S_k(N, a) = \sum_{\substack{1 \leq n \leq N \\ \\ p_1, \dots, p_a \nmid n \\ \\ T(n) = 3^k}} n
$$

Then the solution to the problem is $S_5(10^{11}, 0)$. Let's find an efficient formula for $S_k(N, a)$:

$$
\begin{align*}
S_k(N, a)
&= \sum_{v \geq 0} \sum_{\substack{1 \leq n p_{a + 1}^v \leq N \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) T(p^v) = 3^k}} n p_{a + 1}^v \\
&= \sum_{v \geq 0} p_{a + 1}^v \sum_{\substack{1 \leq n \leq N / p_{a + 1}^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) T(p_{a+1}^v) = 3^k}} n \\
\end{align*}
$$

If $p_{a+1} \equiv 2 \pmod 3$ then

$$
\begin{align*}
S_k(N, a)
&= \sum_{v \geq 0} p_{a + 1}^v \sum_{\substack{1 \leq n \leq N / p_{a + 1}^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) T(p_{a+1}^v) = 3^k}} n \\
&= \sum_{v \geq 0} p_{a + 1}^v \sum_{\substack{1 \leq n \leq N / p_{a + 1}^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) = 3^k}} n \\
&= \sum_{v \geq 0} p_{a + 1}^v S_k(N / p_{a+1}^v, a + 1) \\
&= S_k(N, a + 1) + \sum_{v \geq 1} p_{a + 1}^v S_k(N / p_{a+1}^v, a + 1) \\
\end{align*}
$$

If $p_{a+1} \equiv 1 \pmod 3$ then

$$
\begin{align*}
S_k(N, a)
&= \sum_{v \geq 0} p_{a + 1}^v \sum_{\substack{1 \leq n \leq N / p_{a + 1}^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) T(p_{a+1}^v) = 3^k}} n \\
&= S_k(N, a+1) + \sum_{v \geq 1} p_{a + 1}^v \sum_{\substack{1 \leq n \leq N / p_{a + 1}^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) \cdot 3 = 3^k}} n \\
&= S_k(N, a+1) + \sum_{v \geq 1} p_{a + 1}^v \sum_{\substack{1 \leq n \leq N / p_{a + 1}^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) = 3^{k-1}}} n \\
&= S_k(N, a+1) + \sum_{v \geq 1} p_{a + 1}^v S_{k-1}(N / p_{a+1}^v, a + 1) \\
\end{align*}
$$

where $S_k(N, a) = 0$ for $k < 0$. Finally if $p_{a+1} = 3$ then

$$
\begin{align*}
S_k(N, a)
&= \sum_{v \geq 0} 3^v \sum_{\substack{1 \leq n \leq N / 3^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) T(3^v) = 3^k}} n \\
&=
\sum_{\substack{1 \leq n \leq N \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) = 3^k}} n
+ 3 \sum_{\substack{1 \leq n \leq N / 3 \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) = 3^k}} n
+ \sum_{v \geq 2} 3^v \sum_{\substack{1 \leq n \leq N / 3^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) \cdot 3 = 3^k}} n \\
&= S_k(N, a + 1) + 3 S_k(N / 3, a + 1) + \sum_{v \geq 2} 3^v \sum_{\substack{1 \leq n \leq N / p_{a + 1}^v \\ \\ p_1, \dots, p_{a + 1} \nmid n \\ \\ T(n) = 3^{k-1}}} n \\
&= S_k(N, a + 1) + 3 S_k(N / 3, a + 1) + \sum_{v \geq 2} 3^v S_{k-1}(N / 3^v, a + 1) \\
\end{align*}
$$

Notice that if $a \geq \pi(N)$ then $S_k(N, a) = \mathbb{1}_{k=0}$ and if $a \geq \pi(\sqrt{N})$ then

$$
S_k(N, a) = \mathbb{1}_{k=0} + \sum_{\substack{a + 1 \leq i \leq \pi(N) \\ \\ T(p_i) = 3^k}} p_i
$$

If $k \geq 2$, then $S_k(N, a) = 0$. If $k = 1$ then

$$
S_k(N, a) = \sum_{\substack{a + 1 \leq i \leq \pi(N) \\ \\ p_i \equiv 1 \pmod 3}} p_i
$$

If $k = 0$ then

$$
S_k(N, a) = 1 + \sum_{\substack{a + 1 \leq i \leq \pi(N) \\ \\ p = 3 \text{ or } p \equiv 2 \pmod 3}} p_i
$$

### Calculating sums of primes over equivalence classes modulo $3$

Define for $k = 1, 2$

$$
\Sigma\pi_{k}(N) = \sum_{\substack{1 \leq i \leq \pi(N) \\ \\ p_i \equiv k \pmod 3}} p_i \\
$$

Define an auxiliary function

$$
\varphi_k(N, a) = \sum_{\substack{1 \leq n \leq N \\ \\ n \equiv k \pmod 3 \\ \\ p_1, \dots, p_a \nmid n}} n
$$

Notice that if $a \geq \pi(\sqrt{N}) \Rightarrow \varphi_k(N, a) = \Sigma\pi_k(N) - \Sigma\pi_k(p_a) + \mathbb{1}_{k = 1}$. Additionally, for $a \not= 2$

$$
\begin{align*}
\varphi_k(N, a - 1)
&= \sum_{\substack{1 \leq n \leq N \\ \\ n \equiv k \pmod 3 \\ \\ p_1, \dots, p_{a-1} \nmid n}} n \\
&= \sum_{\substack{1 \leq n \leq N \\ \\ n \equiv k \pmod 3 \\ \\ p_1, \dots, p_a \nmid n}} n
+ \sum_{\substack{1 \leq n p_a \leq N \\ \\ n p_a \equiv k \pmod 3 \\ \\ p_1, \dots, p_{a-1} \nmid n}} n p_a \\
&= \sum_{\substack{1 \leq n \leq N \\ \\ n \equiv k \pmod 3 \\ \\ p_1, \dots, p_a \nmid n}} n
+ p_a \sum_{\substack{1 \leq n \leq N / p_a \\ \\ n \equiv k \cdot k_a \pmod 3 \\ \\ p_1, \dots, p_{a-1} \nmid n}} n \\
&= \varphi_k(N, a) + p_a \varphi_{k \cdot k_a}(N / p_a, a - 1)
\end{align*}
$$

where $k_a \equiv p_a \pmod 3$. Rewriting it in a more usable form we get

$$
\varphi_k(N, a) = \varphi_k(N, a - 1) - p_a \varphi_{k \cdot k_a}(N / p_a, a - 1)
$$

If $a = 2$, then

$$
\varphi_k(N, a) = \varphi_k(N, a - 1)
$$

Therefore

$$
\varphi_k(N, a) = \varphi_k(N, 0) - \sum_{\substack{i = 1 \\ i \not=2}}^a p_i \varphi_{k \cdot k_a}(N / p_i, i - 1)
$$

Applying Meissel's method now we set $a = \pi(\sqrt[3]{N}), b = \pi(\sqrt{N})$ and get

$$
\varphi_k(N, a) = \mathbb{1}_{k = 1} + \Sigma\pi_k(N) - \Sigma\pi_k(p_a) + P_{k,2}(N, a)
$$

where

$$
\begin{align*}
P_{k,2}(N, a)
&= \sum_{i = a + 1}^b p_i \sum_{\substack{p_i \leq p_j \leq N / p_i \\ \\ p_j \equiv k \cdot k_i \pmod 3}} p_j \\
&= \sum_{i = a + 1}^b p_i [ \Sigma\pi_{k \cdot k_i}(N / p_i) - \Sigma\pi_{k \cdot k_i}(p_i - 1) ] \\
\end{align*}
$$

and we can isolate $\Sigma\pi_k(N)$ to obtain an efficient formula for it.