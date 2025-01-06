# Pisano Periods I

For every positive integer $n$ the Fibonacci sequence modulo 
$n$ is periodic. The period depends on the value of $n$.
This period is called the <strong>Pisano period</strong> for $n$, often shortened to $\pi(n)$.

There are three values of $n$ for which 
$\pi(n)$ equals $18$: $19$, $38$ and $76$. The sum of those smaller than $50$ is $57$.

Find the sum of the values of $n$ smaller than $1\,000\,000\,000$ for which $\pi(n)$ equals $120$.

## Solution

We will assume the conjecture $\pi(p^k) = p^{k - 1} \pi(p)$ where $p$ is a prime and $k$ is an integer greater than $1$. Also, by the chinese remainder theorem, if $m$ and $n$ are coprime then $\pi(mn) = \text{lcm}(\pi(m), \pi(n))$.

With these facts we can discard all numbers divisible by a prime $p$ with $\pi(p) \nmid 120$ and those divisibles by powers of prime greater than $1$ except when $p | 120 \Rightarrow p \in \{ 2, 3, 5 \}$.

Once we know all valid prime powers we construct numbers $\le 10^9$ using these prime powers and compute $\pi(\cdot)$ for these numbers. If this value equals $120$ we add it to the result.
