# Sum of Products

A <b>partition</b> of $n$ is a set of positive integers for which the sum equals $n$.<br>
The partitions of 5 are:<br>
$\{5\},\{1,4\},\{2,3\},\{1,1,3\},\{1,2,2\},\{1,1,1,2\}$ and $\{1,1,1,1,1\}$.

Further we define the function $D(p)$ as:<br>
$$
\begin{align}
\begin{split}
D(1) &= 1 \\
D(p) &= 1, \text{ for any prime } p \\
D(pq) &= D(p)q + pD(q), \text{ for any positive integers } p,q \gt 1.
\end{split}
\end{align}
$$

Now let $\{a_1, a_2,\ldots,a_k\}$ be a partition of $n$.<br>
We assign to this particular partition the value:<br> $$P=\prod_{j=1}^{k}D(a_j). $$

$G(n)$ is the sum of $P$ for all partitions of $n$.<br>
We can verify that $G(10) = 164$.

We also define:
$$S(N)=\sum_{n=1}^{N}G(n).$$
You are given $S(10)=396$.<br>
Find $S(5\times 10^4) \mod 999676999$.

## Solution

Consider the generating function for the partition function $p(n)$

$$
\sum_{n \ge 0} p(n) x^n = \prod_{k \ge 1} \sum_{i \ge 0} x^{ik}
$$

Then using the same logic we can derive the generating function for $G(n)$ to be

$$
\begin{align*}
\sum_{n \ge 0} G(n) x^n
&= \prod_{k \ge 1} \sum_{i \ge 0} D(k)^i x^{ik} \\
\end{align*}
$$

And we need to compute this polynomial modulo $x^{N+1}$.
