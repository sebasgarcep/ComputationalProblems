# Pseudorandom Sequence

<b>Rand48</b> is a pseudorandom number generator used by some programming languages. It generates a sequence from any given integer $a_0$ using the rule $a_n = (25214903917 \cdot a_{n - 1} + 11) \bmod 2^{48}$.

Let $b_n = \lfloor a_n / 2^{16} \rfloor \bmod 52$.
The sequence $b_0, b_1, \dots$ is translated to an infinite string $c = c_0c_1\dots$ via the rule:<br />
$0 \rightarrow$ a, $1\rightarrow$ b, $\dots$, $25 \rightarrow$ z, $26 \rightarrow$ A, $27 \rightarrow$ B, $\dots$, $51 \rightarrow$ Z.

For example, if we choose $a_0 = 123456$, then the string $c$ starts with: "bQYicNGCY $\dots$".<br />
Moreover, starting from index $100$, we encounter the substring "RxqLBfWzv" for the first time.

Alternatively, if $c$ starts with "EULERcats $\dots$", then $a_0$ must be $78580612777175$.

Now suppose that the string $c$ starts with "PuzzleOne $\dots$".<br />
Find the starting index of the first occurrence of the substring "LuckyText" in $c$.

## Solution

Note that $a_n \in [0, 2^{48} - 1]$ for all $n \gt 1$ by the recurrence relation. Note also that if $a_0$ is any value satisfying $a_0 \equiv k \pmod {2^{48}}$ where $k$ is fixed, then the resulting sequence $(a_n)_{n \in \mathbb{N}_0}$ will be equal for any choice of $a_0$. Therefore let's assume that $a_0 \in [0, 2^{48} - 1]$ as well.

On another note, $b_n = \lfloor a_n / 2^{16} \rfloor \bmod 52 \Rightarrow b_n = \lfloor a_n / 2^{16} \rfloor \bmod 4$, which tells us that we can use $b_n \pmod 4$ to compute the 17th and 18th bits of $a_n$. One strategy we can use to reduce the search space for $a_0$ is to consider the recurrence relation of $a_n$ modulo $2^{18}$. We can go through all possible initial values for $a_0$ modulo $2^{18}$ and for each initial value generate as many elements of the sequence as we have $b_n$'s. If this sequence matches the values of $b_n$ modulo $4$ then this 18-bit $a_0$ serves as a starting point for the full search.

Note that we can narrow down the remaining search space. Suppose $a_0 = c_0 + 2^{18} \cdot d_0$ is a 48-bit candidate initial value for the sequence. Then $b_0 \equiv 4d_0 + \left\lfloor c_0 / 2^{16} \right\rfloor \pmod {52}$. Then $(b_0 - \left\lfloor c_0 / 2^{16} \right\rfloor) / 4 \equiv d_0 \pmod {13}$. Now all we are left to do is try all $a_0$ in the remaining search space until we find one that works.

Note that we can apply the same procedure to the text we are searching for to obtain $a_n$, i.e. the value of the sequence at the $n$-th index (the one we are looking for). Then $a_n = \text{Rand48}^{(n)}(a_0)$. Let $A = 25214903917, B = 11$. Then

$$
\text{Rand48}^{(n)}(a_0) \equiv A^n a_0 + B \sum_{k = 0}^{n-1} A^k \pmod {2^{48}}
$$

Furthermore we have

$$
(A-1) \sum_{k = 0}^{n-1} A^k = A^n - 1 \\
$$

which allows us to show that

$$
\begin{align*}
(A-1) A^n a_0 + B (A-1) \sum_{k = 0}^{n-1} A^k
&= (A-1) A^n a_0 + B (A^n - 1) \\
&= ((A-1) a_0 + B) A^n - B \\
\end{align*}
$$

Therefore

$$
(A - 1) a_n \equiv ((A-1) a_0 + B) A^n - B \pmod {2^{48}} \\
\Rightarrow (A - 1) a_n + B \equiv ((A-1) a_0 + B) A^n \pmod {2^{48}} \\
$$

Let $C := (A-1) a_0 + B, D := (A - 1) a_n + B$. Then we have $CA^n \equiv D \pmod {2^{48}}$. Because $B$ is odd but $A-1$ isn't, $C, D$ must be odd which implies that they belong to the multiplicative group of the modulus. Let $E := C^{-1} D \pmod {2^{48}}$. Then $A^n \equiv E \pmod {2^{48}}$.

## Solving the Discrete Logarithm problem modulo $2^m$ where $m \ge 3$

