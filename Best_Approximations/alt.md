# Best Approximations

NOTE: this is not the solution but is valuable work.

Let's prove that the convergents of the continued fractions are the best rational approximations to a number:

## Lemma 1

Let $x$ be an positive, irrational number. Let $(p_n)_{n \geq 0}$ and $(q_n)_{n \geq 0}$ be, respectively, the numerators and denominators of its continued fraction expansion (or convergents) as given by the recurrence:

$$
u_0 = x \\
\: \\
a_i = \lfloor u_i \rfloor \:, i \geq 0 \\
\: \\
u_i = \frac{1}{u_{i-1} - a_{i-1}}x \:, i > 0 \\
\: \\
p_0 = a_0 \\
q_0 = 1 \\
p_1 = a_1 * a_0 + 1 \\
q_1 = a1 \\
\: \\
p_k = a_k * p_{k-1} + p_{k-2} \\
q_k = a_k * q_{k-1} + q_{k-2} \\
$$

Then $p_1 < p_2 < ... < p_n$ and $q_1 < q_2 < ... < q_n$. Also $\frac{p_n}{q_n}$ is irreducible.

Proof: Notice that $0 < u_{i-1} - a_{i-1} = u_{i-1} - \lfloor u_{i-1} \rfloor < 1$. Therefore $a_i > 1$. Thus:

$$
p_k = a_k * p_{k-1} + p_{k-2} > p_{k-1} + p_{k-2} > p_{k-1} \\
q_k = a_k * q_{k-1} + q_{k-2} > q_{k-1} + q_{k-2} > q_{k-1} \\
$$

Then $p_1 < p_2 < ... < p_n$ and $q_1 < q_2 < ... < q_n$.

Now to show that $\frac{p_n}{q_n}$ is irreducible suppose that there is a common factor $d > 1$ of both $p_n$ and $q_n$. Then:

$$
p_n q_{n-1} - p_{n-1} q_n \equiv (-1)^{n+1} \: \text{(mod d)} \\
0 \equiv (-1)^{n+1} \: \text{(mod d)} \\
$$

which implies either $0 \equiv 1 \: \text{(mod d)}$ or $0 \equiv -1 \equiv d-1 \: \text{(mod d)}$, both of which imply $d = 1$, a contradiction. Therefore $\frac{p_n}{q_n}$ is irreducible.

## Lemma 2

Let $x$ be an positive, irrational number. Let $(p_n)_{n \geq 0}$ and $(q_n)_{n \geq 0}$ be, respectively, the numerators and denominators of its continued fraction expansion (or convergents). Then the even-indexed convergents are increasing and odd-indexed convergents are decreasing.

Proof: Notice that:

$$
\frac{p_n}{q_n} - \frac{p_{n-1}}{q_{n-1}} = \frac{p_n q_{n-1} - p_{n-1} q_n}{q_n q_{n-1}} = \frac{(-1)^{n+1}}{q_n q_{n-1}} \\
\: \\
\frac{p_{n+1}}{q_{n+1}} - \frac{p_{n-1}}{q_{n-1}} = (\frac{p_{n+1}}{q_{n+1}} - \frac{p_n}{q_n}) - (\frac{p_n}{q_n} - \frac{p_{n-1}}{q_{n-1}}) = \frac{(-1)^{n+2}}{q_{n+1} q_n} - \frac{(-1)^{n+1}}{q_n q_{n-1}} = \frac{(-1)^{n+2} q_{n-1} - (-1)^{n+1} q_{n+1}}{q_{n+1} q_n q_{n-1}} \\
$$

If $n$ is even then:

$$
\frac{p_{n+1}}{q_{n+1}} - \frac{p_{n-1}}{q_{n-1}} = \frac{q_{n-1} + q_{n+1}}{q_{n+1} q_n q_{n-1}}
$$

Because all terms of $(q_n)_{n \geq 0}$ are positive, then the even-indexed convergents are increasing. Similarly, if $n$ is odd then:

