"""
Approach:
- Use the sieve to calculate the sum of divisors, then iterate over the
result and skip already found elements of amicable chains.
"""

import time

start = time.time()
limit = 10 ** 6
slots = [1] * (limit + 1)
skip = [False] * (limit + 1)
for n in range(2, limit // 2 + 1):
    for k in range(2 * n, limit + 1, n):
        slots[k] += n
    if slots[n] > limit:
        skip[n] = True

result = None
l = None
for n in range(2, limit + 1):
    if skip[n]:
        continue
    v = n
    chain = []
    chain_set = set()
    while True:
        if v > limit:
            for j in range(0, len(chain)):
                skip[chain[j]] = True
            break
        if v in chain_set:
            i = chain.index(v)
            if l is None or len(chain) - i > l:
                result = None
                l = len(chain) - i
                for j in range(0, len(chain)):
                    skip[chain[j]] = True
                    if j >= i and (result is None or chain[j] < result):
                        result = chain[j]
            break
        chain.append(v)
        chain_set.add(v)
        v = slots[v]

print(result)
end = time.time()
print('Took %.4f secs' % (end - start))
