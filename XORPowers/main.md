# XOR-Powers

We use $x\oplus y$ to be the bitwise XOR of $x$ and $y$.

Define the <i>XOR-product</i> of $x$ and $y$, denoted by $x \otimes y$, similar to a long multiplication in base $2$, except that the intermediate results are XORed instead of the usual integer addition.

For example, $11 \otimes 11 = 69$, or in base $2$, $1011_2 \otimes 1011_2 = 1000101_2$:
$$
\begin{align*}
\phantom{\otimes 1111} 1011_2 \\
\otimes \phantom{1111} 1011_2 \\
\hline
\phantom{\otimes 1111} 1011_2 \\
\phantom{\otimes 111} 1011_2 \phantom{9} \\
\oplus \phantom{1} 1011_2  \phantom{999} \\
\hline
\phantom{\otimes 11} 1000101_2 \\
\end{align*}
$$
Further we define $P(n) = 11^{\otimes n} = \overbrace{11\otimes 11\otimes \ldots \otimes 11}^n$. For example $P(2)=69$.

Find $P(8^{12}\cdot 12^8)$. Give your answer modulo $10^9+7$.

## Solution

Let $b_k \dots b_0$ be the binary representation of $n$. Then $f_n(x) = \sum_{i = 0}^k b_i x^i$ and $f_n(2) = n$. Suppose the coefficients of $f_n$ are in $\mathbb{Z}_2$. Then it is not hard to prove that $f_a(x) \cdot f_b(x) = f_{a \otimes b}(x)$. Note that $P(n)$ can be computed from $f_{11^{\otimes n}}(x)$, so let's try to find some information about that polynomial. Firstly, $f_{11}(x) = 1 + x + x^3$. By the multiplication property we also know that $f_{11^{\otimes n}}(x) = (1 + x + x^3)^n$. Exponentiation by squaring allows us to efficiently calculate the desired polynomial, so let's derive a fact about $f_{11^{\otimes 2^k}}(x)$.

### Lemma 1

For any non-negative integer $k$ we have:

$$
f_{11^{\otimes 2^k}}(x) = 1 + x^{2^k} + x^{3 \cdot 2^k}
$$

### Proof

This is clearly true for $k = 0$. Now suppose the statement is true for $k - 1$. Then

$$
\begin{align*}
f_{11^{\otimes 2^k}}(x)
&= (1 + x + x^3)^{2^k} \\
&= \left((1 + x + x^3)^{2^{k-1}}\right)^2 \\
&= \left(1 + x^{2^{k-1}} + x^{3 \cdot 2^{k-1}}\right)^2 \\
&= 1 + x^{2^{k-1}} + x^{3 \cdot 2^{k-1}} + (x^{2^{k-1}} + x^{2^k} + x^{2^{k+1}}) + (x^{3 \cdot 2^{k-1}} + x^{2^{k+1}} + x^{3 \cdot 2^{k}}) \\
&= 1 + x^{2^k} + x^{3 \cdot 2^{k}} \\
\end{align*}
$$

---

Note that we are interested in $n = 8^{12} \times 12^8 = 2^{52} \times 3^8$. Therefore

$$
\begin{align*}
f_{11^{\otimes n}}(x)
&= (1 + x + x^3)^{2^{52} \times 3^8} \\
&= ((1 + x + x^3)^{2^{52}})^{3^8} \\
\end{align*}
$$

And exponentiation by squaring (taking into account the extra $2^{52}$) can efficienly calculate the polynomial. $P(n)$ is then equal to the evaluation of the polynomial at $2$, but considering the coefficients to be in $\mathbb{Z}_p$ instead of $\mathbb{Z}_2$.