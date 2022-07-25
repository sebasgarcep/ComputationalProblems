# Sums of power sums

Let f<sub>k</sub>(<var>n</var>) be the sum of the <var>k</var><sup>th</sup> powers of the first <var>n</var> positive integers.

For example, f<sub>2</sub>(10) = 1<sup>2</sup> + 2<sup>2</sup> + 3<sup>2</sup> + 4<sup>2</sup> + 5<sup>2</sup> + 6<sup>2</sup> + 7<sup>2</sup> + 8<sup>2</sup> + 9<sup>2</sup> + 10<sup>2</sup> = 385.

Let S<sub>k</sub>(<var>n</var>) be the sum of f<sub>k</sub>(<var>i</var>) for 1 ≤ <var>i</var> ≤ <var>n</var>. For example, S<sub>4</sub>(100) = 35375333830.

What is <span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> (S<sub>10000</sub>(10<sup>12</sup>) mod p) over all primes <var>p</var> between 2 ⋅ 10<sup>9</sup> and 2 ⋅ 10<sup>9</sup> + 2000?

## Solution

First we need to define and prove a few facts about Bernoulli numbers.

## Bernoulli numbers

Suppose $x/(e^x - 1)$ has the following Taylor expansion:

$$
\sum_{n = 0}^\infty \frac{b_n}{n!} x^n = \frac{x}{e^x - 1}
$$

Then $b_n$ is the $n$-th Bernoulli number. Calculating the limit of $x/(e^x-1)$ as $x$ approaches $0$ gives $b_0 = 1$. Now let's prove the following lemmas:

### Lemma 1

The Bernoulli numbers satisfy the relation

$$
\sum_{k = 0}^{r-1} {r \choose k} b_k = 0
$$

for all $r \ge 2$.

#### Proof

Note that

$$
\begin{align*}
& (e^x - 1) \sum_{n = 0}^\infty \frac{b_n}{n!} x^n = x \\
\Rightarrow & \left( \sum_{m = 1}^\infty \frac{x^m}{m!} \right) \left( \sum_{n = 0}^\infty \frac{b_n}{n!} x^n \right) = x
\end{align*}
$$

After multiplication the coefficient of $x^r$ (where $r \ge 2$) satisfies

$$
\begin{align*}
& \sum_{\substack{n + m = r \\ n \ge 0 \\ m \ge 1}} \frac{b_n}{n!} \cdot \frac{1}{m!} = 0 \\
\Rightarrow & \sum_{k = 0}^{r-1} \frac{b_k}{k!} \cdot \frac{1}{(r - k)!} = 0 \\
\Rightarrow & \sum_{k = 0}^{r-1} \frac{b_k}{k!} \cdot \frac{r!}{(r - k)!} = 0 \\
\Rightarrow & \sum_{k = 0}^{r-1} {r \choose k} b_k = 0 \\
\end{align*}
$$

Equivalently this can be written as

$$
\sum_{k = 0}^r {r+1 \choose k} b_k = 0
$$

for $r \ge 1$.

### Lemma 2

Suppose $f$ is a polynomial of degree $m$. Then

$$
f'(x) = \sum_{k = 0}^m \frac{b_k}{k!} (f^{(k)}(x + 1) - f^{(k)}(x))
$$

#### Proof

The statement is clearly true for constant functions. Now suppose the statement is true for all polynomials of degree $0, 1, \dots, m-1$ and $f$ is a polynomial of degree $m$. Then $f(x) = c x^m + g(x)$ where $g$ is a polynomial of degree less than $m$ and $c$ is a non-zero real number. For $k \le m$ we have $f^{(k)}(x) = c \frac{m!}{(m - k)!} x^{m-k} + g^{(k)}(x)$. By the induction hypothesis we have

$$
g'(x) = \sum_{k = 0}^m \frac{b_k}{k!} (g^{(k)}(x + 1) - g^{(k)}(x))
$$

Therefore we only need to prove that

$$
\begin{align*}
& cmx^{m-1} = \sum_{k = 0}^m \frac{b_k}{k!} (c \frac{m!}{(m - k)!} (x+1)^{m-k} - c \frac{m!}{(m - k)!} x^{m-k}) \\
\iff \, & mx^{m-1} = \sum_{k = 0}^m \frac{b_k}{k!} (\frac{m!}{(m - k)!} (x+1)^{m-k} - \frac{m!}{(m - k)!} x^{m-k}) \\
\iff \, & mx^{m-1} = \sum_{k = 0}^m {m \choose k} b_k \cdot ((x+1)^{m-k} - x^{m-k}) \\
\end{align*}
$$

Note that

