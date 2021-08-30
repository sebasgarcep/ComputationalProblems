# Hallway of Square Steps

Peter moves in a hallway with <var>N</var>+1 doors consecutively numbered from 0 through <var>N</var>. All doors are initially closed. Peter starts in front of door 0, and repeatedly performs the following steps:
<ul><li>First, he walks a positive square number of doors away from his position.</li>
<li>Then he walks another, larger square number of doors away from his new position.</li>
<li>He toggles the door he faces (opens it if closed, closes it if open).</li>
<li>And finally returns to door 0.</li>
</ul>We call an action any sequence of those steps. Peter never performs the exact same action twice, and makes sure to perform all possible actions that don't bring him past the last door.
Let <var>F</var>(<var>N</var>) be the number of doors that are open after Peter has performed all possible actions. You are given that <var>F</var>(5) = 1, <var>F</var>(100) = 27, <var>F</var>(1000) = 233 and <var>F</var>(10<sup>6</sup>) = 112168.
Find <var>F</var>(10<sup>12</sup>).

## Solution

Clearly, each action can be represented by a tuple $(a, b)$, such that $a < b$. Then he walks to the $a^2 + b^2$-th door and toggles it. Therefore, each door is going to be toggled once for each representation as a sum of distinct squares. Thus, we want to find how many numbers $1 \leq n \leq N$ have an odd number of such representations.

### Sum of two squares theorem

A number $n$ can be represented as a sum of two squares if and only if $n = a^2 b$, where $b$ is a squarefree number not divisible by primes of the form $4k+3$.

#### Proof

$\Leftarrow$] First, notice that $a^2 = a^2 + 0^2$. By Fermat's two squares theorem, each prime that divides $b$ has a representation as a sum of two squares. Then using the Brahmagupta-Fibonacci identity we can multiply these representations to obtain a representation for $b$ as $b = c^2 + d^2$. Finally, it is clear that $n = (a^2 + 0^2) (c^2 + d^2)$. But from the Brahmagupta-Fibonacci identity, this product can be expressed as a sum of two squares.

$\Rightarrow$] Suppose $n = a^2 b$ where $b$ is a squarefree number. Suppose there is a prime $p$ of the form $4k+3$ such that $p \mid b$. Assume $n = u^2 + v^2$. Let $d = \text{gcd}(u,v), u = dx, v = dy$. Then $n/d^2 = x^2 + y^2$. Because $p$ occurs an odd number of times in the factorization of $n$, then $p \mid n/d^2 = x^2 + y^2$. Also, $p \nmid x, y$, otherwise $\text{gcd}(x,y) \not= 1$, a contradiction. Then $x^{p-1} \equiv y^{p-1} \equiv 1$ modulo $p$. Also $x^2 \equiv -y^2$ modulo $p$. Because $p = 4k+3 \Rightarrow p - 1 = 4k+2 = 2(2k+1)$, then $(x^2)^{2k+1} \equiv (-y^2)^{2k+1} \Rightarrow 1 \equiv (-1)^{2k+1} \equiv -1$ modulo $p$, which is a contradiction for $p > 2$. Therefore our hypothesis is false. No prime of the form $4k+3$ can divide $b$.

### Gaussian primes

The Gaussian primes are (up to multiplication by an unit):

1. $1 + i$
2. prime numbers of the form $4k+3$
3. All prime number of the form $4k+1$ can be written uniquely as $a^2 + b^2$. Then $a+bi, a-bi$ are Gaussian primes.

#### Proof

