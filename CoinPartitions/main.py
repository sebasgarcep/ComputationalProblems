"""
Approach:
- Use Euler's Pentagonal Number formula.
- Use the modulus to reduce the numbers' length.

Proofs:
- Proof that the generating function of the partition numbers can be written
as a simple product:
https://en.wikipedia.org/wiki/Partition_function_(number_theory)
- Relation of the generating function of the partition numbers (in product form)
to the pentagonal numbers:
https://faculty.math.illinois.edu/~reznick/2690367.pdf
- Proof of the recurrence formula used:
https://math.blogoverflow.com/2014/08/25/playing-with-partitions-eulers-pentagonal-theorem/
"""

n = 1
mod = 10 ** 6
memo = [1]
while True:
    p = 0
    k = 1
    l = 0
    while True:
        pentagonal = k * (3 * k - 1) // 2
        if n - pentagonal < 0:
            break
        sign = 1 if l % 4 == 0 or l % 4 == 1 else -1
        p += (sign * memo[n - pentagonal]) % mod
        if k > 0:
            k = -k
        else:
            k = -k + 1
        l += 1
    p = p % mod
    if p == 0:
        break
    memo.append(p)
    n += 1
print(n)
