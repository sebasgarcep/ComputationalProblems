# Number of lattice points in a hyperball

Notice that $x^2 + y^2 + z^2 + t^2 \in \mathbb{N}_0$. Therefore we are being asked the number of different ways that we can express integers from $0$ to $r^2$ as a sum of four squares.

## Triple product identity

For complex $x$ and $z$ with $|x| < 1$ and $z \neq 0$ we have

$$
\prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n - 1} z^2) (1 + x^{2n - 1} z^{-2}) = \sum_{n = -\infty}^{\infty} z^{2n} x^{n^2}
$$

Proof: The restriction $|x| < 1$ assures absolute convergence of each of the products $\prod (1 - x^{2n}), \prod (1 + x^{2n - 1} z^2), \prod (1 + x^{2n - 1} z^{-2})$ and of the series. Moreover, for each fixed $x$ with $|x| < 1$ the series and products converge uniformly on compact subsets of the z-plane not containing $z = 0$ so each member of the product is an analytic function of z for $z \neq 0$. For fixes $z \neq 0$ the series and products also converge uniformly for $|x| \leq r < 1$ hence represent analytic functions of $x$ in the disk $|x| < 1$.

To prove the result we keep $x$ fixed and define $F(z)$ for $z \neq 0$ by the equation

$$
F(z) = \prod_{n \geq 1} (1 + x^{2n - 1} z^2) (1 + x^{2n - 1} z^{-2})
$$

First we show that $F$ satisfies the functional equation

$$
x z^2 F(x z) = F(z)
$$

Let

$$
x z^2 F(x z) = x z^2 \prod_{n \geq 1} (1 + x^{2n - 1} (x z)^2) (1 + x^{2n - 1} (x z)^{-2}) \\
= x z^2 \prod_{n \geq 1} (1 + x^{2n + 1} z^2) (1 + x^{2n - 3} z^{-2}) \\
= x z^2 \prod_{n \geq 2} (1 + x^{2n - 1} z^2) \prod_{n \geq 0} (1 + x^{2n - 1} z^{-2}) \\
= x z^2 (1 + x^{- 1} z^{-2}) \prod_{n \geq 2} (1 + x^{2n - 1} z^2) \prod_{n \geq 1} (1 + x^{2n - 1} z^{-2}) \\
= (1 + x z^2) \prod_{n \geq 2} (1 + x^{2n - 1} z^2) \prod_{n \geq 1} (1 + x^{2n - 1} z^{-2}) \\
= \prod_{n \geq 1} (1 + x^{2n - 1} z^2) \prod_{n \geq 1} (1 + x^{2n - 1} z^{-2}) \\
= F(z) \\
$$

which proves the functional equation.

Now let $G(z)$ denote the LHS of the desired result, i.e.

$$
G(z) = F(z) \prod_{n \geq 1} (1 - x^{2n})
$$

Then $G(z)$ also satisfies the functional equation. Moreover, $G(z)$ is an even function of $z$ which is analytical for all $z \neq 0$, so it has a Laurent expansion of the form

$$
G(z) = \sum_{m = -\infty}^{\infty} a_m z^{2m}
$$

where $a_{-m} = a_m$ since, clearly, $G(z) = G(z^{-1})$. Using the functional equation

$$
x z^2 \sum_{m = -\infty}^{\infty} a_m (x z)^{2m} = \sum_{m = -\infty}^{\infty} a_m z^{2m} \\
\sum_{m = -\infty}^{\infty} a_m x^{2m + 1} z^{2m + 2} = \sum_{m = -\infty}^{\infty} a_m z^{2m} \\
\sum_{m = -\infty}^{\infty} a_{m - 1} x^{2(m - 1) + 1} z^{2(m - 1) + 2} = \sum_{m = -\infty}^{\infty} a_m z^{2m} \\
\sum_{m = -\infty}^{\infty} a_{m - 1} x^{2m - 1} z^{2m} = \sum_{m = -\infty}^{\infty} a_m z^{2m} \\
$$

and by comparing coefficients we get the recursion formula

$$
a_m = x^{2m - 1} a_{m - 1}
$$

which when iterated gives

