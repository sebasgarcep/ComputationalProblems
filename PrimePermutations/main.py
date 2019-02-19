"""
For each possible set of digits:
1. If the digits add up to 3 then the numbers they generate cannot be prime, so
skip.
2. Generate all possible permutations but add only to the list the prime numbers.
3. If the number of primes is less than 3 then skip.
4. Otherwise test all possible ordered triples until you find the solution.
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

for w in range(1, 9 + 1):
    for x in range(w, 9 + 1):
        for y in range(x, 9 + 1):
            for z in range(y, 9 + 1):
                if w + x + y + z % 3 == 0:
                    continue
                nums = []
                digits = [w, x, y, z]
                for perm in itertools.permutations(digits):
                    value = sum([d * (10 ** (3 - i)) for (i, d) in enumerate(perm)])
                    if is_prime(value) and value not in nums:
                        nums.append(value)
                if len(nums) < 3:
                    continue
                for i in range(0, len(nums) - 2):
                    for j in range(i + 1, len(nums) - 1):
                        for k in range(j + 1, len(nums)):
                            if nums[j] - nums[i] == nums[k] - nums[j] and nums[i] != 1487:
                                print(nums[i] * (10 ** 8) + nums[j] * (10 ** 4) + nums[k])
