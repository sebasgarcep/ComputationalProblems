# Subset Sums

Let $A_q(n)$ be the number of subsets, $B$, of the set $\{1, 2, ..., q \cdot n\}$ that satisfy two conditions:<br>
1) $B$ has exactly $n$ elements;<br>
2) the sum of the elements of $B$ is divisible by $n$.


E.g. $A_2(5)=52$ and $A_3(5)=603$.

Let $S_q(L)$ be $\sum A_q(p)$ where the sum is taken over all primes $p \le L$.<br>
E.g. $S_2(10)=554$, $S_2(100)$ mod $1\,000\,000\,009=100433628$ and<br> $S_3(100)$ mod $1\,000\,000\,009=855618282$.


Find $S_2(10^8)+S_3(10^8)$. Give your answer modulo $1\,000\,000\,009$.

## Solution

Fix a value of $q > 1$ and a value of $n = p$ where $p$ is an odd prime. Let $C_{i,j}$ be the number of subsets of $\{ 1, 2, \dots, q \cdot p \}$ such that the subset has $i$ elements and the elements add up to $j$. Then $A_q(p) = \sum_{j \equiv 0 \pmod p} C_{p, j}$.

Let $f(x, y) = \sum_i \sum_j C_{i,j} x^i y^j$. Then it is easy to see that $f(x, y) = \prod_{j=0}^{qp-1} (1 + x y^j)$. Now consider

$$
\begin{align*}
\sum_{k=0}^{p-1} f(x, \omega_p^k)
\end{align*}
$$

where $\omega_p$ is the $p$-th root of unity. Then on one side

$$
\begin{align*}
\sum_{k=0}^{p-1} f(x, \omega_p^k)
&= \sum_{k=0}^{p-1} \sum_i \sum_j C_{i,j} x^i (\omega_p^k)^j \\
&= \sum_i \sum_j C_{i,j} x^i \sum_{k=0}^{p-1} (\omega_p^k)^j \\
&= \sum_i \sum_{j \equiv 0 \pmod p} C_{i,j} x^i \sum_{k=0}^{p-1} (\omega_p^k)^j + \sum_i \sum_{j \not\equiv 0 \pmod p} C_{i,j} x^i \sum_{k=0}^{p-1} (\omega_p^k)^j \\
&= \sum_i \sum_{j \equiv 0 \pmod p} C_{i,j} x^i \cdot p + \sum_i \sum_{j \not\equiv 0 \pmod p} C_{i,j} x^i \cdot 0 \\
&= p \sum_i x^i \sum_{j \equiv 0 \pmod p} C_{i,j} \\
\end{align*}
$$

Note that the coefficient for $x^p$ is $p \sum_{j \equiv 0 \pmod p} C_{p,j} = p \cdot A_q(p)$. On the other hand

$$
\begin{align*}
\sum_{k=0}^{p-1} f(x, \omega_p^k)
&= \sum_{k=0}^{p-1} \prod_{j=0}^{qp-1} (1 + x (\omega_p^k)^j) \\
&= (1+x)^{qp} + \sum_{k=1}^{p-1} \prod_{j=0}^{qp-1} (1 + x (\omega_p^k)^j) \\
&= (1+x)^{qp} + \sum_{k=1}^{p-1} \prod_{j=0}^{p-1} (1 + x \omega_p^j)^q \\
&= (1+x)^{qp} + (p - 1) \cdot \prod_{j=0}^{p-1} (1 + x \omega_p^j)^q \\
\end{align*}
$$

Let $g_x(z) = z^p - x^p = \prod_{j=0}^{p-1} (z - x \omega_p^j)$. Then $g_x(-1) = -1 - x^p = \prod_{j=0}^{p-1} (-1 - x \omega_p^j) = - \prod_{j=0}^{p-1} (1 + x \omega_p^j)$. Thus $1 + x^p = \prod_{j=0}^{p-1} (1 + x \omega_p^j)$. Plugging this into the previous equation we get

$$
\begin{align*}
\sum_{k=0}^{p-1} f(x, \omega_p^k)
&= (1+x)^{qp} + (p - 1) \cdot \prod_{j=0}^{p-1} (1 + x \omega_p^j)^q \\
&= (1+x)^{qp} + (p - 1) \cdot (1 + x^p)^q \\
\end{align*}
$$

Note that the coeffiecient for $x^p$ in this formula is $\binom{qp}{p} + (p - 1) \cdot q$. Therefore

$$
A_q(p) = \frac{1}{p} \cdot \left( \binom{qp}{p} + (p - 1) \cdot q \right)
$$

Finally, let's find the formula for $p = 2$. There are $\binom{2q}{2} = q \cdot (2q-1)$ subsets of size $2$. The sum of these elements is even if both numbers are even or both are odd. There are $\binom{q}{2}$ ways to pick two even numbers and $\binom{q}{2}$ ways to pick two odd ones. Therefore $A_q(2) = 2 \binom{q}{2} = q \cdot (q-1)$.