$$
a_m = a_0 \cdot x \cdot x^3 \cdot \dots \cdot x^{2m - 1} \\
a_m = a_0 \cdot x^{1 + 3 + \dots + 2m - 1} \\
a_m = a_0 \cdot x^{m^2} \\
$$

for all $m \geq 0$ (and $m < 0$ by the symmetry property). Thus

$$
G(z) = a_0(x) \sum_{n = -\infty}^{\infty} z^{2n} x^{n^2}
$$

Finally we need to find a closed form for $a_0$ in terms of $x$. Let

$$
G(e^{\pi i/4}) / a_0(x) = \sum_{m = -\infty}^{\infty} x^{m^2} i^m = \sum_{n = -\infty}^{\infty} (-1)^n x^{(2n)^2}
$$

since $i^m + i^{-m} = 0$ if $m$ is odd, so we are left only with even $m$. Now let

$$
G(i) / a_0(x^4) = \sum_{n = -\infty}^{\infty} (x^4)^{n^2} (i)^{2n} = \sum_{n = -\infty}^{\infty} (-1)^n x^{(2n)^2}
$$

Thus $G(e^{\pi i/4}) / a_0(x) = G(i) / a_0(x^4)$. Now, let

$$
G(e^{\pi i/4}) = \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n - 1} (e^{\pi i/4})^2) (1 + x^{2n - 1} (e^{\pi i/4})^{-2}) \\
G(e^{\pi i/4}) = \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n - 1} i) (1 + x^{2n - 1} -i) \\
G(e^{\pi i/4}) = \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n - 1} i - x^{2n - 1} i + x^{4n - 2}) \\
G(e^{\pi i/4}) = \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{4n - 2}) \\
$$

Since every even number is of the form $4n$ or $4n-2$ we have

$$
\prod_{n \geq 1} (1 - x^{2n}) = \prod_{n \geq 1} (1 - x^{4n}) (1 - x^{4n-2})
$$

so

$$
G(e^{\pi i/4}) = \prod_{n \geq 1} (1 - x^{4n}) (1 - x^{4n-2}) (1 + x^{4n - 2}) \\
G(e^{\pi i/4}) = \prod_{n \geq 1} (1 - x^{4n}) (1 - x^{8n - 4}) \\
$$

and since all numbers of the form $4n$ are also of the form $8n$ or $8n - 4$, we have

$$
G(e^{\pi i/4}) = \prod_{n \geq 1} (1 - x^{8n}) (1 - x^{8n - 4}) (1 - x^{8n - 4}) \\
$$

On the other hand

$$
G_{x^4}(i) = \prod_{n \geq 1} (1 - x^{8n}) (1 - x^{8n - 4}) (1 - x^{8n - 4}) \\
$$

Thus $G(e^{\pi i/4}) = G_{x^4}(i)$, hence $a_0(x) = a_0(x^4)$. And with proper substitutions we get $a_0(x) = a_0(x^{4k})$ for $k = 1, 2, \dots$. Then

$$
a_0(x) = \lim_{k \rightarrow \infty} a_0(x) = \lim_{k \rightarrow \infty} a_0(x^{4k}) = a_0(0) = 1
$$

which proves the theorem.

## Lambert Series of Arithmetic Functions

Let $|x| < 1$. Then

$$
\sum_{n = 1}^{\infty} a_n \frac{x^n}{1 - x^n} = \sum_{r = 1}^{\infty} b_r x^r
$$

where

$$
b_r = \sum_{n|r} a_n
$$

Proof:

Notice that

$$
\frac{x^n}{1 - x^n} = \frac{x^n - x^{2n} + x^{2n}}{1 - x^n} \\
\: \\
= \frac{x^n (1 - x^n) + x^{2n}}{1 - x^n} \\
\: \\
= x^n + \frac{x^{2n} - x^{3n} + x^{3n}}{1 - x^n} \\
\: \\
= x^n + \frac{x^{2n} (1 - x^n) + x^{3n}}{1 - x^n} \\
\: \\
= x^n + x^{2n} + \frac{x^{3n}}{1 - x^n} \\
\: \\
\dots \\
\: \\
= x^n + x^{2n} + x^{3n} + ... \\
= \sum_{m = 1}^{\infty} x^{mn} \\
$$

Therefore