1. Clearly $2 = 1^2 + 1^2 = (1+i) (1-i)$. But $(1-i)i = 1+i$. Therefore we pick $1+i$ to be the representative of this Gaussian prime.
2. Suppose $p$ is a prime of the form $4k+3$ and $p = \alpha \beta$. Then $|\alpha|=|\beta|=p$. But if $|\alpha|=u^2+v^2$ then $p=u^2+v^2$, which Fermat's sum of two squares theorem tells us is impossible. Therefore $p$ is a Gaussian prime.
3. Suppose $p$ is a prime of the form $4k+1$. Then by Fermat's sum of two squares theorem there are unique $a, b \in \mathbb{N}$ such that $p = a^2 + b^2$. Therefore $p = (a+bi) (a-bi)$ and $|a+bi|=|a-bi|=p$. Suppose there is a Gaussian integer $u+vi$ that divides $a+bi$ or $a-bi$. Then $|u+vi| \mid p$. If $|u+vi| = p$, then $u+vi$ has to equal either $a+bi$ or $a-bi$ up to multiplication by an unit. If $|u+vi|=1$, then it is an unit and cannot be a prime. Therefore $a+bi, a-bi$ are prime. These are also distinct up to multiplication by an unit as $a \not= b$ (otherwise $p$ would be divisible by 2 and a square, a contradiction).

To see that this list is complete, suppose $u+vi$ is a Gaussian prime not on the list. Notice that $u^2+v^2$ is either $2$, $p$ of the form $4k+1$ or $p^2$ where $p$ is of the form $4k+3$. To see this, assume that $u^2+v^2$ is larger. Then by the Sum of Two Squares Theorem there would be maximal $x^2+y^2 > 1$, such that $x^2+y^2 \mid u^2+v^2$ and $x^2+y^2 \not= u^2+v^2$. If $x+yi \mid u+vi$ or $x-yi \mid u+vi$, we are done. Otherwise $(x+yi) (x-yi) \mid u-vi$. But then $(x^2+y^2)^2 \mid u^2+v^2$, a contradiction by the maximality of $x^2+y^2$.

Now let's analyze all cases:

- Suppose $u^2+v^2=p$. Therefore $p=2$ or it is of the form $4k+1$. But $p$ has a unique representation as a sum of squares. Therefore $u+vi$ is already in the list, a contradiction.
- Suppose $u^2+v^2=p^2$ with $p$ is of the form $4k+3$. Then $p^2 \mid u^2+v^2=(u+vi) (u-vi)$. If $p^2 \mid u-vi \Rightarrow p^4 \mid u^2+v^2$, a contradiction. Therefore $p \mid u+vi$. Therefore $u+vi$ is not prime, a contradiction.

Summing everything up, we have shown that the list is complete.

### Number of representations as a sum of squares.

Let $r_2(n) = \{ (x, y) \in \mathbb{Z}^2 \mid x^2+y^2=n \}$ be the number of representations of a natural number $n$ as a sum of squares. Then $r_2(n) = 0$ if a prime of the form $\equiv 3 \text{ (mod 4)}$ occurs an odd numbers of times in the factorization of $n$. On the other hand, suppose $n$ factorizes as $n = 2^{v_0} \prod_k p_k^{v_k} \prod_j q_j^{2w_j}$, where the $p_k$ are primes of the form $\equiv 1 \text{ (mod 4)}$ and the $q_j$ are primes of the form $\equiv 3 \text{ (mod 4)}$. Then $r_2(n) = 4 \prod_k (v_k + 1)$.

#### Proof

Suppose $p_k = (a_k + b_k i) (a_k - b_k i)$. Then we can factorize $n$ in the Gaussian integers as

$$
\begin{align*}
n
&= (1+i)^{v_0} (1-i)^{v_0} \prod_k (a_k + b_k i)^{v_k} (a_k - b_k i)^{v_k} \prod_j q_j^{2w_j} \\
&= (-i)^{v_0} (1+i)^{2v_0} \prod_k (a_k + b_k i)^{v_k} (a_k - b_k i)^{v_k} \prod_j q_j^{2w_j} \\
\end{align*}
$$

