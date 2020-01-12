#=
Legendre's Prime Counting function
----------------------------------

Let smpf(i) be the smallest prime factor of number i. Let i <= x, for a given x. Then i is composite
if and only if smpf(i) <= sqrt(i) <= sqrt(x). Therefore, all numbers smaller than or equal to x which
are not divisible by a prime in the range [1, sqrt(x)] must be prime. By the inclusion-exclusion
principle, the amount of numbers which are not divisible the primes pi in the range [1, sqrt(x)] is:

x - 1 - sum(i) floor(x / pi) + sum(i < j) floor(x / (pi * pj)) - sum(i < j < k) floor(x / (pi * pj * pk)) + ...

Where the -1 term arises from the fact that eliminating multiples of the primes cannot eliminate the
number 1, which is not a prime.

On the other hand, this quantity equals the prime numbers strictly greater than sqrt(x). Therefore it
equals:

pr(x) - pr(sqrt(x))

Clearly pr(sqrt(x)) = |{ pi }i = 1, 2, ... , k|. Therefore we can find pr(x) by equating both expressions
and isolating it.

Legendre's formula clearly doesn't scale well as x grows, as the inclusion-exclusion formula requires us
to make (q choose r) calculations, where r <= 13 for 10^12 and q is at least larger than 200, which is on
the order of 10^20. A better aproach would be Meissel's.

Meissel–Lehmer's algorithm
--------------------------

Let:

phi(x, a) = |{ n | n <= x and n is not divisible by any of the first a primes }|
Pk(x, a) = |{ n | n <= x and n is not divisible by any of the first a primes and n has k prime factors }|

Therefore:

phi(x, a) = sum(k = 0, infty) Pk(x, a)

but, Pk(x, a) = 0 for all k >= L, for some L given by x. Therefore, phi(x, a) can be expressed as a finite
sum. Also, if n has 1 prime factor, then n is prime. Therefore:

pr(x) = P1(x, a) + a

Joining both expressions we get:

pr(x) = a - 1 + phi(x, a) - sum(k = 2, infty) Pk(x, a)

P2(x, a) can be computed to be:

P2(x, a) = |{ n | n <= x, n = pb * pc, a < b <= c }|
         = sum(b = a + 1, pr(sqrt(x))) |{ n | n <= x, n = pb * pc, b <= c <= pr(x / pb) }|, add over each pb
         = sum(b = a + 1, pr(sqrt(x))) ( pr(x / pb) - (b - 1) )
         = sum(b = a + 1, pr(sqrt(x))) ( pr(x / pb) ) + (pr(sqrt(x)) - a) - pr(sqrt(x)) * (pr(sqrt(x)) + 1) / 2 + a * (a + 1) / 2
         = sum(b = a + 1, pr(sqrt(x))) ( pr(x / pb) ) - pr(sqrt(x)) * (pr(sqrt(x)) - 1) / 2 + a * (a - 1) / 2
         = sum(b = a + 1, pr(sqrt(x))) ( pr(x / pb) ) - ( pr(sqrt(x)) choose 2 ) + ( a choose 2 )

Clearly, a similar procedure can be done for P3(x, a) to obtain:

P3(x, a) = sum(i = a + 1, pr(x^1/3)) sum(j = i, pr(sqrt(x / pi))) ( pr(x / (pi * pj)) - (j - 1) )

It is clear then that Pk(x, a) = 0 when a = pr(x ^ (1 / k)).

On the other hand, phi(x, a) counts all numbers <= x that are not divisible by p1, p2, ... , pa, and
phi(x, a - 1) counts all numbers <= x that are not divisble by p1, p2, ... , pa-1. Therefore the
difference equals the numbers divisble by pa, which are not divisible by any of the previous primes.
There is a clear bijection between pa, 2 * pa, 3 * pa, ..., m * pa and 1, 2, 3, ... m. Therefore, if
we find the amount of the latter which are not divisible by p1, p2, ... , pa-1, it will be the same
amount as for the numbers pa, 2 * pa, 3 * pa, ... , m * pa. This is amount is phi(x / pa, a - 1).
Therefore we have the following identity:

phi(x / pa, a - 1) = phi(x, a - 1) - phi(x, a)

Or:

phi(x, a) = phi(x, a - 1) - phi(x / pa, a - 1)

Given the previous considerations an outline for Meissel–Lehmer's algorithm would be:

1. Use a prime sieve to calculate the primes up to at least sqrt(x). For this problem we will
use 10^9.

2. Then the prime counting function will use this list of primes and the binary search algorithm to
solve for values smaller than or equal to sqrt(x).

3. Set a = pr(x ^ (1 / 4)), b = pr(sqrt(x)), c = pr(x ^ (1 / 3)). Then:

pr(x) = a - 1 + phi(x, a) - P2(x, a) - P3(x, a)

4. The formula for P2(x, a) will be:

P2(x, a) = sum(i = a + 1, b) ( pr(x / pi) ) - ( b choose 2 ) + ( a choose 2 )

5. The formula for P3(x, a) will be:

bi = pr(sqrt(x / pi))
P3(x, a) = sum(i = a + 1, c) sum(j = i, bi) ( pr(x / (pi * pj)) - (j - 1) )

6. Finally the formula for phi(x, a) will be:

phi(x, a) = phi(x, a - 1) - phi(x / pa, a - 1)