$$
\sum_{n = 1}^{\infty} a_n \frac{x^n}{1 - x^n} = \sum_{n = 1}^{\infty} a_n \sum_{m = 1}^{\infty} x^{mn} = \sum_{r = 1}^{\infty} x^r \sum_{n|r} a_n = \sum_{r = 1}^{\infty} b_r x^r
$$

## Theorem 1

$$
\sum_{r = 1}^{\infty} \sigma(r) q^r = \sum_{n = 1}^{\infty} \frac{n q^n}{1 - q^n}
$$

Proof:

Let $a_n = n$. Therefore $b_r = \sum_{n|r} n = \sigma(r)$. The theorem results from the application of Lambert Series of Arithmetic Functions.

## Jacobi's four-square theorem

The number of ways to represent $n$ as the sum of four squares is:

$$
r_4(n) = 8 (\sum_{d|n} d - \sum_{4d | n} 4d)
$$

Proof:

Note that the coefficients of the following polynomial are the number of ways in which one can write an integer as a sum of four squares

$$
(\sum_{n = -\infty}^{\infty} x^{n^2})^4
$$

and by Theorem 1

$$
\sum_{n = 1}^{\infty} \sigma(n) q^n = \sum_{n = 1}^{\infty} \frac{n q^n}{1 - q^n} \\
\: \\
\sum_{n = 1}^{\infty} \sigma(4n) q^{4n} = \sum_{n = 1}^{\infty} \frac{4n q^{4n}}{1 - q^{4n}} \\
$$

therefore, if we can prove that

$$
(\sum_{n = -\infty}^{\infty} x^{n^2})^4 = 1 + 8 (\sum_{n = 1}^{\infty} \frac{n q^n}{1 - q^n} - \sum_{n = 1}^{\infty} \frac{4n q^{4n}}{1 - q^{4n}}) \text{ \: \: \: \: \: \: (1)}
$$

then we get

$$
(\sum_{n = -\infty}^{\infty} x^{n^2})^4 = 1 + 8 [\sum_{n = 1}^{\infty} (\sum_{d | n} d) q^n - \sum_{n = 1}^{\infty} (\sum_{4d | n} 4d) q^{4n}]
$$

and it is clear from the LHS that the coefficient of $x^n$ is $r_4(n)$. From the RHS we get that the coefficient of $x^n$ is $8 (\sum_{d|n} d - \sum_{4d | n} 4d)$, which proves our statement. Thus, let's prove (1). First set $z^2 = -1$ in the triple product identity

$$
\sum_{n = -\infty}^{\infty} (-1)^n x^{n^2} = \prod_{n \geq 1} (1 - x^{2n}) (1 - x^{2n - 1})^2 \\
= \prod_{n \geq 1} (1 - x^n) (1 - x^{2n - 1}) \\
= \prod_{n \geq 1} \frac{(1 - x^{2n}) (1 - x^{2n - 1})}{1 + x^n} \\
= \prod_{n \geq 1} \frac{1 - x^n}{1 + x^n} \text{ \: \: \: \: \: \: (2)} \\
$$

Now set $z^2 \rightarrow -x z^2$ in the triple product identity

$$
\sum_{n = -\infty}^{\infty} (-1)^n x^n z^{2n} x^{n^2} = \prod_{n \geq 1} (1 - x^{2n}) (1 - z^2 x^{2n}) (1 - z^{-2}  x^{2n - 2}) \\
\: \\
\sum_{n = -\infty}^{\infty} (-1)^n z^{2n} x^{n^2 + n} = \prod_{n \geq 1} (1 - x^{2n}) (1 - z^2 x^{2n}) (1 - z^{-2} x^{2n - 2}) \\
$$

set $x  \rightarrow x^{1/2}$ and multiply result by $z$

$$
\sum_{n = -\infty}^{\infty} (-1)^n z^{2n+1} x^{(n^2 + n) / 2} = z \prod_{n \geq 1} (1 - x^n) (1 - z^2 x^n) (1 - z^{-2} x^{n-1}) \\
\: \\
\sum_{n = -\infty}^{\infty} (-1)^n z^{2n+1} x^{(n^2 + n) / 2} = z (1 - z^{-2}) \prod_{n \geq 1} (1 - x^n) (1 - z^2 x^n) (1 - z^{-2} x^n) \\
\: \\
\sum_{n = -\infty}^{\infty} (-1)^n z^{2n+1} x^{(n^2 + n) / 2} = (z - z^{-1}) \prod_{n \geq 1} (1 - x^n) (1 - z^2 x^n) (1 - z^{-2} x^n) \text{ \: \: \: \: \: \: (3)} \\
$$

