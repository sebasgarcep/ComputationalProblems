# Twos are all you need

A positive integer, $n$, is factorised into prime factors. We define $f(n)$ to be the product when each prime factor is replaced with $2$. In addition we define $f(1)=1$.

For example, $90 = 2\times 3\times 3\times 5$, then replacing the primes, $2\times 2\times 2\times 2 = 16$, hence $f(90) = 16$.
 
Let $\displaystyle S(N)=\sum_{n=1}^{N} f(n)$. You are given $S(10^8)=9613563919$.

Find $S(10^{14})$.

## Solution

### Griff's Method

This method is taken from `griff`'s post in PE484. It describes a general approach to solving problems about sums of multiplicative functions. Suppose you have multiplicative functions $f, g$. Now define

$$
f_p(x) = \sum_{k \geq 0} f(p^k) x^k \\
g_p(x) = \sum_{k \geq 0} g(p^k) x^k \\
$$

Now assume there is a function $h_p(x)$ defined by $h_p(x) = f_p(x) / g_p(x)$. Then there is a multiplicative function $h$ given by the coefficients of $h_p(x) = \sum_{k \geq 0} h(p^k) x^k$, i.e. the $k$-th coefficient of $h_p(x)$ equals $h(p^k)$. Moreover this function satisfies $f \equiv g * h$. Before proving this let's prove that for any two multiplicative functions $g$ and $h$, their Dirichlet convolution is also multiplicative. Let $\text{gcd}(a, b) = 1$. Then

$$
\begin{align*}
(g * h)(ab)
&= \sum_{d \mid ab} g(d) \cdot h(ab / d) \\
&= \sum_{d_a \mid a} \sum_{d_b \mid b} g(d_a d_b) \cdot h(ab / d_a d_b) \\
&= \sum_{d_a \mid a} \sum_{d_b \mid b} g(d_a d_b) \cdot h((a / d_a) \cdot (b / d_b)) \\
&= \sum_{d_a \mid a} \sum_{d_b \mid b} g(d_a) \cdot g(d_b) \cdot h(a / d_a) \cdot h(b / d_b) \\
&= \sum_{d_a \mid a} g(d_a) \cdot h(a / d_a) \sum_{d_b \mid b} g(d_b) \cdot h(b / d_b) \\
&= [ \sum_{d_a \mid a} g(d_a) \cdot h(a / d_a) ] \cdot [ \sum_{d_b \mid b} g(d_b) \cdot h(b / d_b) ] \\
&= (g * h)(a) \cdot (g * h)(b) \\
\end{align*}
$$

Thus we only need to prove that $f(p^k) = (g * h)(p^k)$ in order to prove $f \equiv g * h$. To see this note that

$$
\begin{align*}
g_p(x) \cdot h_p(x)
&= \sum_{i \geq 0} g(p^i) x^i \cdot \sum_{j \geq 0} h(p^j) x^j \\
&= \sum_{n \geq 0} [ \sum_{i + j = n} g(p^i) \cdot h(p^j) ] \cdot x^n \\
&= \sum_{n \geq 0} [ \sum_{d \mid p^n} g(d) \cdot h(n / d) ] \cdot x^n \\
&= \sum_{n \geq 0} (g * h)(p^n) \cdot x^n \\
\end{align*}
$$

But $g_p(x) \cdot h_p(x) = f_p(x)$ and thus, by comparing coefficients, we get $f(p^k) = (g * h)(p^k)$.

### Applying Griff's method

A good heuristic for finding a suitable value of $g$ is to pick a multiplicative function that satisfies $f(n) = g(n)$ for squarefree $n$ and that is easily summable. Therefore we picked $g$ to be the number of divisors function. Applying Griff's method (using Wolfram Alpha to perform the tedious calculations involved) we get a function $h$ that satisfies

$$
h(1) = 1 \\
h(p) = 0 \\
h(p^k) = 2^{k - 2} \text{, for $k \geq 2$} \\
$$

As we will prove in the next section, this choice of $g$ is suitable.

### Computing $S$

Notice that $h(n) \not= 0 \iff \text{n is powerful}$. Therefore:

$$
\begin{align*}
S(N)
&= \sum_{n = 1}^N f(n) \\
&= \sum_{n = 1}^N \sum_{d \mid n} h(d) \cdot g(n / d) \\
&= \sum_{d = 1}^N \sum_{n = 1}^{N / d} h(d) \cdot g(n) \\
&= \sum_{d = 1}^N h(d) \sum_{n = 1}^{N / d} g(n) \\
&= \sum_{\substack{d = 1 \\ \text{$d$ is powerful}}}^N h(d) \cdot T(N / d) \\
\end{align*}
$$

where

$$
\begin{align*}
T(N)
&= \sum_{n = 1}^N g(n) \\
&= \sum_{n = 1}^N \sum_{d \mid n} 1 \\
&= \sum_{d = 1}^N \sum_{n = 1}^{N / d} 1 \\
&= \sum_{d = 1}^N \lfloor N / d \rfloor \\
&= \sum_{d = 1}^{\lfloor \sqrt{N} \rfloor} \lfloor N / d \rfloor + \sum_{d = \lfloor \sqrt{N} \rfloor + 1}^N \lfloor N / d \rfloor \\
\end{align*}
$$

The first sum can be calculated in $O(N^{1/2})$ time. Let's optimize the second sum using a standard method. Notice that the terms in the second sum can only take values in tha range $[1, \sqrt{N}]$. Therefore, many consecutive values of $d$ will return the same value for $\lfloor N / d \rfloor$. Fix $u = \lfloor N / d \rfloor$. Then $u \leq N / d < u + 1 \Rightarrow N / (u + 1) < d \leq N / u$. Thus

$$
\begin{align*}
\sum_{d = \lfloor \sqrt{N} \rfloor + 1}^N \lfloor N / d \rfloor 
&= \sum_{\substack{u = 1 \\ u \not= \lfloor N / u \rfloor}}^{\lfloor \sqrt{N} \rfloor} u \sum_{N / (u + 1) < d \leq N / u} 1 \\
&= \sum_{\substack{u = 1 \\ u \not= \lfloor N / u \rfloor}}^{\lfloor \sqrt{N} \rfloor} u \cdot ( \lfloor N / u \rfloor - \lfloor N / (u + 1) \rfloor ) \\
\end{align*}
$$

where we have to check that $u \not= \lfloor N / u \rfloor$ to avoid double counting values from the other sum. Thankfully this case can only happen at the upper limit of the sum. Therefore if the upper limit of the sum satisfies this condition, we just subtract $1$ from it. Notice that this sum now runs in $O(N^{1/2})$ time.

Finally, we can rapidly generate the powerful numbers using the fact that each powerful number $n = a^2 b^3$ has an unique representation such that $b$ is squarefree. Then generating these numbers is as easy as iterating over all squarefree $b$ and generating all values of $a$ such that $n = a^2 b^3 \leq N$.