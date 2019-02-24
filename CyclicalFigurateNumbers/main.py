"""
Approach:
- Lower and upper bound the set of figurate numbers using the fact they have
the following formula: n * (a * n + b) / 2, and that they must fall between 10^3
and 10^4.
- Recursive search.
"""

import itertools
import math

def figurate (a, b, n):
    return n * (a * n + b) // 2

def lower_bound (a, b):
    return int(math.ceil((-b + math.sqrt(math.pow(b, 2) + 8 * math.pow(10, 3) * a)) / (2 * a)))

def upper_bound (a, b):
    return int(math.ceil((-b + math.sqrt(math.pow(b, 2) + 8 * math.pow(10, 4) * a)) / (2 * a)))

def generate (a, b):
    numbers = [figurate(a, b, n) for n in range(lower_bound(a, b), upper_bound(a, b))]
    prefixes = [str(numbers[idx] // 100).zfill(2) for idx in range(0, len(numbers))]
    suffixes = [str(numbers[idx] % 100).zfill(2) for idx in range(0, len(numbers))]
    return {
        'numbers': numbers,
        'prefixes': prefixes,
        'suffixes': suffixes
    }

def search (values, k, positions):
    if k >= len(values):
        first_prefix = values[0]['prefixes'][positions[0]]
        curr_suffix = values[k - 1]['suffixes'][positions[-1]]
        return positions if curr_suffix == first_prefix else None
    elif k == 0:
        for idx in range(0, len(values[k]['numbers'])):
            result = search(values, k + 1, positions + [idx])
            if result is not None:
                break
        return result
    else:
        result = None
        curr_suffix = values[k - 1]['suffixes'][positions[-1]]
        next_prefixes = values[k % len(values)]['prefixes']
        for idx in range(0, len(next_prefixes)):
            if curr_suffix == next_prefixes[idx]:
                result = search(values, k + 1, positions + [idx])
                if result is not None:
                    break
        return result

result = None
for permutation in itertools.permutations([
    generate(2, 0),
    generate(3, -1),
    generate(4, -2),
    generate(5, -3),
    generate(6, -4)
]):
    values = [generate(1, 1)] + list(permutation)
    result = search(values, 0, [])
    if result is not None:
        result = [values[k]['numbers'][result[k]] for k in range(0, len(values))]
        break
print(result)
print(sum(result))
