def binary_search (arr, item):
    posi = 0
    posf = len(arr)
    while posf - posi > 1:
        posn = (posf + posi) // 2
        if arr[posn] == item:
            return True
        elif arr[posn] < item:
            posi = posn
        else:
            posf = posn
    return False

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
(primes, slots) = sieve(limit)
result = 953
size = 21
beg = 0
end = beg + size + 2
current = sum(primes[beg:end])
while beg + size < len(primes):
    if current < limit and slots[current]:
        result = current
        size = end - beg
    if current < limit and end < len(primes) - 2:
        end += 2
        current += primes[end - 1]
        current += primes[end - 2]
    else:
        beg += 1
        end = beg + size + 2
        current = sum(primes[beg:end])

print(result)
print(size)
