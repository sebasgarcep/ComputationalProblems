# Shifted Multiples


For a positive integer $n$, let $s(n)$ be the integer obtained by shifting the leftmost digit of the decimal representation of $n$ to the rightmost position.<br />
For example, $s(142857)=428571$ and $s(10)=1$.


For a positive rational number $r$, we define $N(r)$ as the smallest positive integer $n$ such that $s(n)=r\cdot n$.<br />
If no such integer exists, then $N(r)$ is defined as zero.<br />
For example, $N(3)=142857$, $N(\tfrac 1{10})=10$ and $N(2) = 0$.

Let $T(M)$ be the sum of $N(u^3/v^3)$ where $(u,v)$ ranges over all ordered pairs of coprime positive integers not exceeding $m$.<br />
For example, $T(3)\equiv 262429173 \pmod {1\,000\,000\,007}$.


Find $T(200)$. Give your answer modulo $1\,000\,000\,007$. 

## Solution

Suppose $r = p/q$ is a reduced fraction. Because $s(n) = n \cdot r$ and $s(n)$ is an integer then $n$ must be a multiple of $q$. Therefore we want to solve for the smallest $k$ satisfying $s(kq) = kp$, in which case $N(r) = kq$.

Suppose $n$ can be written as $n = \overline{ab}$, where $a$ is a non-zero digit and $b$ is a non-negative integer. Then there is a positive integer $t$ (see appendix A) such that $n = 10^t a + b$. Then $s(n) = 10b + a$, but this implies that $kq = 10^t a + b, kp = 10b + a$. Therefore

$$
\begin{align*}
10^t ap + bp = 10bq + aq \\
\Rightarrow a (10^t p - q) = b (10q - p) \\
\Rightarrow b = \frac{a (10^t p - q)}{10q - p} \\
\end{align*}
$$

We can use this formula to calculate $b$ as it only depends on $t$ and $a$, which can only take so many values. Therefore let's fix the value of $a$. Let $h = 10q - p$. If $h < 0$ then $10q \lt p \Rightarrow q \lt 10^{t+1}q \lt 10^tp$, in which case the numerator is positive and $b$ is negative. Therefore let's ignore this case. We can also ignore the case $h = 0$ as we will never have to consider when $p/q = 10$, as $p, q$ will always be cubes. Let $g = h / \gcd(a, h)$. Then $10^t p \equiv q \pmod g$.

Let's show that $\gcd(g, q) = 1$. Note that due to the linear relationship between $h, 10q, p$ we must have $\gcd(h, q) \mid p$. But because $\gcd(p, q) = 1$ and $\gcd(h, q) \mid q$ it must be the case that $\gcd(h, q) = 1$. And because $h$ is a multiple of $g$ then $\gcd(g, q) = 1$.

Suppose for now that $\gcd(p, 10) = 1$. Then $\gcd(g, 10) = 1$. Now let's show that $\gcd(g, p) = 1$. By a similar reasoning as before we must have $\gcd(h, p) =: 10q$. But $\gcd(h, 10) = 1$, therefore $\gcd(h, p) \mid q$. But $\gcd(p, q) = 1$ implies that $\gcd(h, p) = 1$ and therefore $\gcd(g, p) = 1$.

The previous paragraph allows us to invert $p$ modulo $g$ to solve the exponential modular equation:

$$
10^t \equiv p^{-1} q \pmod g
$$

Solving for the smallest $t$ that satisfies this equation we can obtain the smallest $b$ that satisfies the previous integer equation for a given $a$. Then $N(r)$ will be the smallest of all resulting $n$ across all choices of $a$ (See appendix B for caveats).

Now let's consider the case when $\gcd(p, 10) \not= 1$. Then $\gcd(q, 10) = 1$. But this implies that $\gcd(10^t p - q, 10) = 1$. This means all the factors of $2$ and $5$ in $10q - p$ must divide $a$. If this condition holds then $\gcd(g, 10) = 1$, which allows us to reuse all the previous reasoning. Otherwise there is no solution for this given $a$.

