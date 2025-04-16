# Two-Dimensional Recurrence

The <b>Fibonacci sequence</b> $(f_i)$ is the unique sequence such that

- $f_0=0$
- $f_1=1$
- $f_{i+1}=f_i+f_{i-1}$

Similarly, there is a unique function $A(m,n)$ such that

- $A(0,0)=0$
- $A(0,1)=1$
- $A(m+1,n)=A(m,n+1)+A(m,n)$
- $A(m+1,n+1)=2A(m+1,n)+A(m,n)$

Define $S(k)=\displaystyle\sum_{i=2}^k\sum_{j=2}^k A(f_i,f_j)$. For example
$$
\begin{align}
S(3)&=A(1,1)+A(1,2)+A(2,1)+A(2,2)\\
&=2+5+7+16\\
&=30
\end{align}
$$You are also given $S(5)=10396$.

Find $S(50)$, giving your answer modulo $1123581313$.

## Solution

Let

$$
B(m,n)
=
\begin{pmatrix}
A(m,n) \\
A(m,n+1) \\
\end{pmatrix}
$$

Note that

$$
\begin{align*}
A(m+1,n) &= A(m,n+1) + A(m,n) \\
A(m+1,n+1) &= 2A(m+1,n) + A(m,n) \\
&= 2A(m,n+1) + 3A(m,n) \\
\end{align*}
$$

Therefore

$$
B(m+1,n)
=
\begin{pmatrix}
1 & 1 \\
3 & 2 \\
\end{pmatrix}
B(m,n)
$$

Note that

$$
\begin{align*}
A(m,n+2) &= A(m+1,n+1) - A(m,n+1) \\
&= 2A(m,n+1) + 3A(m,n) - A(m,n+1) \\
&= A(m,n+1) + 3A(m,n) \\
\end{align*}
$$

Therefore

$$
B(m,n+1)
=
\begin{pmatrix}
0 & 1 \\
3 & 1 \\
\end{pmatrix}
B(m,n)
$$

Which means that

$$
B(m,n)
=
\begin{pmatrix}
1 & 1 \\
3 & 2 \\
\end{pmatrix}^m

\begin{pmatrix}
0 & 1 \\
3 & 1 \\
\end{pmatrix}^n

B(0,0)
$$
