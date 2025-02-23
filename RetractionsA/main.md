# Retractions A

For every integer $n > 1$, the family of functions $f_{n,a,b}$ is defined by $f_{n,a,b}(x)\equiv a x + b \mod n\,\,\, $ for $a,b,x$ integer and  $0< a <n, 0 \le b < n,0 \le x < n$. 

We will call $f_{n,a,b}$ a <i>retraction</i> if $\,\,\, f_{n,a,b}(f_{n,a,b}(x)) \equiv f_{n,a,b}(x) \mod n \,\,\,$ for every $0 \le x < n$.

Let $R(n)$ be the number of retractions for $n$.

You are given that $\displaystyle \sum_{k=1}^{99\,999} R(\binom {100\,000} k)  \equiv 628701600 \mod 1\,000\,000\,007$.
 
Find $\displaystyle \sum_{k=1}^{9\,999\,999} R(\binom {10\,000\,000} k)$.

Give your answer modulo $1\,000\,000\,007$.

## Solution

Suppose $f_{n,a,b}$ is a retraction.

$$
\begin{align*}
f_{n,a,b}(f_{n,a,b}(x)) &\equiv f_{n,a,b}(x) \pmod n \\
\Rightarrow \: a(ax + b) + b &\equiv ax + b \pmod n \\
\Rightarrow \: a^2 x + ab + b &\equiv ax + b \pmod n \\
\Rightarrow \: (a^2 - a) x + ab &\equiv 0 \pmod n \\
\end{align*}
$$

Suppose $p$ is a prime such that $p \mid n$. Then for $0 \le x \le p -1$ we have $(a^2 - a) x + ab \equiv 0 \pmod p$. Suppose $a^2 - a \not\equiv 0 \pmod p$. Then $x \equiv -ab(a^2 - a)^{-1} \pmod p$, which is not possible since $x$ is not constant. Therefore $a^2 - a \equiv 0 \pmod p$ and $ab \equiv 0 \pmod p$. Now pick a value of $2 \le k \le \nu_p(n)$ and suppose $a^2 - a \equiv 0 \pmod {p^{k-1}}$, $ab \equiv 0 \pmod {p^{k-1}}$. Suppose $a^2 - a = u \cdot p^{k-1}$ and $ab = v \cdot p^{k-1}$. Then

$$
\begin{align*}
(a^2 - a) x + ab &\equiv 0 \pmod {p^k} \\
\Rightarrow \: u \cdot p^{k-1} \cdot x + v \cdot p^{k-1} &\equiv 0 \pmod {p^k} \\
\Rightarrow \: u \cdot x + v &\equiv 0 \pmod {p} \\
\Rightarrow \: u \equiv  v &\equiv 0 \pmod {p} \\
\end{align*}
$$

Thus $a^2 - a \equiv 0 \pmod {p^{\nu_p(n)}}$ and $ab \equiv 0 \pmod {p^{\nu_p(n)}}$. This implies that $a^2 - a \equiv 0 \pmod n$ and $ab \equiv 0 \pmod n$.

Now suppose $a^2 - a \equiv 0 \pmod n$. Let $\gcd(a, n) = d$. Then $b$ can be either of $0 \cdot \frac{n}{d}, 1 \cdot \frac{n}{d}, \dots, (d - 1) \cdot \frac{n}{d}$. So there are $d$ possible choices for $b$ given $a$.

Suppose $n = p^r$ for some prime $p$. Then $a^2 \equiv a \pmod {p^r}$ has only two solutions: $a=0$ and $a=1$. To prove this note that $p$ either divides $a$ or $a-1$. Therefore $a^2 - a \equiv a(a-1) \equiv 0 \pmod {p^r}$ implies either $p^r \mid a$ or $p^r \mid a-1$. The first case implies $a \equiv 0 \pmod {p^r}$ and the latter case implies $a \equiv 1 \pmod {p^r}$.

Now suppose $n = p_1^{r_1} \cdots p_k^{r_k}$. Then by the chinese remainder theorem there are $2^k$ solutions to $a^2 - a \equiv 0 \pmod n$. This implies that

$$
R(n) = \prod_{i = 1}^k (1 + p_i^{r_i}) - n
$$

where we subtract the case $a \equiv 0 \pmod n$. Let $Q(n)$ be the product in this formula. Then $R(n) = Q(n) - n$. Therefore

$$
\begin{align*}
S(n)
&= \sum_{k=1}^{n-1} R \binom{n}{k} \\
&= \sum_{k=1}^{n-1} Q \binom{n}{k} - \sum_{k=1}^{n-1} \binom{n}{k} \\
&= \sum_{k=1}^{n-1} Q \binom{n}{k} - (2^n - 2) \\
\end{align*}
$$

Note that for $k \ge 1$

$$
\binom{n}{k} = \binom{n}{k-1} \cdot \frac{n-k+1}{k}
$$

So we can build $Q \binom{n}{k}$ iteratively by taking $Q \binom{n}{k-1}$ and only changing the parts affected by the factors of $\frac{n-k+1}{k}$.