# Powers of $1 + \sqrt{7}$

When $(1+\sqrt 7)$ is raised to an integral power, $n$, we always get a number of the form $(a+b\sqrt 7)$.<br />
We write $(1+\sqrt 7)^n = \alpha(n) + \beta(n)\sqrt 7$.

For a given number $x$ we  define $g(x)$ to be the smallest positive integer $n$ such that:

$$\alpha(n) \equiv 1 \pmod x$$

$$\beta(n) \equiv 0 \pmod x$$

and $g(x) = 0$ if there is no such value of $n$. For example, $g(3) = 0$, $g(5) = 12$.

Further define
$G(N) = \sum_{x=2}^{N} g(x)$
You are given $G(10^2) = 28891$ and $G(10^3)  = 13131583$.

Find $G(10^6)$.

## Solution

First note that:

$$\alpha(1) = 1$$
$$\beta(1) = 1$$

Also note that

$$\alpha(n + 1) + \beta(n + 1) \sqrt 7 = (1 + \sqrt{7})^{n + 1}$$
$$= (1 + \sqrt{7})^n (1 + \sqrt{7})$$
$$= (\alpha(n) + \beta(n) \sqrt 7) (1 + \sqrt{7})$$
$$= (\alpha(n) + 7 \beta(n)) + (\alpha(n) + \beta(n)) \sqrt{7}$$

Therefore:

$$\alpha(n + 1) = \alpha(n) + 7 \beta(n)$$
$$\beta(n + 1) = \alpha(n) + \beta(n)$$

Or expressed in matrix form:

$$
\begin{pmatrix}
\alpha(n + 1) \\
\beta(n + 1)
\end{pmatrix}
=
\begin{pmatrix}
1 & 7 \\
1 & 1
\end{pmatrix}
\begin{pmatrix}
\alpha(n) \\
\beta(n)
\end{pmatrix}
$$

$$
\begin{pmatrix}
\alpha(n + 1) \\
\beta(n + 1)
\end{pmatrix}
\begin{pmatrix}
1 & 7 \\
1 & 1
\end{pmatrix}^n
\begin{pmatrix}
1 \\
1
\end{pmatrix}
$$

Fix $x$. Assume that there is a minimal $m$ such that

$$
\begin{pmatrix}
1 & 7 \\
1 & 1
\end{pmatrix}^{m-1}
\begin{pmatrix}
1 \\
1
\end{pmatrix}
\equiv
\begin{pmatrix}
z \\
0
\end{pmatrix}
\equiv
z
\begin{pmatrix}
1 \\
0
\end{pmatrix}
\: (\text{mod } x)
$$

for some $z \neq 0$. Then:

$$
\begin{pmatrix}
1 & 7 \\
1 & 1
\end{pmatrix}^{m}
\begin{pmatrix}
1 \\
1
\end{pmatrix}
\equiv
z
\begin{pmatrix}
1 \\
1
\end{pmatrix}
\: (\text{mod } x)
$$

$$
\begin{pmatrix}
1 & 7 \\
1 & 1
\end{pmatrix}^{2m - 1}
\begin{pmatrix}
1 \\
1
\end{pmatrix}
\equiv
z^2
\begin{pmatrix}
1 \\
0
\end{pmatrix}
\: (\text{mod } x)
$$

$$
\dots
$$

$$
\begin{pmatrix}
1 & 7 \\
1 & 1
\end{pmatrix}^{km - 1}
\begin{pmatrix}
1 \\
1
\end{pmatrix}
\equiv
z^k
\begin{pmatrix}
1 \\
0
\end{pmatrix}
\: (\text{mod } x)
$$

And therefore there is only a solution $g(x) = km - 1$ if there is a minimal $k$ such that

$$
z^k \equiv 1 \: (\text{mod } x)
$$

which is only possible if $\text{gdc}(z, x) = 1$.

Now, let $x = 2$. Then $\alpha(2) \equiv \beta(2) \equiv 0 \: (\text{mod } 2)$. By induction one can see that $\alpha(n) \equiv \beta(n) \equiv 0 \: (\text{mod } 2)$. Therefore there are no solutions for $x = 2$. If $x$ is a multiple of $2$, then the same is true as the modular equations have to also hold modulus $2$. If $x = 3$ then solutions alternate between $\alpha(n) \equiv -\beta(n) \equiv \pm 1 \: (\text{mod } 3)$ and therefore there are no solutions for $x = 3$. Similarly, there are also no solutions for multiples of $3$ using a similar logic as before.