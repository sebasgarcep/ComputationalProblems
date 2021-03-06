"""
A closed-form formula for the probability of N being the number of steps before
the algorithm stops can be derived by hand. If P(N) is this probability, then
it is trivial to show that:

P(1) = 1 / 2^32
P(N) = sum(k_1 = 0, 32 - 1) sum(k_2 = 0, 32 - k_1 - 1) ... sum(k_N-1 = 0, 32 - k_1 - k_2 - ... - k_N-2 - 1)
    ((32 choose k_1) / 2^32) * ((32 - k_1 choose k_2) / 2^32 - k_1) * ... *
    ((32 - k_1 - k_2 - ... - k_N-2 choose k_N-1) / 2^32 - k_1 - k_2 - ... - k_N-2) *
    1 / 2^32 - k_1 - k_2 - ... - k_N-2 - k_N-1

Because when you pick a set of bits in one round of the algorithm you then have
to choose over the remaining digits. In the final round there is only one choice
left: the remaining digits.

P(N) can be simplified using the following formula:

sum(k = 0, n) 2^k (n choose k) = 3^n

This formula can be proved by noticing that the number of base-3 numbers with n
digits or less is 3^n and they can be generated by setting all digits to 0, then
picking k out of the n digits and setting each of them to either 1 or 2. Therefore
each pick implies 2^k new numbers, and adding over each of the different possible
picks gives us the formula.

The simplified form of P(N=2) can then be calculated to be:

P(N) = (1/2^32)^2 * (3^32 - 2^32)

A similar argument to the one above can be used to prove that:

sum(k = 0, n) a^k (n choose k) b^(n-k) = (a+b)^n

By noticing that base-(a+b) digits can be generated by picking a set of k digits
and setting them to any of the a different possible values, and then taking the
remaining (n-k) digits and setting them to any of the b different values. In
fact, this is a known formula, so I don't know why I had to prove it hehe.

We will now show that P(N) = (1/2^32)^N (2^N - 1)^32 - P(N-1) - P(N-2) ... - P(1):

Notice that P(N) can be rewritten as:

P(N) = (1/2^32)^N sum(k_1 = 0, 32 - 1) 2^((N-1) * k_1) (32 choose k_1)
    sum(k_2 = 0, 32 - k_1 - 1) 2^((N-2) * k_2) (32 - k_1 choose k_2) ...
    sum(k_N-1 = 0, 32 - k_1 - k_2 - ... - k_N-2 - 1) 2^k_(N-1) (32 - k_1 - k_2 - ... - k_N-2 choose k_N-1)

Notice that the final summation can be replaced with:

3^(32 - k_1 - k_2 - ... - k_N-2) - 2^(32 - k_1 - k_2 - ... - k_N-2)

If we distribute the summations over both of these terms, the negative term will
reduce the term of each power of two inside the summations by one, and also of
outer power of two. This reduced term corresponds to P(N-1).

The positive term then ends up muliplying a power of 4 and using the above result
we remove another summation to get a power of 7 minus a power of 4. Notice that on each
iteration the positive term has a power of 2^i - 1 (Because adding over powers of
two gives this result). Repeating the procedure of using the above result to
simplify the positive summation and using the negative term of the result as P(N-i)
we get the desired result.

The expected value of N can then be calculated easily.
"""

import math
from random import randrange

def monte_carlo ():
    hashmap = {}
    limit = 2 ** 32
    for iteration in range(10 ** 6):
        x = 0
        n = 0
        while x < limit - 1:
            mask = randrange(limit)
            x = x | mask
            n += 1
        key = str(n)
        if key not in hashmap:
            hashmap[key] = 0
        hashmap[key] += 1

    numer = 0
    denom = 0

    for (n, occurrences) in hashmap.items():
        denom += occurrences

    for (n, occurrences) in hashmap.items():
        numer += int(n) * occurrences
        print((int(n), occurrences / denom))

    result = numer / denom
    print(result)

lookup = [1]
def factorial (n):
    idx = len(lookup)
    for idx in range(len(lookup), n + 1):
        lookup.append(idx * lookup[idx - 1])
    return lookup[n]

def choose (n, k):
    return factorial(n) // (factorial(k) * factorial(n - k))

result = 0
diff = math.inf
n = 1
curr = 0
while n < 10 or n * diff > 10e-20:
    prev = curr
    curr = ((2 ** n - 1) / (2 ** n)) ** 32
    diff = curr - prev
    result += n * diff
    n += 1
print('%.10f' % result)
