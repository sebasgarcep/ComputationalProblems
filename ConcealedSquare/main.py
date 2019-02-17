"""
Because the number has to end in 0 it needs to be a multiple of 10. Because the
square has 19 digits, the number is less than 10^10 and more than 10^9. In fact
the number is at least sqrt(sqrt(1020304050607080900)) ~ 1010101010 and at most
sqrt(1929394959697989990) ~ 1389026623.

Our approach involves calculating the highest digit on which both numbers differ
and then jump to the nearest number where they might be equal. So if the digit
is d, and it had to be c we know that the next square with at least that digit
equal is n^2 + p * 10^(10 - c) where p is c - d if d < c and 10 - (d - c) otherwise.
Therefore the next n value to test should be in the vecinity of sqrt(n^2 + p * 10^(10 - c)).
"""

import math

def test (varg):
    nd = 19
    v = 0
    idx = 0
    while idx < nd:
        v = varg // (10 ** (nd - idx - 1))
        if idx % 2 == 0:
            d = v % 10
            c = (idx // 2 + 1) % 10
            if d != c:
                return (d, c)
        v = v // 10
        idx += 1
    return None

n = 1010101010
while n <= 1389026623:
    v = n * n
    t = test(v)
    if t is None:
        break
    else:
        (d, c) = t
        p = c - d if d < c else 10 - (d - c)
        k = 10 - c
        i = int(math.sqrt(v + p * (100 ** k))) - n
        i = max([i - (i % 10), 10])
        n += i

print((n, n * n))
