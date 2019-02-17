import itertools

prime_list = [2, 3, 5, 7, 11, 13, 17]
digits = [str(idx) for idx in range(10)]

def is_pandigital_divisible(arrangement):
    for (idx, prime) in enumerate(prime_list):
        value = ''
        for pos in range(idx + 1, idx + 4):
            value += arrangement[pos]
        value = int(value)
        if value % prime != 0:
            return False
    return True

result = 0
for arrangement in itertools.permutations(digits):
    if is_pandigital_divisible(arrangement):
        result += int(''.join(arrangement))

print(result)
