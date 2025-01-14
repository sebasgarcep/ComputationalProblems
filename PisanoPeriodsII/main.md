# Pisano Periods

For every positive integer $n$ the Fibonacci sequence modulo $n$ is periodic. The period depends on the value of $n$.
This period is called the <strong>Pisano period</strong> for $n$, often shortened to $\pi(n)$.

Define $M(p)$ as the largest integer $n$ such that $\pi(n) = p$, and define $M(p) = 1$ if there is no such $n$.<br>
For example, there are three values of $n$ for which $\pi(n)$ equals $18$: $19, 38, 76$. Therefore $M(18) = 76$.

Let the product function $P(n)$ be: $$P(n)=\prod_{p = 1}^{n}M(p).$$
You are given: $P(10)=264$.

Find $P(1\,000\,000)\bmod 1\,234\,567\,891$.

## Solution

For these proofs we will assume $\pi(p^n) = p^{n-1} \pi(p)$.

Fix a value of $p > 1$. Let $f_n$ be the $n$-th Fibonacci number. Suppose $\begin{pmatrix} f_{p+1} \\ f_p \end{pmatrix} \equiv \begin{pmatrix} 1 \\ 0 \end{pmatrix} \pmod n$ for some value of $n > 1$. Let $g_p = \gcd(f_p, f_{p+1} - 1)$. Then $n \mid g_p$. Therefore $M(p)$ is the largest divisor $d$ of $g_p$ for which $\pi(d) = p$.

### Lemma 1

Every cycle modulo $n$ of the Fibonacci sequence starts with $0, 1$.

#### Proof

Suppose $(f_s, f_{s+1}) \equiv (f_r, f_{r+1}) \pmod n$ for $s \lt r$. Then

$$
f_{s-1} \equiv f_{s+1} - f_{s} \equiv f_{r+1} - f_{r} \equiv f_{r-1} \pmod n
$$

And following the same logic we have

$$
f_{s-2} \equiv f_{s} - f_{s-1} \equiv f_{r} - f_{r-1} \equiv f_{r-2} \pmod n
$$

Therefore we can repeat this procedure until we get that

$$
f_{0} \equiv f_{r-s} \pmod n \\
f_{1} \equiv f_{r-s+1} \pmod n \\
$$

Which proves that $f_0, f_1$ are part of the cycle and therefore the cycle starts with them.

### Lemma 2

For $k \ge 0$ we have

$$
g_{3+6k} = 2 \\
g_{5+6k} = 1 \\
g_{7+6k} = 1 \\
$$

#### Proof

The base case $k = 0$ is easy to check. Now suppose the statement is true for $k$. We want to prove it for $k+1$. First note that

$$
\begin{align*}
g_{r+6(k + 1)}
&= \gcd(f_{r+6+6k}, f_{r+7+6k} - 1) \\
&= \gcd(f_{r+6+6k}, f_{r+5+6k} + f_{r+6+6k} - 1) \\
&= \gcd(f_{r+6+6k}, f_{r+5+6k} - 1) \\
&= \gcd(f_{r+5+6k} + f_{r+4+6k}, f_{r+5+6k} - 1) \\
&= \gcd(f_{r+4+6k} + 1, f_{r+5+6k} - 1) \\
&= \gcd(f_{r+4+6k} + 1, f_{r+3+6k} + f_{r+4+6k} - 1) \\
&= \gcd(f_{r+4+6k} + 1, f_{r+3+6k} - 2) \\
&= \gcd(f_{r+3+6k} + f_{r+2+6k} + 1, f_{r+3+6k} - 2) \\
&= \gcd(f_{r+2+6k} + 3, f_{r+3+6k} - 2) \\
&= \gcd(f_{r+2+6k} + 3, f_{r+1+6k} + f_{r+2+6k} - 2) \\
&= \gcd(f_{r+2+6k} + 3, f_{r+1+6k} - 5) \\
&= \gcd(f_{r+6k} + f_{r+1+6k} + 3, f_{r+1+6k} - 5) \\
&= \gcd(f_{r+6k} + 8, f_{r+1+6k} - 5) \\
&= \gcd(f_{r+6k} + 8, f_{r+1+6k} - 1 - 4) \\
\end{align*}
$$

