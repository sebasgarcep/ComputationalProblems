# Investigating a Prime Pattern

<p>The smallest positive integer <i>n</i> for which the numbers <i>n</i><sup>2</sup>+1, <i>n</i><sup>2</sup>+3, <i>n</i><sup>2</sup>+7, <i>n</i><sup>2</sup>+9, <i>n</i><sup>2</sup>+13, and <i>n</i><sup>2</sup>+27 are consecutive primes is 10. The sum of all such integers <i>n</i> below one-million is 1242490.</p>

<p>What is the sum of all such integers <i>n</i> below 150 million?</p>

## Solution

Suppose $n^2 + 1, n^2 + 3, n^2 + 7, n^2 + 9, n^2 + 13, n^2 + 27$ are primes. Let's study divisibility by different primes.

### Divisibility by $2$

If $n$ is odd then $n^2 + 3$ is an even number larger than $2$ and thus it cannot be prime. Therefore $n \equiv 0 \: (\text{mod } 2)$.

### Divisibility by $3$

Suppose $3$ divides $n$. Then $n^2 + 3$ is not prime. Therefore $n \equiv 1, 2 \: (\text{mod } 3)$ and thus $n^2 \equiv 1 \: (\text{mod } 3)$. Then the following terms satisfy $n^2 + 5 \equiv n^2 + 11 \equiv n^2 + 17 \equiv n^2 + 23 \equiv 0 \: (\text{mod } 3)$ and cannot be prime.

### Divisibility by $5$

Suppose $n$ is not divisible by $5$. Then one can check that $n^2 \equiv 1, 4 \: (\text{mod } 5)$. But then either of $n^2 + 1, n^2 + 9$ is divisible by $5$. Therefore $n \equiv 0 \: (\text{mod } 5)$, and thus $n^2 + 15, n^2 + 25$ cannot be prime.

### Divisibility by $7$

We can check that $n^2 \equiv 0, 1, 2, 4 \: (\text{mod } 7)$. If $n^2 \equiv 0 \: (\text{mod } 7)$ then $n^2 + 7 \equiv 0 \: (\text{mod } 7)$ cannot be prime. If $n^2 \equiv 1 \: (\text{mod } 7)$ then $n^2 + 13 \equiv 0 \: (\text{mod } 7)$ cannot be prime. If $n^2 \equiv 4 \: (\text{mod } 7)$ then $n^2 + 3 \equiv 0 \: (\text{mod } 7)$ cannot be prime. Therefore $n^2 \equiv 2 \: (\text{mod } 7)$, which implies that $n^2 + 19 \equiv 0 \: (\text{mod } 7)$ cannot be prime.

### Divisibility by $13$

If $n \equiv 0 \: (\text{mod } 13)$, then $n^2 + 13 \equiv 0 \: (\text{mod } 7)$ cannot be prime. Therefore $n \not\equiv 0 \: (\text{mod } 13)$.

And all of these cases together prove that $n^2 + 1, n^2 + 3, n^2 + 7, n^2 + 9, n^2 + 13, n^2 + 27$ are consecutive primes if $n^2 + 21$ is not prime.

### Algorithm

The algoritm depends on the following idea: if a number is composite, it is more likely that it has small factors rather than large ones. Therefore, instead of performing the complete primality check for each of $n^2 + 1, n^2 + 3, n^2 + 7, n^2 + 9, n^2 + 13, n^2 + 27$, we check the primality of all of them at the same time the following way:

1. Calculate all primes up to the given limit using a sieve.
2. For each prime, check that all of $n^2 + 1, n^2 + 3, n^2 + 7, n^2 + 9, n^2 + 13, n^2 + 27$ are not divisible by said prime.
3. If any of these is divisible by said prime, then $n$ is not viable, otherwise continue iterating.

This way, we only have to do just enough iterations to find the smallest prime that divides any of these terms.