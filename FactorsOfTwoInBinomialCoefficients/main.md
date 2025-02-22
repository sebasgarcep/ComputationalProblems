# Factors of Two in Binomial Coefficients

Define $g(n, m)$ to be the largest integer $k$ such that $2^k$ divides $\binom{n}m$. 
For example, $\binom{12}5 = 792 = 2^3 \cdot 3^2 \cdot 11$, hence $g(12, 5) = 3$. 
Then define $F(n) = \max \{ g(n, m) : 0 \le m \le n \}$. $F(10) = 3$ and $F(100) = 6$.

Let $S(N)$ = $\displaystyle\sum_{n=1}^N{F(n)}$. You are given that $S(100) = 389$ and $S(10^7) = 203222840$.

Find $S(10^{16})$.

## Solution

Let $T_p(n)$ be the sum of the digits of $n$ in base $p$ and let $r(n)$ be the largest $k$ such that $2^k \le n$.

### Kummer's Theorem

Let $p$ be a prime number, and let $0 \le m \le n$. Then

$$
\nu_p \binom{n}{m} = \frac{T_p(m) + T_p(n - m) - T_p(n)}{p - 1}
$$

#### Proof

Write $a$ in base $p$ as $\sum_{k \ge 0} a_k p^k$. Then $T_p(a) = \sum_{k \ge 0} a_k$ and

$$
\begin{align*}
\nu_p(a!)
&= \sum_{i \ge 1} \left\lfloor \frac{a}{2^i} \right\rfloor \\
&= \sum_{i \ge 1} \sum_{k \ge i} a_k p^{k-i} \\
&= \sum_{k \ge 1} a_k \sum_{1 \le i \le k} p^{k-i} \\
&= \sum_{k \ge 1} a_k \sum_{i=0}^{k-1} p^i \\
&= \sum_{k \ge 1} a_k \cdot \frac{p^k - 1}{p - 1} \\
&= \frac{1}{p - 1} \sum_{k \ge 1} a_k \cdot (p^k - 1) \\
&= \frac{1}{p - 1} \cdot (a - T_p(a)) \\
\end{align*}
$$

Using this formula we get

$$
\begin{align*}
\nu_p \binom{n}{m}
&= \nu_p(n!) - \nu_p(m!) - \nu_p((n - m)!) \\
&= \frac{n - T_p(n) - m + T_p(m) - (n - m) + T_p(n - m)}{p - 1} \\
&= \frac{T_p(m) + T_p(n - m) - T_p(n)}{p - 1} \\
\end{align*}
$$

### Corollary

The number of carries when calculating $m+(n-m)$ is exactly given by Kummer's theorem.

#### Proof

Write $r := n - m$ in base $p$ as $\sum_{k \ge 0} r_k p^k$. We define $c_{-1} = 0$ and for each $k \ge 0$ we define

$$
c_k
=
\begin{cases}
1 \text{ for } m_k + r_k + c_{k-1} \ge p \\
0 \text{ otherwise}
\end{cases}
$$

For each $k \ge 0$, we have

$$
n_k = m_k + r_k + c_{k-1} - p \cdot c_k
$$

Then

$$
\begin{align*}
T_p(m) + T_p(r) - T_p(n)
&= \sum_{k \ge 0} \left[ m_k + r_k - n_k \right] \\
&= \sum_{k \ge 0} \left[ p \cdot c_k - c_{k-1} \right] \\
&= (p - 1) \sum_{k \ge 0} c_k \\
\end{align*}
$$

Therefore

$$
\nu_p \binom{n}{m} = \sum_{k \ge 0} c_k
$$

### Lemma 1

$$
F(n) = g(n, 2^{r(n)} - 1)
$$

#### Proof

Due to the corollary of Kummer's theorem, $F(n)$ is maximized if there are $r(n)$ carries when adding $m+(n-m)$ in base $2$. If $n$ ends in a $0$ then we make both summands end in $1$. This forces a carry. If the next digit of $n$ is a $0$ then we make both summands be $1+0(+1)$, which carries again. If instead the next digit is $1$ we can make both summands be $1+1(+1)$ which carries as well. Repeating this process results in $r(n)$ carries, which is maximal and one of the summands will be $11 \dots 11_2 = 2^{r(n)} - 1$ which proves the statement.

Now suppose $n$ ends in a string of $1$'s. Then there's no way to carry since the summands have to be $1+0$. But at least this implies that one of the summands can be $11 \dots 11_2$ for this first string of digits. Once we reach the first $0$ in the base $2$ represenation of $n$ we can perform the previous procedure to maximize the number of carries, which also results in a summand of the form $11 \dots 11_2$. Concatenating both we get that one of the summands can be $11 \dots 11_2 = 2^{r(n)} - 1$, proving the statement.

### Algorithm

Let $C(N) = \sum_{i=1}^N T_2(n)$. Then

$$
\begin{align*}
S(N)
&= \sum_{n=1}^N F(n) \\

&= \sum_{n=1}^N g(n, 2^{r(n)} - 1) \\

&= \sum_{n=1}^N \left[ T_2(2^{r(n)} - 1) + T_2(n - 2^{r(n)} + 1) - T_2(n) \right] \\

&= \sum_{n=1}^N \left[ T_2(2^{r(n)} - 1) + T_2(n - 2^{r(n)} + 1) \right] - C(N) \\

&= \sum_{k=0}^{r(N) - 1} \sum_{n=2^k}^{2^{k+1}-1} \left[ T_2(2^k - 1) + T_2(n - 2^k + 1) \right] \\
&+ \sum_{n=2^{r(N)}}^N \left[ T_2(2^{r(N)} - 1) + T_2(n - 2^{r(N)} + 1) \right] - C(N) \\

&= \sum_{k=0}^{r(N) - 1} \sum_{n=2^k}^{2^{k+1}-1} T_2(2^k - 1) + \sum_{k=0}^{r(N) - 1} \sum_{n=2^k}^{2^{k+1}-1} T_2(n - 2^k + 1) \\
&+ \sum_{n=2^{r(N)}}^N T_2(2^{r(N)} - 1) + \sum_{n=2^{r(N)}}^N T_2(n - 2^{r(N)} + 1) - C(N) \\

&= \sum_{k=0}^{r(N) - 1} \sum_{n=2^k}^{2^{k+1}-1} k + \sum_{k=0}^{r(N) - 1} \sum_{n=1}^{2^k} T_2(n) \\
&+ \sum_{n=2^{r(N)}}^N r(N) + \sum_{n=1}^{N-2^{r(N)}+1} T_2(n) - C(N) \\

&= \sum_{k=0}^{r(N) - 1} k \cdot 2^k + \sum_{k=0}^{r(N) - 1} C(2^k) \\
&+ r(N) \cdot (N-2^{r(N)}+1) + C(N-2^{r(N)}+1) - C(N) \\
\end{align*}
$$

Finally we need to find formulas for $C(N)$. Clearly

$$
C(0) = 0 \\
C(1) = 1 \\
$$

And an efficient recusion is given by

$$
\begin{align*}
C(N)
&= C(2^{r(N)} - 1) + \sum_{n=2^{r(N)}}^N T_2(n) \\
&= C(2^{r(N)} - 1) + \sum_{n=0}^{N - 2^{r(N)}} \left[ 1 + T_2(n) \right] \\
&= C(2^{r(N)} - 1) + (N - 2^{r(N)} + 1) + C(N - 2^{r(N)}) \\
\end{align*}
$$