First lets prove that $g_{3+6(k+1)} = 2$. Because $2 \mid f_{3+6k}, f_{4+6k} \Rightarrow 2 \mid f_{3+6k} + 8, f_{4+6k} - 1 - 4$. Note that $4 \nmid f_{3+6k}, f_{4+6k} \Rightarrow 4 \nmid f_{3+6k} + 8, f_{4+6k} - 1 - 4$. Now let $p$ be an odd prime such that $p \mid g_{3+6(k + 1)}$. Then there is an odd $k$ such that:

$$
\begin{align*}
&\Rightarrow f_{3+6k} + 8 + f_{4+6k} - 5 = 2pk \\
&\Rightarrow 4 + (f_{3+6k} + f_{4+6k} - 1) = 2pk \\
&\Rightarrow (f_{3+6k} + f_{4+6k} - 1) = 2pk - 4 \\
&\Rightarrow (f_{3+6k} + f_{4+6k} - 1) = 2(pk - 2) \\
&\Rightarrow \frac{f_{3+6k} + f_{4+6k} - 1}{2} = pk - 2 \\
\end{align*}
$$

Because $\pi(4) = 6$ then $f_{3+6k} + f_{4+6k} - 1 \equiv f_3 + f_4 - 1 \equiv 0\pmod 4$ and therefore the left-hand side of the equation is even. But the right-hand side of the equation is odd. Therefore $p$ cannot exist and $g_{3+6k} = 2$.

Now lets prove $g_{5+6(k+1)} = 1$. Note that the proof for $g_{7+6(k+1)} = 1$ is exactly like this one, so we will only prove this case. Because $2 \nmid f_{5+6k}, f_{6+6k} \Rightarrow 2 \nmid f_{5+6k} + 8, f_{6+6k} - 1 - 4$. Now let $p$ be an odd prime such that $p \mid g_{5+6(k + 1)}$. Then there is an odd $k$ such that:

$$
\begin{align*}
&\Rightarrow f_{5+6k} + 8 + f_{6+6k} - 5 = pk \\
&\Rightarrow 4 + (f_{6+6k} + f_{6+6k} - 1) = pk \\
&\Rightarrow (f_{5+6k} + f_{6+6k} - 1) = pk - 4 \\
\end{align*}
$$

Because $\pi(4) = 6$ then $f_{5+6k} + f_{6+6k} - 1 \equiv f_5 + f_6 - 1 \equiv 0 \pmod 4$ and therefore the left-hand side of the equation is even. But the right-hand side of the equation is odd. Therefore $p$ cannot exist and $g_{5+6(k+1)} = 1$.

### Lemma 3: d'Ocagne's identity

$$
f_{m} f_{n+1} - f_{m+1} f_{n} = (-1)^{n} f_{m-n}
$$

for $1 \le n \le m$.

#### Proof

Since

$$
\begin{pmatrix}
f_{m+1} \\
f_{m} \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 \\
1 & 0 \\
\end{pmatrix}^n

\begin{pmatrix}
f_{m-n+1} \\
f_{m-n} \\
\end{pmatrix}
$$

and

$$
\begin{pmatrix}
f_{n+1} \\
f_{n} \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 \\
1 & 0 \\
\end{pmatrix}^n

\begin{pmatrix}
f_1 \\
f_0 \\
\end{pmatrix}
$$

Then we must have

$$
\begin{pmatrix}
f_{m+1} & f_{n+1} \\
f_{m} & f_{n} \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 \\
1 & 0 \\
\end{pmatrix}^n

\begin{pmatrix}
f_{m-n+1} & f_1 \\
f_{m-n} & f_0 \\
\end{pmatrix}
$$

Applying the determinant on both sides we get

$$
\begin{align*}
& f_{m+1} f_{n} - f_{m} f_{n+1} = (-1)^{n} \cdot (-f_{m-n}) \\
\Rightarrow & f_{m} f_{n+1} - f_{m+1} f_{n} = (-1)^{n} f_{m-n} \\
\end{align*}
$$

### Lemma 4: Catalan's identity

$$
f_n^2 - f_{n+r} f_{n-r} = (-1)^{n-r} f_r^2
$$

