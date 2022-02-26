# Neighbourly Constraints

Let $T(n, m)$ be the number of $m$-tuples of positive integers such that the sum of any two neighbouring elements of the tuple is $\le n$.

For example, $T(3, 4)=8$, via the following eight $4$-tuples:<br />
$(1, 1, 1, 1)$<br />
$(1, 1, 1, 2)$<br />
$(1, 1, 2, 1)$<br />
$(1, 2, 1, 1)$<br />
$(1, 2, 1, 2)$<br />
$(2, 1, 1, 1)$<br />
$(2, 1, 1, 2)$<br />
$(2, 1, 2, 1)$<br />

You are also given that $T(5, 5)=246$, $T(10, 10^{2}) \equiv 862820094 \pmod{1\,000\,000\,007}$ and  $T(10^2, 10) \equiv 782136797 \pmod{1\,000\,000\,007}$.

Find $T(5000, 10^{12}) \bmod 1\,000\,000\,007$.

## Solution

Let $f(n, m, k)$ be the number of $m$-tuples of positive integers such that the sum of any two neighbouring elements of the tuple is $\le n$ and the last element of the tuple is $k$. Clearly $f(n, 1, k) = 1$ if $k \le n - 1$, and $f(n, 1, k) = 0$ otherwise. Moreover, the following relation clearly holds

$$
T(n, m) = \sum_{k = 1}^{n - 1} f(n, m, k)
$$

It is clear that for the last element of a tuple to be $k$, the next-to-last has to be less than or equal to $n - k$. Therefore

$$
f(n, m, k) = \sum_{i = 1}^{n - k} f(n, m - 1, i)
$$

We can express the previous expression with matrices and vectors.

$$
\begin{pmatrix}
f(n, m, 1) \\
f(n, m, 2) \\
\vdots \\
f(n, m, n - 1) \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 & \cdots & 1 \\
1 & 1 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
1 & 0 & \cdots & 0 \\
\end{pmatrix}

\begin{pmatrix}
f(n, m - 1, 1) \\
f(n, m - 1, 2) \\
\vdots \\
f(n, m - 1, n - 1) \\
\end{pmatrix}
$$

and recursively applying this expression we obtain

$$
\begin{pmatrix}
f(n, m, 1) \\
f(n, m, 2) \\
\vdots \\
f(n, m, n - 1) \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 & \cdots & 1 \\
1 & 1 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
1 & 0 & \cdots & 0 \\
\end{pmatrix}^{m - 1}

\begin{pmatrix}
f(n, 1, 1) \\
f(n, 1, 2) \\
\vdots \\
f(n, 1, n - 1) \\
\end{pmatrix}
=
\begin{pmatrix}
1 & 1 & \cdots & 1 \\
1 & 1 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
1 & 0 & \cdots & 0 \\
\end{pmatrix}^{m - 1}

\begin{pmatrix}
1 \\
1 \\
\vdots \\
1 \\
\end{pmatrix}
$$

Let

$$
A =
\begin{pmatrix}
1 & 1 & \cdots & 1 \\
1 & 1 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
1 & 0 & \cdots & 0 \\
\end{pmatrix} \\
\hat{f}(n, m) =
\begin{pmatrix}
f(n, m, 1) \\
f(n, m, 2) \\
\vdots \\
f(n, m, n - 1) \\
\end{pmatrix}
$$

Then we need to solve for the equation $\hat{f}(n, m) = A^{m-1} \hat{f}(n, 1)$. Suppose we have a monic polynomial $c_A$ of the matrix $A$ with degree less than or equal to $n - 1$ such that it is divisible by the minimal polynomial. Then $c_A(A) = 0$. Suppose $x^{m-1} \equiv a_0 + a_1 x + a_2 x^2 + \dots + a_{n-2} x^{n-2} \pmod {c_A(x)}$. Then

$$
\begin{align*}
\hat{f}(n, m)
&= A^{m-1} \hat{f}(n, 1) \\
&= (a_0 + a_1 A + a_2 A^2 + \dots + a_{n-2} A^{n-2}) \hat{f}(n, 1) \\
&= a_0 \hat{f}(n, 1) + a_1 A \hat{f}(n, 1) + a_2 A^2 \hat{f}(n, 1) + \dots + a_{n-2} A^{n-2} \hat{f}(n, 1) \\
&= a_0 \hat{f}(n, 1) + a_1 \hat{f}(n, 2) + a_2 \hat{f}(n, 3) + \dots + a_{n-2} \hat{f}(n, n - 1) \\
\end{align*}
$$

Now we need to find an efficient method of computing $c_A$.

### Berlekamp-Massey Algorithm

Let $K$ be a field. Suppose a sequence $\{ s_t \}_t$ satisfies a linearly recurrent relation

$$
s_t + c_1 s_{t-1} + c_2 s_{t-2} + \dots + c_N s_{t-N} = 0
$$

where $c_i \in K, i = 1, \dots, N$ are unknown. Then the Berlekamp-Massey Algorithm returns the polynomial $C(x) = 1 + c_1 x + c_2 x^2 + \dots + c_N x^N$, given the first $2N$ terms of the sequence $\{ s_t \}_t$.

FIXME: Prove this algorithm.

### Applying the Berlekamp-Massey Algorithm

Because $c_A(x)$ is monic there are $n - 1$ coefficients $c_i, i = 0, \dots, n - 2$ such that $c_A(x) = x^{n-1} + \sum_{i = 0}^{n-2} c_i x^i$. At this point these coefficients are unknown. Let $H$ be the linear operator that sums the entries of its input. Then $H \hat{f}(n, m) = T(n, m)$ Let $t \ge 0$. Then

$$
A^{n - 1} + \sum_{i = 0}^{n-2} c_i A^i = 0 \\
\Rightarrow A^{n - 1 + t} + \sum_{i = 0}^{n-2} c_i A^{i + t} = 0 \\
\Rightarrow H A^{n - 1 + t} \hat{f}(n, 1) + \sum_{i = 0}^{n-2} c_i H A^{i + t} \hat{f}(n, 1) = 0 \\
\Rightarrow H \hat{f}(n, n + t) + \sum_{i = 1}^{n-1} c_{i-1} H \hat{f}(n, i + t) = 0 \\
\Rightarrow T(n, n + t) + \sum_{i = 1}^{n-1} c_{i-1} T(n, i + t) = 0 \\
$$

If we set $t = 0, 1, \dots, n - 2$ we get $n - 1$ equations on the set of unknowns $c_i, i = 0, \dots, n - 2$. Because there are $n - 1$ unknowns, these equations are sufficient to uniquely determine the coefficients. Therefore we only need to calculate $T(n, 1), \dots, T(n, 2n - 2))$ to obtain these coefficients. Moreover, these equations show that there is a linearly recurrent relation between the values of $T(n, m)$. Thus we can apply the Berlekamp-Massey algorithm to obtain the coefficients.

## References

- https://en.wikipedia.org/wiki/Berlekamp%E2%80%93Massey_algorithm

### Notes

We can transform this problem into a linearly recurrent sequence by noticing that

$$
\begin{pmatrix}
\hat{f}(n, m) \\
\hat{f}(n, m - 1) \\
\end{pmatrix}
=
\begin{pmatrix}
A & 0 \\
I & 0 \\
\end{pmatrix}

\begin{pmatrix}
\hat{f}(n, m - 1) \\
\hat{f}(n, m - 2) \\
\end{pmatrix}
$$