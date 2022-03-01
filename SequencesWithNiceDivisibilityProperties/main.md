# Sequences with nice divisibility properties

<p>Let <var>Seq</var>(<var>n</var>,<var>k</var>) be the number of positive-integer sequences {<var>a<sub>i</sub></var>}<sub>1≤i≤<var>n</var></sub> of length <var>n</var> such that:</p>
<ul style="list-style-type:disc;"><li><var>n</var> is divisible by <var>a<sub>i</sub></var> for 1 ≤ <var>i</var> ≤ <var>n</var>, and</li>
  <li><var>n</var> + <var>a</var><sub>1</sub> + <var>a</var><sub>2</sub> + ... + <var>a<sub>n</sub></var> is divisible by <var>k</var>.</li>
</ul><p>Examples:</p>
<p><var>Seq</var>(3,4) = 4, and the 4 sequences are:<br />
{1, 1, 3}<br />
{1, 3, 1}<br />
{3, 1, 1}<br />
{3, 3, 3}</p>
<p><var>Seq</var>(4,11) = 8, and the 8 sequences are:<br />
{1, 1, 1, 4}<br />
{1, 1, 4, 1}<br />
{1, 4, 1, 1}<br />
{4, 1, 1, 1}<br />
{2, 2, 2, 1}<br />
{2, 2, 1, 2}<br />
{2, 1, 2, 2}<br />
{1, 2, 2, 2}</p>
<p>The last nine digits of <var>Seq</var>(1111,24) are 840643584.</p>
<p>Find the last nine digits of <var>Seq</var>(1234567898765,4321).</p>

## Solution

Define $f(n, k, r)$ as the number of positive-integer sequences of length $r$ such that all members of the sequence divide $n$ and $n$ plus the sum of all members of the sequence is divisible by $k$. Then $\text{Seq}(n, k) = f(n, k, n)$. We can define an extra function $g(n, k, r, t)$ to be the number of positive-integer sequences of length $r$ such that all members of the sequence divide $n$ and $n$ plus the sum of all members of the sequence is equivalent to $t$ modulo $k$. Then $f(n, k, r) = g(n, k, r, 0)$.

We can compute $g(n, k, r, t)$ using dynamic programming:

$$
g(n, k, r, t) = \sum_{a \mid n} g(n, k, r - 1, (t - a) \pmod k)
$$

And because this relationship is linear, we can express it in terms of matrices and vectors. Let

$$
\hat{g}(n, k, r) =
\begin{pmatrix}
g(n, k, r, 0) \\
g(n, k, r, 1) \\
\cdots \\
g(n, k, r, k-1) \\
\end{pmatrix}
$$

And let the matrix $A$ satisfy $A_{i,j} = \sum_{a \mid n, \: (j + a) \equiv i \pmod k} 1$. Then $\hat{g}(n, k, r) = A \hat{g}(n, k, r - 1) = A^r \hat{g}(n, k, 0)$, where

$$
\hat{g}(n, k, 0)_i =
\begin{cases}
1 & \text{if } n \equiv i \pmod k \\
0 & \text{otherwise} \\
\end{cases}
$$

Now let's study the structure of $A$. Let $P$ be the cyclic permutation matrix with structure

$$
P =
\begin{pmatrix}
0 & 0 & \dots & 0 & 1 \\
1 & 0 & \dots & 0 & 0 \\
0 & 1 & \ddots & \vdots & \vdots \\
\vdots & \ddots & \ddots & 0 & 0 \\
0 & \dots & 0 & 1 & 0 \\
\end{pmatrix}
$$

It is easy to see that powers of $P$ move the big and small diagonals downwards and $P^k = I$. Then each divisor contributes an instance of $P^r$ to the sum of $A$. Thus $A$ is a circulant matrix with structure

$$
A = c_0 I + c_1 P + \dots + c_{k-1} P^{k-1}
$$

Let $c_i, i = 0, \dots, k - 1$ be members of a ring $R$. Then we can compute $A^n \pmod {A^k - I}$ efficiently by considering the polynomial $f(x) = c_0 + c_1 x + \dots + c_{k-1} x^{k-1} \in R[x]$ and calculating $(f(x))^n \pmod {x^k - 1}$ using binary exponentiation with polynomial modulo reduction at each step. Once we have the reduced polynomial $g(x) = g_0 + g_1 x + \dots + g_{k-1} x^{k-1} \equiv (f(x))^n \pmod {x^k - 1}$, then it is not hard to see that $A^n = g(P)$.

Finally, the ring we will use to perform our computations is $R = \mathbb{Z} / 10^9 \mathbb{Z}$.