where $n, r$ are positive integers such that $1 \le r \le n$.

#### Proof

The statement is clearly true for $r = 0$ and all $n$, and for $n = r$. Let's prove the statement for $r=1$ (Cassini's identity). For $n \ge 1$ we have

$$
\begin{pmatrix}
f_{n+1} \\
f_n \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 \\
1 & 0 \\
\end{pmatrix}^{n-1}
\begin{pmatrix}
f_2 \\
f_1 \\
\end{pmatrix}
$$

and

$$
\begin{pmatrix}
f_n \\
f_{n-1} \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 \\
1 & 0 \\
\end{pmatrix}^{n-1}
\begin{pmatrix}
f_1 \\
f_0 \\
\end{pmatrix}
$$

Therefore

$$
\begin{pmatrix}
f_{n+1} & f_n \\
f_n & f_{n-1} \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 \\
1 & 0 \\
\end{pmatrix}^{n-1}
\begin{pmatrix}
f_2 & f_1 \\
f_1 & f_0 \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 \\
1 & 0 \\
\end{pmatrix}^n
$$

Applying the determinant to the left-most and right-most sides we get

$$
\begin{align*}
& f_{n+1} f_{n-1} - f_n^2 = (-1)^n \\
\Rightarrow & f_n^2 - f_{n+1} f_{n-1} = (-1)^{n-1} \\
\end{align*}
$$

Now fix a value of $r$ and a value of $n \ge 2$ such that $r \lt n$ and assume the statement is true for $n' \lt n$ and all $r' \le n'$ and that the statement is true for all $r' \lt n$. Then

$$
\begin{align*}
f_n^2 - f_{n+r} f_{n-r}
&= f_n^2 - f_{n+r-1} f_{n-r+1} + f_{n+r-1} f_{n-r+1} - f_{n+r} f_{n-r} \\
&= (-1)^{n-r+1} f_{r-1}^2 + f_{n+r-1} f_{n-r+1} - f_{n+r} f_{n-r} \\
&= (-1)^{n-r+1} f_{r-1}^2 + f_{n+r-1} f_{n-r+1} - (f_{n+r-2} + f_{n+r-1}) f_{n-r} \\
&= (-1)^{n-r+1} f_{r-1}^2 + f_{n+r-1} (f_{n-r+1} - f_{n-r}) - f_{n+r-2} f_{n-r} \\
&= (-1)^{n-r+1} f_{r-1}^2 + f_{n+r-1} f_{n-r-1} - f_{n+r-2} f_{n-r} \\
&= (-1)^{n-r+1} f_{r-1}^2 - f_{n-1}^2 + f_{n+r-1} f_{n-r-1} + f_{n-1}^2 - f_{n+r-2} f_{n-r} \\
&= (-1)^{n-r+1} f_{r-1}^2 - (-1)^{n-1-r} f_r^2 + (-1)^{(n-1)-(r-1)} f_{r-1}^2 \\
&= - (-1)^{n-r} f_{r-1}^2 + (-1)^{n-r} f_r^2 + (-1)^{n-r} f_{r-1}^2 \\
&= (-1)^{n-r} f_r^2 \\
\end{align*}
$$

which proves the statement.

### Lemma 4, Corollary 1

$$
f_{2n} = f_{n+1}^2 - f_{n-1}^2 = f_n (f_{n+1} + f_{n-1})
$$

#### Proof

Set $n \rightarrow n+1, r \rightarrow n-1$. Then

$$
\begin{align*}
f_{2n}
&= f_{n+1}^2 - f_{n-1}^2 \\
&= (f_{n+1} - f_{n-1}) (f_{n+1} + f_{n-1}) \\
&= f_n (f_{n+1} + f_{n-1}) \\
\end{align*}
$$

### Lemma 4, Corollary 2

$$
f_n \mid f_{mn}
$$

for a positive integer $m$.

#### Proof

