"""
Approach:
Given that:

phi(n) = n * prod(p | n) (1 - 1/p)

we know that:

n / phi(n) = prod(p | n) p / (p - 1)

Use the sieve to determine the prime divisors of all numbers efficiently, and
this calculate phi(n) and n / phi(n) efficiently. Then for values that will no
longer change calculate whether they fulfill the condition.
"""

import time

def get_value (n):
    d = []
    v = n
    while v > 0:
        d.append(v % 10)
        v = v // 10
    d = sorted(d)
    v = 0
    for i in range(0, len(d)):
        v += d[i] * (10 ** i)
    return v

def are_permutations (a, b):
    da = get_value(a)
    db = get_value(b)
    return da == db

start = time.time()

result = (87109, 87109 / 79180)
limit = 10 ** 7
slots = [True] * (limit + 1)
phi = [1.0] * (limit + 1)
phi_inv = [1.0] * (limit + 1)
idx = 2
count = 0
while idx < len(slots):
    phi[idx] = phi[idx] * idx
    if slots[idx]:
        factor = (idx - 1) / idx
        factor_inv = 1.0 / factor
        for ptr in range(idx, limit + 1, idx):
            slots[ptr] = False
            phi[ptr] = phi[ptr] * factor
            phi_inv[ptr] = phi_inv[ptr] * factor_inv
    if phi_inv[idx] < result[1]:
        if are_permutations(idx, phi[idx]):
            result = (idx, phi_inv[idx])
    idx += 1

print(result[0])
end = time.time()
print('Took %.4f secs' % (end - start))
