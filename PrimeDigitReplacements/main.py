"""
Notes:
- The last digit cannot be replaced (If we replace that digit by an even number
    the resulting number isn't prime).
- We need to replace a multiple of 3 digits, as these do not change the mod-3 sum
    of the remaining digits (Allowing more than 7 of the possibilities to be prime).

Approach:
- Upper bound of 10^6 (If we don't find a solution we can always grow the
    upper bound)
- Sieve to find all primes and composites below 10^6.
- Because we cannot replace the last digit and have to replace a multiple of 3
    we can replace at most 3 digits.
- Start with 4 digit numbers. The last digit is fixed, pick that digit.
- Then go for 5 digit numbers. Pick a digit to fix between the first and the
    second-to-last, set that digit (and the last one).
- Then go for 6 digit numbers. Pick two digits to fix between the first and the
    second-to-last, set those digits (and the last one).
- For each of the previous choices, generate the digit replacements and test
    their primality using the sieve. Check that the number of misses is lower
    than 2 (or 1 when the leading digit is replaceable).
"""

def sieve(n):
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

def build_number (k, pos, r):
    idx = 0
    pwr = k - 1
    number = 0
    while pwr >= 0:
        (val, digit) = pos[idx]
        if val == pwr:
            number += digit * (10 ** pwr)
            idx += 1
        else:
            number += r * (10 ** pwr)
        pwr -= 1
    return number

limit = 10 ** 6
(_, slots) = sieve(limit)
def recursive (k, step, pos, lst):
    if step <= 0:
        misses = 0
        if pos[0][0] < k - 1:
            min_r = 1
        else:
            min_r = 0
        for r in range(min_r, 9 + 1):
            number = build_number(k, pos, r)
            if not slots[number]:
                misses += 1
            if misses > 2 - min_r:
                return None
        return build_number(k, pos, min_r)
    elif step == 1:
        for j in range(1, 9 + 1, 2): # The last digit cannot be prime
            result = recursive(k, 0, pos + [(0, j)], k - 1)
            if result is not None:
                return result
    else:
        for i in range(lst + 1, k - step + 1):
            for j in range(0, 9 + 1):
                if lst == -1 and j == 0:
                    continue
                result = recursive(k, step - 1, pos + [(k - i - 1, j)], i)
                if result is not None:
                    return result
    return None

def search ():
    for k in range(4, 6 + 1):
        result = recursive(k, k - 3, [], -1)
        if result is not None:
            return result
    return None

print(search())