Fix the value of $n$. The result is trivial when $m = 1$. Assume the statement is true for $m'$ less than an arbitrary $m$. Lets prove the statement for this $m$. Set $n \rightarrow \left\lceil m/2 \right\rceil n, r \rightarrow \left\lfloor m/2 \right\rfloor n$. Then $f_{\left\lceil m/2 \right\rceil n}^2 - f_{mn} f_{1_{\text{m is odd}}} \equiv (-1)^{1_{\text{m is odd}}} f_{\left\lfloor m/2 \right\rfloor n}^2 \pmod{f_n} \Rightarrow -f_{mn} \equiv 0 \pmod{f_n}$, which proves the corollary.

### Lemma 5

$$
g_{4k} = f_{2k} \\
$$

for $k \ge 1$.

#### Proof

First lets prove $f_{2k} \mid g_{4k}$. Clearly $f_{2k} \mid f_{4k}$. Note that $f_{2k+1}^2 - f_{4k+1} f_{1} = - f_{2k}^2 \Rightarrow f_{4k+1} \equiv f_{2k+1}^2 \pmod{f_{2k}}$ and $f_{2k+1}^2 - f_{2k+2} f_{2k} = 1 \Rightarrow f_{2k+1}^2 \equiv 1 \pmod{f_{2k}}$. Therefore $f_{4k+1} - 1 \equiv 0 \pmod{f_{2k}} \iff f_{2k} \mid f_{4k+1} - 1$, which proves the statement.

Now lets prove that $g_{4k} \mid f_{2k}$. Suppose an odd prime $p$ and a positive integer $r$ satisfy $p^r \mid g_{4k}$. Then $p^r \mid f_{4k}, f_{4k+1} - 1 \iff f_{4k} \equiv f_{4k+1} - 1 \equiv 0 \pmod{p^r}$.

$$
f_{4k} f_{2k+1} - f_{4k+1} f_{2k} = f_{2k} \\
- f_{2k} \equiv f_{2k} \pmod{p^r} \\
0 \equiv 2f_{2k} \pmod{p^r} \\
0 \equiv f_{2k} \pmod{p^r} \\
$$

If $3 \nmid 4k$ then we are done, since no power of $2$ could divide $f_{4k}$ and hence no power of $2$ could divide $g_{4k}$. Suppose $3 \mid 4k$. Then $4k$ is a multiple of $12$. Because $\pi(8) = 12$ then $f_{4k} \equiv f_{12} \equiv 0 \pmod{8}, f_{4k+1} \equiv f_{13} \equiv 1 \pmod{8}$. Therefore $\nu_2(f_{4k}), \nu_2(f_{4k+1}-1) > 2$, where $\nu_p(x)$ be the largest power of a prime $p$ that divides $x$.

We also want to prove that $\nu_2(f_{4k}) = \nu_2(f_{4k+1} - 1) + 1 = \nu_2(k) + 4$ for $3 \mid 4k$ or equivalently that $\nu_2(f_{12k}) = \nu_2(f_{12k+1} - 1) + 1 = \nu_2(k) + 4$. A stronger version would be to prove that $\nu_2(f_{6k}) = \nu_2(f_{6k+1} - 1) + 1 = \nu_2(k) + 3$. The statement is clearly true for $k = 1$. Suppose the statement is true for all $k'$ less than some arbitrary $k$. Let $r = \nu_2(6k) = \nu_2(k) + 1$. Note that $\pi(2^{r+1}) = 3 \cdot 2^r \mid 6k$ and $\pi(2^{r+2}) = 3 \cdot 2^{r+1} \nmid 6k$. Therefore $2^{r+1} \mid f_{6k}, f_{6k+1} - 1$ and $2^{r+2}$ can't divide both. Let's show it can divide $f_{6k}$. Note that $f_{6k} = f_{3k} (f_{3k+1} + f_{3k-1})$. If $k$ is even then $\nu_2(f_{3k}) = \nu_2(k) + 2$ by the induction hypothesis and $2 \equiv 2 f_{3k+1} \equiv f_{3k+1} + f_{3k} + f_{3k-1} \equiv f_{3k+1} + f_{3k-1} \pmod{4}$, therefore $\nu_2(f_{3k+1} + f_{3k-1}) = 1$. This implies that $\nu_2(f_{6k}) = \nu_2(k) + 2 + 1 = \nu_2(k) + 3$. If $k$ is odd then since $\pi(4) = 6$ we must have $f_{3k} \equiv f_3 \equiv 2 \pmod 4$, and therefore $2 \mid f_{3k}$ but $4 \nmid f_{3k}$. On the other hand since $\pi(8) = 12$ then $f_{3k+1} + f_{3k-1} \equiv f_2 + f_4 \text{ or } f_{8} + f_{10} \equiv 4 \pmod{8}$ and therefore $4 \mid f_{3k+1} + f_{3k-1}$ but $8 \nmid f_{3k+1} + f_{3k-1}$. This implies that $\nu_2(f_6k) = 1 + 2 = 3$, completing the proof.

