# Prime-ary Tree

A full $k$-ary tree is a tree with a single root node, such that every node is either a leaf or has exactly $k$ ordered children.  The <b>height</b> of a $k$-ary tree is the number of edges in the longest path from the root to a leaf.


For instance, there is one full 3-ary tree of height 0, one full 3-ary tree of height 1, and seven full 3-ary trees of height 2. These seven are shown below.

<img src="https://projecteuler.net/resources/images/0927_PrimeTrees.jpg?1735590785" alt="0927_PrimeTrees.jpg">

For integers $n$ and $k$ with $n\ge 0$ and $k \ge 2$, define $t_k(n)$ to be the number of full $k$-ary trees of height $n$ or less.<br> 
Thus, $t_3(0) = 1$, $t_3(1) = 2$, and $t_3(2) = 9$. Also, $t_2(0) = 1$, $t_2(1) = 2$, and $t_2(2) = 5$.


Define $S_k$ to be the set of positive integers $m$ such that $m$ divides $t_k(n)$ for some integer $n\ge 0$.  For instance, the above values show that 1, 2, and 5 are in $S_2$ and 1, 2, 3, and 9 are in $S_3$.

Let $S = \bigcap_p S_p$ where the intersection is taken over all primes $p$.  Finally, define $R(N)$ to be the sum of all elements of $S$ not exceeding $N$.  You are given that $R(20) = 18$ and $R(1000) = 2089$.

Find $R(10^7)$.

## Solution

Clearly $t_k(0) = 1$. Furthermore, for $n \gt 0$ one can either choose to have a leaf root node or to have $k$ child nodes under the root, each holding a tree of height at most $n-1$. Thus $t_k(n) = t_k(n-1)^k + 1$. Now define $x_k(0) = 0, x_k(n) = t_k(n-1)$. Note that we can redefine belonging to $S_p$ around $x_p(n)$ instead of $t_p(n)$ since it will lead to simpler arguments.

If $a \in S$, then for each prime $p$ there is an $n \gt 0$ such that $x_p(n) \equiv 0 \pmod a$. Note that $x_p(n) \equiv 0 \pmod a$ so $x_p$ modulo $a$ has a cycle of size $n$. Now suppose $b \in S$ and $\gcd(a, b) = 1$. Then $x_p$ modulo $b$ has a cycle of size $n'$ and $x_p(n') \equiv 0 \pmod b$. Thus $x_p(\text{lcm}(n, n')) \equiv 0 \pmod {ab}$. This implies that $ab \in S$.

If $a \not\in S$ then there is a prime $p$ such that for all $n \gt 0$ we have $x_p(n) \not\equiv 0 \pmod a$. Therefore for all $b \gt 0$ and $n \gt 0$ we have $x_p(n) \not\equiv 0 \pmod {ab}$. Thus $ab \not\in S$.

Thus $m \in S$ if and only if all the prime powers in its factorization are in $S$. Furthermore, if $q$ is a prime and $k \gt 0$ such that $q^k \not\in S$ then $q^r \not\in S$ for all $r \ge k$.

Clearly $1 \in S$. Furthermore, $x_p(2) = 2$, which implies $2 \in S$. Now look at the following

$$
x_2(2) \equiv 2 \pmod 3 \\
x_2(3) \equiv 2^2 + 1 \equiv 2 \pmod 3 \\
$$

Which implies $3 \not\in S$. Now look at

$$
x_2(1) \equiv 1 \pmod 4 \\
x_2(2) \equiv 2 \pmod 4 \\
x_2(3) \equiv 2^2 + 1 \equiv 1 \pmod 4 \\
$$

Thus $4 \not\in S$.

Now suppose $q \ge 5$ is an odd prime.

Note that $x^2 + 1 \equiv 0 \pmod q$ only has solutions if $q \equiv 1 \pmod 4$ due to Euler's criterion. Thus if $q \not\equiv 1 \pmod 4$ then $q \not\in S_2 \Rightarrow q \not\in S$.

Now suppose additionally that $q \equiv 1 \pmod 4$ and $q \in S_2$. Suppose $p$ is an odd prime such that $\gcd(p, \varphi(q)) = 1$. Consider the equation $x^p + 1 \equiv y^p + 1 \pmod {q} \iff x^p \equiv y^p \pmod {q}$. If $x = 0$ or $y = 0$ then the other one must be $0$ as well (otherwise we would have a contradiction since $q$ is prime). Now assume $x,y \not= 0$. Then $(x \cdot y^{-1})^p \equiv 1 \pmod {q}$. Because $\gcd(p, \varphi(q)) = 1$, then $x \cdot y^{-1} \equiv 1 \pmod {q} \iff x \equiv y \pmod {q}$. Thus $f_p: x \rightarrow x^p + 1$ is a bijection modulo $q$. Because $f_p$ cannot map two elements to the same value modulo $q$ then repeated applications of $f_p$ cannot lead to a cycle that doesn't include $0$, since if it did, then there would be a chain that starts at $0$ and goes to the beginning of the cycle, and another chain that goes from the beginning of the cycle back into itself. That would imply two numbers mapping to the same value, which is not possible. Therefore $q \in S_p$.

Suppose $q \in S$. Pick a prime $p$ such that $p \equiv -1 \pmod {\varphi(q^2)}$ (which must exist by Dirichlet's theorem). Let $f_p: a \rightarrow a^p + 1$. If $q \nmid a$ then we can use $f_p(a) \equiv 1 + a^{-1} \pmod {q^2}$. Suppose $F_n$ is the $n$-th Fibonacci number. Then $f_p(\frac{F_n}{F_{n-1}}) \equiv 1 + \frac{F_{n-1}}{F_n} \equiv \frac{F_n + F_{n-1}}{F_n} \equiv \frac{F_{n+1}}{F_n} \pmod {q^2}$. Thus $f_p$ is projecting ratios of Fibonacci numbers forward. We start from $\frac{F_2}{F_1} = 1$ until we reach $a \equiv 0 \pmod {q}$. At that point we need to apply $f_p(a) \equiv 1 + a^p \pmod {q}$. Because $p > 1$ and $q \mid a$ then $f_p(a) \equiv 1 \pmod {q}$, at which point the sequence has reached a cycle and the values will begin repeating. Thus, the only opportunity for $q^2$ to divide an element of this sequence is when $a \equiv 0 \pmod {q}$. But this would imply that the Pisano Period of $q^2$ equals the Pisano Period of $q$. This implies $q$ is a Wall-Sun-Sun prime, but there are no Wall-Sun-Sun primes less than $10^{14}$, so we can safely assume $q^2 \not\in S$.

These facts lead to the following algorithm:

1. Create a table of all numbers from $1$ to $N$.
2. Strike out all numbers divisible by primes of the form $4k+3$ or by the square of a prime.
3. For each prime $p$ in the range $[1, N]$ iterate over the prime factors $q$ of $\varphi(p) = p - 1$. If there is a prime $q$ such that $p \not\in S_q$ then strike out all multiples of $p$.
4. Sum all the remaining numbers in the table.

Finally, to find if $p \in S_q$ we have to find if the cycle returns to $0$ at some point or not. We can use Floyd's cycle detection algorithm to detect the cycle. If the slow or the fast pointer ever find another $0$ then $p \in S_q$. Otherwise, if they meet before finding a $0$, then there are no $0$'s in the cycle and $p \not\in S_q$.
