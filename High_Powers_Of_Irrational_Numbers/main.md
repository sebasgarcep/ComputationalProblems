# High powers of irrational numbers

Let $a, b, n \in \mathbb{N}$ and $0 \leq a - \sqrt{b} < 1$. Then:

$$
(a + \sqrt{b})^n + (a - \sqrt{b})^n = 2 a^n + {n \choose 2} a^{n - 2} b + ... + {n \choose n - 2} a^{2} b^{\lfloor (n - 2) / 2 \rfloor} + b^{\lfloor n / 2 \rfloor} \in \mathbb{N}
$$

Also, let $\epsilon = 0$ if $a - \sqrt{b} = 0$, otherwise let $\epsilon = 1$. Then:

$$
\lfloor (a + \sqrt{b})^n \rfloor = \lfloor (a + \sqrt{b})^n + (a - \sqrt{b})^n \rfloor = (a + \sqrt{b})^n + (a - \sqrt{b})^n - \epsilon
$$

Finally, we need to calculate $(a + \sqrt{b})^n + (a - \sqrt{b})^n$. Notice that:

$$
(a + \sqrt{b})^n + (a - \sqrt{b})^n = tr(
    \begin{pmatrix}
    a + \sqrt{b} & 0 \\
    0 & a - \sqrt{b}
    \end{pmatrix}^n
)
$$

First let's prove that $tr(AB) = tr(BA)$ for $2 \times 2$ matrices:

$$
\begin{pmatrix}
a_{1,1} & a_{1,2} \\
a_{2,1} & a_{2,2}
\end{pmatrix}

\begin{pmatrix}
b_{1,1} & b_{1,2} \\
b_{2,1} & b_{2,2}
\end{pmatrix}

=

\begin{pmatrix}
a_{1,1} b_{1,1} + a_{1,2} b_{2,1} & \dots \\
\dots & a_{2,1} b_{1,2} + a_{2,2} b_{2,2}
\end{pmatrix}
$$

$$
\begin{pmatrix}
b_{1,1} & b_{1,2} \\
b_{2,1} & b_{2,2}
\end{pmatrix}

\begin{pmatrix}
a_{1,1} & a_{1,2} \\
a_{2,1} & a_{2,2}
\end{pmatrix}

=

\begin{pmatrix}
b_{1,1} a_{1,1} + b_{2,1} a_{1,2} & \dots \\
\dots & b_{1,2} a_{2,1} + b_{2,2} a_{2,2}
\end{pmatrix}
$$

And clearly the traces are equal.

Finally:

$$
\begin{pmatrix}
a + \sqrt{b} & 0 \\
0 & a - \sqrt{b}
\end{pmatrix}

=

\begin{pmatrix}
1 & 1 \\
\frac{-1}{\sqrt{b}} & \frac{1}{\sqrt{b}}
\end{pmatrix}^{-1}

\begin{pmatrix}
a & b \\
1 & a
\end{pmatrix}

\begin{pmatrix}
1 & 1 \\
\frac{-1}{\sqrt{b}} & \frac{1}{\sqrt{b}}
\end{pmatrix}
$$

$$
\begin{pmatrix}
a + \sqrt{b} & 0 \\
0 & a - \sqrt{b}
\end{pmatrix}^n

=

\begin{pmatrix}
1 & 1 \\
\frac{-1}{\sqrt{b}} & \frac{1}{\sqrt{b}}
\end{pmatrix}^{-1}

\begin{pmatrix}
a & b \\
1 & a
\end{pmatrix}^n

\begin{pmatrix}
1 & 1 \\
\frac{-1}{\sqrt{b}} & \frac{1}{\sqrt{b}}
\end{pmatrix}
$$

$$
tr(
    \begin{pmatrix}
    a + \sqrt{b} & 0 \\
    0 & a - \sqrt{b}
    \end{pmatrix}^n
)

=
$$

$$
=

tr(
    \begin{pmatrix}
    1 & 1 \\
    \frac{-1}{\sqrt{b}} & \frac{1}{\sqrt{b}}
    \end{pmatrix}^{-1}

    \begin{pmatrix}
    a & b \\
    1 & a
    \end{pmatrix}^n

    \begin{pmatrix}
    1 & 1 \\
    \frac{-1}{\sqrt{b}} & \frac{1}{\sqrt{b}}
    \end{pmatrix}
)
$$

$$
=

tr(
    \begin{pmatrix}
    1 & 1 \\
    \frac{-1}{\sqrt{b}} & \frac{1}{\sqrt{b}}
    \end{pmatrix}

    \begin{pmatrix}
    1 & 1 \\
    \frac{-1}{\sqrt{b}} & \frac{1}{\sqrt{b}}
    \end{pmatrix}^{-1}

    \begin{pmatrix}
    a & b \\
    1 & a
    \end{pmatrix}^n
)

\text{\: \: \: \:\: (Using the fact about traces we just proved)}
$$

$$
=

tr(
    \begin{pmatrix}
    a & b \\
    1 & a
    \end{pmatrix}^n
)
$$


Therefore:

$$
(a + \sqrt{b})^n + (a - \sqrt{b})^n

=

tr(
    \begin{pmatrix}
    a & b \\
    1 & a
    \end{pmatrix}^n
)
$$

which can be easily calculated using binary multiplication.