$$
\frac{p_{n+1}}{q_{n+1}} - \frac{p_{n-1}}{q_{n-1}} = \frac{- q_{n-1} - q_{n+1}}{q_{n+1} q_n q_{n-1}}
$$

the odd-indexed convergents are decreasing.

## Corollary from Lemma 2

Because the even-indexed convergents both converge and are increasing, they must all lie below $x$. Similary, odd-indexed convergents must all lie above $x$. This means that the convergents alternate from lying below $x$ to lying above.

## Lemma 3

Let $x$ be an irrational number. Let $(p_n)_{n \geq 0}$ and $(q_n)_{n \geq 0}$ be, respectively, the numerators and denominators of its continued fraction expansion (or convergents). Let $\frac{a}{b}$ be any rational number such that $1 \leq b \leq q_n$.

Then for all $n \geq 1$ we have $|x - \frac{p_n}{q_n}| \leq |x - \frac{a}{b}|$.

Proof: If $a = p_n$ and $b = q_n$ then the equality certainly holds. Suppose then that this is not true. Consider the system of equations:

$$
a = r p_n + s p_{n + 1} \\
b = r q_n + s q_{n + 1}
$$

Multiplying the first by $q_n$, and the second by $p_n$, then subtracting, we get:

$$
a q_n - b p_n = s (p_{n + 1} q_{n} - p_n q_{n + 1}) \\
a q_n - b p_n = s (-1)^{n + 2} \\
s = (-1)^{n + 2} (a q_n - b p_n) \\
$$

and therefore $s$ is an integer. Let's do the same to isolate $r$ by multiplying the first by $q_{n + 1}$, and the second by $p_{n + 1}$, then subtracting:

$$
a q_{n - 1} - b p_{n - 1} = r (p_n q_{n + 1} - p_{n + 1} q_n) \\
a q_{n - 1} - b p_{n - 1} = - r (p_{n + 1} q_n - p_n q_{n + 1}) \\
a q_{n - 1} - b p_{n - 1} = - r (-1)^{n + 2} \\
a q_{n - 1} - b p_{n - 1} = r (-1)^{n + 3} \\
r = (-1)^{n + 3} (a q_{n + 1} - b p_{n + 1}) \\
$$

Therefore $r$ is also an integer. If $s = 0$ then by $1 \leq b \leq q_n$ we get $r = 1$. This implies $a = p_n$, $b = q_n$, which is a contradiction. Therefore $s \neq 0$. If $r = 0$ then $\frac{a}{p_{n + 1}} = \frac{b}{q_{n + 1}}$ or equivalently $\frac{a}{b} = \frac{p_{n + 1}}{q_{n + 1}}$, which implies by Lemma 1 that $b$ is a multiple of $q_{n + 1}$. This is a contradiction. Therefore $r \neq 0$.

Since $0 < b = r q_n + s q_{n+1} < q_{n+1}$, $r$ and $s$ must have opposite signs. Similarly using the corollary from Lemma 2 $(q_n x - p_n)$ and $(q_{n+1} x - p_{n+1})$ must have opposite signs. Therefore $r (q_n x - p_n)$ and $s (q_{n+1} x - p_{n+1})$ must have the same sign. Thus:

$$
|bx - a| = |(r q_n + s q_{n + 1}) x - (r p_n + s p_{n + 1})| \\
= |r (q_n x - p_n) + s (q_{n + 1} x - p_{n + 1})| \\
= |r| |q_n x - p_n| + |s| |q_{n + 1} x - p_{n + 1}| \\
\geq |r| |q_n x - p_n| \\
\geq |q_n x - p_n| \\
$$

which is a stronger statement than what we wish to prove. Now let's prove the desired result:

$$
|q_n x - p_n| \leq |bx - a| \\
\: \\
|x - \frac{p_n}{q_n}| \cdot \frac{1}{|b|} \leq |x - \frac{a}{b}| \cdot \frac{1}{|q_n|} \\
\: \\
|x - \frac{p_n}{q_n}| \leq |x - \frac{a}{b}| \cdot \frac{|b|}{|q_n|} < |x - \frac{a}{b}| \\
$$

as $b < q_n$.