This last statement shows that $\nu_2(g_{4k}) = \nu_2(f_{4k+1}) = \nu_2(f_{4k}) - 1$. Using the previous statement we get

$$
\begin{align*}
& f_{4k} f_{2k+1} - f_{4k+1} f_{2k} = f_{2k} \\
\Rightarrow & -(1 + 2^{\nu_2(f_{4k}) - 1}) f_{2k} \equiv f_{2k} \pmod{2^{\nu_2(f_{4k})}} \\
\Rightarrow & (2 + 2^{\nu_2(f_{4k}) - 1}) f_{2k} \equiv 0 \pmod{2^{\nu_2(f_{4k})}} \\
\Rightarrow & 2 (1 + 2^{\nu_2(f_{4k}) - 2}) f_{2k} \equiv 0 \pmod{2^{\nu_2(f_{4k})}} \\
\Rightarrow & f_{2k} \equiv 0 \pmod{2^{\nu_2(f_{4k}) - 1}} \\
\end{align*}
$$

since $1 + 2^{\nu_2(f_{4k}) - 2}$ is an odd number. That is, $2^{\nu_2(g_{4k})} \mid f_{2k}$, which proves the lemma.

### Lemma 6

$$
\gcd(f_n, f_{n+1}) = 1
$$

for $n \ge 1$.

#### Proof

This is clearly true for $n = 1$. Assume it is true for an arbitrary $n$. Then

$$
\begin{align*}
\gcd(f_{n+1}, f_{n+2})
&= \gcd(f_{n+1}, f_{n} + f_{n+1}) \\
&= \gcd(f_{n+1}, f_{n}) \\
&= \gcd(f_{n}, f_{n+1}) \\
&= 1 \\
\end{align*}
$$

### Lemma 7

$\pi(n)$ is even for $n \gt 2$.

#### Proof

Note that

$$
\begin{pmatrix}
1 & 1 \\
1 & 0 \\
\end{pmatrix}^{\pi(n)} \equiv \begin{pmatrix}
1 & 0 \\
0 & 1 \\
\end{pmatrix} \pmod{n}
$$

Applying the determinant on both sides we get

$$
(-1)^{\pi(n)} \equiv 1 \pmod{n}
$$

which implies that $\pi(n)$ must be even.

### Lemma 8

$$
g_{4k+2} = f_{2k+2} + f_{2k} 
$$

for $k \ge 1$.

#### Proof

First let's prove that $f_{2k+2} + f_{2k} \mid g_{4k+2}$. Note that $f_{4k+2} = f_{2k+1}(f_{2k+2} + f_{2k})$ and therefore $f_{2k+2} + f_{2k} \mid f_{4k+2}$. On the other hand, note that $f_{4k+2} f_{2k+1} - f_{4k+3} f_{2k} = f_{2k+2}$ by d'Ocagne's identity. Therefore

$$
\begin{align*}
f_{4k+2} f_{2k+1} - f_{4k+3} f_{2k} &\equiv f_{2k+2} \pmod{f_{2k} + f_{2k+2}} \\
\Rightarrow f_{4k+2} f_{2k+1} - f_{4k+3} f_{2k} + f_{2k} &\equiv f_{2k+2} + f_{2k} \pmod{f_{2k} + f_{2k+2}} \\
\Rightarrow (1 - f_{4k+3}) f_{2k} &\equiv 0 \pmod{f_{2k} + f_{2k+2}} \\
\end{align*}
$$