Suppose $n = x^2+y^2 = (x+yi) (x-yi)$. Notice that $|x+yi|=|x-yi|$. Thus these norms have to factorize equally. Therefore the $1+i, q_j$ are split evenly between $x+yi$ and $x-yi$, and there is only $1$ way to do so. The $(-i)^{v_0}$ can be split in $4$ different ways: $(-i)^{v_0+f} (-i)^{-f}$ where $f = 0,1,2,3$. Now suppose $s_1$ is the largest exponent such that $(a_k + b_k i)^{s_1} \mid x+yi$. Let $s_2=v_k-s_1$. Because $|x+yi|=|x-yi|$, then $s_2$ is the largest exponent such that $(a_k - b_k i)^{s_2} \mid x+yi$. Here we have a choice of $v_k+1$ ways of choosing the value of $s_1=0,1,\dots,v_k$. Multiplying all possibilities we get $r_2 = 1 \cdot 4 \cdot \prod_k (v_k+1) = 4 \prod_k (v_k+1)$.

### Number of representations as a sum of positive, distinct, ascending squares

Let $f_2(n) = \{ (x, y) \in \mathbb{N}^2 \mid x < y, x^2 + y^2 = n \}$. Notice that there are two representations which are problematic: $c^2 = 0^2 + c^2$ and $2c^2 = c^2 + c^2$.

Suppose $n$ is of the form $c^2$. Then there are $4$ representations to prune: $c^2 + 0^2, (-c)^2+0^2, 0^2+c^2, 0^2+(-c)^2$. Then $f_2(n) = 1/8 \cdot (r_2(n) - 4) = 1/2 \cdot (\prod_k (v_k + 1) - 1)$.

Now suppose $n$ is of the form $2c^2$. Then there are $4$ representations to prune: $c^2+c^2, (-c)^2+c^2, c^2+(-c)^2, (-c)^2+(-c)^2$. Then $f_2(n) = 1/8 \cdot (r_2(n) - 4) = 1/2 \cdot (\prod_k (v_k + 1) - 1)$.

Therefore $f_2(c^2) = f_2(2c^2)$.

Suppose $n$ is not of the form $c^2, 2c^2$. Then $n$ is of the form $n = a^2 b$, where $b \geq 3$ is squarefree and only divisible by primes of the form $\equiv 1 \text{ (mod 4)}$ or $2$. Then for any representation, there are $8$ derivative representations obtained by changing the order or the signs of the summands. Therefore $f_2(n) = 1/8 \cdot r_2(n) = 1/2 \cdot \prod_k (v_k + 1)$.

## Calculating $F(N)$

If $n$ is of the form $c^2, 2c^2$ then we can use the factorization of $c$ to compute $f_2(n)$, as there are only $O(N^{1/2})$ cases to check.

Now suppose $n$ is of the form $n = a^2 b$, where $b \geq 3$ is squarefree and only divisible by primes of the form $\equiv 1 \text{ (mod 4)}$ or $2$. Notice that if $b$ has more than one prime factor distinct from $2$, then more than one $v_k + 1$ is even, and $f_2(n)$ is even. Therefore we want to count only the $n = a^2 b, 2 a^2 b$ with prime $b$ of the form $\equiv 1 \text{ (mod 4)}$. Notice that if $v_k+1$ is divisible by $4$ then $f_2(a^2 b)$ is even. This can only happen in $b^3 \leq N$, so we can split the $b$ at this point. Then this part of $F(N)$ becomes

$$
\sum_{\substack{1 \leq a^2 b \leq N \\ \\ b \equiv 1 \text{ (mod 4)} \\ \\ \text{b is prime} \\ \\ b^3 > N}} 1
+
\sum_{\substack{1 \leq 2a^2 b \leq N \\ \\ b \equiv 1 \text{ (mod 4)} \\ \\ \text{b is prime} \\ \\ b^3 > N}} 1
+
\sum_{\substack{b \equiv 1 \text{ (mod 4)} \\ \\ \text{b is prime} \\ \\ b^3 \leq N}} \sum_{\substack{k \geq 0 \\ \\ 2k + 2 \not\equiv 0 \text{ (mod 4)}}} \sum_{\substack{1 \leq a^2 b^{2k+1} \leq N \\ \\ b \nmid a}} 1
+
\sum_{\substack{b \equiv 1 \text{ (mod 4)} \\ \\ \text{b is prime} \\ \\ b^3 \leq N}} \sum_{\substack{k \geq 0 \\ \\ 2k + 2 \not\equiv 0 \text{ (mod 4)}}} \sum_{\substack{1 \leq 2 a^2 b^{2k+1} \leq N \\ \\ b \nmid a}} 1
$$

