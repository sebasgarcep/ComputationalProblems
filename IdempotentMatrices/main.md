# Idempotent matrices

A matrix $M$ is called idempotent if $M^2 = M$.<br />
Let $M$ be a three by three matrix : 
$M=\begin{pmatrix} 
  a & b & c\\ 
  d & e & f\\
  g &h &i\\
\end{pmatrix}$.<br />
Let C(<var>n</var>) be the number of  idempotent three by three matrices $M$ with integer elements such that<br />
$ -n \le a,b,c,d,e,f,g,h,i \le n$.

C(1)=164 and C(2)=848.

Find C(200).

## Solution

Let $M = Q \Lambda Q^{-1}$ be the eigen decomposition of $M$. Then

$$
M^2 = Q \Lambda^2 Q^{-1} = M = Q \Lambda Q^{-1} 
$$

Thus $\Lambda^2 = \Lambda$, and because $\Lambda$ is a diagonal matrix with the eigenvalues of $M$ as entries, then the eigenvalues must satisfy $\lambda^2 = \lambda$. Thus the eigenvalues of $M$ are either $0$ or $1$.

It is well-known that the sum of eigenvalues of a matrix equals the trace. The multiplicity of the $0$ eigenvalue gives us the rank of the null space of $M$. Thus by the rank-nullity theorem, the rank of $M$ is given by the multiplicity of $1$.

If rank of $M$ is $3$, then $M$ is invertible. Thus

$$
M^2 = M \Rightarrow M = I
$$

On the other hand, if the multiplicity of $1$ is $0$, then $M = 0$. Thus assume from now on that the rank of $M$ is $1$ or $2$.

It is well-know that the trace of a matrix is given by the sum of eigenvalues. Because $M$ has a multiplicity of $1$ of either $1$ or $2$, then the trace of $M$ must equal either $1$ or $2$, depending on the rank.

Suppose $M$ is a rank-$2$. Then $(I - M)^2 = I^2 - 2M + M^2 = I - M$. Thus $I - M$ is another idempotent matrix. Let $M = Q \Lambda Q^{-1}$ be the eigen-decomposition of $M$. Then $I - M = Q (I - \Lambda) Q^{-1}$ is the eigen-decomposition of $I - M$. Because

$$
\Lambda =
\begin{pmatrix}
1 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 0 \\
\end{pmatrix}
\Rightarrow
I - \Lambda =
\begin{pmatrix}
0 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 1 \\
\end{pmatrix}
$$

Therefore the eigenvalue $1$ has multiplicity $1$ in $I - M$, which implies that $I - M$ is rank-$1$. This fact implies a bijection between the rank-$1$ and rank-$2$ matrices and therefore we only need to iterate over the rank-$1$ matrices. Note that if $-n \le 1 - x \le n \Rightarrow -(n + 1) \le x \le n + 1$. Therefore we need to expand our search to rank-$1$ matrices with entries in the range $[-(n + 1), n + 1]$. Whenever we find a rank-$1$ matrix $M$ in that range we perform two checks:

- Is $M$ in the range $[-n, n]$ ? If so, then $M$ gets counted
- Is $I - M$ in the range $[-n, n]$ ? If so, then $I - M$ gets counted

Now let's figure out a search strategy for rank-$1$ matrices. A rank-$1$ matrix $M$ is going to be of the form

$$
M =
\begin{pmatrix}
xa & xb & xc \\
ya & yb & yc \\
za & zb & zc \\
\end{pmatrix}
$$

Moreover, the trace must equal $1$. Therefore $xa + yb + zc = 1$. Now consider

$$
M^2 =
\begin{pmatrix}
xa \cdot xa + ya \cdot xb + za \cdot xc & xb \cdot xa + yb \cdot xb + zb \cdot xc & xc \cdot xa + yc \cdot xb + zc \cdot xc \\
xa \cdot ya + yb \cdot ya + za \cdot yc & xb \cdot ya + yb \cdot yb + zb \cdot yc & xc \cdot ya + yc \cdot yb + zc \cdot yc \\
xa \cdot za + ya \cdot zb + za \cdot zc & xb \cdot za + yb \cdot zb + zb \cdot zc & xc \cdot za + yc \cdot zb + zc \cdot zc \\
\end{pmatrix}
$$

From $M^2 = M$ we get

$$
\begin{align*}
xa \cdot xa + ya \cdot xb + za \cdot xc &= xa \\
xb \cdot xa + yb \cdot xb + zb \cdot xc &= xb \\
xc \cdot xa + yc \cdot xb + zc \cdot xc &= xc \\
xa \cdot ya + yb \cdot ya + za \cdot yc &= ya \\
xb \cdot ya + yb \cdot yb + zb \cdot yc &= yb \\
xc \cdot ya + yc \cdot yb + zc \cdot yc &= yc \\
xa \cdot za + ya \cdot zb + za \cdot zc &= za \\
xb \cdot za + yb \cdot zb + zb \cdot zc &= zb \\
xc \cdot za + yc \cdot zb + zc \cdot zc &= zc \\
\end{align*}
$$

which can be rewritten as

$$
\begin{align*}
xa \cdot (xa + yb + zc - 1) &= 0 \\
xb \cdot (xa + yb + zc - 1) &= 0 \\
xc \cdot (xa + yb + zc - 1) &= 0 \\
ya \cdot (xa + yb + zc - 1) &= 0 \\
yb \cdot (xa + yb + zc - 1) &= 0 \\
yc \cdot (xa + yb + zc - 1) &= 0 \\
za \cdot (xa + yb + zc - 1) &= 0 \\
zb \cdot (xa + yb + zc - 1) &= 0 \\
zc \cdot (xa + yb + zc - 1) &= 0 \\
\end{align*}
$$

And all of this equations are implied by the trace equation. Therefore we only need $xa + yb + zc = 1$ to hold to ensure $M$ is idempotent.