# Functional Difference

Define the <i>$(N,M)$-functional inverse of $x^2$</i> to be the monic polynomial $Q(x)$ of degree $N+1$ such that $Q(n^2) \equiv n \pmod M$ for all integers $0 \le n \le N$ and all coefficients are non-negative and smaller than $M$.

For example, the $(2, 7)$-functional inverse of $x^2$ is $x^3 + 3x^2 + 4x$.

Find the coefficient of $x^{10}$ in the $(10^7, 10^9+7)$-functional inverse of $x^2$.

## Solution

For the remainder of this solution assume $0^0 = 1$ by convention.

Let $Q_{N,M}(x)$ be the <i>$(N,M)$-functional inverse of $x^2$</i>. Suppose $Q_{N,M}(x) = x^{N+1} + \sum_{i=0}^N c_i x^i$. Then

$$
\begin{pmatrix}
1 & (0^2)^1 & (0^2)^2 & \cdots & (0^2)^N \\
1 & (1^2)^1 & (1^2)^2 & \cdots & (1^2)^N \\
1 & (2^2)^1 & (2^2)^2 & \cdots & (2^2)^N \\
\vdots & \vdots & \ddots & \vdots \\
1 & (N^2)^1 & (N^2)^2 & \cdots & (N^2)^N \\
\end{pmatrix}

\begin{pmatrix}
c_0 \\
c_1 \\
\vdots \\
c_N
\end{pmatrix}

=

\begin{pmatrix}
0 - (0^2)^{N+1} \\
1 - (1^2)^{N+1} \\
2 - (2^2)^{N+1} \\
\vdots \\
N - (N^2)^{N+1} \\
\end{pmatrix}
$$

So the problem reduces to finding a particular row in the inverse of the left-most matrix and performing a dot product against the right-side vector. This matrix has the shape of a Vandermonde matrix, for which inverses are well studied.

### Vandermonde Matrix Inverse

For a sequence $(y_0, y_1, \dots, y_n)$ of distinct numbers the associated Vandermonde matrix $V(y_0, y_1, \dots, y_n)$ is

$$
V(y_0, y_1, \dots, y_n)

=

\begin{pmatrix}
1 & y_0 & y_0^2 & \cdots & y_0^n \\
1 & y_1 & y_1^2 & \cdots & y_1^n \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1 & y_n & y_n^2 & \cdots & y_n^n \\
\end{pmatrix}
$$

Let $L(y_0, y_1, \dots, y_n)$ be the inverse matrix of $V(y_0, y_1, \dots, y_n)$ and let $L_{i,j}$ be the coefficients of this matrix. Then for fixed $i$, $j$

$$
\sum_{k=0}^n y_i^k L_{k,j} = \delta_{i,j}
$$

Define the following polynomial $F_j(x) = \sum_{k=0}^n x_i^k L_{k,j}$. Then $F_j(y_i) = \delta_{i,j}$ for $0 \le i \le n$. This means we have $n$ evaluations of an $n$-th degree polynomial. By Lagrange interpolation this implies

$$
F_j(x) = \prod_{\substack{0 \le i \le n \\ i \ne j}} \frac{x - y_i}{y_j - y_i}
$$

### Bringing it back

Since $y_j = j^2$ for $1 \le j \le N$ (we don't care about $j = 0$ since all terms in that polynomial will get multiplied by $0 - (0^2)^{N+1} = 0$ anyways and it complicates calculations if we include it), we have

$$
F_j(x) = \prod_{\substack{0 \le i \le N \\ i \ne j}} \frac{x - i^2}{j^2 - i^2}
$$

Which reduces to

$$
\begin{align*}
F_j(x)
&= \frac{(-1)^{N-j}}{j! (N-j)!} \cdot \frac{2j \cdot (j - 1)!}{(N + j)!} \cdot \frac{\prod_{i=0}^N (x - i^2)}{(x - j^2)} \\
&= \frac{2 \cdot (-1)^{N-j}}{(N-j)! \cdot (N + j)!} \cdot \frac{\prod_{i=0}^N (x - i^2)}{(x - j^2)} \\
\end{align*}
$$

Let $u_j = j - (j^2)^{N+1}$ and $v_j = \frac{2 \cdot (-1)^{N-j}}{(N-j)! \cdot (N + j)!}$. Then

$$
\begin{align*}
Q(x)
&= \sum_{j=1}^N u_j F_j(x) \\
&= \prod_{i=0}^N (x - i^2) \cdot \sum_{j=1}^N u_j v_j \cdot \frac{1}{x - j^2} \\
\end{align*}
$$

Note that

$$
\frac{1}{x - j^2}

=
\frac{-1}{j^2} \cdot \frac{1}{1 - x/j^2}

=
- \frac{1}{j^2} \sum_{k=0}^\infty \left( \frac{x}{j^2} \right)^k
$$

Therefore


$$
\begin{align*}
Q(x)
&= \sum_{j=1}^N u_j F_j(x) \\
&= - \prod_{i=0}^N (x - i^2) \sum_{j=1}^N u_j v_j \cdot \frac{1}{j^2} \sum_{k=0}^\infty \left( \frac{x}{j^2} \right)^k \\
&= - \prod_{i=0}^N (x - i^2) \cdot \sum_{j=1}^N u_j v_j \sum_{k=0}^\infty x^k \cdot \frac{1}{(j^2)^{k+1}} \\
\end{align*}
$$

And calculating the $W$-th coefficient of this polynomial can now be done in $O(NW)$ time.

### Algorithm

Assume $M$ is prime. Then $\mathbb{Z}_M$ is a field and every non-zero element has an inverse. Suppose we want to calculate the coefficient of $x$ to the $W$-th power. 

Calculate $\prod_{i=0}^N (x - i^2)$ modulo $x^{W+1}$ and $\sum_{k=0}^W x^k \sum_{j=1}^N u_j \cdot v_j \cdot \frac{1}{(j^2)^{k+1}}$. Multiply both together (modulo $x^{W+1}$) and multiply by $-1$ to get the coefficient of $x^W$.

## Appendix

### Theorem A

If $n$ is prime then $\mathbb{Z}_n^{\times}$ is cyclic.

#### Proof

Let $d_1, \dots, d_{n-1}$ be all the possible orders of the elements of $\mathbb{Z}_n^{\times}$. Let $e = \text{lcm}(d_1, \dots, d_r)$. Then all $n - 1$ elements satisfy $x^e \equiv 1 \pmod n$. But since this is a field, for this polynomial to have $n - 1$ distinct roots, $e \ge n-1$. But $e \mid n-1$. Thus $e = n-1$.

We just need to prove now that there is an element of order $e$. Note that $e$ decomposes into $\prod_i p_i^{e_i}$. So for each $p_i^{e_i}$, there is an element whose order is a multiple of $p_i^{e_i}$. Suppose this element is $y$ and it has order $p_i^{e_i} t$. Then $y^t$ has order $p_i^{e_i}$. So for each term in the decomposition of $e$, we can find an element that has that order.

Finally we need to prove that if $a$ has order $s$, $b$ has order $t$ and $\gcd(s, t) = 1$, then $ab$ has order $st$. Note that $(ab)^{st} \equiv 1 \pmod{n}$. Suppose $h$ is the order of $ab$. Then $h \mid st$ and $1 \equiv (ab)^{ht} \equiv a^{ht} b^{ht} \equiv a^{ht} \pmod{n}$. Thus $s \mid ht \Rightarrow s \mid h$. By a similar argument $t \mid h$. Therefore $h = st$.
