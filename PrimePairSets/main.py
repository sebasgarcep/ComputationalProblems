"""
Approach:
Determine pairwise if both primes can be concatenated. Imagine that every number
is a vertex in a graph and that edges exist when they can be concatenated. Then
use recursive search to find primes lower than it that form a fully connected
graph of size 5. Search until the prime is larger than the smallest sum that was
found.
"""

import math
import time

def is_prime (n):
    if n == 2:
        return True
    if n < 2 or n % 2 == 0:
        return False
    for k in range(3, int(math.floor(math.sqrt(n))) + 1, 2):
        if n % k == 0:
            return False
    return True

def get_digits (n):
    d = []
    v = n
    while v > 0:
        d.append(v % 10)
        v = v // 10
    return d

def count_bits (n):
    return bin(n).count('1')

def get_bit_positions (n):
    iterator = []
    pos = 0
    while n > 0:
        if n & 1:
            iterator.append(pos)
        n = n >> 1
        pos += 1
    return iterator

start_time = time.time()
# I know beforehand that there is a solution that adds up to less than 30k
limit = 3 * (10 ** 4)
size = 5
slots = [True] * (limit + 1)
slots[0] = False
slots[1] = False
idx = 2
primes = []
digits = []
relations = []
min_sum = math.inf
while idx < len(slots):
    if slots[idx]:
        num_digits = get_digits(idx)
        sum_digits = sum(num_digits) % 2

        if idx == 3 or idx > 5:
            primes.append(idx)
            digits.append(len(num_digits))
            relations.append(2 ^ idx)

        for ptr in range(2 * idx, limit + 1, idx):
            slots[ptr] = False
    idx += 1

def test (i1, i2):
    if not is_prime(primes[i1] * (10 ** digits[i2]) + primes[i2]):
        return False
    if not is_prime(primes[i2] * (10 ** digits[i1]) + primes[i1]):
        return False
    return True

def search (idx, iterator, k, comp, lst):
    if k == size - 1:
        return comp if count_bits(comp) == size else None
    for pos in range(lst + 1, len(iterator)):
        updt = comp & relations[iterator[pos]]
        if count_bits(updt) < size:
            continue
        result = search(idx, iterator, k + 1, updt, pos)
        if result is not None:
            return result
    return None

def is_fully_connected (idx):
    comp = relations[idx]
    if count_bits(comp) < size:
        return None
    iterator = get_bit_positions(comp ^ (2 ** idx))
    return search(idx, iterator, 0, comp, -1)


for idx in range(0, len(primes)):
    print(primes[idx])
    if primes[idx] >= min_sum:
        break
    relations[idx] = 2 ** idx
    for pos in range(0, idx):
        if test(idx, pos):
            relations[idx] = relations[idx] | (2 ** pos)
            relations[pos] = relations[pos] | (2 ** idx)
    result = is_fully_connected(idx)
    if result is not None:
        alt_sum = sum([primes[pos] for pos in get_bit_positions(result)])
        if alt_sum < min_sum:
            min_sum = alt_sum

elapsed_time = time.time() - start_time
print('Solution: %d' % min_sum)
print('%.4f secs' % elapsed_time)
