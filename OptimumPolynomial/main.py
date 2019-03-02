"""
Approach:
The following formula for polynomial interpolation:

p(x) = sum(i = 1, n) p(x_i) prod(j = 1, n, j != i) (x - x_j) / (x_i - x_j)

can be derived by noticing that the product takes the value of 1 when x = x_i
(all terms in the product cancel out) and is zero when x = x_j and j != i (one
of the terms in the numerator becomes a zero).

Therefore the problem can be solved by interpolating for the first n terms and
applying the formula to n + 1. One important issue is that the answer had to be
rounded due to rounding errors.
"""

import math

def u (n):
    v = 0
    for p in range(0, 10 + 1):
        v += ((-1) ** p) * (n ** p)
    return v

result = 0
for n in range(1, 10 + 1):
    summation = 0
    for i in range(1, n + 1):
        product = 1
        for j in range(1, n + 1):
            if j == i:
                continue
            product = product * ((n + 1) - j) / (i - j)
        summation += u(i) * product
    result += round(summation)
result = round(result)
print(result)