Now we differentiate $\text{(3)}$ by $z$

$$
\sum_{n = -\infty}^{\infty} (-1)^n (2n+1) z^{2n} x^{(n^2 + n) / 2} = (1 + z^{-2}) \prod_{n \geq 1} (1 - x^n) (1 - z^2 x^n) (1 - z^{-2} x^n) \\
+ (z - z^{-1}) \sum_{m \geq 1} (1 - x^m) (1 - 2 z x^m) (1 - z^{-2} x^m) \prod_{n \geq 1, n \neq m} (1 - x^n) (1 - z^2 x^n) (1 - z^{-2} x^n) \\
+ (z - z^{-1}) \sum_{m \geq 1} (1 - x^n) (1 - z^2 x^n) (1 + 2 z^{-3} x^n) \prod_{n \geq 1, n \neq m} (1 - x^n) (1 - z^2 x^n) (1 - z^{-2} x^n) \\
\: \\
$$

Then set $z = 1$, then multiply the result by $\frac{1}{2}$

$$
\sum_{n = -\infty}^{\infty} (-1)^n (2n+1) x^{(n^2 + n) / 2} = 2 \prod_{n \geq 1} (1 - x^n) (1 - x^n) (1 - x^n) \\
\: \\
\frac{1}{2} \sum_{n = -\infty}^{\infty} (-1)^n (2n+1) x^{(n^2 + n) / 2} = \prod_{n \geq 1} (1 - x^n)^3 \text{ \: \: \: \: \: \: (4)} \\
$$

Squaring $\text{(4)}$ gives

$$
\prod_{n \geq 1} (1 - x^n)^6 = \frac{1}{4} (\sum_{n = -\infty}^{\infty} (-1)^n (2n+1) x^{(n^2 + n) / 2})^2 \\
\: \\
\prod_{n \geq 1} (1 - x^n)^6 = \frac{1}{4} \sum_{n = -\infty}^{\infty} \sum_{m = -\infty}^{\infty} (-1)^{m+n} (2n+1) (2m+1) x^{(n^2 + n + m^2 + m) / 2} \\
$$

We split the sum into two subsums, the first with even $m + n$ and the second with odd $m + n$. In the first subsum we change the variables to $r = (m + n) / 2$, $s = (m - n) / 2$, and in the second to $r = (m - n - 1) / 2$, $s = (m + n + 1) / 2$. It is easy to check that in both cases $m^2 + m + n^2 + n$ turns into $2(r^2 + r + s^2)$ and $(-1)^{m+n} (2m + 1) (2n + 1)$ turns into $(2r + 1)^2 - (2s)^2$ Hence the two subsums coincide and the sign disappears

$$
\prod_{n \geq 1} (1 - x^n)^6 = \frac{1}{4} (\sum_{r, s, m+n \text{ even}} [(2r + 1)^2 - (2s)^2] x^{r^2 + r + s^2} + \sum_{r, s, m+n \text{ odd}} [(2r + 1)^2 - (2s)^2] x^{r^2 + r + s^2}) \\
\: \\
\prod_{n \geq 1} (1 - x^n)^6 = \frac{1}{4} (2 \sum_{r, s} [(2r + 1)^2 - (2s)^2] x^{r^2 + r + s^2}) \\
\: \\
\prod_{n \geq 1} (1 - x^n)^6 = \frac{1}{2} \sum_{r, s} [(2r + 1)^2 - (2s)^2] x^{r^2 + r + s^2} \text{ \: \: \: \: \: \: (5)} \\
$$

Take the RHS of $\text{(5)}$ and write it as a difference of two sums, and separate in each sums the variables $r, s$. Then

$$
\frac{1}{2} \sum_{r, s} [(2r + 1)^2 - (2s)^2] x^{r^2 + r + s^2} \\
\: \\
\frac{1}{2} (\sum_{r, s} (2r + 1)^2 x^{r^2 + r + s^2} - \sum_{r, s} (2s)^2 x^{r^2 + r + s^2}) \\
\: \\
\frac{1}{2} (\sum_{s} x^{s^2} \sum_{r} (2r + 1)^2 x^{r^2 + r} - \sum_{r} x^{r^2 + r} \sum_{s} (2s)^2 x^{s^2}) \\
$$

