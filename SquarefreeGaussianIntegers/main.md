# Squarefree Gaussian Integers

A <b>Gaussian integer</b> is a number <var>z</var> = <var>a</var> + <var>b</var>i where <var>a</var>, <var>b</var> are integers and i<sup>2</sup> = -1.<br />
Gaussian integers are a subset of the complex numbers, and the integers are the subset of Gaussian integers for which <var>b</var> = 0.

A Gaussian integer <b>unit</b> is one for which <var>a</var><sup>2</sup> + <var>b</var><sup>2</sup> = 1, i.e. one of 1, i, -1, -i.<br />
Let's define a <i>proper</i> Gaussian integer as one for which <var>a</var> &gt; 0 and <var>b</var> ≥ 0.

A Gaussian integer z<sub>1</sub> = a<sub>1</sub> + <var>b</var><sub>1</sub>i is said to be divisible by <var>z</var><sub>2</sub> = a<sub>2</sub> + <var>b</var><sub>2</sub>i if <var>z</var><sub>3</sub> = <var>a</var><sub>3</sub> + <var>b</var><sub>3</sub>i = <var>z</var><sub>1</sub>/<var>z</var><sub>2</sub> is a Gaussian integer.<br />
$\frac {z_1} {z_2} = \frac {a_1 + b_1 i} {a_2 + b_2 i} = \frac {(a_1 + b_1 i)(a_2 - b_2 i)} {(a_2 + b_2 i)(a_2 - b_2 i)} = \frac {a_1 a_2 + b_1 b_2} {a_2^2 + b_2^2} + \frac  {a_2 b_1 - a_1 b_2}  {a_2^2 + b_2^2}i = a_3 + b_3 i$<br />
So, <var>z</var><sub>1</sub> is divisible by <var>z</var><sub>2</sub> if $\frac {a_1 a_2 + b_1 b_2} {a_2^2 + b_2^2}$ and $\frac  {a_2 b_1 - a_1 b_2}  {a_2^2 + b_2^2}$ are integers.<br />
For example, 2 is divisible by 1 + i because 2/(1 + i) = 1 - i is a Gaussian integer.

A <b>Gaussian prime</b> is a Gaussian integer that is divisible only by a unit, itself or itself times a unit.<br />
For example, 1 + 2i is a Gaussian prime, because it is only divisible by 1, i, -1, -i, 1 + 2i, i(1 + 2i) = i - 2, -(1 + 2i) = -1 - 2i and -i(1 + 2i) = 2 - i.<br />
2 is not a Gaussian prime as it is divisible by 1 + i.

A Gaussian integer can be uniquely factored as the product of a unit and proper Gaussian primes.<br />
For example 2 = -i(1 + i)<sup>2</sup> and 1 + 3i = (1 + i)(2 + i).<br />
A Gaussian integer is said to be squarefree if its prime factorization does not contain repeated proper Gaussian primes.<br />
So 2 is not squarefree over the Gaussian integers, but 1 + 3i is.<br />
Units and Gaussian primes are squarefree by definition.

Let <var>f</var>(<var>n</var>) be the count of proper squarefree Gaussian integers with <var>a</var><sup>2</sup> + <var>b</var><sup>2</sup> ≤ n.<br />
For example <var>f</var>(10) = 7 because 1, 1 + i, 1 + 2i, 1 + 3i = (1 + i)(2 + i), 2 + i, 3 and 3 + i = -i(1 + i)(1 + 2i) are squarefree, while 2 = -i(1 + i)<sup>2</sup> and 2 + 2i = -i(1 + i)<sup>3</sup> are not.<br />
You are given <var>f</var>(10<sup>2</sup>) = 54, <var>f</var>(10<sup>4</sup>) = 5218 and <var>f</var>(10<sup>8</sup>) = 52126906.

Find <var>f</var>(10<sup>14</sup>).

## Solution

## Gauss Circle Problem

Let

$$
G(N) = \sum_{|z|^2 \leq N} 1
$$

Then

$$
\begin{align*}
G(N)
&= \sum_{|z|^2 \leq N} 1 \\
&= 1 + \sum_{1 \leq |z|^2 \leq N} 1 \\
&= 1 + \sum_{n = 1}^N \sum_{|z|^2 = n} 1 \\
&= 1 + \sum_{n = 1}^N \sum_{x^2 + y^2 = n} 1 \\
&= 1 + \sum_{n = 1}^N r_2(n) \\
\end{align*}
$$

where $r_2(n)$ is the number of ways to write $n$ as a sum of two squares. We already know from Hallway of Square Steps that if $n$ factorizes as

$$
n = 2^{v_0} \prod_k p_k^{v_k} \prod_j q_j^{2w_j}
$$

then

$$
r_2(n) = 4 \prod_k (v_k + 1)
$$

otherwise $r_2(n) = 0$. Now let's prove that for all $n$, $r_2(n) = 4(d_1(n) - d_3(n))$ where $d_1(n)$ is the number of divisors of $n$ congruent to $1$ modulo $4$, and $d_3(n)$ is the number of divisors of $n$ congruent to $3$ modulo $4$.