Now we need to figure out how to solve the exponential modular equation.

### Pohlig-Hellman Algorithm

The Pohlig-Hellman algorithm is used to solve for the minimal integer $x$ in the equation $g^x = h$ where $g, h$ are elements of a finite group such that $h \in \langle g \rangle$. In particular, if the order of $g$ is $n$ then $0 \le x \le n-1$.

### Baby-step giant-step Algorithm

Suppose the order of $g$ is $n$. Let $m = \left\lceil \sqrt{n} \right\rceil$. Then there are $i, j$ such that $x = im + j$, in which case $g^x = g^{im + j} = h \iff g^j = h \cdot (g^{-m})^i$. Therefore one approach to solving for $i, j$ is to generate all $g^j$ and store them in a hash map. This will requiere $O(\sqrt{n})$ memory but will help us reduce the complexity of the search to $O(\sqrt{n})$ by applying a meet-in-the-middle approach. After generating all $g^j$ we iterate over the $i$ and figure out for each $i$ if $h \cdot (g^{-m})^i$ is in the hashmap. If it is, the hashmap will return the value of $j$ which we can use to construct $x$.

Note that this approach will work for any cyclic group, but we will only apply it to prime-order groups as the Pohlig-Hellman Algorithm provides ways to reduce more complex groups to this case.

### Pohlig-Hellman Algorithm for prime-power order groups

Suppose the order of $g$ is a prime power, i.e. $n = p^e$ where $p$ is prime. Suppose $x$ has representation in base $p$ as $x = \sum_{k = 0}^{e-1} p^k d_k$. We want to iteratively construct $x$. Let $x_k$ be the partial sum of $x$ over the first $k$ digits. Then

$$
\begin{align*}
g^x &= h \\
\Rightarrow g^{x_k + p^k d_k + \sum_{i = k+1}^{e-1} p^i d_i} &= h \\
\Rightarrow g^{p^k d_k} \cdot g^{\sum_{i = k+1}^{e-1} p^i d_i} &= g^{-x_k} h \\
\Rightarrow g^{p^k d_k \cdot p^{e-1-k}} \cdot g^{p^{e-1-k} \sum_{i = k+1}^{e-1} p^i d_i} &= (g^{-x_k} h)^{p^{e-1-k}} \\
\Rightarrow g^{p^{e-1} d_k} \cdot g^{\sum_{i = k+1}^{e-1} p^{e-1+i-k} d_i} &= (g^{-x_k} h)^{p^{e-1-k}} \\
\Rightarrow g^{p^{e-1} d_k} \prod_{i = k+1}^{e-1} g^{p^{e-1+i-k} d_i} &= (g^{-x_k} h)^{p^{e-1-k}} \\
\end{align*}
$$

Note that $g^{p^e} = 1$ where $1$ is the identity element of the group generated by $g$. Therefore $g^{p^r} = 1$ for any non-negative integer $r \ge e$. Note that $i \ge k + 1 \Rightarrow e - 1 + i - k \ge e$. Therefore the product over $i$ is identically $1$. Therefore

$$
g^{p^{e-1} d_k} = (g^{-x_k} h)^{p^{e-1-k}}
$$

Let $\gamma = g^{p^{e-1}}, h_k = (g^{-x_k} h)^{p^{e-1-k}}$. Then

$$
\gamma^{d_k} = h_k
$$

By construction $h_k \in \langle \gamma \rangle$. Furthermore, $\gamma \not= 1$ but $\gamma^p = g^{p^e} = 1$, therefore $\gamma$ has order $p$. The problem $\gamma^{d_k} = h_k$ can be solved using the baby-step giant-step algorithm for $d_k$, and $x_{k+1} = x_k + p^k d_k$.

Once we have performed $e$ iterations we will have calculated $x_e$, which we can return as the solution to $g^x = h$.

