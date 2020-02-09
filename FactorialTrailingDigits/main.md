# Factorial Trailing Digits

Let $c$ be the number of trailing zeroes in the base-10 representation of $n!$. Therefore:

$$f(n) \equiv \frac{n!}{10^c} \: (\text{mod} \: 10^5)$$

Let $A(k)$ be the largest power of $2$ that divides $k$. Similarly, let $B(k)$ be the largest power of $5$ that divides $k$. Let:

$$a = \sum_{k \leq n} A(k) = \sum_i \lfloor \frac{n}{2^i} \rfloor$$
$$b = \sum_{k \leq n} B(k) = \sum_i \lfloor \frac{n}{5^i} \rfloor$$

Notice that $a \geq b$, thus $c = b$. So our problem reduces to calculating:

$$f(n) \equiv \frac{n!}{2^a 5^b} 2^{a - b} \: (\text{mod} \: 10^5)$$

Finding $2^{a - b} \: (\text{mod} \: 10^5)$ is trivial, therefore we are interested in calculating $\frac{n!}{2^a 5^b} \: (\text{mod} \: 10^5)$. This is equivalent to multiplying all numbers from $1$ to $n$ modulo $10^5$, but with all powers of $2$ and $5$ divided out of them, i.e. multiplying the $g(k) := \frac{k}{2^{A(k)} 5^{B(k)}}$.

Notice that:

$$f(n) = 2^{a - b} \prod_{k \leq n} \frac{k}{d_k}$$

where $d_k = 2^{A(k)} 5^{B(k)}$. Let:

$$h(n) = \prod_{k \leq n} \frac{k}{d_k}$$

Then:

$$f(n) = 2^{a - b} h(n)$$

and:

$$h(n) = \prod_{k \leq n, \: (k, 10) = 1} k \prod_{k \leq n, \: (k, 10) = 2} \frac{k}{2 d_{k / 2}} \prod_{k \leq n, \: (k, 10) = 5} \frac{k}{5 d_{k/5}} / \prod_{k \leq n, \: (k, 10) = 10} \frac{k}{10 d_{k / 10}}$$

Let $u(n) = \prod_{k \leq n, \: (k, 10) = 1} k$. Then:

$$h(n) = u(n) \prod_{k \leq \frac{n}{2}} \frac{k}{d_k} \prod_{k \leq \frac{n}{5}} \frac{k}{d_k} / \prod_{k \leq \frac{n}{10}} \frac{k}{d_k}$$
$$h(n) = u(n) \: h(\lfloor \frac{n}{2} \rfloor) \: h(\lfloor \frac{n}{5} \rfloor) \: h(\lfloor \frac{n}{10} \rfloor)^{-1}$$

Therefore we are left with how to efficiently compute $u(n) \: (\text{mod} \: 10^5)$. Notice that:

$$u(n) = \prod_{k \leq n, \: (k, 10) = 1} k = (\prod_{k \leq 10^5, \: (k, 10) = 1} k)^{\lfloor \frac{n}{10^5} \rfloor} \prod_{k \leq \text{mod}(n, 10^5), \: (k, 10) = 1} k \: (\text{mod} \: 10^5)$$
