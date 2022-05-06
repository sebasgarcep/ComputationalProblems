# Alternating GCD Sum


For a positive integer $n$, the function $g(n)$ is defined as

$$\displaystyle g(n)=\sum_{i=1}^{n} (-1)^i \gcd \left(n,i^2\right)$$

For example, $g(4) = -\gcd \left(4,1^2\right) + \gcd \left(4,2^2\right) - \gcd \left(4,3^2\right) + \gcd \left(4,4^2\right) = -1+4-1+4=6$.<br />
You are also given $g(1234)=1233$.


Let $\displaystyle G(N) = \sum_{n=1}^N g(n)$. You are given $G(1234) = 2194708$.


Find $G(12345678)$.


## Solution

Note that

$$
\begin{align*}
G(N)
&= \sum_{n = 1}^N g(n) \\
&= \sum_{n = 1}^N \sum_{i = 1}^n (-1)^i \gcd(n, i^2) \\
&= \sum_{i = 1}^N \sum_{n = i}^N (-1)^i \gcd(n, i^2) \\
&= \sum_{i = 1}^N (-1)^i \sum_{n = i}^N \gcd(n, i^2) \\
\end{align*}
$$

Now let's prove that $\sum_{n = 1}^N \gcd(n, k) = \sum_{d \mid k} \left\lfloor N/d \right\rfloor \varphi(d)$ for a fixed $N, k$. Notice that

$$
\begin{align}
\sum_{n = 1}^N \gcd(n, k)
&= \sum_{r \mid k} \sum_{\substack{1 \le n \le N \\ \gcd(n, k) = r}} r \\
&= \sum_{r \mid k} \sum_{\substack{1 \le n \le N/r \\ \gcd(n, k/r) = 1}} r \\
&= \sum_{r \mid k} \sum_{d \mid (k/r)} \left\lfloor N/rd \right\rfloor \mu(d) \cdot r \\
&= \sum_{r \mid k} \sum_{r \mid d \mid k} \left\lfloor N/d \right\rfloor \mu(d/r) \cdot r \\
&= \sum_{d \mid k} \sum_{r \mid d} \left\lfloor N/d \right\rfloor \mu(d/r) \cdot r \\
&= \sum_{d \mid k} \left\lfloor N/d \right\rfloor \sum_{r \mid d} \mu(d/r) \cdot r \\
&= \sum_{d \mid k} \left\lfloor N/d \right\rfloor \varphi(d) \\
\end{align}
$$

where the justifications for steps 3 and 7 are in the appendix. We can use this to show that

$$
\begin{align*}
G(N)
&= \sum_{i = 1}^N (-1)^i \sum_{n = i}^N \gcd(n, i^2) \\
&= \sum_{i = 1}^N (-1)^i \cdot \left( \sum_{n = 1}^N \gcd(n, i^2) - \sum_{n = 1}^{i-1} \gcd(n, i^2) \right) \\
&= \sum_{i = 1}^N (-1)^i \sum_{d \mid i^2} \left( \left\lfloor N/d \right\rfloor - \left\lfloor (i - 1)/d \right\rfloor \right) \varphi(d) \\
\end{align*}
$$

where we use the fact that $\varphi(d) = d \prod_p (p - 1)/p$ (the iteration being over the primes that divide $d$) to optimize our calculations.

### Appendix: Step 3

This step is justified by the following fact

$$
\sum_{\substack{1 \le n \le N \\ \gcd(n, k) = 1}} 1 = \sum_{d \mid k} \left\lfloor N/d \right\rfloor \mu(d)
$$

### Proof

If $k = 1$ then the result is trivial. Fix $N$ and $k' > 1$ and suppose the result is true for $k = 1, \dots, k' - 1$. Suppose $p$ is a prime such that $p^r \mid k'$ but $p^{r+1} \nmid k'$. Then

$$
\begin{align*}
\sum_{d \mid k'} \left\lfloor N/d \right\rfloor \mu(d)
&= \sum_{e = 0}^r \sum_{d \mid (k'/p^r)} \left\lfloor N/ (d p^e) \right\rfloor \mu(d p^e) \\
&= \sum_{d \mid (k'/p^r)} \left\lfloor N/ d \right\rfloor \mu(d)
+ \sum_{d \mid (k'/p^r)} \left\lfloor N/ (dp) \right\rfloor \mu(dp) \\
&= \sum_{d \mid (k'/p^r)} \left\lfloor N/ d \right\rfloor \mu(d)
- \sum_{d \mid (k'/p^r)} \left\lfloor (N/p) / d \right\rfloor \mu(d) \\
&= \sum_{\substack{1 \le n \le N \\ \gcd(n, k' / p^r) = 1}} 1
- \sum_{\substack{1 \le n \le N/p \\ \gcd(n, k' / p^r) = 1}} 1 \\
&= \sum_{\substack{1 \le n \le N \\ \gcd(n, k' / p^r) = 1}} 1
- \sum_{\substack{1 \le n \le N \\ \gcd(n, k' / p^r) = 1 \\ p \mid n}} 1 \\
&= \sum_{\substack{1 \le n \le N \\ \gcd(n, k') = 1}} 1 \\
\end{align*}
$$

### Appendix: Step 7

The justification for this step is the formula for the Dirichlet convolution of the identity function and the mobius function. Namely $\varphi = \mu * \text{Id}$.

### Proof

Set $N = k$ in the formula proved in Appendix: Step 3. Then we get

$$
\begin{align*}
\sum_{\substack{1 \le n \le k \\ \gcd(n, k) = 1}} 1 = \sum_{d \mid k} \left\lfloor k/d \right\rfloor \mu(d)
\end{align*}
$$

But on one hand

$$
\varphi(k) = \sum_{\substack{1 \le n \le k \\ \gcd(n, k) = 1}} 1
$$

and on the other

$$
\sum_{d \mid k} \left\lfloor k/d \right\rfloor \mu(d) = \sum_{d \mid k} \mu(k/d) 
\cdot d
$$