Note that

$$
(2s)^2 x^{s^2} = 4 s^2 x^{s^2} = 4x \cdot s^2 x^{s^2 - 1} = 4x \frac{d}{dx} x^{s^2} \\
\: \\
(2r + 1)^2 x^{r^2 + r} = (4r^2 + 4r + 1) x^{r^2 + r} = x^{r^2 + r} + 4x (r^2 + r) x^{r^2 + r - 1} = x^{r^2 + r} + 4x \frac{d}{dx} x^{r^2 + r} = (1 + 4x \frac{d}{dx}) x^{r^2 + r} \\
$$

where we treat $\frac{d}{dx}$ as an operator. Thus, we can express the last sums as

$$
\frac{1}{2} (\sum_{s} x^{s^2} \cdot (1 + 4x \frac{d}{dx}) \sum_{r} x^{r^2 + r} - \sum_{r} x^{r^2 + r} \cdot 4x \frac{d}{dx} \sum_{s} x^{s^2}) \\
$$

where each sum is independent of each other and therefore we can express them as a product of sums. Setting $z^2 = 1$ in $\sum_{s}$ and $z^2 = x$ in $\sum_{r}$ in the triple product identity we can replace each of the sums

$$
\sum_{s} x^{s^2} = \sum_{n = -\infty}^{\infty} x^{n^2} = \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n - 1})^2 \\
\: \\
\sum_{r} x^{r^2 + r} = \sum_{n = -\infty}^{\infty} x^n x^{n^2} = \sum_{n = -\infty}^{\infty} x^{n^2 + n} = \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n}) (1 + x^{2n - 2}) \\
\: \\
= 2 \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n}) (1 + x^{2n}) = 2 \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n})^2 \\
$$

And thus the last sums can be rewritten as products like

$$
\prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n - 1})^2 \cdot (1 + 4x \frac{d}{dx}) \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n})^2 \\
- \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n})^2 \cdot 4x \frac{d}{dx} \prod_{n \geq 1} (1 - x^{2n}) (1 + x^{2n - 1})^2
$$

Let $a = 1 + x^{2n}, b = 1 + x^{2n-1}, c = 1 - x^{2n}$. Then

$$
\prod_{n \geq 1} c b^2 \cdot (1 + 4x \frac{d}{dx}) \prod_{n \geq 1} c a^2 - \prod_{n \geq 1} c a^2 \cdot 4x \frac{d}{dx} \prod_{n \geq 1} c b^2 \\
\prod_{n \geq 1} c b^2 \cdot \prod_{n \geq 1} c a^2 + \prod_{n \geq 1} c b^2 \cdot 4x \frac{d}{dx} \prod_{n \geq 1} c a^2 - \prod_{n \geq 1} c a^2 \cdot 4x \frac{d}{dx} \prod_{n \geq 1} c b^2 \\
\prod_{n \geq 1} (a b c)^2 + \prod_{n \geq 1} c b^2 \cdot 4x \frac{d}{dx} \prod_{n \geq 1} c a^2 - \prod_{n \geq 1} c a^2 \cdot 4x \frac{d}{dx} \prod_{n \geq 1} c b^2 \\
$$

We can use the identiy $(\prod f_n)' = \prod f_n \cdot \sum f_n' / f_n$ to get

