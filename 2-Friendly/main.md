# 2-Friendly

Two positive integers $a$ and $b$ are <em>2-friendly</em> when $\gcd(a,b) = 2^t, t>0$. For example, 24 and 40 are 2-friendly because $\gcd(24,40) = 8 = 2^3$ while 24 and 36 are not because $\gcd(24,36) = 12 = 2^2\cdot 3$ not a power of 2.

Let $f(n)$ be the number of pairs, $(p,q)$, of positive integers with $1\le p\lt q\le n$ such that $p$ and $q$ are 2-friendly. You are given $f(10^2) = 1031$ and $f(10^6) = 321418433$ modulo $1\,000\,000\,007$.

Find $f(10^{11})$ modulo $1\,000\,000\,007$.

## Solution

Notice that $a$ and $b$ can only be 2-friendly if both $a$ and $b$ are even. Therefore

$$
\begin{align*}
f(n)
&= \sum_{2 \leq a \leq n} \sum_{\substack{1 \leq b \leq a - 1 \\ \\ \text{gcd}(a, b) = 2^t, \: t > 0}} 1 \\
&= \sum_{\substack{2 \leq a \leq n \\ 2 \mid a}} \sum_{\substack{1 \leq b \leq a - 1 \\ \\ 2 \mid b \\ \\ \text{gcd}(a, b) = 2^t, \: t > 0}} 1 \\
&= \sum_{2 \leq 2a \leq n} \sum_{\substack{1 \leq 2b \leq 2a - 1 \\ \\ \text{gcd}(2a, 2b) = 2^t, \: t > 0}} 1 \\
&= \sum_{1 \leq a \leq n / 2} \sum_{\substack{1 \leq b \leq a - 1 \\ \\ \text{gcd}(a, b) = 2^t}} 1 \\
&= \sum_{2 \leq a \leq n / 2} \sum_{\substack{1 \leq b \leq a - 1 \\ \\ \text{gcd}(a, b) = 2^t}} 1 \\
&= \sum_{2 \leq a \leq n / 2} \sum_{\substack{1 \leq b \leq a - 1 \\ \\ \text{gcd}(a, b) = 1}} 1
+ \sum_{1 \leq a \leq n / 2} \sum_{\substack{1 \leq b \leq a - 1 \\ \\ \text{gcd}(a, b) = 2^t, \: t > 0}} 1 \\
&= \sum_{2 \leq a \leq n / 2} \varphi(a) + f(n / 2) \\
&= \sum_{1 \leq a \leq n / 2} \varphi(a) - \varphi(1) + f(n / 2) \\
&= \sum_{1 \leq a \leq n / 2} \varphi(a) - 1 + f(n / 2) \\
\end{align*}
$$

Let $S(N) = \sum_{n = 1}^N \varphi(n)$. Then

$$
\begin{align*}
f(n)
&= S(n / 2) - 1 + f(n / 2) \\
&= S(n / 2) - 1 + S(n / 4) - 1 + f(n / 4) \\
&\cdots \\
&= S(n / 2) - 1 + S(n / 4) - 1 + S(n / 8) - 1 + \cdots \\
\end{align*}
$$

And we already have an efficient method of calculating $S$ from the Hexagonal Orchard problem.