$$
\begin{align*}
\sum_{k = 0}^m {m \choose k} b_k \cdot ((x+1)^{m-k} - x^{m-k})
&= \sum_{k = 0}^m {m \choose k} b_k \cdot \left( \sum_{r = 0}^{m-k} {m-k \choose r} x^r - x^{m-k} \right) \\
&= \sum_{k = 0}^{m-1} {m \choose k} b_k \sum_{r = 0}^{m-k-1} {m-k \choose r} x^r \\
&= \sum_{k = 0}^{m-1} \sum_{r = 0}^{m-k-1} {m \choose k} {m-k \choose r} b_k x^r \\
&= \sum_{r = 0}^{m-1} x^r \sum_{k = 0}^{m - r - 1} {m \choose k} {m-k \choose r} b_k \\
&= \sum_{r = 0}^{m-1} x^r \sum_{k = 0}^{m - r - 1} \frac{m!}{k! (m-k)!} \frac{(m-k)!}{r! (m-r-k)!} b_k \\
&= \sum_{r = 0}^{m-1} \frac{x^r}{r!} \cdot \frac{m!}{(m-r)!} \sum_{k = 0}^{m - r - 1} \frac{(m-r)!}{k! (m-r-k)!} b_k \\
&= \sum_{r = 0}^{m-1} x^r {m \choose r} \sum_{k = 0}^{m - r - 1} {m-r \choose k} b_k \\
\end{align*}
$$

Now let's study the coefficients of this expression. If $r = m - 1$ we get

$$
{m \choose r} \sum_{k = 0}^{m - r - 1} {m-r \choose k} b_k = m
$$

If $r \lt m - 1$ then $m - r \gt 1 \Rightarrow m - r \ge 2$. We can now apply Lemma 1 to get

$$
{m \choose r} \sum_{k = 0}^{m - r - 1} {m-r \choose k} b_k = 0
$$

which proves that this expression equals $m x^{m-1}$, finishing the proof of Lemma 2.

## Power Sums

Let $g(x) = \frac{x^{m+1}}{m+1}$. Then by Lemma 2 we have

$$
\begin{align*}
x^m
&= \sum_{k = 0}^m \frac{b_k}{k!} \cdot \frac{1}{m + 1} \cdot \frac{(m + 1)!}{(m + 1 - k)!} ((x + 1)^{m + 1 - k} - x^{m + 1 - k}) \\
&= \frac{1}{m+1}((x+1)^{m+1} - x^{m+1}) + \sum_{k = 1}^m \frac{b_k}{k!} \cdot \frac{1}{m + 1} \cdot \frac{(m + 1)!}{(m + 1 - k)!} ((x + 1)^{m + 1 - k} - x^{m + 1 - k}) \\
&= \frac{1}{m+1}((x+1)^{m+1} - x^{m+1}) + \sum_{k = 1}^m \frac{b_k}{k} {m \choose k-1} ((x + 1)^{m + 1 - k} - x^{m + 1 - k}) \\
\end{align*}
$$

and by adding over $x$ from $1$ to $n$ we get


$$
\begin{align*}
f_m(n)
&= \sum_{x=1}^n x^m \\
&= \sum_{x=1}^n \frac{1}{m+1}((x+1)^{m+1} - x^{m+1}) + \sum_{x=1}^n \sum_{k = 1}^m \frac{b_k}{k} {m \choose k-1} ((x + 1)^{m + 1 - k} - x^{m + 1 - k}) \\
&= \frac{1}{m+1} \sum_{x=1}^n ((x+1)^{m+1} - x^{m+1}) + \sum_{k = 1}^m \frac{b_k}{k} {m \choose k-1} \sum_{x=1}^n ((x + 1)^{m + 1 - k} - x^{m + 1 - k}) \\
&= \frac{1}{m+1} ((n+1)^{m+1} - 1) + \sum_{k = 1}^m \frac{b_k}{k} {m \choose k-1} ((n + 1)^{m + 1 - k} - 1) \\
\end{align*}
$$

## Sums of Power Sums

And by adding over $i$ in $f_m(i)$ from $1$ to $n$ we get

$$
\begin{align*}
S_m(n)
&= \sum_{i = 1}^n \frac{1}{m+1} ((i+1)^{m+1} - 1) + \sum_{i = 1}^n \sum_{k = 1}^m \frac{b_k}{k} {m \choose k-1} ((i + 1)^{m + 1 - k} - 1) \\
&= \frac{1}{m+1} \sum_{i = 1}^n ((i+1)^{m+1} - 1) + \sum_{k = 1}^m \frac{b_k}{k} {m \choose k-1} \sum_{i = 1}^n ((i + 1)^{m + 1 - k} - 1) \\
&= \frac{1}{m+1} (f_{m+1}(n+1) - n - 1) + \sum_{k = 1}^m \frac{b_k}{k} {m \choose k-1} (f_{m+1-k}(n+1) - n - 1) \\
\end{align*}
$$

## Implementation

1. Because the final result of any computation of $S_m(n)$ or $f_m(n)$ will result in an integer we can treat all fraction denominators as inverses modulo $p$. That way, if a Bernoulli number is represented by the fraction $a/b$ we can instead calculate $ab^{-1} \pmod p$ and use that as the Bernoulli number for our calculations.
2. We can cache the values of the inverse mod operation for small inputs (in our case we cache the values all the way up to $m+2$).
3. Because $S_m(n)$ uses $f_{*}(n+1)$ which calculates powers of $(n+2)$, we can cache all the powers modulo $p$ of $(n+2)$ for exponents going from $0$ to $m+2$.