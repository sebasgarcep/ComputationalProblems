# $x^y \equiv y^x$

The positive integral solutions of the equation $x^y=y^x$ are $(2,4)$, $(4,2)$ and $(k,k)$ for all $k \gt 0$.

For a given positive integer $n$, let $f(n)$ be the number of integral values $0 \lt x,y \leq n^2-n$ such that
$$x^y\equiv y^x \pmod n$$
For example, $f(5)=104$ and $f(97)=1614336$.

Let $S(M,N)=\sum f(p)$ where the sum is taken over all primes $p$ satisfying $M\le p\le N$.

You are given $S(1,10^2)=7381000$ and $S(1,10^5) \equiv 701331986 \pmod{993353399}$.

Find $S(10^{16}, 10^{16}+10^6)$. Give your answer modulo $993353399$.

## Solution

Let $p$ be a prime number. Note that the Carmichael function of $p$ is $\lambda(p) = \varphi(p) = p-1$. Therefore exponents in $\mathbb{Z}_p$ have modulo $\varphi(p) = p-1$.

Suppose $a^b \equiv c^d \pmod p$ for $1 \le a, c \le p$ and $1 \le b, d \le p-1$. Because $\gcd(p, p-1) = 1$ by the Chinese Remainder Theorem there is an unique solution modulo $p(p-1) = p^2 - p$ to the following system of modular equations

$$
\begin{align*}
x &= a \pmod p \\
x &= d \pmod {p-1} \\
y &= c \pmod p \\
y &= b \pmod {p-1} \\
\end{align*}
$$

Therefore for each tuple $(a, b, c, d)$ that satisfies $a^b \equiv c^d \pmod p$ there is an unique $(x, y)$ that satisfies $x^y \equiv y^x \pmod p$. Suppose $g_p(k)$ is the number of solutions to $a^b \equiv k \pmod p$, where $1 \le a \le p, 1 \le b \le p-1$. Fix a value of $k$. Then any two tuples $(a, b), (c, d)$ that satisfy $a^b, c^d \equiv k \pmod p$ give rise to an unique $(x, y)$ in the count of $f(p)$. But there are $g_p(k)^2$ ways to pick pairs of such tuples (they do not have to be different). This implies that $f(p) = \sum_{k=0}^{p-1} g_p(k)^2$.

Firstly, let's compute $g_p(0)$. Note that $a^b \equiv 0 \pmod p \Rightarrow a = p \Rightarrow g_p(0) = p-1$.

Before continuing let's prove that there are $\varphi(m)$ numbers in the range $[1, p-1]$ with order $m$ modulo $p$, where $m \mid p-1$. Let $\gamma_p(m)$ be the amount of numbers in the range $[1, p-1]$ with order $m$ modulo $p$. Note that $x^m \equiv 1 \pmod p$ has $m$ distinct solutions. Therefore $\sum_{d \mid m} \gamma_p(d) = m \Rightarrow \gamma_p * 1 = \text{Id} \Rightarrow \gamma_p = \text{Id} * \mu = \varphi$.

Now let's compute $g_p(k)$ for $k \gt 1$. Let

$$
h_p(m) := \sum_{\substack{1 \le k \le p-1 \\ \text{ord}_p(k) = m}} g_p(k)
$$

In particular, all of the $g_p(k)$ in the above sum have the same value (as there is a bijective map that takes from an equation of the form $a^b \equiv k \pmod p$ to an equation of the form $(a')^{b'} \equiv k' \pmod p$ when $k, k'$ have the same order). Therefore $g_p(k) = \frac{h_p(m)}{\varphi(m)}$ where $\text{ord}_p(k) = m$. Fix $m \mid p-1$. Note that for any $k$ that satisfies $k^m \equiv 1 \pmod p$ one can show that $a^b \equiv k \pmod p \Rightarrow a^{mb} \equiv 1 \pmod p$. Let's count the number of solutions to this last equation and use that to compute $h_p$. Suppose $r_p(m)$ is the number of solutions $a, b$ to $a^{mb} \equiv 1 \pmod p$. Let's suppose that $\text{ord}_p(a) = t$ where $t \mid p-1$. Let $q = \gcd(m, t)$. Then $b = r \frac{t}{q}$ where $r$ is any integer. Thus for any given $a$ that satisfies the previous condition there are $\frac{(p-1) q}{t}$ values of $b$ such that $a, b$ satisfy the equation we are studying. Because there are $\varphi(t)$ values of $a$ that satisfy $\text{ord}_p(a) = t$ we have

$$
r_p(m) = \sum_{t \mid p-1} \frac{(p-1) \gcd(m, t)}{t} \varphi(t)
$$

Note that

$$
r_p(m) = \sum_{d \mid m} h_p(d) \\
\Rightarrow r_p = h_p * 1 \\
\Rightarrow h_p = r_p * \mu \\
\Rightarrow h_p(m) = \sum_{d \mid m} r_p(d) \cdot \mu(m/d) \\
$$

Finally

$$
\begin{align*}
f(p)
&= \sum_{k=0}^{p-1} g_p(k)^2 \\
&= (p-1)^2 + \sum_{m \mid p-1} \sum_{\substack{1 \le k \le p-1 \\ \text{ord}_p(k) = m}} \frac{h_p(m)^2}{\varphi(m)^2} \\
&= (p-1)^2 + \sum_{m \mid p-1} \frac{h_p(m)^2}{\varphi(m)^2} \sum_{\substack{1 \le k \le p-1 \\ \text{ord}_p(k) = m}} 1 \\
&= (p-1)^2 + \sum_{m \mid p-1} \frac{h_p(m)^2}{\varphi(m)^2} \cdot \varphi(m) \\
&= (p-1)^2 + \sum_{m \mid p-1} \frac{h_p(m)^2}{\varphi(m)} \\
\end{align*}
$$

And we already have a nice formula for $h_p(m)$. The problem now reduces to finding the primes in the range $[M, N]$ (which can be done using a sieve over the primes no larger than $\sqrt{N}$) and computing $f$ over these primes.