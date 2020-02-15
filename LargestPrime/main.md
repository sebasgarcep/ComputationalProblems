# Largest Prime

Let $p$ be a prime. Then, we must find, for a given value of $k$, whether $p$ satisfies:

$$n^2 + k^2 \equiv 0 \: (\text{mod} \: p)$$
$$(n + 1)^2 + k^2 \equiv 0 \: (\text{mod} \: p)$$

Subtracting the first from the second, we get:

$$2n + 1 \equiv 0 \: (\text{mod} \: p)$$

If $p = 2$, then $2n + 1 \equiv 1 \equiv 0 \: (\text{mod} \: 2)$ has no solutions. Therefore, let $p > 2$. Notice that the value of $n$ will be unique in the range $[0, p - 1]$. Thus $n = \frac{p - 1}{2}$. Replacing in the first equivalence:

$$(\frac{p - 1}{2})^2 + k^2 \equiv 0 \: (\text{mod} \: p)$$
$$(p - 1)^2 + 4k^2 \equiv 0 \: (\text{mod} \: p)$$
$$(- 1)^2 + 4k^2 \equiv 0 \: (\text{mod} \: p)$$
$$1 + 4k^2 \equiv 0 \: (\text{mod} \: p)$$

Thus $p \: | \: 1 + 4k^2$. Let $l(k) := \sqrt{1 + 4k^2}$. Then, there are three possible cases:

1. $1 + 4k^2$ is not divisible by any of the primes up to $l(k)$. In this case $1 + 4k^2$ is prime, and thus, the largest prime factor to divide two consecutive terms of $n^2 + k^2$.
2. $1 + 4k^2$ is divisible by primes up to $l(k)$ and its largest prime factor is smaller than or equal to $l(k)$.
3. $1 + 4k^2$ is divisible by primes up to $l(k)$, but its largest prime factor $q$ is larger than $l(k)$. Notice that there is only one prime factor that satisfies this condition. Thus if we divide out all the prime factors of $1 + 4k^2$ up to $l(k)$, we are left with $q$.

Therefore we only need to know the primes up to $l(10 '000'000)$. For each prime $p$ we can use the Tonelli-Shanks algorithm to solve $1 + 4k^2 \equiv 0 \: (\text{mod} \: p)$, for the values of $k$. Then each $k + rp$, is divisible by $p$.

Therefore for each $k$ we need to keep track of the largest prime factor we have found for it, and the result of dividing each of these primes from $1 + 4k^2$.

At the end we use these variables to decide on which of the three cases does $1 + 4k^2$ fall on and sum the corresponding largest prime factor.
