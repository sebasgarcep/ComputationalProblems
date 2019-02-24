"""
Approach:
- For each number of digits generate all its possible cubes
- Check whether two numbers have the same digits by taking each of their digits,
arranging them from highest to lowest and building a number from these digits.
"""


import math

def get_digits (n):
    v = n
    digits = []
    while v > 0:
        digits.append(v % 10)
        v = v // 10
    digits = sorted(digits)
    return sum([value * (10 ** power) for (power, value) in enumerate(digits)])

def search ():
    d = 1
    while True:
        lower = int(math.ceil(math.pow(10, (d - 1) / 3)))
        upper = int(math.ceil(math.pow(10, d / 3)))
        numbers = []
        for n in range(lower, upper):
            value = n ** 3
            digits = get_digits(value)
            numbers.append((value, digits))
        for idx in range(0, len(numbers)):
            count = 1
            for pos in range(idx + 1, len(numbers)):
                if numbers[idx][1] == numbers[pos][1]:
                    count += 1
            if count == 5:
                return numbers[idx][0]
        d += 1

print(search())
