# Fast Polynomial Multiplication

Suppose we have two polynomials $p(x) = p_0 + p_1 x + p_2 x^2 + \dots + p_n x^n$ and $q(x) = q_0 + q_1 x + q_2 x^2 + \dots + q_m x^m$ and we want to find $r(x) = p(x) q(x)$ (Also, suppose $p_i = 0$ and $q_j = 0$ for $i > n, j > m$). The naive approach of distributive multiplication is an $O(nm)$ operation, which is quadratic. Given that $r$ has degree $n + m$, another approach would be evaluating $p$ and $q$ at $n + m + 1$ points, multiplying the values of these evaluations and then interpolating $r$ from these values. But each evaluation of $p$ is $O(n)$ and each evaluation of $q$ is $O(m)$, which again leads to an $O(nm)$ complexity. Similarly, interpolation will have quadratic complexity.

In the next section we will prove formulas for the FFT which is an algorithm for efficiently evaluating a polynomial at all the $k$-th roots of unity. Because the FFT has complexity $O(k \log k)$ we can reduce the complexity of each evaluation to $O((n + m) \log (n + m))$. Finally we will prove formulas for the inverse FFT, which has the same complexity as FFT and allows us to interpolate the polynomial $r$. This innovations leads to a subquadratic algorithm for polynomial multiplication.

## Cooley-Tukey FFT

Fix a value of $k$ such that $k$ is a power of $2$ and let $p(x) = p_0 + p_1 x + p_2 x^2 + \dots + p_{k-1} x^{k-1}$, where the order of $p$ may be smaller than $k-1$. Suppose we want to evaluate $p$ at $w^0, w^1, \dots, w^{k-1}$ where $w = e^{2 \pi i / k}$. Notice that $p$ can be rewritten as

$$
p(x) = (p_0 + p_2 x^2 + \dots) + x (p_1 + p_3 x^2 + \dots)
$$

Then evaluating at $w^j$ gives

$$
p(w^j) = (p_0 + p_2 w^{2j} + \dots) + w^j (p_1 + p_3 w^{2j} + \dots)
$$

But $w^j = -w^{j + k/2}$. Then

$$
\begin{align*}
p(w^{j + k/2})
&= (p_0 + p_2 w^{2j + k} + \dots) + w^{j + k/2} (p_1 + p_3 w^{2j + k} + \dots) \\
&= (p_0 + p_2 w^{2j} + \dots) - w^j (p_1 + p_3 w^{2j} + \dots)
\end{align*}
$$

Which is almost the same expression as the one for $p(w^j)$ save for a sign. Therefore if we can efficiently evaluate

$$
p_0 + p_2 w^{2j} + \dots \\
p_1 + p_3 w^{2j} + \dots \\
$$

for $j = 0, \dots, k/2 - 1$ we are done. Let $k' = k/2, w' = w^2$. Then this is equivalent to the evaluations, with $j = 0, \dots, k' - 1$ of

$$
p_0 + p_2 w'^j + \dots \\
p_1 + p_3 w'^j + \dots \\
$$

Let $p_e(x) = p_0 + p_2 x + p_4 x^2 + \dots$ and $p_o(x) = p_1 + p_3 x + p_5 x^2 + \dots$. Then these evaluations correspond to the FFTs of $p_e$ and $p_o$ respectively of degree $k'$, which instantly motivates a recursive implementation of the FFT. The result for the case $k = 1$ is trivially equal to the input polynomial.

## Cooley-Tukey Inverse FFT (IFFT)

Note that the $FFT$ of a polynomial of order $k$ is equivalent to the following matrix multiplication

$$
\begin{pmatrix}
f_0 \\
f_1 \\
f_2 \\
\vdots \\
\end{pmatrix}
:=
\begin{pmatrix}
1 & 1 & 1 & \dots \\
1 & w & w^2 & \dots \\
1 & w^2 & w^4 & \dots \\
\vdots & \vdots & \vdots & \ddots \\
1 & w^{k-1} & w^{2(k-1)} & \dots \\
\end{pmatrix}

\begin{pmatrix}
p_0 \\
p_1 \\
p_2 \\
\vdots \\
\end{pmatrix}
$$

Where the matrix is of size $k \times k$. Note that this square matrix is invertible with inverse equal to:

$$
\frac{1}{k}
\begin{pmatrix}
1 & 1 & 1 & \dots \\
1 & w^{-1} & w^{-2} & \dots \\
1 & w^{-2} & w^{-4} & \dots \\
\vdots & \vdots & \vdots & \ddots \\
1 & w^{-(k-1)} & w^{-2(k-1)} & \dots \\
\end{pmatrix}
$$

To prove this notice that the fact is trivially true for $k = 1$. Not let $k \gt 1$ and pick the $i$-th row of the original matrix and the $j$-th column of the inverse. Then the dot product of both vectors will be:

$$
\frac{1}{k} \sum_{a=0}^{k-1} w^{ai} \cdot w^{-aj}
= \frac{1}{k} \sum_{a=0}^{k-1} w^{a(i - j)}
$$

If $i = j$ then the exponent of $w$ will always be zero, implying that the dot product is $1$. Otherwise let $d = \gcd(i - j, k)$. If $d = 1$ then there is a bijection between the $k$-th roots of unity and the image of $w^{a(i-j)}$. But

$$
\sum_{a = 0}^{k-1} w^a = \frac{w^k - 1}{w - 1} = 0
$$

If $d > 1$, split the sum into $d$ parts of $k/d$ elements in the order they appear in the sum. Then there is a bijection between the $(k/d)$-th roots of unity and the first $k/d$ elements of the sum, and by the same argument as above that part of the sum is zero. The same logic can be applied to the remaining $d - 1$ parts of the sum to prove that they add up to zero.

Then we can interpolate a polynomial $p$ from the value of its evaluations at the $k$-th roots of unity by performing the following calculations:

$$
\begin{pmatrix}
p_0 \\
p_1 \\
p_2 \\
\vdots \\
\end{pmatrix}
:=
\frac{1}{k}
\begin{pmatrix}
1 & 1 & 1 & \dots \\
1 & w^{-1} & w^{-2} & \dots \\
1 & w^{-2} & w^{-4} & \dots \\
\vdots & \vdots & \vdots & \ddots \\
1 & w^{-(k-1)} & w^{-2(k-1)} & \dots \\
\end{pmatrix}

\begin{pmatrix}
f_0 \\
f_1 \\
f_2 \\
\vdots \\
\end{pmatrix}
$$

From this point on it is very easy to see that the inverse FFT uses very similar formulas to the FFT (and thus has the same complexity). The only changes would be to think of $f_0, f_1, \dots$ as the coefficients of the polynomial $f$, replacing $p$ with it, and setting $w = e^{-2 \pi i/k}$. Finally we multiply the result of this altered FFT by $1/k$.
