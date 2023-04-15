# Not Coprime

Let $f(N)$ be the smallest positive integer that is not coprime to any positive integer $n \le N$ whose least significant digit is $3$.

For example $f(40)$ equals to $897 = 3 \cdot 13 \cdot 23$ since it is not coprime to any of $3,13,23,33$. By taking the <b><a href="https://en.wikipedia.org/wiki/Natural_logarithm">natural logarithm</a></b> (log to base $e$) we obtain $\ln f(40) = \ln 897 \approx 6.799056$ when rounded to six digits after the decimal point.

You are also given $\ln f(2800) \approx 715.019337$.

Find $f(10^6)$. Enter its natural logarithm rounded to six digits after the decimal point.

## Solution

Let $S$ be any set and let $f(S)$ be the smallest integer that is not coprime with all elements of $S$. Then $f(N) = f(K)$, where $K := \{ 10k+3 : k \in \mathbb{N}_0, 1 \le 10k+3 \le N \}$. Note that $f(K)$ will not be divisible by $5$, as any number divisible by $5$ ends in $5$ or $0$. It will also not be divisible by any prime $p \equiv 1 \pmod{10}$, as if $a = pb \equiv 3 \pmod{10}$, then $b \equiv 3 \pmod{10}$ and $b < a$, so whatever factor makes $f(K)$ not coprime to $b$ will do the same to $a$.

Note that $f(K)$ must be divisible by all $n \in K$ who only have one distinct prime factor. After that we are left only to solve for the $n$ composed of two or more distinct prime factors, that do not share a prime factor with the previous numbers. Let the previous set of numbers be $L$ and the latter set be $R$. Clearly $f(K) = f(L) \cdot f(R)$, $f(L)$ is coprime with $f(R)$, and at this point we already know $f(L)$.

Finding $f(R)$ can be done by trying all possible covers of $R$ and stopping early if while generating a cover the product of the factors is larger than the smallest valid cover we have found yet.

But we did a greedy approach instead:
1. Initialize $R_0 := R$.
2. For each prime $p \equiv 3, 7, 9 \pmod{10}$ that divides an element of $R_{k-1}$ we assign it a "score" equal to the natural logarithm of the product of the elements in $R_{k-1}$ it divides (equivalently, it is the sum over logarithms of elements in $R_{k-1}$).
3. We pick the prime $p_k$ with the largest score.
4. $R_k$ is the set of all elements in $R_{k-1}$ that are not divisible by $p_k$.
5. We finish when $R_k$ is the empty set and assign $f(R) = p_1 \cdot p_2 \dots$.

Even when this approach doesn't work it produces a cover close to optimal that can be used to reduce the search space. In our case it worked.