### Pohlig-Hellman Algorithm for general order groups

Suppose the order of $g$ can be factorized as $n = \prod_{i=1}^r p_i^{e_i}$. Then for each $i$ compute $k_i = n / p_i^{e_i}, g_i = g^k, h_i = h^k$. Notice that $g_i$ has order $p_i^{e_i}$, therefore the equation $g_i^{x_i} = h_i$ can be solved using the Pohlig-Hellman Algorithm for prime-power order groups. Then the $x_i$ form a system of simultaneous congruences:

$$
x \equiv x_i \pmod {p_i^{e_i}}
$$

which can be solved modulo $n$ using the Chinese Remainder Theorem.

### Generalized Chinese Remainder Theorem

Suppose we want to solve a system of simultaneous congruences

$$
\begin{align*}
x &\equiv a_1 \pmod {n_1} \\
x &\equiv a_2 \pmod {n_2} \\
&\dots \\
x &\equiv a_k \pmod {n_k} \\
\end{align*}
$$

Note that the solution to the first two congruences is another congruence of the form $x \equiv a' \pmod {n'}$. Therefore we can solve the system by reducing pairs of congruences into a single one until we are left with one congruence. Thus, let's concern ourselves with the base case

$$
\begin{align*}
x &\equiv a_1 \pmod {n_1} \\
x &\equiv a_2 \pmod {n_2} \\
\end{align*}
$$

Let $g = \gcd(n_1, n_2)$. Note that a solution to this system exists if and only if $a_1 \equiv a_2 \pmod g$. We can use the Extended Euclidean algorithm to find numbers $q_1, q_2$ such that $\frac{n_1}{g} q_1 + \frac{n_2}{g} q_2 = 1$. Let

$$
x = a_1 \frac{n_2}{g} q_2 + a_2 \frac{n_1}{g} q_1
$$

Then

$$
\begin{align*}
x &= a_1 (1 - \frac{n_1}{g} q_1) + a_2 \frac{n_1}{g} q_1 \\
x &= a_1 + (a_2 - a_1) \frac{n_1}{g} q_1 \\
\end{align*}
$$

Because $g \mid a_2 - a_1$, then the second term is divisible by $n_1$ which implies $x \equiv a_1 \pmod {n_1}$. An analogous argument can be made to show that $x \equiv a_2 \pmod {n_2}$.

Now suppose $x'$ is another solution to this pair of congruences. Then $x \equiv x' \pmod {n_1}$ and $x \equiv x' \pmod {n_2}$. Therefore $\text{lcm}(n_1, n_2) \mid x - x'$. Thus the solution to this pair of congruences is unique modulo $\text{lcm}(n_1, n_2)$.

### Appendix A

The condition $t = 0$ implies that $n$ is a digit, in which case $s(n) = n$. Therefore the only case for which a digit $n$ satisfies $N(r) = n$ would be $r = 1$. In particular $N(1) = 1$.

### Appendix B

We have to consider a few caveats. Firstly,

$$
b \lt 10^t \iff a(p - q/10^t) \lt h
$$

Because $a, p, q, h$ are non-negative this constraint can be approximated with the constraint $ap \le h$, as generally $t$ will be large enough that the term multiplied by $q$ will have no bearing on the condition. In particular, if $ap \gt h$ we won't consider a solution for the given $a$.

The second caveat is checking for the minimal $b$ across the choices of $a$. This comparison can be approximated without calculating the actual numbers by looking for the minimal $t$, and using the minimal $a$ as a tie-breaker. The reason is that $b$ is exponential on $t$ with base $10$ and linear on $a$, where $a \lt 9$. Therefore we expect $t$ to dominate in most if not all cases.

## References
- https://forthright48.com/chinese-remainder-theorem-part-2-non-coprime-moduli/
- https://en.wikipedia.org/wiki/Baby-step_giant-step
- https://en.wikipedia.org/wiki/Pohlig%E2%80%93Hellman_algorithm