Suppose $m \ge 3$. Let $\alpha: \mathbb{Z}_{2^m}^* \rightarrow S := \{\pm1\}$ where $x \equiv 1 \pmod 4$ gets mapped to the plus sign and $x \equiv 3 \equiv -1 \pmod 4$ gets mapped to the negative sign. Let $\beta: \mathbb{Z}_{2^m}^* \rightarrow U := \{x : x \equiv 1 \pmod 4\}$ where $x \equiv 1 \pmod 4$ gets mapped to $x$ and $x \equiv 3 \equiv -1 \pmod 4$ gets mapped to $-x$. Now consider a function $\lambda: U \rightarrow \mathbb{Z}_{2^{m-2}}$ given by

$$
\lambda(x) = \left( \frac{x^{2^{m-1}} - 1}{2^{m+1}} \right) \pmod {2^{m-2}}
$$

Now we shall prove that $\lambda$ is an isomorphism. First let's show that it is a homomorphism. On one hand $\lambda(1) = 0$. On the other hand, consider the identity $ab - 1 = (a-1) + (b-1) + (a-1)(b-1)$. Let $x, y \in U$. Then $x^{2^{m-1}} - 1, y^{2^{m-1}} - 1 \equiv 0 \pmod {2^{m+1}}$. But this implies

$$
\begin{align*}
\lambda(xy)
&\equiv \left( \frac{(xy)^{2^{m-1}} - 1}{2^{m+1}} \right) \pmod {2^{m-2}} \\
&\equiv \left( \frac{x^{2^{m-1}} - 1}{2^{m+1}} \right) + \left( \frac{y^{2^{m-1}} - 1}{2^{m+1}} \right) + \left( \frac{(x^{2^{m-1}} - 1) (y^{2^{m-1}} - 1)}{2^{m+1}} \right) \pmod {2^{m-2}} \\
&\equiv \lambda(x) + \lambda(y) + \left( \frac{(x^{2^{m-1}} - 1) (y^{2^{m-1}} - 1)}{2^{m+1}} \right) \pmod {2^{m-2}} \\
\end{align*}
$$

Therefore the last product is divisible by $2^{2m+2}$ and after division by $2^{m+1}$ we are left with a factor of $2^{m+1}$ which is divisible by $2^{m-2}$. Therefore this last term cancels, giving us the homomorphism property.

Let's show that $\lambda$ is injective. First note that if $x = 4k+1$ for some integer $k$ then $x^{2^{m-1}} = (4k+1)^{2^{m-1}} = 1 + {2^{m-1} \choose 1} 4k + \cdots = 1 + 2^{m+1}k + \dots$, where every remaining term is divisible by $2^{2m-1}$ whenever $m \ge 3$. This implies that for $2^{2m-1}$ to divide $x^{2^{m-1}} - 1$, $k$ has to be a multiple of $2^{m-2}$. Therefore $x \equiv 1 \pmod {2^m}$ or in other words $\lambda(x) = 0 \Rightarrow x \equiv 1 \pmod {2^m}$. This implies that

$$
\lambda(x) - \lambda(y) \equiv 0 \pmod {2^{m-2}} \\
\Rightarrow \lambda(xy^{-1}) \equiv 0 \pmod {2^{m-2}} \\
\Rightarrow xy^{-1} \equiv 1 \pmod {2^m} \\
\Rightarrow x \equiv y \pmod {2^m}
$$

and therefore $\lambda$ is injective. Because $\lambda$ is a function between finite sets of the same cardinality, and it is injective, it must be bijective, which shows $\lambda$ is an isomorphism. Furthermore, $\lambda$ can be computed efficiently by calculating the numerator modulo $2^{2m-1}$.

Let $\theta = \lambda \circ \beta$. Because both $\beta$ and $\lambda$ are homomorphisms, then $\theta$ is as well. In particular, it is a homomorphism from $\mathbb{Z}_{2^m}^*$ where the operation is multiplication, to $\mathbb{Z}_{2^{m-2}}$ where the operation is addition. Therefore

$$
\theta(A^n) \equiv \theta(E) \pmod{2^{m-2}} \\
\Rightarrow \theta(A \cdots A) \equiv \theta(E) \pmod{2^{m-2}} \\
\Rightarrow \theta(A) + \cdots + \theta(A) \equiv \theta(E) \pmod{2^{m-2}} \\
\Rightarrow n \theta(A) \equiv \theta(E) \pmod{2^{m-2}} \\
$$

This will give $n \equiv n_1 \pmod {2^{m'}}$ where $m' \le m - 2$. Because $\varphi(2^m) = 2^{m-1}$ we want to find $n$ modulo $2^{m-1}$ which can now be done through simple trial and error of $n \equiv n_1 + 2^{m'} k \pmod {2^{m-1}}$.

## References
- https://www2.eecs.berkeley.edu/Pubs/TechRpts/1984/CSD-84-186.pdf