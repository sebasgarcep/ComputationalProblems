"""
Apply the standard approach to calculating powers for big integers. Apply the
mod at every step to keep intermediate values small and computations simpler.
"""

mod = 10 ** 10

coeff = 28433
power = 7830457
result = 1

while power > 0:
    d = 1
    value = 2
    while d * 2 < power:
        d = d * 2
        value = (value ** 2) % mod
    power -= d
    result = (result * value) % mod

print((coeff * result + 1) % mod)
