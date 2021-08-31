# Sum of largest prime factors

Let $f(n)$ be the largest prime factor of $n$ and $\displaystyle F(n) = \sum_{i=2}^{n}f(i)$.<br />
For example $F(10)=32$, $F(100)=1915$ and $F(10000)=10118280$.

Find $F(201820182018)$. Give your answer modulus $10^9$.

## Solution

Let $F(x, k)$ be the sum of the largest prime factor of all $1 \leq n \leq x$, such that $p_1, \dots, p_k \nmid n$, where $p_i$ is the $i$-th prime. Then

$$
F(x, k) = \sum_{\substack{2 \leq n \leq x \\ \\ p_1, \dots, p_k \nmid n}} \text{lpf}(n)
$$

Let $a(x) = \pi(\sqrt{x}), b(x) = \pi(x)$. Then

$$
F(x, k)
= \sum_{i = k + 1}^{b(x)} \sum_{\substack{1 \leq n \leq x / p_i \\ \\ p_1, \dots, p_{i - 1} \nmid n}} \text{lpf}(n \cdot p_i)
$$

Notice that if $a(x) + 1 \leq i \leq b(x)$ then $p_i > \sqrt{x} \Rightarrow n \leq x/p_i < \sqrt{x} < p_i \Rightarrow n < p_i$. Therefore $\text{lpf}(n p_i) = p_i$. Thus

$$
\begin{align*}
F(x, k)
&= \sum_{i = k + 1}^{a(x)} \sum_{\substack{1 \leq n \leq x / p_i \\ \\ p_1, \dots, p_{i - 1} \nmid n}} \text{lpf}(n \cdot p_i)
+ \sum_{i = a(x) + 1}^{b(x)} \sum_{\substack{1 \leq n \leq x / p_i \\ \\ p_1, \dots, p_{i - 1} \nmid n}} \text{lpf}(n \cdot p_i) \\
&= \sum_{i = k + 1}^{a(x)} \sum_{\substack{1 \leq n \leq x / p_i \\ \\ p_1, \dots, p_{i - 1} \nmid n}} \text{lpf}(n \cdot p_i)
+ \sum_{i = a(x) + 1}^{b(x)} p_i \\
&= \sum_{i = k + 1}^{a(x)} \sum_{\substack{2 \leq n \leq x / p_i \\ \\ p_1, \dots, p_{i - 1} \nmid n}} \text{lpf}(n \cdot p_i)
+ \sum_{i = k + 1}^{a(x)} p_i
+ \sum_{i = a(x) + 1}^{b(x)} p_i \\
&= \sum_{i = k + 1}^{a(x)} \sum_{\substack{2 \leq n \leq x / p_i \\ \\ p_1, \dots, p_{i - 1} \nmid n}} \text{lpf}(n \cdot p_i)
+ \sum_{i = k + 1}^{b(x)} p_i
\end{align*}
$$

Let $\Sigma\pi(x) = \sum_{i = 1}^{b(x)} p_i$. Then

$$
F(x, k)
= \sum_{i = k + 1}^{a(x)} \sum_{\substack{2 \leq n \leq x / p_i \\ \\ p_1, \dots, p_{i - 1} \nmid n}} \text{lpf}(n \cdot p_i)
+ \Sigma\pi(x) - \Sigma\pi(p_k)
$$

Notice that because $n \geq 2$ and $p_1, \dots, p_{i-1}$, then at least one of $p_i, p_{i + 1}, \dots$ divides $n$. Therefore $\text{lpf}(n) \geq \text{lpf}(p_i)$ and thus $\text{lpf}(n \cdot p_i) = \text{lpf}(n)$. Thus

$$
\begin{align*}
F(x, k)
&= \sum_{i = k + 1}^{a(x)} \sum_{\substack{2 \leq n \leq x / p_i \\ \\ p_1, \dots, p_{i - 1} \nmid n}} \text{lpf}(n)
+ \Sigma\pi(x) - \Sigma\pi(p_k) \\
&= \sum_{i = k + 1}^{a(x)} F(x / p_i, i - 1)
+ \Sigma\pi(x) - \Sigma\pi(p_k) \\
\end{align*}
$$

Finally, $F(N) = F(N, 0)$.

## Computing Prime Sum ($\Sigma\pi$)

The prime sum can be calculated efficiently combining Lucy Hedgehog's method with Meissel's method. Let $\phi_\Sigma(x, a)$ be the sum of all numbers that are not divisible by $p_1, \dots, p_a$. Let $P_{\Sigma,k}(x,a)$ be the sum of the terms in $\phi_\Sigma(x, a)$ with exactly $k$ prime factors. Then

$$
\phi_\Sigma(x, a) = \sum_{k \geq 0} P_{\Sigma,k}(x,a)
$$

Clearly $P_{\Sigma,0}(x, a) = 1, P_{\Sigma,1}(x, a) = \sum_{i = a + 1}^{\pi(x)} p_i = \Sigma\pi(x) - \Sigma\pi(p_a)$. We can also calculate $P_{\Sigma,2}(x, a)$ as

$$
\begin{align*}
P_{\Sigma,2}(x, a)
&= \sum_{\substack{p_i p_j \leq x \\ \\ i, j, > a}} p_i p_j \\
&= \sum_{i = a + 1}^{\pi(\sqrt{x})} p_i \sum_{\substack{p_i \leq p_j \leq x / p_i}} p_j \\
&= \sum_{i = a + 1}^{\pi(\sqrt{x})} p_i [ \Sigma\pi(x / p_i) - \Sigma\pi(p_i - 1) ] \\
\end{align*}
$$

Finally, let's prove the following recurrence relation for $\phi_{\Sigma}(x,a)$

$$
\begin{align*}
\phi_{\Sigma}(x, a)
&= \sum_{\substack{1 \leq n \leq x \\ \\ p_1, \dots, p_a \nmid n}} n \\
&= \sum_{\substack{1 \leq n \leq x \\ \\ p_1, \dots, p_{a+1} \nmid n}} n
+ \sum_{\substack{1 \leq n p_{a+1} \leq x \\ \\ p_1, \dots, p_a \nmid n}} n p_{a+1} \\
&= \sum_{\substack{1 \leq n \leq x \\ \\ p_1, \dots, p_{a+1} \nmid n}} n
+ p_{a+1} \sum_{\substack{1 \leq n \leq x / p_{a+1} \\ \\ p_1, \dots, p_a \nmid n}} n \\
&= \phi_{\Sigma}(x, a+1) + p_{a+1} \phi_{\Sigma}(x / p_{a + 1}, a) \\
\end{align*}
$$

Or rewritten in a more usable form

$$
\phi_{\Sigma}(x, a) = \phi_{\Sigma}(x, a-1) - p_a \phi_{\Sigma}(x / p_a, a-1)
$$

The base cases for this recurrence are $\phi_{\Sigma}(0,a) = 0, \phi_{\Sigma}(x,0) = T(x)$, where $T(x)$ is the $x$-th triangular number. Additionally, we can further optimize this recurrence by noticing that if $a \geq \pi(\sqrt{x})$, then $\phi_{\Sigma}(x, a) = 1 + \Sigma\pi(x) - \Sigma\pi(p_a)$.

Finally, if $\pi(\sqrt[3]{x}) \leq a < \pi(\sqrt{x})$ then $\phi_{\Sigma}(x, a) = 1 + \Sigma\pi(x) - \Sigma\pi(p_a) + P_{\Sigma,2}(x,a)$. We can now isolate $\Sigma\pi(x)$ to get a formula for calculating it efficiently. In our implementation we pick $a = \pi(\sqrt[3]{x})$.