with base cases for a = 0, 1, 2. Notice that we can optimize the recursion by expanding the term that hasn't
been divided, which results in:

phi(x, a) = phi(x, k) - sum(i = k, a - 1) phi(x / pi+1, i)

and in our case we set k = 3.

Approach:
---------

Assume we wish to compute f(L). Then the number of divisors of n = p1^k1 * p2^k2 * ... * pm^km
is given by:

d(n) = (1 + k1) * (1 + k2) * ... * (1 + km)

Because d(n) = 8 = 2 * 4 = 2 * 2 * 2, n can have at most 3 distinct prime divisors.

Case 1: n = p^7
------------------------

Because n <= L, then p <= L^(1/7). Thus the number of solutions in this case equals pr(L^(1/7)),
where pr is the prime counting function.

Case 2: n = p1 * p2^3
------------------------

Because n <= L, then p2 <= (L / 2)^(1/3). Then for each of these pr(L^(1/3) / 2) primes the number of
solutions is pr(L / p2^3). Subtract 1 if p2 <= L / p2^3.

Case 3: n = p1 * p2 * p3
------------------------

Assume that p1 < p2 < p3. Then p1 <= L^(1/3), p2 <= (L / p1)^(1/2). Then for each pair of primes p1, p2,
the number of solutions is pr(L / (p1 * p2)) - j, to exclude the primes less than or equal to pj.

Sources:
https://projecteuclid.org/download/pdf_1/euclid.ijm/1255455259
https://euler.stephan-brumme.com/toolbox/

=#

using Printf
using Memoize

function integer_nth_root(x, n)
    if n == 1
        return x
    elseif n == 2
        return isqrt(x)
    else
        fl = convert(Int64, floor(x ^ (1 / n)))
        cl = convert(Int64, ceil(x ^ (1 / n)))
        if cl^n <= x
            return cl
        else
            return fl
        end
    end
end

function main()
    start = time()
    result = 0

    # Problem Parameters
    l = 10^12

    # Constants
    k = 10^9 # isqrt(l)

    # Find primes up to k using a prime sieve
    primes = []
    slots = [i % 2 == 1 for i in 1:k]
    slots[1] = false
    slots[2] = true
    push!(primes, 2)
    for m in 3:2:k
        if slots[m]
            push!(primes, m)
            for t in (2 * m):m:k
                slots[t] = false
            end
        end
    end

    # These functions require list of primes and must be memoized
    function binary_prime_counting(x)
        if x < primes[1]
            return 0
        end
        lower = 1
        upper = length(primes)
        while upper - lower > 1
            middle = fld(lower + upper, 2)
            if primes[middle] == x
                lower = middle
                upper = middle
            elseif primes[middle] < x
                lower = middle
            else
                upper = middle
            end
        end
        if primes[upper] <= x
            return upper
        else
            return lower
        end
    end

    function phi(x, a)
        # Base cases
        if a == 0
            return x
        elseif x <= primes[a]
            return 1
        elseif a == 1
            return x - fld(x, 2)
        elseif a == 2
            return x - fld(x, 2) - fld(x, 3) + fld(x, 6)
        end
        res = x - fld(x, 2) - fld(x, 3) - fld(x, 5) + fld(x, 6) + fld(x, 10) + fld(x, 15) - fld(x, 30)
        for ai in 3:(a - 1)
            res -= phi(fld(x, primes[ai + 1]), ai)
        end
        return res
    end

    @memoize function meissel_lehmer_prime_counting(x)
        # Binary search
        if x <= k
            return binary_prime_counting(x)
        end

        # Enumeration constants
        a = meissel_lehmer_prime_counting(integer_nth_root(x, 4))
        b = meissel_lehmer_prime_counting(integer_nth_root(x, 2))
        c = meissel_lehmer_prime_counting(integer_nth_root(x, 3))

        # Base answer
        res = a - 1 + phi(x, a)

        # Calculate P2(x, a)
        res -= binomial(a, 2) - binomial(b, 2)
        for i in (a + 1):b
            x_div_p = fld(x, primes[i])
            res -= meissel_lehmer_prime_counting(x_div_p)
            # Calculate P3(x, a)
            if i <= c
                bi = meissel_lehmer_prime_counting(isqrt(x_div_p))
                for j in i:bi
                    res -= meissel_lehmer_prime_counting(fld(x_div_p, primes[j])) - (j - 1)
                end
            end
        end

        return res
    end

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
    start = time()

    # Case 1
    lmt = integer_nth_root(l, 7)
    pos = binary_prime_counting(lmt)
    result += pos

    # Case 2
    lmt = integer_nth_root(fld(l, 2), 3)
    pos = binary_prime_counting(lmt)
    for i in 1:pos
        p = primes[i]
        x = fld(l, p^3)
        result += meissel_lehmer_prime_counting(x)
        if x >= p
            result -= 1
        end
    end

    # Case 3
    lmti = integer_nth_root(l, 3)
    posi = binary_prime_counting(lmti)
    for i in 1:posi
        pi = primes[i]
        lmtj = integer_nth_root(fld(l, pi), 2)
        posj = binary_prime_counting(lmtj)
        for j in (i + 1):posj
            pj = primes[j]
            x = fld(l, pi * pj)
            result += meissel_lehmer_prime_counting(x) - j
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