Notice that the first and second sum are calculated almost equivalently, so let's focus only on the first. Let $\pi_1$ be the function that counts primes of the form $4k+1$. Then

$$
\sum_{\substack{1 \leq a^2 b \leq N \\ \\ b \equiv 1 \text{ (mod 4)} \\ \\ \text{b is prime} \\ \\ b^3 > N}} 1
= \sum_{a = 1}^{\sqrt{N}} \sum_{\substack{1 \leq b \leq N / a^2 \\ \\ b \equiv 1 \text{ (mod 4)} \\ \\ \text{b is prime} \\ \\ b^3 > N}} 1
= \sum_{a = 1}^{\sqrt{N}} \text{max}(0, \pi_1(N / a^2) - \pi_1(N^{1/3}))
$$

Notice also that the third and fourth sum are calculated almost equivalently, so let's focus only on the third. Because $b^3 \leq N$ is small enough, suppose we iterate over all values of $b$ and $k$. Then we only need to focus on optimizing the inner sum

$$
\begin{align*}
\sum_{\substack{1 \leq a^2 b^{2k+1} \leq N \\ \\ b \nmid a}} 1
&=
\sum_{1 \leq a^2 b^{2k+1} \leq N} 1
-
\sum_{\substack{1 \leq a^2 b^{2k+1} \leq N \\ \\ b \mid a}} 1 \\
&=
\sum_{1 \leq a^2 b^{2k+1} \leq N} 1
-
\sum_{1 \leq a^2 b^{2k+3} \leq N} 1 \\
&=
\lfloor \sqrt{N / b^{2k + 1}} \rfloor
-
\lfloor \sqrt{N / b^{2k + 3}} \rfloor \\
\end{align*}
$$

## Counting primes of the form $4k+1$

The following takes inspiration from Lucy_Hedgehog and the proof of Meissel-Lehmer's formula for the prime counting function. Number the primes in order as $p_1, p_2, \dots$. Define

$$
\phi_1(n, a) = \sum_{\substack{1 \leq x \leq n \\ \\ x \equiv 1 \text{ (mod 4)} \\ \\ p_1, p_2, \dots, p_a \nmid x}} 1 \\
\phi_3(n, a) = \sum_{\substack{1 \leq x \leq n \\ \\ x \equiv 3 \text{ (mod 4)} \\ \\ p_1, p_2, \dots, p_a \nmid x}} 1 \\
$$

Notice that $\phi_1(N, \pi(\sqrt{N})) = \pi_1(N) - \pi_1(\sqrt{N}) + 1$. Therefore, if we can find an efficient way to compute $\phi_1$, we are done. Notice that $p_1 = 2$ does not divide any of the terms in $\phi_1$ and $\phi_3$. Therefore

$$
\phi_k(n, 1) = \sum_{\substack{1 \leq x \leq n \\ \\ x \equiv k \text{ (mod 4)}}} 1 = \sum_{1 \leq 4y + k \leq n} 1 = 1 + \lfloor (n - k) / 4 \rfloor
$$

for $n$ large enough. Notice also that if $n \leq p_a$, then $\phi_1(n, a) = 1, \phi_3(n, a) = 0$. Now let's compute a recursive version of $\phi_k$:

