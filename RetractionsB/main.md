# Retractions B

For every integer $n>1$, the family of functions $f_{n,a,b}$ is defined 
by  <br />
$f_{n,a,b}(x)\equiv a x + b \mod n\,\,\, $ for $a,b,x$ integer and  $0< a <n, 0 \le b < n,0 \le x < n$. 

We will call $f_{n,a,b}$ a <i>retraction</i> if $\,\,\, f_{n,a,b}(f_{n,a,b}(x)) \equiv f_{n,a,b}(x) \mod n \,\,\,$ for every $0 \le x < n$.<br />
Let $R(n)$ be the number of retractions for $n$.

$\displaystyle F(N)=\sum_{n=1}^NR(n^4+4)$. <br /> 
$F(1024)=77532377300600$.<br />

Find $F(10^7)$.<br />
Give your answer modulo $1\,000\,000\,007$.

## Solution

From Retractions A we know that $R(n) = Q(n) - n$ where $Q(n)$ is the sum of the unitary divisors of $n$. Note that $Q(n)$ is trivial to find if we know the factorization of $n$.

Firstly, $n^4 + 4 = (n^2 - 2n + 2)(n^2 + 2n + 2)$. Note also that $n^2 - 2n + 2 = (n-1)^2 + 1$ and $n^2 + 2n + 2 = (n+1)^2 + 1$ so we just need to factor the numbers $0^2 + 1, 1^2 + 1, 2^2 + 1, \dots, N^2 + 1, (N+1)^2 + 1$.

## Factoring numbers of the form $x^2+1$

Firstly, note that if $x$ is odd then $x^2+1$ is even. Secondly, by Euler's criterion $x^2 \equiv -1 \pmod p \iff (-1)^{\frac{p-1}{2}} \equiv 1 \pmod p \iff p \equiv 1 \pmod 4$ for an odd prime $p$. This implies the following algorithm for factoring all numbers of the form $x^2 + 1$:

1. Generate all primes up to $\left\lfloor \sqrt{(N+1)^2 + 1} \right\rfloor = N+1$. Discard all primes that are not even or congruent to $1$ modulo $4$.
2. For each $x^2+1$, initialize a dictionary to keep track of factors.
3. For each odd $x$, $x^2 + 1$ is divisible by $2$.
4. For each odd prime $p$, solve $x^2 \equiv -1 \pmod p$. This produces two solutions $a, b$. Then every $x^2 + 1$ is divisible by $p$ if $x$ is of the form $a+kp, b+kp$.
5. Now that we know all prime factors of $x^2+1$ up to $N+1$, we can divide these factors out of $x^2+1$. If $1$ is left, then these are all of the prime factors. Otherwise what's left is a prime factor and we add that to the factorization.
