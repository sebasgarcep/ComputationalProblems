# Number Rotations

Consider the number 142857. We can right-rotate this number by moving the last digit (7) to the front of it, giving us 714285.<br />
It can be verified that 714285=5×142857.<br />
This demonstrates an unusual property of 142857: it is a divisor of its right-rotation.
Find the last 5 digits of the sum of all integers <var>n</var>, 10 &lt; <var>n</var> &lt; 10<sup>100</sup>, that have this property.

## Solution

Suppose $n$ is an $r$-digit number ending in $d$. Then its right-rotation is also an $r$-digit number. Suppose $n$ satisfies the unusual property. Then there is a $k \in \mathbb{N}$ such that

$$
kn = \frac{n - d}{10} + d \cdot 10^{r-1}
$$

where the right hand side is the right-rotation operation. Because both $n$ and $kn$ are $r$-digit numbers, then $k = 1, 2, \dots, 9$. Therefore we can iterate over all possible values of $k, d, r$ to find the valid values of $n$. Thus, fix a value of $k$. Then $n$ satisfies the following equation (which is given by the previous one):

$$
10kn = n - d + d \cdot 10^{r}
$$

Therefore

$$
10kn \equiv n - d \pmod{10^r} \\
(10k - 1)n \equiv -d \pmod{10^r} \\
n \equiv -d \cdot (10k - 1)^{-1} \pmod{10^r} \\
$$

where the inverse of $10k - 1$ always exists as $\text{gcd}(10k - 1) = 1$. Because $0 \leq n < 10^r$, the solution to this modular equation gives us the solution to the general equation. We only need to check that $n \geq 10^{r-1}$, i.e. that $n$ is an $r$-digit number. Notice that if $d = 0$, then the solution ends up being $n = 0$, which fails to be a proper solution. Therefore $d = 1, 2, \dots 9$. Due to the limits in the problem statement, $r = 2, \dots, 100$. Finally, we need to test that $n$ satisfies the equation $10kn = n - d + d \cdot 10^{r}$, for the given $k, r, d$.