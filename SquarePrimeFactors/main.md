# Square Prime Factors

For an integer $n$, we define the <i>square prime factors</i> of $n$ to be the primes whose square divides $n$. For example, the square prime factors of $1500=2^2 \times 3 \times 5^3$ are $2$ and $5$.

Let $C_k(N)$ be the number of integers between $1$ and $N$ inclusive with exactly $k$ square prime factors. You are given some values of $C_k(N)$ in the table below.

Find the product of all non-zero $C_k(10^{16})$. Give the result reduced modulo $1\,000\,000\,007$.

## Solution

Define $\tau(n)$ for squarefree $n$ to be the number of distinct prime factors in $n$. If $n$ is not squarefree, then let $\tau(n) = -1$ (it can be any value, as long as $\tau(n) \not\in \{ 0, 1, \dots \}$). Let

$$
T_{i}(N) = \sum_{\substack{1 \leq n^2 \leq N \\ \\ \tau(n) = i}} \lfloor N / n^2 \rfloor
$$

Now let's prove that

$$
C_{k}(N) = {k \choose k} T_{k}(N) - {k + 1 \choose k} T_{k + 1}(N) + {k + 2 \choose k} T_{k + 2}(N) - \dots
$$

Clearly, if $k = 0$, this function reduces to the squarefree counting function. Thus, assume $k > 0$. Fix a value of $k$. Then any number with exactly $k$ distinct, square prime factors will be divisible by the square of a squarefree number with exactly $k$ distinct prime factors. Thus $C_{k}(N)$ can be approximated with $T_{k}(N)$. But any number divisible by $k + 1, k + 2, \dots$ distinct squares of primes is divisible by $k$ squares of primes. Thus we have to exclude those numbers from the count.

Let's start with $k + 1$. In particular, a term divisible by the square of a squarefree number $d$ with $k + 1$ prime factors will be counted in the sum of each of the ${k + 1 \choose k}$ divisors of $d$ with $k$ prime factors. Therefore a better approximation for $C_{k}(N)$ is $T_{k}(N) - {k + 1 \choose k} T_{k + 1}(N)$.

But the subtraction term will oversubtract terms divisible by $k + 2$ squares of primes. In particular the contribution from both terms to the count of number divisibles by $k + 2$ squares of primes until this point will be ${k + 2 \choose k} - {k + 1 \choose k} {k + 2 \choose k + 1} = - {k + 2 \choose k}$. To cancel it out we need to add ${k + 2 \choose k} T_{k + 2}(N)$. A better approximation for $C_{k}(N)$ becomes $T_{k}(N) - {k + 1 \choose k} T_{k + 1}(N) + {k + 2 \choose k} T_{k + 2}(N)$.

For $k + 3$ we need to correct ${k + 3 \choose k} - {k + 1 \choose k} {k + 3 \choose k + 1} + {k + 2 \choose k} {k + 3 \choose k + 2} = {k + 3 \choose k}$, which we need to correct with the term $- {k + 3 \choose k} T_{k + 3}(N)$.

In general, for $k + u$, we have to correct the following sum

$$
\begin{align*}
\sum_{i = 0}^{u - 1} (-1)^i {k + i \choose k} {k + u \choose k + i}
&= \sum_{i = 0}^{u - 1} (-1)^i \frac{(k + i)!}{k! \cdot i!} \frac{(k + u)!}{(k + i)! \cdot (u - i)!} \\
&= \sum_{i = 0}^{u - 1} (-1)^i \frac{(k + u)!}{k! \cdot i! \cdot (u - i)!} \\
&= \frac{(k + u)!}{k! \cdot u!} \sum_{i = 0}^{u - 1} (-1)^i \frac{u!}{i! \cdot (u - i)!} \\
&= {k + u \choose k} \sum_{i = 0}^{u - 1} (-1)^i {u \choose i} \\
&= {k + u \choose k} \cdot [\sum_{i = 0}^{u} (-1)^i {u \choose i} - (-1)^u] \\
&= {k + u \choose k} \cdot [(1 - 1)^u - (-1)^u] \\
&= (-1)^{u + 1} {k + u \choose k} \\
\end{align*}
$$

Therefore the coefficient for $k + u$ is

$$
(-1)^u {k + u \choose k}
$$