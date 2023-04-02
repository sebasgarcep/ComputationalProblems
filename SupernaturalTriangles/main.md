# Supernatural Triangles

A <strong>Pythagorean triangle</strong> is called <dfn>supernatural</dfn> if two of its three sides are consecutive<span style="white-space:nowrap;"> 
 integers.</span>

Let $S(N)$ be the sum of the perimeters of all distinct supernatural triangles with perimeters less than or equal to $N$.
For example, $S(100) = 258$ and $S(10000) = 172004$.

Find $S(10^{10^{10}})$. Give your answer modulo $1234567891$.

## Solution

There are three possible cases:

### Case 1: $a + (a+1)^2 = b^2$

Let's rewrite this equation as:

$$
(2a+1)^2 - 2b^2 = -1
$$

Let $x = 2a+1, y = b$. Then the equation becomes $x^2 - 2y^2 = -1$. Let $\beta = 1 + \sqrt{2}$, and let $\epsilon = 3 + 2\sqrt{2}$ be the fundamental unit. Now we will prove all solutions to this equation can be obtained from the coefficients of $\beta \epsilon^k$. We know all solutions to $x^2 - 2y^2 = 1$ can be obtained from the coefficients of $\epsilon^k$ by the Theory of Pell's equation. Therefore the coefficients of $\beta \epsilon^k$ always give solutions to $x^2 - 2y^2 = -1$. Suppose the coefficients of $\alpha$ are both positive and a solution to $x^2 - 2y^2 = -1$ but $\alpha \not= \beta \epsilon^k$ for some integer $k$. Then there is a non-negative integer $k$ such that $\beta \epsilon^k < \alpha < \beta\epsilon^{k+1} \Rightarrow 1 < \alpha (\beta \epsilon^k)^{-1} = -\alpha \bar{\beta} \epsilon^{-k} < \epsilon$. But $\mathcal{N}(-1) = 1$,$\mathcal{N}(\alpha) = -1$ by definition, $\mathcal{N}(\bar{\beta}) = -1$, $\mathcal{N}(\epsilon^{-k}) = \mathcal{N}(\bar{\epsilon}^k) = 1$. Therefore $\mathcal{N}(-\alpha \bar{\beta} \epsilon^{-k}) = 1$. But this contradicts the minimality of $\epsilon$.

Once we have found a solution to $x^2 - 2y^2 = -1$, then we only need to check that $x$ is odd, in which case $a = (x-1)/2$ generates a solution for this case. The permiter in this case is $2a + 1 + b = x + y$. The sequence of solutions to $x_k'^2 - 2y_k'^2 = 1$ is given by the theory of Pell's equation to be

$$
\begin{pmatrix}
x_k' \\
y_k' \\
\end{pmatrix}
=
\begin{pmatrix}
3 & 4 \\
2 & 3 \\
\end{pmatrix}^k
\begin{pmatrix}
1 \\
0 \\
\end{pmatrix}
$$

Therefore the $k$-th solutions to $x_k^2 - 2y_k^2 = -1$ is given by

$$
\begin{pmatrix}
x_k \\
y_k \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 2 \\
1 & 1 \\
\end{pmatrix}
\begin{pmatrix}
3 & 4 \\
2 & 3 \\
\end{pmatrix}^k
\begin{pmatrix}
1 \\
0 \\
\end{pmatrix}
$$

Note that the middle matrix in $\mathbb{F}_2$ is the identity matrix. This implies that $x$ is either always even or always odd, and a quick inspection shows us that it is always odd. Therefore there is a bjection between the solutions to $x^2 - 2y^2 = -1$ and the solutions to case 1.

---

### Case 2: $b^2 + a^2 = (a+1)^2$

This case can be simplified to $b^2 = 2a+1$. This has a solution whenever $b$ is an odd integer, where $a = (b^2 - 1)/2$. The perimeter in this case is $b^2 + b$. Let $B$ be the largest odd integer such that $B^2 + B \le N \Rightarrow B \le \frac{1}{2}(\sqrt{4N + 1} - 1)$ and let $C = (B-1)/2$. Then the contribution of case 2 to $S(N)$ is $\sum_{b = 3}^B [ b^2 + b ] - \sum_{k = 2}^C [4k^2 + 2k] = \frac{B(B+1)(2B+1)}{6} + \frac{B(B+1)}{2} - \frac{2C(C+1)(2C+1)}{3} - C(C+1) - 2$.

---

### Case 3: $a^2 + (a+1)^2 = (a+2)^2$

This case has only one solution: the triple $(3, 4, 5)$.

---

The final solution is adding the number of case 1s and the number of case 2s and subtracting the number of case 3s to correct for double counting.

Now let's optimize this for the case where $N = 10^M$ and $M$ is a very large even number and we want to calculate $S(N)$ modulo a prime number $p > 3$.

### Case 1

Note that for $k \ge 1$ we have

$$
\begin{align*}
\begin{pmatrix}
x_k \\
y_k \\
\end{pmatrix}
&=
\begin{pmatrix}
1 & 2 \\
1 & 1 \\
\end{pmatrix}
\begin{pmatrix}
3 & 4 \\
2 & 3 \\
\end{pmatrix}^k
\begin{pmatrix}
1 \\
0 \\
\end{pmatrix} \\

