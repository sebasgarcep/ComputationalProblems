# Retractions C


For every integer $n>1$, the family of functions $f_{n,a,b}$ is defined 
by  <br />
$f_{n,a,b}(x)\equiv a x + b \mod n\,\,\, $ for $a,b,x$ integer and  $0< a <n, 0 \le b < n,0 \le x < n$. 

We will call $f_{n,a,b}$ a <i>retraction</i> if $\,\,\, f_{n,a,b}(f_{n,a,b}(x)) \equiv f_{n,a,b}(x) \mod n \,\,\,$ for every $0 \le x < n$.<br />
Let $R(n)$ be the number of retractions for $n$.


$\displaystyle F(N)=\sum_{n=2}^N R(n)$. <br /> 
$F(10^7)\equiv 638042271 \mod 1\,000\,000\,007$.<br />

Find $F(10^{14})$.<br />
Give your answer modulo $1\,000\,000\,007$.

## Solution

From Retractions A we know that $R(n) = Q(n) - n$, where if $n$ factors as $p_1^{r_1} \dots p_k^{r_k}$ then $Q(n) = \prod_{i = 1}^k (1 + p_i^{r_i}) = \sum_{\substack{d \mid n \\ \gcd(d, n/d) = 1}} d$. That is, $Q(n)$ is the sum of unitary divisors of $n$. Note also that

$$
\begin{align*}
F(N)
&= \sum_{2 \le n \le N} R(n) \\
&= \sum_{2 \le n \le N} \left[ Q(n) - n \right] \\
&= \sum_{1 \le n \le N} \left[ Q(n) - n \right] \\
&= \sum_{1 \le n \le N} Q(n) - \sum_{1 \le n \le N} n \\
&= \sum_{1 \le n \le N} Q(n) - \Sigma_1(N) \\
\end{align*}
$$

where $\Sigma_1(N) = \sum_{1 \le n \le N} n = \frac{N(N+1)}{2}$. Let $W(N) := \sum_{1 \le n \le N} Q(n)$. Then

$$
\begin{align*}
W(N)

&= \sum_{1 \le n \le N} Q(n) \\

&= \sum_{1 \le n \le N} \sum_{\substack{d \mid n \\ \gcd(d, n/d) = 1}} d \\

&= \sum_{1 \le d \le N} d \sum_{\substack{1 \le k \le N/d \\ \gcd(d, k) = 1}} 1 \\

&= \sum_{1 \le d \le N} d \sum_{q \mid d} \mu(q) \cdot \left\lfloor N/(d \cdot q) \right\rfloor \\

&= \sum_{\substack{1 \le q \le N}} \sum_{1 \le k \le N/q} k \cdot q \cdot \mu(q) \cdot \left\lfloor N/(k \cdot q^2) \right\rfloor \\

&= \sum_{\substack{1 \le q \le \sqrt{N}}} q \cdot \mu(q) \sum_{1 \le k \le N/q^2} k \cdot \left\lfloor (N/q^2)/k \right\rfloor \\
\end{align*}
$$

Let $G(N) = \sum_{1 \le k \le N} k \cdot \left\lfloor N/k \right\rfloor$. Then $W(N) = \sum_{1 \le q \le \sqrt{N}} q \cdot \mu(q) \cdot G(N/q^2)$. Thus the problem reduces to finding an efficient formula for $G(N)$. Note that

$$
\begin{align*}
G(N)

&= \sum_{1 \le k \le N} k \cdot \left\lfloor N/k \right\rfloor \\

&= \sum_{1 \le k \le \sqrt{N}} k \cdot \left\lfloor N/k \right\rfloor + \sum_{\sqrt{N} \lt k \le N} k \cdot \left\lfloor N/k \right\rfloor \\

&= \sum_{1 \le k \le \sqrt{N}} k \cdot \left\lfloor N/k \right\rfloor + \sum_{\substack{1 \le u \le \sqrt{N} \\ u \not= \left\lfloor N/u \right\rfloor }} u \sum_{\frac{N}{u+1} \lt k \le \frac{N}{u}} k \\

&= \sum_{1 \le k \le \sqrt{N}} k \cdot \left\lfloor N/k \right\rfloor + \sum_{\substack{1 \le u \le \sqrt{N} \\ u \not= \left\lfloor N/u \right\rfloor }} u \cdot (\Sigma_1(N/u) - \Sigma_1(N/(u+1))) \\
\end{align*}
$$