First suppose that $n$ fails to factorize as above. Then $n/2^{v_0}$ is not a square number and for each divisor $d$ of $n/2^{v_0}$, there is a distinct divisor $n/d2^{v_0}$ of $n/2^{v_0}$. But $n/2^{v_0}$ is congruent to $3$ modulo $4$, therefore either $d$ or $n/d2^{v_0}$ is congruent to $1$ modulo $4$ and the other is congruent to $3$. But this implies a bijection between divisors of $n$ congruent to $1$ modulo $4$ and divisors of $n$ congruent to $3$ modulo $4$. Thus $d_1(n) - d_3(n) = 0 \Rightarrow r_2(n) = 4 (d_1(n) - d_3(n)) = 0$.

Now suppose $n$ factorizes as above. Then $r_2(n) = 4 \prod_k (v_k + 1)$

$$
d_1(n) = d_1(n / 2^{v_0}) \\
d_3(n) = d_3(n / 2^{v_0}) \\
$$

Therefore

$$
\begin{align*}
d_1(n) - d_3(n)
&= d_1(n / 2^{v_0}) - d_3(n / 2^{v_0}) \\
&= \sum_{\substack{d \mid n / 2^{v_0} \\ d \equiv 1 \pmod 4}} 1 - \sum_{\substack{d \mid n / 2^{v_0} \\ d \equiv 3 \pmod 4}} 1 \\
&= \sum_{\substack{d \mid \prod_k p_k^{v_k} \prod_j q_j^{2w_j} \\ d \equiv 1 \pmod 4}} 1 - \sum_{\substack{d \mid \prod_k p_k^{v_k} \prod_j q_j^{2w_j} \\ d \equiv 3 \pmod 4}} 1 \\
&= \sum_{d \mid \prod_k p_k^{v_k}} 1 \cdot [ \sum_{\substack{d \mid \prod_j q_j^{2w_j} \\ d \equiv 1 \pmod 4}} 1 - \sum_{\substack{d \mid \prod_j q_j^{2w_j} \\ d \equiv 3 \pmod 4}} 1 ] \\
&= \prod_k (v_k + 1) \cdot [ \sum_{\substack{d \mid \prod_j q_j^{2w_j} \\ d \equiv 1 \pmod 4}} 1 - \sum_{\substack{d \mid \prod_j q_j^{2w_j} \\ d \equiv 3 \pmod 4}} 1 ] \\
&= \frac{r_2(n)}{4} \cdot [ \sum_{\substack{d \mid \prod_j q_j^{2w_j} \\ d \equiv 1 \pmod 4}} 1 - \sum_{\substack{d \mid \prod_j q_j^{2w_j} \\ d \equiv 3 \pmod 4}} 1 ] \\
\end{align*}
$$

Thus we only need to prove that the right hand side of the product is identically $1$ to prove the identity. Suppose there is only one prime $q_j$ in the factorization of $n$. Then the divisors of $q_j^{2w_j}$ that are congruent to $1$ modulo $4$ are $q_j^0, q_j^{2}, \dots, q_j^{2v_j}$. Therefore there are $v_j + 1$ divisors congruent to $1$ modulo $4$, and because $q_j^{2w_j}$ has $2v_j + 1$ divisors, there are $v_j$ divisors congruent to $3$ modulo $4$. Thus the difference $v_j + 1 - v_j = 1$ is identically $1$. Now suppose there are $k > 1$ primes $q_j$ in the factorization of $n$. If there are $m + 1$ divisors congruent to $1$ modulo $4$ of the first $k - 1$ primes then by induction we can assume that there are $m$ divisors congruent to $3$ modulo $4$ of the first $k - 1$ primes. Suppose the $k$-th prime is $q_j$. Then there are $v_j + 1$ divisors of $q_j^{2v_j}$ congruent to $1$ modulo $4$ and $v_j$ divisors congruent to $3$ modulo $4$. Thus, the number of divisors congruent to $1$ modulo $4$ after combining both parts are

$$
(m + 1) (v_j + 1) + m v_j
$$

On the other hand the number of divisors congruent to $3$ modulo $4$ after combining both parts are

$$
(m + 1) v_j + m (v_j + 1)
$$

And the difference between both is

$$
(m + 1) (v_j + 1) + m v_j - (m + 1) v_j - m (v_j + 1) = 1
$$

Therefore

$$
\sum_{\substack{d \mid \prod_j q_j^{2w_j} \\ d \equiv 1 \pmod 4}} 1 - \sum_{\substack{d \mid \prod_j q_j^{2w_j} \\ d \equiv 3 \pmod 4}} 1 = 1
$$

which proves that $r_2(n) = 4(d_1(n) - d_3(n))$. Applying this to $G(N)$ we get

