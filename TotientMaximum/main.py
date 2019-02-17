from functools import reduce

primes = [2, 3, 5, 7, 11, 13, 17]

def multiply (a, b):
    return a * b

def totient_product (acc, val):
    return acc / (1 - 1 / val)

print(reduce(multiply, primes))
print(reduce(multiply, primes) <= 1000000)
print(reduce(totient_product, primes, 1))
