# Riffle Shuffles

A riffle shuffle is executed as follows: a deck of cards is split into two equal halves, with the top half taken in the left hand and the bottom half taken in the right hand. Next, the cards are interleaved exactly, with the top card in the right half inserted just after the top card in the left half, the 2nd card in the right half just after the 2nd card in the left half, etc. (Note that this process preserves the location of the top and bottom card of the deck)

Let $s(n)$ be the minimum number of consecutive riffle shuffles needed to restore a deck of size $n$ to its original configuration, where $n$ is a positive even number.

Amazingly, a standard deck of $52$ cards will first return to its original configuration after only $8$ perfect shuffles, so $s(52) = 8$. It can be verified that a deck of $86$ cards will also return to its original configuration after exactly $8$ shuffles, and the sum of all values of $n$ that satisfy $s(n) = 8$ is $412$.

Find the sum of all values of n that satisfy $s(n) = 60$.

## Solution

Let $S(t) = \sum_{\substack{s(n) = t}} n$. Then we know that $S(8) = 412$ and we are looking for $S(60)$.

Consider the first $n - 1$ cards of the deck, numbered from $0$ to $n - 2$ (we can ignore the last card since it stays put after each shuffle). Then a shuffle will map the cards in the following way:

$$
i \lt n/2 \Rightarrow i \rightarrow 2i \pmod{n - 1} \\
i \ge n/2 \Rightarrow i \rightarrow 2(i - n/2) + 1 \equiv 2i - n + 1 \equiv 2i \pmod{n - 1} \\
$$

Therefore a Riffle Shuffle is the same as multiplying all elements by $2$ in $\mathbb{Z}_{n-1}$. This implies that $s(n) = \varphi_{n-1}(2)$, which is the multiplicative order of $2$ modulo $n - 1$.

Note that for a given $t$, $n$ will only be considered if $2^t \equiv 1 \pmod{n - 1}$. This implies $n - 1 \mid 2^t - 1$. So we can find all valid values of $n$ by factorizing $2^t - 1$, iterating over all divisors $d$ of it and only counting the ones that don't have an $x \lt t$ such that $2^x \equiv 1 \pmod d$. Once we find a valid $d$ then the corresponding valid $n$ is $d + 1$, which we can add to the result.

## Reference
- https://oeis.org/A002326