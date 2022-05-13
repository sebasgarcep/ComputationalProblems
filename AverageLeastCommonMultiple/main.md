# Average least common multiple

The function <b>lcm</b>(a,b) denotes the least common multiple of a and b.<br />
Let A(n) be the average of the values of lcm(n,i) for 1≤i≤n.<br />
E.g: A(2)=(2+2)/2=2 and A(10)=(10+10+30+20+10+30+70+40+90+10)/10=32. 

Let S(n)=<span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> A(k) for 1≤k≤n.<br />
S(100)=122726.

Find S(99999999019) mod 999999017.

## Solution

Note that

$$
\begin{align*}
A(k)
&= \frac{1}{k} \sum_{i=1}^k \text{lcm}(k, i) \\
&= \frac{1}{k} \sum_{i=1}^k \frac{ni}{\gcd(k, i)} \\
&= \sum_{d \mid k} \sum_{\substack{1 \le i \le k \\ \gcd(k, i) = d}} \frac{i}{d} \\
&= \sum_{d \mid k} \sum_{\substack{1 \le i \le k/d \\ \gcd(k/d, i) = 1}} i \\
&= \sum_{d \mid k} \sum_{\substack{1 \le i \le d \\ \gcd(d, i) = 1}} i \\
&= \sum_{d \mid k} \sum_{r \mid d} r \cdot T(d/r) \cdot \mu(r) \\
&= \sum_{d \mid k} \sum_{r \mid d} \frac{d}{r} \cdot T(r) \cdot \mu(d/r) \\
&= \frac{1}{2} \sum_{d \mid k} d \sum_{r \mid d} (r + 1) \cdot \mu(d/r) \\
&= \frac{1}{2} \left( \sum_{d \mid k} d \sum_{r \mid d} r \cdot \mu(d/r)
+ \sum_{d \mid k} d \sum_{r \mid d} \mu(d/r) \right) \\
&= \frac{1}{2} \left( \sum_{d \mid k} d \cdot \varphi(d)
+ \sum_{d \mid k} d \cdot \epsilon(d) \right) \\
&= \frac{1}{2} \left( \sum_{d \mid k} d \cdot \varphi(d) + 1 \right) \\
\end{align*}
$$

where $T(n) = n(n+1)/2$. To justify some of the steps we must use the facts that $\epsilon = \mu * 1$ and $\varphi = \text{Id} * \mu$, where $*$ is the Dirichlet convolution. The first we already know. The second is a result of applying the Exclusion-Inclusion principle to compute the Euler totient function. Thus

$$
\begin{align*}
S(n)
&= \sum_{k=1}^n A(k) \\
&= \frac{1}{2} \left( \sum_{k=1}^n \sum_{d \mid k} d \cdot \varphi(d) + \sum_{k=1}^n 1 \right) \\
&= \frac{1}{2} \left( \sum_{d=1}^n \sum_{k=1}^{\left\lfloor n/d \right\rfloor} d \cdot \varphi(d) + n \right) \\
&= \frac{1}{2} \left( \sum_{d=1}^n \left\lfloor n/d \right\rfloor d \cdot \varphi(d) + n \right) \\
\end{align*}
$$

Let $R(n) = \sum_{d=1}^n \left\lfloor n/d \right\rfloor d \cdot \varphi(d)$. Then $S(n) = (R(n) + n)/2$, and the problem reduces to efficiently computing $R(n)$. Consider the associated sums $Q(n) = \sum_{d=1}^n d \cdot \varphi(d), P(n)=\sum_{d=1}^n d^2 = n(n+1)(2n+1)/6$. Then

$$
\begin{align*}
\sum_{k=1}^n k \cdot Q(\left\lfloor n/k \right\rfloor)
&= \sum_{k=1}^n k \sum_{\substack{1 \le d \le n/k}} d \cdot \varphi(d) \\
&= \sum_{k=1}^n \sum_{\substack{1 \le kd \le n}} kd \cdot \varphi(d) \\
&= \sum_{m=1}^n \sum_{d \mid m} m \cdot \varphi(d) \\
&= \sum_{m=1}^n m \sum_{d \mid m} \varphi(d) \\
&= \sum_{m=1}^n m \cdot m \\
&= P(n) \\
\end{align*}
$$

where the third step is obtained by setting $m = kd$, and the fourth step is justified by $\varphi = \text{Id} * \mu \iff \text{Id} = \varphi * 1$. This formula allows us to efficiently compute $Q(n)$ recursively using the square of splitting down the square root of the iteration upper bound. Finally note that

$$
\begin{align*}
R(n)
&= \sum_{d=1}^n \left\lfloor n/d \right\rfloor d \cdot \varphi(d) \\

&= \sum_{d=1}^{\left\lfloor \sqrt{n} \right\rfloor} \left\lfloor n/d \right\rfloor d \cdot \varphi(d)
+ \sum_{d=\left\lfloor \sqrt{n} \right\rfloor + 1}^n \left\lfloor n/d \right\rfloor d \cdot \varphi(d) \\

&= \sum_{d=1}^{\left\lfloor \sqrt{n} \right\rfloor} \left\lfloor n/d \right\rfloor d \cdot \varphi(d)
+ \sum_{\substack{1 \le u \le \left\lfloor \sqrt{n} \right\rfloor \\ u \not= \left\lfloor n/u \right\rfloor}} u \sum_{d = \left\lfloor n/(u+1) \right\rfloor + 1}^{\left\lfloor n/u \right\rfloor} d \cdot \varphi(d) \\

&= \sum_{d=1}^{\left\lfloor \sqrt{n} \right\rfloor} \left\lfloor n/d \right\rfloor d \cdot \varphi(d)
+ \sum_{\substack{1 \le u \le \left\lfloor \sqrt{n} \right\rfloor \\ u \not= \left\lfloor n/u \right\rfloor}} u \cdot \left( Q(\left\lfloor n/u \right\rfloor) - Q(\left\lfloor n/(u+1) \right\rfloor) \right) \\
\end{align*}
$$

which is just an application of this same trick.