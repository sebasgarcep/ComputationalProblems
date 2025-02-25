# Square + 1 = Squarefree

Let $C(n)$ be the number of squarefree integers of the form $x^2 + 1$ such that $1 \le x \le n$.

For example, $C(10) = 9$ and $C(1000) = 895$.

Find $C(123567101113)$.

## Solution

This problem is harder than it claims to be.

We want to count all $1 \le x \le n$ such that $x^2 + 1 = ky^2$ has no integer solutions. That is

$$
C(n) = \sum_{x=1}^n \mu^2(x^2 + 1)
$$

Note that $x^2 + 1 \equiv 0 \pmod 4$ has no solutions. Furthermore, by Euler's criteron, $x^2 + 1 \equiv 0 \pmod {p^2} \iff p \equiv 1 \pmod 4$ for $p$ prime. That is $x^2+1$ factors into a product of odd prime powers congruent where each prime is congruent to $1$ modulo $4$ and a single factor of $2$ when $x$ is odd. So we can sieve the squareful numbers using the inclusion-exclusion principle to find $C(n)$:

$$
C(n) = \sum_{\substack{1 \le y \le n \\ 4k+3 \nmid y, \forall k \ge 0}} \mu(y) \sum_{\substack{1 \le x \le n \\ y^2 \mid x^2 + 1}} 1 \\
$$

Suppose $y$ factors into $p_1 \dots p_k$. Then $y^2 \mid x^2 + 1$ implies the following system of congruences

$$
\begin{align*}
x^2 + 1 &\equiv 0 \pmod {p_1^2} \\
&\vdots \\
x^2 + 1 &\equiv 0 \pmod {p_k^2} \\
\end{align*}
$$

which can be solved by using the Tonelli-Shanks algorithm to solve $x^2+1 \equiv 0 \pmod p$ and then using Hensel's lifting lemma to lift these solutions into solutions modulo $p^2$. This will give us two solutions for each equivalence. We can then use the chinese remainder theorem to merge these into $2^k$ distinct solutions to $x^2 + 1 \equiv 0 \pmod {y^2}$. Suppose these solutions are $x_1, \dots, x_m$. Then

$$
\begin{align*}
\sum_{\substack{1 \le x \le n \\ y^2 \mid x^2 + 1}} 1
&=
\sum_{\substack{1 \le i \le m \\ x_i \le n}} \left( 1_{y \not= 1} + \left\lfloor (n - x_i) / y^2 \right\rfloor \right)
\end{align*}
$$

In our case $n$ is too large to compute all values of $y \le n$. So we will truncate the first sum at $L \ge \sqrt{n}$ leaving us with

$$
\sum_{\substack{1 \le y \le L \\ 4k+3 \nmid y, \forall k \ge 0}} \mu(y) \sum_{\substack{1 \le x \le n \\ y^2 \mid x^2 + 1}} 1
$$

This also implies that we need to find all primes up to $L$.

To obtain the truncated portion corresponding to $y \gt L$ we will solve the negative Pell equation $x^2 - ky^2 = -1 \iff x^2 + 1 = ky^2$ for all non-square values of $k$ that we need to. Note that $k = \frac{x^2+1}{y^2} \le \frac{n^2+1}{L^2}$. A pick of $L = n^{2/3}$ leads to $k \le n^{2/3}$ which is a good bound for $k$ given our problem. Because $y^2 \gt L^2 \ge n$ then $\left\lfloor (n - x_i) / y^2 \right\rfloor = 0$, so we are just going to be adding/subtracting the solutions we find using the negative Pell equation.

Suppose we have found a solution to the negative Pell equation that satisfies $x \le n, y \gt L$. We first save this value of $x$ to a set so we don't process it if it ever comes up again as a solution for another value of $k$. Note that $k \le n$ since $L \ge \sqrt{n}$ implies that $\frac{n^2+1}{L^2} \le n$. Also note that $y \le n$ since $y^2 \le k y^2 = x^2 + 1 \Rightarrow y \le x \le n$. This implies that we only need to know the primes up to $\sqrt{n}$ to factor $k$ and $y$ (and we already have them, since we used these to calculate all squarefree values of $y$ up $L \ge \sqrt{n}$). Furthermore, because $4$ and primes congruent to $3$ modulo $4$ cannot divide $x^2+1$, they also cannot divide $k, y$, which reduces the amount of trial division we need to do.

Once we've factorized $k, y$ we know the factorization of $x^2 + 1$, since $x^2 + 1 = ky^2$. With this in mind we can extract all primes $p \le L$ such that $p^2$ divides $x^2 + 1$. If there are no primes like this, then this number could not have been sieved out during the inclusion-exclusion process we did before, and we should just subtract $1$ from the total result.

If on the other hand there is a prime $p \le L$ such that $p^2 \mid x^2 + 1$, then we take this set of primes and form all possible squarefree products of these primes. If the product does not exceed $L$ then it was already considered during the inclusion-exclusion process and we do not need to do anything with it. Otherwise, this product is in the truncated part of the inclusion-exclusion process and we need to add or subtract $1$ from the total based on the $\mu$ value of this product.