&=
\begin{pmatrix}
1 & 2 \\
1 & 1 \\
\end{pmatrix}
\begin{pmatrix}
- \sqrt{2} & \sqrt{2} \\
1 & 1 \\
\end{pmatrix}
\begin{pmatrix}
(3 - 2 \sqrt{2})^k & 0 \\
0 & (3 + 2 \sqrt{2})^k \\
\end{pmatrix}
\begin{pmatrix}
-\frac{1}{2\sqrt{2}} & \frac{1}{2} \\
\frac{1}{2\sqrt{2}} & \frac{1}{2} \\
\end{pmatrix}
\begin{pmatrix}
1 \\
0 \\
\end{pmatrix} \\

&=
\begin{pmatrix}
2 - \sqrt{2} & 2 + \sqrt{2} \\
1 - \sqrt{2} & 1 + \sqrt{2} \\
\end{pmatrix}
\begin{pmatrix}
(3 - 2 \sqrt{2})^k & 0 \\
0 & (3 + 2 \sqrt{2})^k \\
\end{pmatrix}
\begin{pmatrix}
-\frac{1}{2\sqrt{2}} \\
\frac{1}{2\sqrt{2}} \\
\end{pmatrix} \\

&=
\frac{1}{4}
\begin{pmatrix}
(2 - 2 \sqrt{2}) \cdot (3 - 2 \sqrt{2})^k + (2 + 2 \sqrt{2}) \cdot (3 + 2 \sqrt{2})^k \\
(2 - \sqrt{2}) \cdot (3 - 2 \sqrt{2})^k + (2 + \sqrt{2}) \cdot (3 + 2 \sqrt{2})^k \\
\end{pmatrix} \\
\end{align*}
$$

where the second expression is obtained by eigendecomposition of the matrix. Now we need to find the largest $K$ such that $x_K + y_K \le N$. Firstly, $x_k + y_k = \frac{1}{4} ((4 - 3 \sqrt{2}) \cdot (3 - 2 \sqrt{2})^k + (4 + 3 \sqrt{2}) \cdot (3 + 2 \sqrt{2})^k)$. Note that $(3 - 2 \sqrt{2})^k \rightarrow 0$ as $k \rightarrow \infty$. Therefore we can ignore $(3-2\sqrt(2))^k$ when calculating $K$. Then

$$
\frac{4 + 3 \sqrt{2}}{4} \cdot (3 + 2 \sqrt{2})^k < N = 10^M \\
\Rightarrow k \log_{10}\left( 3 + 2 \sqrt{2} \right) + \log_{10}\left(\frac{4 + 3 \sqrt{2}}{4}\right) <  M \\
$$

which we can use to compute $K$. Now that we know $K$, the contribution of case 1 is

$$
\begin{align*}
\sum_{k = 1}^K \left[ x_k + y_k \right]
&= \sum_{k = 1}^K \left[ \frac{1}{4} ((4 - 3 \sqrt{2}) \cdot (3 - 2 \sqrt{2})^k + (4 + 3 \sqrt{2}) \cdot (3 + 2 \sqrt{2})^k) \right] \\
&= \frac{4 - 3 \sqrt{2}}{4} \sum_{k = 1}^K (3 - 2 \sqrt{2})^k + \frac{4 + 3 \sqrt{2}}{4} \sum_{k = 1}^K (3 + 2 \sqrt{2})^k \\
&= \frac{4 - 3 \sqrt{2}}{4} \sum_{k = 0}^K (3 - 2 \sqrt{2})^k + \frac{4 + 3 \sqrt{2}}{4} \sum_{k = 0}^K (3 + 2 \sqrt{2})^k - \frac{4 - 3 \sqrt{2}}{4} - \frac{4 + 3 \sqrt{2}}{4} \\
&= \frac{4 - 3 \sqrt{2}}{4} \cdot \frac{1 - (3 - 2 \sqrt{2})^{K+1}}{1 - (3 - 2 \sqrt{2})} + \frac{4 + 3 \sqrt{2}}{4} \cdot \frac{1 - (3 + 2 \sqrt{2})^{K+1}}{1 - (3 + 2 \sqrt{2})} - 2 \\
&= \frac{(4 - 2 \sqrt{2}) \cdot ((3 - 2 \sqrt{2})^{K+1} - 1) + (4 + 2 \sqrt{2}) \cdot ((3 + 2 \sqrt{2})^{K+1} - 1)}{16} - 2 \\
&= \frac{(4 - 2 \sqrt{2}) \cdot (3 - 2 \sqrt{2})^{K+1} + (4 + 2 \sqrt{2}) \cdot (3 + 2 \sqrt{2})^{K+1} - 8}{16} - 2 \\
\end{align*}
$$

Now we need to compute $(3 \pm 2 \sqrt{2})^{K+1}$ in $\mathbb{Z}_p[\sqrt{2}]$. This can be done efficiently using exponentiation by squaring.

### Case 2

Notice that $\left\lfloor \frac{1}{2}(\sqrt{4N + 1} - 1) \right\rfloor = \left\lfloor 10^{M/2} - 1/2 \right\rfloor = 10^{M/2} - 1$, which is clearly an odd number. Therefore $B = 10^{M/2} - 1$.

### Case 3

We always need to subtract $12$ from the result to obtain $S(N)$.