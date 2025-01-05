# Reversible Prime Squares

Both $169$ and $961$ are the square of a prime. $169$ is the reverse of $961$.

We call a number a <dfn>reversible prime square</dfn> if:
<ol>
<li>It is not a palindrome, and</li>
<li>It is the square of a prime, and</li>
<li>Its reverse is also the square of a prime.</li>
</ol>

$169$ and $961$ are not palindromes, so both are reversible prime squares.

Find the sum of the first $50$ reversible prime squares.

## Solution

Find all primes up to a certain number, square them, reverse them and compute the square root. If that square root is also a prime and the square is not a palindrome then we have found the reversible prime square. Stop when we have found 50.