$$
\begin{align*}
G(N)
&= 1 + \sum_{n = 1}^N r_2(n) \\
&= 1 + \sum_{n = 1}^N 4(d_1(n) - d_3(n)) \\
&= 1 + 4 [ \sum_{n = 1}^N d_1(n) - \sum_{n = 1}^N d_3(n) ] \\
&= 1 + 4 [ \sum_{n = 1}^N \sum_{\substack{d \mid n \\ d \equiv 1 \pmod 4}} 1 - \sum_{n = 1}^N \sum_{\substack{d \mid n \\ d \equiv 3 \pmod 4}} 1 ] \\
&= 1 + 4 [ \sum_{\substack{1 \leq d \leq N \\ d \equiv 1 \pmod 4}} \sum_{n = 1}^{N / d} 1 - \sum_{\substack{1 \leq d \leq N \\ d \equiv 3 \pmod 4}} \sum_{n = 1}^{N / d} 1 ] \\
&= 1 + 4 [ \sum_{\substack{1 \leq d \leq N \\ d \equiv 1 \pmod 4}} \lfloor N / d \rfloor - \sum_{\substack{1 \leq d \leq N \\ d \equiv 3 \pmod 4}} \lfloor N / d \rfloor ] \\
&= 1 + 4 [ \sum_{i \geq 0} \lfloor N / (4i + 1) \rfloor - \sum_{i \geq 0} \lfloor N / (4i + 3) \rfloor ] \\
\end{align*}
$$

## Proper Gaussian Integers

The proper Gaussian integers are the ones in the first quadrant, excluding the $a$-axis and the origin. Therefore the formula to count the proper Gaussian integers 

$$
C(N) = (G(N) - 1) / 4 = \sum_{i \geq 0} \lfloor N / (4i + 1) \rfloor - \sum_{i \geq 0} \lfloor N / (4i + 3) \rfloor
$$

and $C(N)$ can be computed in $O(N^{1/2})$ time by using the trick of splitting the sum along $\sqrt{N}$.

## Squarefree Gaussian Integers

From the inclusion-exclusion principle, the formula for calculating $f(N)$ is

$$
\begin{align*}
f(N)
&= \frac{1}{4} \sum_{z \in \mathbb{Z}[i] \setminus \{ 0 \}} \mu(z) \sum_{\substack{|x z^2|^2 \leq N \\ x \not = 0}} 1 \\
&= \frac{1}{4} \sum_{z \in \mathbb{Z}[i] \setminus \{ 0 \}} \mu(z) \sum_{\substack{|x|^2 \leq N / |z|^4 \\ x \not= 0}} 1 \\
&= \frac{1}{4} \sum_{z \in \mathbb{Z}[i] \setminus \{ 0 \}} \mu(z) \cdot [ G(N / |z|^4) - 1 ] \\
&= \sum_{1 \leq |z|^4 \leq N} \mu(z) \cdot C(N / |z|^4) \\
\end{align*}
$$

where the $\frac{1}{4}$ comes from the fact that we are counting only the proper Gaussian integers and $\mu$ gives the sign of the term in the inclusion-exclusion formula. If $z$ is not-squarefree then $\mu(z) = 0$. Otherwise if $z$ is divisible by an odd number of Gaussian primes, then $\mu(z) = -1$. On the other hand if $z$ is divisible by an even number of Gaussian primes, then $\mu(z) = 1$.

All we are missing is an efficient way of generating the $z$. Factorize all numbers up to $\sqrt{N}$. Notice that $|z|^2$ will be an integer in this range. Therefore we can use each factorization to generate the $z$. Suppose a number $n$ factorizes as

$$
n = 2^{e_2} \cdot \prod_{\substack{p \mid n \\ p \equiv 1 \pmod 4}} p^{e_p} \cdot \prod_{\substack{q \mid n \\ q \equiv 3 \pmod 4}} q^{e_q}
$$

Suppose $|z|^2 = n$. Because $q \equiv 3 \pmod 4$ is a Gaussian prime, then $e_q$ must be even. Therefore if $e_q$ is odd for $n$, no $z$ can be generated from it. Moreover, if $e_q$ is an even larger than $2$, then $z$ has two copies of $q$, and $\mu(z) = 0$, and we can ignore these as they do not contribute to the sum. Because $2^{e_2} = |1+i|^{2 e_2}$ then $e_2 \leq 1$, otherwise $\mu(z) = 0$. Finally, $p \equiv 1 \pmod 4$ splits into two distinct Gaussian primes. Therefore $e_p \leq 2$. If $e_p = 1$ we can pick either of the two primes that $p$ splits into. If $e_p = 2$ we have to pick both, and there is only one way to do so. If $e_p > 2$, then either of the two primes must appear more than once in the factorization of $z$ and $\mu(z) = 0$. Therefore, if $\mu(z) \not= 0$, the number of $z$ that can be generated from $n$ is $2^k$, where $k$ is the number of primes $p \equiv 1 \pmod 4$ that appear once in the factorization of $n$.