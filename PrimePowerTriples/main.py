import math

def sieve (n):
    def thunk ():
        slots = [True] * (n + 1)
        slots[0] = False
        slots[1] = False
        idx = 2
        while idx < len(slots):
            if slots[idx]:
                yield idx
                for ptr in range(2 * idx, n + 1, idx):
                    slots[ptr] = False
            idx += 1
    return thunk

threshold = 50 * (10 ** 6)
primes_two = sieve(int(threshold ** (1.0 / 2.0)))
primes_three = sieve(int(threshold ** (1.0 / 3.0)))
primes_four = sieve(int(threshold ** (1.0 / 4.0)))

found = [0] * (threshold)
for p2 in primes_two():
    for p3 in primes_three():
        for p4 in primes_four():
            value = p2 ** 2 + p3 ** 3 + p4 ** 4
            if value < threshold:
                found[value] = 1
            else:
                break

print(sum(found))
