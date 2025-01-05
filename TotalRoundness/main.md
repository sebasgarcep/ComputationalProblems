# Total Roundness

A <strong>round number</strong> is a number that ends with one or more zeros in a given base.

Let us define the <dfn>roundness</dfn> of a number $n$ in base $b$ as the number of zeros at the end of the base $b$ representation of $n$.<br>
For example, $20$ has roundness $2$ in base $2$, because the base $2$ representation of $20$ is $10100$, which ends with $2$ zeros.

Also define $R(n)$, the <dfn>total roundness</dfn> of a number $n$, as the sum of the roundness of $n$ in base $b$ for all $b > 1$.<br>
For example, $20$ has roundness $2$ in base $2$ and roundness $1$ in base $4$, $5$, $10$, $20$, hence we get $R(20)=6$.<br>
You are also given $R(10!) = 312$.

Find $R(10\,000\,000!)$. Give your answer modulo $10^9 + 7$.

## Solution

Note that

$$
R(n) = \sum_{b = 2}^n \gamma_b(n)
$$

where $\gamma_b(n)$ is the largest power $p$ of $b$ such that $b^p | n$. Let's restrict the problem to finding $R(n!)$.

If $b$ is prime we have

$$
\gamma_b(n!) = \sum_{k = 1}^\infty \left\lfloor \frac{n}{b^k} \right\rfloor
$$

Now assume $b$ is the $s$-th power of a prime $p$. Then

$$
\gamma_b(n!) = \left\lfloor \frac{\gamma_p(n!)}{s} \right\rfloor
$$

Now assume $b$ is the product of $r$ prime powers $p_1^{s_1}, \dots, p_r^{s_r}$. Then $\gamma_b(n!) = \min(\gamma_{p_1^{s_1}}(n!), \dots, \gamma_{p_r^{s_r}}(n!))$.


Let $p_1 \lt \dots \lt p_r \le n$ be the primes not greater than $n$. Then $\gamma_b(n!) = \gamma_{p_i^s}(n!)$ for some $1 \le i \le r$ and some $1 \le s \le \gamma_{p_i}(n!)$. Thus we can compute $R(n!)$ by grouping the number of terms that map to $\gamma_{p_i^s}(n!)$ leading to the formula:

$$
\begin{align*}
R(n!)
&= \sum_{i = 1}^r \sum_{s = 1}^{\gamma_{p_i}(n!)} K_{i,s} \cdot \gamma_{p_i^s}(n!) \\
\end{align*}
$$

where $K_{i,s} = A_{i,s} \cdot B_{i,s}$ and

$$
\begin{align*}
A_{i,s}
&= \prod_{1 \le j \lt i} \sum_{\substack{0 \le t \le \gamma_{p_j}(n!) \\ t = 0 \text{ or } \gamma_{p_i^s}(n!) \lt \left\lfloor \frac{\gamma_{p_j}(n!)}{t} \right\rfloor }} 1 \\
&= \prod_{1 \le j \lt i} \left( 1 + \sum_{\substack{1 \le t \le \gamma_{p_j}(n!) \\ \gamma_{p_i^s}(n!) \lt \left\lfloor \frac{\gamma_{p_j}(n!)}{t} \right\rfloor }} 1 \right) \\
&= \prod_{1 \le j \lt i} \left( 1 + \sum_{\substack{1 \le t \le \gamma_{p_j}(n!) \\ \gamma_{p_i^s}(n!) + 1  \: \le \left\lfloor \frac{\gamma_{p_j}(n!)}{t} \right\rfloor }} 1 
\right) \\
&= \prod_{1 \le j \lt i} \left( 1 + \sum_{\substack{1 \le t \le \gamma_{p_j}(n!) \\ \gamma_{p_i^s}(n!) + 1  \: \le \frac{\gamma_{p_j}(n!)}{t} }} 1 \right) \\
&= \prod_{1 \le j \lt i} \left( 1 + \sum_{\substack{1 \le t \le \gamma_{p_j}(n!) \\ t  \: \le \frac{\gamma_{p_j}(n!)}{\gamma_{p_i^s}(n!) + 1} }} 1 \right) \\
&= \prod_{1 \le j \lt i} \left( 1 + \left\lfloor \frac{\gamma_{p_j}(n!)}{\gamma_{p_i^s}(n!) + 1} \right\rfloor \right) \\
\end{align*}
$$

and

$$
\begin{align*}
B_{i,s}
&= \prod_{i \lt j \le r} \sum_{\substack{0 \le t \le \gamma_{p_j}(n!) \\ t = 0 \text{ or } \gamma_{p_i^s}(n!) \le \left\lfloor \frac{\gamma_{p_j}(n!)}{t} \right\rfloor }} 1 \\
&= \prod_{i \lt j \le r} \left( 1 + \sum_{\substack{1 \le t \le \gamma_{p_j}(n!) \\ \gamma_{p_i^s}(n!) \le \left\lfloor \frac{\gamma_{p_j}(n!)}{t} \right\rfloor }} 1 \right) \\
&= \prod_{i \lt j \le r} \left( 1 + \sum_{\substack{1 \le t \le \gamma_{p_j}(n!) \\ \gamma_{p_i^s}(n!) \le \frac{\gamma_{p_j}(n!)}{t} }} 1 \right) \\
&= \prod_{i \lt j \le r} \left( 1 + \sum_{\substack{1 \le t \le \gamma_{p_j}(n!) \\ t \: \le \frac{\gamma_{p_j}(n!)}{\gamma_{p_i^s}(n!)} }} 1 \right) \\
&= \prod_{i \lt j \le r} \left( 1 + \left\lfloor \frac{\gamma_{p_j}(n!)}{\gamma_{p_i^s}(n!)} \right\rfloor \right) \\
\end{align*}
$$

