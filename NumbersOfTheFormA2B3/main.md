# Numbers of the form $a^2 b^3$


Define $F(n)$ to be the number of integers $x≤n$ that can be written in the form $x=a^2b^3$, where $a$ and $b$ are integers not necessarily different and both greater than 1.

For example, $32=2^2\times 2^3$  and $72=3^2\times 2^3$ are the only two integers less than 100 that can be written in this form. Hence, $F(100)=2$.

Further you are given $F(2\times 10^4)=130$ and $F(3\times 10^6)=2014$.

Find $F(9\times 10^{18})$.

## Solution

Let

$$
F'(N) = P(N) - F(N)
$$

where $P(N)$ is the function that counts powerful numbers.

Consider $p^k$ where $p$ is prime. If $k \geq 8$, then you can split $p^k$ into $p^{k - 6} \cdot p^{6}$ if $k$ is even, and $p^{k - 3} \cdot p^{3}$ if $k$ is odd. In both cases the exponents are greater than $0$, which means that a number divisible by $p^k$ will be ignored by $F'$.

If $k = 5, 7$ then $p^k = p^{k - 3} \cdot p^3$, where each exponent is greater than $0$. Therefore any number divisible by $p^k$ will be ignored by $F'$. Thus we are left with the cases $k = 2, 3, 4, 6$.

Notice that if $k = 6$, then we can split $p^k = (p^3)^2 = (p^2)^3$. Thus $p^k$ will be considered by $F'$ only by itself. Thus this case can be counted with the formula $\pi(N^{1/6})$, where $\pi$ is the prime counting function.

If $k = 3$ then $p^k$ will clearly be considered by $F'$, and it is only compatible with other primes raised to $3$. Thus this case can be counted with the formula $Q(N^{1/3}) - 1$, where $Q$ is the function that counts squarefree numbers, and we substract $1$ to ignore the case $1^3 = 1$ as it will be counted in the next case.

If $k = 2, 4$ then $p^k$ will clearly be considered by $F'$, and it is only compatible with other primes raised to $2, 4$. Thus these will be numbers of the form $x^4 y^2$ where $\text{gcd}(x, y) = 1$. These numbers can be counted with the following formula:

$$
\begin{align*}
\sum_{\substack{\mu(x) \not= 0 \\ x^4 \leq N}} \sum_{\substack{\mu(y) \not=0 \\ x^4 y^2 \leq N \\ \text{gcd}(x, y) = 1}} 1
&= \sum_{\substack{\mu(x) \not= 0 \\ x \leq N^{1/4}}} \sum_{\substack{\mu(y) \not=0 \\ y \leq N^{1/2} / x^2 \\ \text{gcd}(x, y) = 1}} 1
&= \sum_{\substack{\mu(x) \not= 0 \\ x \leq N^{1/4}}} Q_{x}(N^{1/2} / x^2)
\end{align*}
$$

where

$$
Q_{x}(L) = \sum_{\substack{\mu(y) \not= 0 \\ y \leq L \\ \text{gcd}(x, y) = 1}} 1
$$

Thus everything can be summed up to the following formula

$$
F'(N) = \pi(N^{1/6}) + Q(N^{1/3}) - 1 + \sum_{\substack{\mu(x) \not= 0 \\ x \leq N^{1/4}}} Q_{x}(N^{1/2} / x^2)
$$

There is a simple recurrence relation for $Q_{x}$ given by

$$
\begin{align*}
Q_{x}(L)
&= \sum_{\substack{\mu(y) \not= 0 \\ y \leq L \\ \text{gcd}(x, y) = 1}} 1 \\
&= \sum_{d \mid x} \mu(d) \sum_{\substack{\mu(y) \not= 0 \\ y \leq L \\ d \mid y}} 1 \\
&= \sum_{d \mid x} \mu(d) \sum_{\substack{\mu(y) \not= 0 \\ y \leq L / d \\ \text{gcd}(d, y) = 1}} 1 \\
&= \sum_{d \mid x} \mu(d) \cdot Q_{d}(L / d) \\
\end{align*}
$$

with base case $Q_{1} \equiv Q$.

Finally $P(N)$ can be computed using the formula

$$
P(N) = \sum_{\substack{\mu(i) \not= 0}} \lfloor \sqrt{N / i^3} \rfloor
$$

To prove this formula note that any powerful number $n = a^2 b^3$ has a unique expression such that $b$ is squarefree. In this expression $a^2 \leq N / b^3 \Rightarrow a \leq \sqrt{N / b^3}$. Thus if we count the possible values of $a$ over all squarefree $b$ we get the desired formula.