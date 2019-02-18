"""
- 1 to 1 pandigital numbers are not prime
- 1 to 2 pandigital numbers are divisible by 3
- 1 to 3 pandigital numbers are divisible by 3
- 1 to 4 pandigital numbers are candidates
- 1 to 5 pandigital numbers are divisible by 3
- 1 to 6 pandigital numbers are divisible by 3
- 1 to 7 pandigital numbers are candidates
- 1 to 8 pandigital numbers are divisible by 3
- 1 to 9 pandigital numbers are divisible by 3
"""

import itertools
import math

def is_prime(n):
    if n == 2:
        return True
    if n < 2 or n % 2 == 0:
        return False
    for k in range(3, int(math.floor(math.sqrt(n))) + 1, 2):
        if n % k == 0:
            return False
    return True

sol = None
for digits in itertools.permutations(range(1, 7 + 1)):
    num = sum([d * (10 ** (len(digits) - i - 1)) for (i, d) in enumerate(digits)])
    if is_prime(num) and (sol is None or sol < num):
        sol = num

if sol is None:
    for digits in itertools.permutations(range(1, 4 + 1)):
        num = sum([d * (10 ** (len(digits) - i - 1)) for (i, d) in enumerate(digits)])
        if is_prime(num) and (sol is None or sol < num):
            sol = num

print(sol)