$$
\begin{align*}
\phi_1(n, a-1)
&= \sum_{\substack{1 \leq x \leq n \\ \\ x \equiv 1 \text{ (mod 4)} \\ \\ p_1, p_2, \dots, p_{a-1} \nmid x}} 1 \\
&= \sum_{\substack{1 \leq x \leq n \\ \\ x \equiv 1 \text{ (mod 4)} \\ \\ p_1, p_2, \dots, p_a \nmid x}} 1
+ \sum_{\substack{1 \leq p_a y \leq n \\ \\ p_a y \equiv 1 \text{ (mod 4)} \\ \\ p_1, p_2, \dots, p_{a-1} \nmid y}} 1 \\
&= \phi_1(n, a)
+ \sum_{\substack{1 \leq y \leq n / p_a \\ \\ y \equiv k_a \text{ (mod 4)} \\ \\ p_1, p_2, \dots, p_{a-1} \nmid y}} 1 \\
&= \phi_1(n, a) + \phi_{k_a}(n/p_a, a - 1) \\
\end{align*}
$$

where $k_a$ depends on the value of $p_a$ modulo $4$. If $p_a \equiv 1$ modulo $4$ then $k_a = 1$, otherwise $k_a = 3$. Rearranging terms we get

$$
\begin{align*}
\phi_1(n, a)
&= \phi_1(n, a-1) - \phi_{k_a}(n/p_a, a-1) \\
&= \dots \\
&= \phi_1(n, 1) -\phi_{k_2}(n/p_2, 1) -\phi_{k_3}(n/p_3, 2) - \dots -\phi_{k_a}(n/p_a, a-1)  \\
\end{align*}
$$

We get a similar expression for $\phi_3$

$$
\phi_3(n, a) = \phi_3(n, 1) -\phi_{3k_2}(n/p_2, 1) -\phi_{3k_3}(n/p_3, 2) - \dots -\phi_{3k_a}(n/p_a, a-1)  \\
$$

where the $3k_a$ are computed modulo $4$.

Taking inspiration from the Meissel-Lehmer's formula, we can define $P_{k,r}(n, a)$ to be the number of products $x \leq n$, where $x \equiv k \text{ (mod 4)}$, of exactly $r$ primes each greater than $p_a$. Then $\phi_k(n, a) = \sum_{r \geq 0} P_{k,r}(n, a)$. Notice that $P_{1,0}(n, a) = 1, P_{3,0}(n, a) = 0$. If $a = \pi(L)$, then $P_{k,1}(n,a) = \pi_k(n) - \pi_k(L)$. Notice that if $L \geq \sqrt{N}$, then for two primes $p, q > p_a$ we have $pq > (\sqrt{N})^2 = N$ and thus $P_{k,r}(n, a) = 0$ for $r \geq 2$. Thus, choosing $a = \pi(\sqrt{N})$ leads to the previous formula $\phi_1(N, \pi(\sqrt{N})) = 1 + \pi_1(N) - \pi_1(\sqrt{N})$.

Now let's pick $a = \pi(N^{1/3})$. By a similar logic as before $P_{k,r}(n, a) = 0$ for $r \geq 3$. Let's compute $P_{k,2}(n,a)$. Let $b = \pi(\sqrt{N})$. Then

$$
\begin{align*}
P_{k,2}(n,a)
&= \sum_{\substack{p_i p_j \leq n \\ \\ p_i p_j \equiv k \text{ (mod 4)} \\ \\ p_i, p_j > p_a}} 1 \\
&= \sum_{i = \text{max}(2,a+1)}^b \sum_{\substack{p_i \leq p_j \leq n/p_i \\ \\ p_j \equiv k \cdot k_i \text{ (mod 4)}}} 1 \\
&= \sum_{i = \text{max}(2,a+1)}^b [ \pi_{k \cdot k_i}(n / p_i) - \pi_{k \cdot k_i}(p_i - 1) ] \\
\end{align*}
$$

where $k \cdot k_i$ is taken modulo $4$.

Adding everything up we get the formula

$$
\phi_k(N, a) = P_{k,0}(N,a) + \pi_k(N) - \pi_k(N^{1/3}) + P_{k,2}(N, a)
$$

and the terms can be rearranged and we can set $k = 1$ to find $\pi_1(N)$.