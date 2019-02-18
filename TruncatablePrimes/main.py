import math

base = [2, 3, 5, 7]
count = 0
result = set()

def found_item(item):
    global count
    global result
    if item not in result:
        print(item)
        count += 1
        result.add(item)
    if count >= 11:
        print('----')
        print(sum(result))
        exit(0)

def is_prime(n):
    if n == 2:
        return True
    if n < 2 or n % 2 == 0:
        return False
    for k in range(3, int(math.floor(math.sqrt(n))) + 1, 2):
        if n % k == 0:
            return False
    return True

def is_right_truncatable(n):
    val = n
    while True:
        val = val // 10
        if val <= 0:
            return True
        if not is_prime(val):
            return False

def is_left_truncatable(n):
    num_pow = int(math.floor(math.log10(n)))
    val = n
    while True:
        val = val % (10 ** num_pow)
        if val <= 0:
            return True
        if not is_prime(val):
            return False
        num_pow = num_pow - 1

def search(n):
    # Left search
    multiplier = 10 ** (int(math.floor(math.log10(n))) + 1)
    for x in range(1, 9 + 1, 2):
        val = multiplier * x + n
        if is_prime(val) and is_left_truncatable(val):
            if is_right_truncatable(val):
                found_item(val)
            search(val)

    # Right search
    for x in range(1, 9 + 1, 2):
        val = n * 10 + x
        if is_prime(val) and is_right_truncatable(val):
            if is_left_truncatable(val):
                found_item(val)
            search(val)

for item in base:
    search(item)
