"""
Approach:
Determine pairwise if both primes can be concatenated. Imagine that every number
is a vertex in a graph and that edges exist when they can be concatenated. Then
use recursive search to find primes lower than it that form a fully connected
graph of size 5. Search until the prime is larger than the smallest sum that was
found.

Possible Optimizations:
    - Instead of using set intersection one can use bitmasks.
    - Remove primes that when added to the searched prime, add up to more than
        or equal to the min_sum.
    - Add the digits: numbers with a digit sum (1 mod 3) can only be concatenated
        with numbers with a digit sum (0 mod 3). Same goes for numbers with
        (2 mod 3) digit sum.
"""

# FIXME: doesn't yet search up to the upper bound, even though it find the answer


import math
import time

def sieve (n):
    slots = [True] * (n + 1)
    slots[0] = False
    slots[1] = False
    idx = 2
    primes = []
    while idx < len(slots):
        if slots[idx]:
            primes.append(idx)
            for ptr in range(2 * idx, n + 1, idx):
                slots[ptr] = False
        idx += 1
    return (primes, slots)

def is_prime (n):
    if n == 2:
        return True
    if n < 2 or n % 2 == 0:
        return False
    for k in range(3, int(math.floor(math.sqrt(n))) + 1, 2):
        if n % k == 0:
            return False
    return True

def count_digits (n):
    d = 0
    v = n
    while v > 0:
        v = v // 10
        d += 1
    return d

start_time = time.time()
limit = 10 ** 6
(primes, _) = sieve(limit)
primes = [3] + primes[3:] # 2 and 5 will never be in the minimal set, but 3 is
digits = [count_digits(prime) for prime in primes]
relations = [None] * len(primes)
size = 5

def test (i1, i2):
    if not is_prime(primes[i1] * (10 ** digits[i2]) + primes[i2]):
        return False
    if not is_prime(primes[i2] * (10 ** digits[i1]) + primes[i1]):
        return False
    return True

def search (idx, iterator, k, comp, lst):
    if k == size - 1:
        return comp if len(comp) == size else None
    for pos in range(lst + 1, len(iterator)):
        updt = comp.intersection(relations[iterator[pos]])
        if len(updt) < size:
            continue
        result = search(idx, iterator, k + 1, updt, pos)
        if result is not None:
            return result
    return None

def is_fully_connected (idx):
    comp = relations[idx]
    if len(comp) < size:
        return None
    iterator = list(relations[idx].difference(set([idx])))
    return search(idx, iterator, 0, comp, -1)

min_sum = math.inf
for idx in range(0, len(primes)):
    print(primes[idx])
    if primes[idx] >= min_sum:
        break
    relations[idx] = set([idx])
    for pos in range(0, idx):
        if test(idx, pos):
            relations[idx].add(pos)
            relations[pos].add(idx)
    result = is_fully_connected(idx)
    if result is not None:
        alt_sum = sum([primes[pos] for pos in result])
        if alt_sum < min_sum:
            alt_sum = min_sum

elapsed_time = time.time() - start_time
print('%.4f secs' % elapsed_time)
