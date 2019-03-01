"""
Approach:
Use the sieve to find the prime factors of every number in the search space. Then
use these to calculate Euler's totient function. Finally add the results.
"""

limit = 10 ** 6
slots = [True] * (limit + 1)
phi = [1] * (limit + 1)
idx = 2
total = 0
while idx < len(slots):
    if slots[idx]:
        factor = (idx - 1) / idx
        for ptr in range(idx, limit + 1, idx):
            slots[ptr] = False
            phi[ptr] = phi[ptr] * factor
    total += idx * phi[idx]
    idx += 1
print(int(total))
