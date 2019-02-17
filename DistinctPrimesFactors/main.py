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

limit = 10 ** 6
num = 644
factors = [[2, 7, 23], [3, 5, 43], [2, 17, 19], [647]]
(primes,_) = sieve(limit)

while num < limit:
    num += 1
    new = num + 3
    factors = factors[1:4]
    factors.append([])
    pos = 0
    while new > 1:
        if new % primes[pos] == 0:
            factors[3].append(primes[pos])
            while new > 1 and new % primes[pos] == 0:
                new = new // primes[pos]
        pos += 1
    if len(factors[0]) == 4 and \
        len(factors[1]) == 4 and \
        len(factors[2]) == 4 and \
        len(factors[3]) == 4:
        print(num)
        exit()

print('Solution not found')