Where we have the condition $\gamma_{p_i^s}(n!) \lt \left\lfloor \frac{\gamma_{p_j}(n!)}{t} \right\rfloor$ in $A_{i,s}$ and the condition $\gamma_{p_i^s}(n!) \le \left\lfloor \frac{\gamma_{p_j}(n!)}{t} \right\rfloor$ in $B_{i,s}$ to avoid double counting terms where $\gamma_{p_i^{s_i}}(n!) = \gamma_{p_j^{s_j}}(n!)$ for $i \not= j$. Writing the whole thing out we get

$$
\begin{align*}
R(n!)
&= \sum_{i = 1}^r \sum_{s = 1}^{\gamma_{p_i}(n!)} \prod_{1 \le j \lt i} \left( 1 + \left\lfloor \frac{\gamma_{p_j}(n!)}{\gamma_{p_i^s}(n!) + 1} \right\rfloor \right) \cdot \prod_{i \lt j \le r} \left( 1 + \left\lfloor \frac{\gamma_{p_j}(n!)}{\gamma_{p_i^s}(n!)} \right\rfloor \right) \cdot \gamma_{p_i^s}(n!) \\
\end{align*}
$$

And if change the iteration variable instead to be $u = \gamma_{p_i^s}(n!)$ we get

$$
\begin{align*}
R(n!)
&= \sum_{i = 1}^r \sum_{s = 1}^{\gamma_{p_i}(n!)} \prod_{1 \le j \lt i} \left( 1 + \left\lfloor \frac{\gamma_{p_j}(n!)}{\gamma_{p_i^s}(n!) + 1} \right\rfloor \right) \cdot \prod_{i \lt j \le r} \left( 1 + \left\lfloor \frac{\gamma_{p_j}(n!)}{\gamma_{p_i^s}(n!)} \right\rfloor \right) \cdot \gamma_{p_i^s}(n!) \\
&= \sum_{u = 1}^{\gamma_{p_1}(n!)} \sum_{\substack{1 \le i \le r \\ u \le \gamma_{p_i}(n!)}} Q_{i,u} \cdot \prod_{1 \le j \lt i} \left( 1 + \left\lfloor \frac{\gamma_{p_j}(n!)}{u + 1} \right\rfloor \right) \cdot \prod_{i \lt j \le r} \left( 1 + \left\lfloor \frac{\gamma_{p_j}(n!)}{u} \right\rfloor \right) \cdot u \\
&= \sum_{u = 1}^{\gamma_{p_1}(n!)} \sum_{\substack{1 \le i \le r \\ u \le \gamma_{p_i}(n!)}} Q_{i,u} \cdot T_{i,u} \cdot u \\
\end{align*}
$$

where $Q_{i,u}$ is the number of terms that have a particular value of $u$ and $i$, and $T_{i,u}$ is just the multiplication of the two products in the middle of the term. Lets calculate $Q_{i,u}$

$$
\begin{align*}
Q_{i,u}
&= \sum_{\substack{1 \le s \le \gamma_{p_i}(n!) \\ \gamma_{p_i}^s(n!) = u}} 1 \\
&= \sum_{\substack{1 \le s \le \gamma_{p_i}(n!) \\ \left\lfloor \frac{\gamma_{p_i}(n!)}{s} \right\rfloor = u}} 1 \\
&= \sum_{\substack{1 \le s \le \gamma_{p_i}(n!) \\ u \le \frac{\gamma_{p_i}(n!)}{s} \lt u + 1}} 1 \\
&= \sum_{\substack{1 \le s \le \gamma_{p_i}(n!) \\ \frac{\gamma_{p_i}(n!)}{u + 1} \lt s \le \frac{\gamma_{p_i}(n!)}{u}}} 1 \\
&= \sum_{\substack{1 \le s \le \gamma_{p_i}(n!) \\ \left\lfloor \frac{\gamma_{p_i}(n!)}{u + 1} \right\rfloor + 1 \le s \le \left\lfloor \frac{\gamma_{p_i}(n!)}{u} \right\rfloor}} 1 \\
&= \left\lfloor \frac{\gamma_{p_i}(n!)}{u} \right\rfloor - \left\lfloor \frac{\gamma_{p_i}(n!)}{u + 1} \right\rfloor
\end{align*}
$$

Finally, for $i \gt 1$ there is a clear recursion on $T_{i,u}$ given by

$$
T_{i,u} = \frac{T_{i-1,u}}{1 + \left\lfloor \frac{\gamma_{p_i}(n!)}{u} \right\rfloor} \cdot \left( 1 + \left\lfloor \frac{\gamma_{p_{i-1}}(n!)}{u + 1} \right\rfloor \right)
$$

So we can calculate $T_{i,u}$ in constant time after the first iteration of $i$.