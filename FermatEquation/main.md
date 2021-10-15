# Fermat Equation

Fermat's Last Theorem states that no three positive integers $a$, $b$, $c$ satisfy the equation 
$$a^n+b^n=c^n$$
for any integer value of $n$ greater than 2.

For this problem we are only considering the case $n=3$. For certain values of $p$, it is possible to solve the congruence equation:
$$a^3+b^3 \equiv c^3 \pmod{p}$$

For a prime $p$, we define $F(p)$ as the number of integer solutions to this equation for $1 \leq a,b,c < p$.

You are given $F(5) = 12$ and $F(7) = 0$.

Find the sum of $F(p)$ over all primes $p$ less than $6\,000\,000$.

## Solution

First it is clear that $F(2) = 0, F(3) = 2$. Suppose $p > 3$. Notice that

$$
a^3 + b^3 \equiv c^3 \pmod p \iff (ab^{-1})^3 + 1 \equiv (cb^{-1})^3 \pmod p
$$

Set $x \equiv ab^{-1} \pmod p, y \equiv cb^{-1} \pmod p$. Then $x^3 + 1 \equiv y^3 \pmod p$, thus we are looking for consecutive cubic residues and multiplying by the number of ways to generate the pair. For each solution $(x, y)$ there are $p - 1$ solutions $(a, b, c)$ given by the choice of $b$. Because $p > 3$ then $p \equiv 1, 2 \pmod 3$.

If $p \equiv 2 \pmod 3$ then it is easy to prove that every number is a cubic residue modulo $p$. Thus there are $p - 2$ consecutive cubic residues and, because there is a bijection between $x$ and $x^3$ modulo $p$, each pair of consecutive cubic residues can only be generated in exactly one way. Therefore $F(p) = (p - 1) (p - 2)$.

If $p \equiv 1 \pmod 3$, we can prove computationally that there is a representation of $p$ of the form $4p = A^2 + 27 B^2$ and that such representation is unique if $A \equiv 1 \pmod 3$ and $B > 0$. Finally, "On the difference of cubes (mod p)" by S. Chowla and others we find a statement that allows us to prove that $F(p) = (p - 1) (p + A - 8)$. I couldn't find an accesible proof of this statement, so I will leave it unproven.