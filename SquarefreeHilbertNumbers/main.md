# Squarefree Hilbert numbers

## Lemma 1: Hilbert primes are closed under multiplication.

This follows clearly from the fact that $(4k_1 + 1)(4k_2 + 1) \equiv 1 \: (\text{mod} \: 4)$.

## Lemma 2: Hilbert primes are either primes of the form $4k + 1$, or the product of two primes of the form $4k + 3$.

Let the Hilbert number $n$ factor as $n = p_1^{k_1} p_2^{k_2} \: ... \: p_m^{k_m} q_1^{r_1} q_2^{r_2} \: ... \: q_s^{r_s}$, where $p_i$ are primes of the form $4k + 1$ and $q_j$ are primes of the form $4k + 3$. Notice that $r_1 + r_2 + ... + r_s$ must be even for the product of the $q_j$ be equivalent to $1 \: (\text{mod} \: 4)$.

Clearly, if $n$ is a prime of the form $4k + 1$, then it is a Hilbert prime. Therefore assume $m = 0$. Then for $n$ to be a Hilbert prime, $r_1 + r_2 = 2$, otherwise we could factor $n$ into pairs of primes, and thus $n$ wouldn't be prime.

## Lemma 3: Let $T(n, m)$ be the amount of Hilbert numbers less than or equal to $n$ that are multiples of $m$. If $m \equiv 1, 3 \: (\text{mod} \: 4)$ then $T(n, m) = \text{max}(0, \frac{n + (4 - r)m}{4m})$. If $m \equiv 0, 2 \: (\text{mod} \: 4)$ then $T(n, m) = 0$.

If $m \equiv 0, 2 \: (\text{mod} \: 4)$, then no multiple of $m$ is a Hilbert number. Now let $m \equiv 1, 3 \: (\text{mod} \: 4)$. Then if $m = 4k_1 + r$, we would like to find the largest value of $k_2 \geq 0$ for which $m * (4k_2 + r) \leq n$. Thus:

$$m * (4k_2 + r) \leq n$$
$$k_2 \leq \frac{\frac{n}{m} - r}{4}$$
$$k_2 \leq \frac{n - rm}{4m}$$
$$T(n, m) = \text{max}(0, \frac{n - rm}{4m} + 1)$$
$$T(n, m) = \text{max}(0, \frac{n - rm + 4m}{4m})$$
$$T(n, m) = \text{max}(0, \frac{n + (4 - r)m}{4m})$$

## Algorithm 1: Hilbert prime sieve.

Suppose we know $m = 4k + 1$ is a Hilbert prime. Then, two consecutive Hilbert multiples of m are $m * (4s + 1)$ and $m * (4s + 5)$. Thus the step on the prime sieve is of:

$$m * (4s + 5) - m * (4s + 1) = 4m$$

Using the fact that only numbers of the form $4k + 1$ can be Hilbert primes, we need only to keep track of every fourth number, and instead of jumping in steps of $4m$ we can jump in steps of $m$ during the sieve. In particular, to keep the flags of whether a number has been sieved out or not, we need an array with a capacity of $T(n, 1)$.

## Approach

1. Use the Hilbert prime sieve to find all primes up to $\sqrt{n}$.
2. Use a quicksort algorithm to sort the list of Hilbert primes by their largest prime factor.
3. Use the inclusion-exclusion principle to sieve the multiples of Hilbert primes. Because Hilbert primes are not coprime, then we have to use the lcm to compose Hilbert primes. This can be calculated efficiently abusing the structure of Hilbert primes (they are either prime or the product of two primes).
4. Use the $T$ function to calculate the amount of multiples of a given Hilbert square.
5. To reduce the amount of times we reach the base case, keep track of the largest prime in the accumulator during the recursive search. Because the prime list is sorted using the largest prime factor of each element, at some point the remaining elements will have a factor that when multiplied with the accumulator, the result will be larger than $\sqrt{n}$, and therefore we may exit the loop early.
