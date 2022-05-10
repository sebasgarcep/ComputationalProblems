# CyclogenicPolynomials

A <b>monic polynomial</b> is a single-variable polynomial in which the coefficient of highest degree is equal to 1.

Define $\mathcal{F}$ to be the set of all monic polynomials with integer coefficients (including the constant polynomial $p(x)=1$). A polynomial $p(x)\in\mathcal{F}$ is <i>cyclogenic</i> if there exists $q(x)\in\mathcal{F}$ and a positive integer $n$ such that $p(x)q(x)=x^n-1$. If $n$ is the smallest such positive integer then $p(x)$ is $n$<i>-cyclogenic</i>.

Define $P_n(x)$ to be the sum of all $n$-cyclogenic polynomials. For example, there exist ten 6-cyclogenic polynomials (which divide $x^6-1$ and no smaller $x^k-1$):
$$\begin{align*}
 & x^6-1 &  & x^4+x^3-x-1 &  & x^3+2x^2+2x+1 &  & x^2-x+1\\
 & x^5+x^4+x^3+x^2+x+1 &  & x^4-x^3+x-1 &  & x^3-2x^2+2x-1\\
 & x^5-x^4+x^3-x^2+x-1 &  & x^4+x^2+1 &  & x^3+1\end{align*}$$
giving
$$P_6(x)=x^6+2x^5+3x^4+5x^3+2x^2+5x$$
Also define
$$Q_N(x)=\sum_{n=1}^N P_n(x)$$
It's given that
$Q_{10}(x)=x^{10}+3x^9+3x^8+7x^7+8x^6+14x^5+11x^4+18x^3+12x^2+23x$ and $Q_{10}(2) = 5598$.

Find $Q_{10^7}(2)$. Give your answer modulo $1\,000\,000\,007$.

## Solution

Notice that

$$
\begin{align*}
x^n - 1
&= \prod_{k = 1}^n (x - e^{2 \pi k / n}) \\
&= \prod_{d \mid n} \prod_{\substack{1 \le k \le n \\ \gcd(k, n) = d}} (x - e^{2 \pi k / n}) \\
&= \prod_{d \mid n} \prod_{\substack{1 \le k \le n/d \\ \gcd(k, n) = 1}} (x - e^{2 \pi k / (n / d)}) \\
&= \prod_{d \mid n} \Phi_{\frac{n}{d}}(x) \\
&= \prod_{d \mid n} \Phi_d(x) \\
\end{align*}
$$

where $\Phi_d(x)$ is the $d$-th cyclotomic polynomial. Now let's prove a few facts about cyclotomic polynomials:

### Lemma 1

Cyclotomic polynomials are monic.

### Proof

Trivially true.

### Lemma 2

Cyclotomic polynomials have integer coefficients.

### Proof

Clearly $\Phi_1(x) = x - 1$ has integer coefficients. Now assume that the result is true for $\Phi_1(x), \dots, \Phi_{n-1}(x)$. But $x^n - 1 = \prod_{d \mid n} \Phi_d(x) = \Phi_n(x) \prod_{d \mid n, \, d < n} \Phi_d(x)$. Let $f_n(x) = \prod_{d \mid n, \, d < n} \Phi_d(x)$. Clearly $f_n(x) \in \mathbb{Z}[x]$. Then $x^n - 1 = \Phi_n(x) f_n(x)$. Suppose

$$
f_n(x) = \sum_i a_i x^i \\
\Phi_n(x) = \sum_j b_j x^j \\
$$

where $a_i \in \mathbb{Z}$. We already know that $\Phi_n(x)$ is monic, i.e. its leading coefficient is $1$. Now note that the absolute value of the roots of $f_n(x)$ is $1$. Therefore the constant coefficient of $f_n(x)$, which is the product of its roots, must have absolute value $1$. But the constant coefficient is an integer. Therefore it must be $\pm 1$. This implies that the constant coefficient of $\Phi_n(x)$ is $\pm 1$. Finally, notice that the $k$-th coefficient of the product of these two polynomials satisfies $\sum_{i + j = k} a_j b_j = 0$ if $k$ does not correspond to the leading or constant coefficients. Therefore $a_0 b_k = \sum_{i = 0}^{k - 1} a_i b_{k-i} \Rightarrow b_k = \pm \sum_{i = 0}^{k - 1} a_i b_{k-i}$ and we can use induction on $k$ to prove that $b_k$ is an integer.

### Lemma 3

Cyclotomic polynomials are irreducible.

### Proof

FIXME: DO THIS AT SOME POINT.

---

With these few facts we can see that divisors of $x^n - 1$ are a product of cyclotomic polynomials with index that divides $n$. Suppose a polynomial $p(x) = \prod_d \Phi_d(x)$ where all the $d$ in the index of the product divide $n$ and let $m$ be the least common multiple of these indexes. Then $p(x)$ belongs to the sum of $P_m(x)$. Furthermore, $p(x)$ is a term in the product $\prod_{d \mid n} (1 + \Phi_d(x))$. Because $m \mid n$ the following equation must hold

$$
\prod_{d \mid n} (1 + \Phi_d(x)) = \sum_{d \mid n} P_d(x)
$$

Which allows us to compute $P_n(2)$ in an inductive fashion if we know the values of $\Phi_n(2)$. Similarly, $\Phi_n(2)$ can be computed in an inductive fashion using the identity

$$
x^n - 1 = \prod_{d \mid n} \Phi_d(x)
$$