Since $\gcd(f_{2k}, f_{2k} + f_{2k+2}) = \gcd(f_{2k}, f_{2k+2}) = \gcd(f_{2k}, f_{2k} + f_{2k+1}) = \gcd(f_{2k}, f_{2k+1}) = 1$ then $1 - f_{4k+3} \equiv 0 \pmod{f_{2k} + f_{2k+2}}$ or equivalently $f_{2k} + f_{2k+2} \mid f_{4k+3} - 1$. That is $f_{2k} + f_{2k+2} \mid g_{4k+2}$.

Now let's prove $g_{4k+2} \mid f_{2k+2} + f_{2k}$. Suppose there is a prime $p$ and a positive integer $r$ such that $p^r \mid g_{4k+2} \Rightarrow p^r \mid f_{4k+2}, f_{4k+3} - 1$. From d'Ocagne's identity we get $f_{4k+2} f_{2k+1} - f_{4k+3} f_{2k} = f_{2k+2}$. Thus

$$
\begin{align*}
f_{4k+2} f_{2k+1} - f_{4k+3} f_{2k} &\equiv f_{2k+2} \pmod{p^r} \\
- f_{2k} &\equiv f_{2k+2} \pmod{p^r} \\
0 &\equiv f_{2k+2} + f_{2k} \pmod{p^r} \\
\end{align*}
$$

Therefore $g_{4k+2} \mid f_{2k+2} + f_{2k}$, completing the proof.

### Algorithm

We have

$$
\begin{align*}
g_1 &= 1 \\
g_2 &= 1 \\
g_{3+6k} &= 2, \: k \ge 0 \\
g_{5+6k} &= 1, \: k \ge 0 \\
g_{7+6k} &= 1, \: k \ge 0 \\
g_{4k} &= f_{2k}, \: k \ge 1 \\
g_{4k+2} &= f_{2k+2} + f_{2k}, \: k \ge 1 \\
\end{align*}
$$

This proves instantly that:

$$
\begin{align*}
M(1) &= 1 \\
M(2) &= 1 \\
M(3) &= 2 \\
M(3+6k) &= 1, \: k \ge 1 \\
M(5+6k) &= 1, \: k \ge 0 \\
M(7+6k) &= 1, \: k \ge 0 \\
\end{align*}
$$

where $M(3+6k) = 1$ for $k \ge 1$ since $\pi(2) = 3 \not= 3+6k$.

Now let's prove that the formulas for $g_{4k}, g_{4k+2}$ never produce the same result. Since each formula is increasing, they can never intersect with themselves. Therefore, if there are collisions, there must be positive integers $r, s$ such that $g_{4r} = g_{4s+2} \Rightarrow f_{4r} = f_{4s+2} + f_{4s}$. If $r \le s \Rightarrow g_{4r} = f_{4r} \le f_{4s} \lt f_{4s+2} + f_{4s} = g_{4s+2}$. If $s \lt r \Rightarrow g_{4r} = f_{4r} \ge f_{4(s+1)} = f_{4s+3} + f_{4s+2} \gt f_{4s+2} + f_{4s} = g_{4s}$, proving the desired result.

Let $k \ge 1$. We want to prove that $M(2k) = g_{2k}$. Note that $g_2 = g_4 = 1$. Because $M(2k) \mid g_{2k}$ $M(2) = 1 = g_2$ and $M(4) = 1 = g_4$, proving the base cases. Fix a value of $k \ge 3$ and assume the statement is true for all $k' \lt k$. Assume $M(2k) \not= g_{2k}$. Then $\pi(g_{2k})$ strictly divides $2k$, since by definition $(f_{2k}, f_{2k+1}) \equiv (f_0, f_1) \pmod{g_{2k}}$. If $\pi(g_{2k})$ is an odd divisor of $2k$ then we've reached a contradiction since $\pi(n)$ is even for $n \gt 2$ and $g_{2k} \ge g_{8} = 3$. Now suppose $\pi(g_{2k})$ is an even divisor of $2k$. Let $2r := \pi(g_{2k})$. Then $M(2r) = g_{2r} \lt g_{2k}$, which is a contradiction since $\pi(g_{2k}) = 2r$. Therefore $M(2k) = g_{2k}$.

## Notes

$$
M(10) = 264 \\
M(20) = 438077876 \\
M(30) = 212018138 \\
M(40) = 739718237 \\
M(50) = 808850178 \\
$$