$$
\prod_{n \geq 1} (a b c)^2
+ \prod_{n \geq 1} c b^2 \cdot 4x \prod_{n \geq 1} c a^2 \sum_{n \geq 1} \frac{(a^2 c)'}{a^2 c}
- \prod_{n \geq 1} c a^2 \cdot 4x \prod_{n \geq 1} c b^2 \sum_{n \geq 1} \frac{(b^2 c)'}{b^2 c} \\
\prod_{n \geq 1} (a b c)^2
+ 4x \prod_{n \geq 1} c b^2 \prod_{n \geq 1} c a^2 \sum_{n \geq 1} \frac{(a^2 c)'}{a^2 c}
- 4x \prod_{n \geq 1} c a^2 \prod_{n \geq 1} c b^2 \sum_{n \geq 1} \frac{(b^2 c)'}{b^2 c} \\
\prod_{n \geq 1} (a b c)^2
+ 4x \prod_{n \geq 1} (a b c)^2 \sum_{n \geq 1} \frac{(a^2 c)'}{a^2 c}
- 4x \prod_{n \geq 1} (a b c)^2 \sum_{n \geq 1} \frac{(b^2 c)'}{b^2 c} \\
\prod_{n \geq 1} (a b c)^2 \cdot (1 + 4x \sum_{n \geq 1} \frac{(a^2 c)'}{a^2 c} - \frac{(b^2 c)'}{b^2 c}) \\
$$

Notice what happens with the last summand

$$
\frac{(a^2 c)'}{a^2 c} - \frac{(b^2 c)'}{b^2 c} = \frac{2 a a' c + a^2 c'}{a^2 c} - \frac{2 b b' c + b^2 c'}{b^2 c} \\
\: \\
= \frac{(2 a a' b^2 c + a^2 b^2 c') - (2 a^2 b b' c +  a^2 b^2 c')}{a^2 b^2 c} \\
\: \\
= \frac{2 a a' b^2 c - 2 a^2 b b' c}{a^2 b^2 c} \\
\: \\
= \frac{2 a a' b^2 c}{a^2 b^2 c} - \frac{2 a^2 b b' c}{a^2 b^2 c} \\
\: \\
= \frac{2 a'}{a} - \frac{2 b'}{b} \\
\: \\
= 2 (\frac{a'}{a} - \frac{b'}{b}) \\
$$

And substituting it back into the sum

$$
\prod_{n \geq 1} (a b c)^2 \cdot (1 + 8x \sum_{n \geq 1} \frac{(1 + x^{2n})'}{1 + x^{2n}} - \frac{(1 + x^{2n-1})'}{1 + x^{2n-1}}) \\
\: \\
\prod_{n \geq 1} (a b c)^2 \cdot (1 + 8x \sum_{n \geq 1} \frac{2n x^{2n-1}}{1 + x^{2n}} - \frac{(2n-1) x^{2n-2}}{1 + x^{2n-1}}) \\
\: \\
\prod_{n \geq 1} (a b c)^2 \cdot (1 + 8 \sum_{n \geq 1} \frac{2n x^{2n}}{1 + x^{2n}} - \frac{(2n-1) x^{2n-1}}{1 + x^{2n-1}}) \\
\prod_{n \geq 1} (a b c)^2 \cdot (1 - 8 \sum_{n \geq 1} \frac{(2n-1) x^{2n-1}}{1 + x^{2n-1}} - \frac{2n x^{2n}}{1 + x^{2n}}) = \prod_{n \geq 1} (1 - x^n)^6 \text{ \: \: \: \: \: \: (6)} \\
$$

Finally

$$
\prod_{n \geq 1} (a b c)^2 = \prod_{n \geq 1} (1 + x^{2n})^2 (1 + x^{2n-1})^2 (1 - x^{2n})^2 \\
= \prod_{n \geq 1} (1 + x^n)^2 (1 + x^n)^2 (1 - x^n)^2 \\
= \prod_{n \geq 1} (1 + x^n)^4 (1 - x^n)^2 \text{ \: \: \: \: \: \: (7)} \\
$$

Using $\text{(2)}$ and elevating it to the fourth power we get

$$
(\sum_{n = -\infty}^{\infty} (-1)^n x^{n^2})^4 = \prod_{n \geq 1} \frac{(1 - x^n)^4}{(1 + x^n)^4} = \prod_{n \geq 1} \frac{(1 - x^n)^6}{(1 + x^n)^4 (1 - x^n)^2} \\
\: \\
$$

Notice that the numerator of this expression is the LHS of $\text{(6)}$ and the denominator of this expression is the LHS of $\text{(7)}$. Thus $\prod_{n \geq 1} (a b c)^2$ is cancelled from the numerator and denominator. Therefore

$$
(\sum_{n = -\infty}^{\infty} (-1)^n x^{n^2})^4 = 1 - 8 \sum_{n \geq 1} \frac{(2n-1) x^{2n-1}}{1 + x^{2n-1}} - \frac{2n x^{2n}}{1 + x^{2n}} \\
$$

Replace $x$ with $-x$, we obtain the identity

$$
(\sum_{n = -\infty}^{\infty} x^{n^2})^4 = 1 + 8 \sum_{n \geq 1} \frac{(2n-1) x^{2n-1}}{1 - x^{2n-1}} + \frac{2n x^{2n}}{1 + x^{2n}} \\
$$

We rewrite the last sum as

$$
\sum_{n \geq 1} (\frac{(2n-1) x^{2n-1}}{1 - x^{2n-1}} + \frac{2n x^{2n}}{1 - x^{2n}}) - \sum_{n \geq 1} (\frac{2n x^{2n}}{1 - x^{2n}} - \frac{2n x^{2n}}{1 + x^{2n}}) \\
\: \\
\sum_{n \geq 1} \frac{n x^n}{1 - x^n} - \sum_{n \geq 1} 2n x^{2n} \frac{(1 + x^{2n}) - (1 - x^{2n})}{1 - x^{4n}} \\
\: \\
\sum_{n \geq 1} \frac{n x^n}{1 - x^n} - \sum_{n \geq 1} 2n x^{2n} \frac{2 x^{2n}}{1 - x^{4n}} \\
\: \\
\sum_{n \geq 1} \frac{n x^n}{1 - x^n} - \sum_{n \geq 1} \frac{4n x^{4n}}{1 - x^{4n}} \\
$$

Therefore

$$
(\sum_{n = -\infty}^{\infty} x^{n^2})^4 = 1 + 8 (\sum_{n \geq 1} \frac{n x^n}{1 - x^n} - \sum_{n \geq 1} \frac{4n x^{4n}}{1 - x^{4n}}) \\
$$

which proves the theorem.

Sources:

- Jacobi's Triple Product Identity, T.M. Apostol, Introduction to analytic number theory, Chapter 14.8
- Jacobi's four square identity proof [https://kam.mff.cuni.cz/~klazar/ostrava1.pdf]

## Algorithm

Note that

$$
\sum_{n = 1}^{N} \sigma(n) = \sum_{n = 1}^{N} \sum_{d|n} d = \sum_{d = 1}^{N} \sum_{n = 1}^{\lfloor \frac{N}{d} \rfloor} d = \sum_{d = 1}^{N} d \lfloor \frac{N}{d} \rfloor \\
$$

Let $k$ be the smallest integer such that $\lfloor \frac{N}{k} \rfloor \leq \sqrt{N}$. Then

$$
\sum_{d = 1}^{N} d \lfloor \frac{N}{d} \rfloor = \sum_{d = 1}^{k-1} d \lfloor \frac{N}{d} \rfloor + \sum_{d = k}^{N} d \lfloor \frac{N}{d} \rfloor
$$

Then the first sum can be easily calculated in $O(\sqrt{N})$ time. Therefore let us focus on the second sum. Note that $\lfloor \frac{N}{d} \rfloor = m \iff m \leq \frac{N}{d} < m + 1 \iff d m \leq N < d (m + 1) \iff \frac{N}{m + 1} < d \leq \frac{N}{m}$. Thus

$$
\sum_{\frac{N}{m + 1} < d \leq \frac{N}{m}} d \lfloor \frac{N}{d} \rfloor = m \sum_{\frac{N}{m + 1} < d \leq \frac{N}{m}} d \\
$$

where the sum on the RHS can be easily calculated using the formulas for triangular numbers. Because there are only at most $\sqrt{N}$ values of $m = \lfloor \frac{N}{d} \rfloor$ this sum will also run in $O(\sqrt{N})$.

The final part in the algorithm is calculating

$$
\sum_{1 \leq n \leq N, \: 4 | n} \sum_{4d | n} 4d = 4 \sum_{1 \leq n \leq N, \: 4 | n} \sum_{d | (n  / 4)} d = 4 \sum_{1 \leq n \leq N, \: 4 | n} \sigma(n  / 4) = 4 \sum_{n = 1}^{\lfloor \frac{N}{4} \rfloor} \sigma(n)
$$

But we already know how to calculate the sum of sigma. Therefore the algorithm has to run in $O(\sqrt{N})$ time.
