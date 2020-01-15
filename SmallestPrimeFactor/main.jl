#=
Approach:

Notice that:

S(n) = sum(i = 2, n) smpf(i)
     = sum(pt <= n, pt prime) pt * |Apt|

where Apt is the set of all numbers divisible by the prime pt, but not by any of the t - 1 primes smaller
than pt. Thus:

|A2| = floor(n / 2)
|A3| = floor(n / 3) - floor(n / 6)
|A5| = floor(n / 5) - floor(n / 10) - floor(n / 15) + floor(n / 30)

For |Apt| set x = n / pt. Then |Apt| = floor(x) - sum(i < t) floor(x / pi) + sum(i < j < t) floor(x / (pi * pj)) - ...,
This is equivalent to the amount of numbers less than or equal to x that are not divisible by any of
the first t - 1 primes. Thus |Apt| = phi(x, t - 1) = phi(n / pt, t - 1), where phi is as defined in
the proof of the Meissel-Lehmer algorithm.

Notice that if smpf(i) > sqrt(n), then i is prime (otherwise sqrt(i) >= smpf(i) > sqrt(n) and thus
i > n, a contradiction). Therefore if p > sqrt(n), then |Apt| = 1. Therefore:

sum(sqrt(n) < p <= n, p prime) p * |Apt| = sum(sqrt(n) < p <= n, p prime) p
                                         = sum(p <= n, p prime) p - sum(p <= sqrt(n), p prime) p
                                         = sp(n) - sp(sqrt(n))

where sp is the sum of primes function.

General sum over primes
-----------------------

As per Lehmer's paper, the Meissel-Lehmer algorithm calculates sum(pt <= x, pt prime) 1. In the final
section he outlines a method to extend the algorithm to general functions f(pt). We will now calculate
the formulas for f(pt) = pt.

Define:

Q(x, k) = sum(n * k <= x) f(n * k)
phi(x, a) = sum(n <= x, gcd(n, ma) = 1) f(n), where ma = p1 * p2 * ... * pa
P0(x, a) = f(1)
Pk(x, a) = sum(q <= x) f(q), q is the product of k primes, each greater than pa

Clearly, when f(q) = 1, these definitions are consistent with the classical formulation for the
Meissel-Lehmer algorithm. Notice that:

sum(d | ma) mu(d) * Q(x, d) = sum(d | ma) mu(d) * sum(n * d <= x) f(n * d)
                            = sum(m <= x) f(m) * sum(d | ma, n * d = m) u(d)
                            = sum(m <= x) f(m) * sum(d | ma, d | m) u(d)
                            = sum(m <= x) f(m) * sum(d | gcd(ma, m)) u(d)

where mu is the Mobius function. It is well known that:

sum(d | n) mu(d) = if n = 1 then 1 else 0 end

To see this notice that the case for n = 1 is a result of mu(1) = 1. Now if n = 2 it is clear that
the sum equals 0. Notice also that if n = p1^k1 * p2^k2 * ... * pm^km, then the sum over n is equal
to the sum over n * pi, i = 1, 2, ... , m, as the new divisors in the sum will have a square factor
of said pi, and therefore their values of mu will be 0. Therefore assume we wish to find the value
of the sum for n * pi+1. Then:

sum(d | n * pi+1) u(d) = sum(d | n) u(d) + u(d * pi+1) = sum(d | n) u(d) - u(d) = 0

Therefore the terms in the sum of sum(d | ma) mu(d) * Q(x, d) vanish except when ma and m are coprime,
in which case the coefficient for f(m) is 1. Therefore:

sum(d | ma) mu(d) * Q(x, d) = sum(m <= x, gcd(m, ma) = 1) f(m) = phi(x, a)

Also, suppose n <= x and gcd(n, ma) = 1. Then pi does not divide n, for i = 1, 2, ... , a. Therefore,
any prime that divides n must be greater than pa. Finally, n must be the product of a finite number of
primes. Therefore:

phi(x, a) = sum(n <= x, gcd(n, ma) = 1) f(n)
          = sum(k = 0, infty) sum(n <= x, gcd(n, ma) = 1, n is the product of k primes) f(n)
          = sum(k = 0, infty) sum(n <= x, n is the product of k primes, each greater than pa) f(n)
          = sum(k = 0, infty) Pk(x, a)

Combining both results we get:

phi(x, a) = sum(d | ma) mu(d) * Q(x, d) = sum(k = 0, infty) Pk(x, a)

Notice that P1(x, a) = sum(pa < p <= x, p prime) f(p). Therefore:

phi(x, a) = P0(x, a) + P1(x, a) + sum(k = 2, infty) Pk(x, a)
          = f(1) + sum(pa < p <= x, p prime) f(p) + sum(k = 2, infty) Pk(x, a)

sum(pa < p <= x, p prime) f(p) = phi(x, a) - f(1) - sum(k = 2, infty) Pk(x, a)
sum(p <= x, p prime) f(p) = sum(p <= pa, p prime) f(p) + phi(x, a) - f(1) - sum(k = 2, infty) Pk(x, a)

If f preserves multiplication, that is, f(m) * f(n) = f(m * n), then:

phi(x, a - 1) - phi(x, a) = sum(n <= x, gcd(n, ma-1) = 1) f(n) - sum(n <= x, gcd(n, ma) = 1) f(n)
                          = sum(n <= x, gcd(n, ma-1) = 1, pa divides n) f(n)
                            + sum(n <= x, gcd(n, ma-1) = 1, pa does not divide n) f(n)
                            - sum(n <= x, gcd(n, ma) = 1) f(n)
                          = sum(n <= x, gcd(n, ma-1) = 1, pa divides n) f(n)
                            + sum(n <= x, gcd(n, ma) = 1) f(n)
                            - sum(n <= x, gcd(n, ma) = 1) f(n)
                          = sum(n <= x, gcd(n, ma-1) = 1, pa divides n) f(n)
                          = sum(n * pa <= x, gcd(n * pa, ma-1) = 1) f(n * pa)
                          = sum(n <= x / pa, gcd(n, ma-1) = 1) f(n * pa)
                          = sum(n <= x / pa, gcd(n, ma-1) = 1) f(n) * f(pa)
                          = f(pa) * sum(n <= x / pa, gcd(n, ma-1) = 1) f(n)
                          = f(pa) * phi(x / pa, a - 1)

Or reorganizing:

phi(x, a) = phi(x, a - 1) - f(pa) * phi(x / pa, a - 1)

Expanding the leftmost term until we reach level r, we get:

phi(x, a) = phi(x, r) - sum(k = r, a - 1) f(pk+1) * phi(x / pk+1, k)

which we can use as a recursive step to simplify the calculation of phi.

Application of General Case
---------------------------

If we set f(p) = p then this function clearly preserves multiplication. Set r = 2, and use the fact
that the only numbers coprime to 6 are of the form 6 * q + 1 and 6 * q + 5. Then:

q(x, 0) = x * (x + 1) / 2
q(x, 1) = ceiling(x / 2) ^ 2
q(x, 2) = 6 * q ^ 2 + s, where
    q = fld(x, 6),
    s = if x mod 6 == 0 then 0 else if x mod 6 == 5 then 6 else 1 end
q(x, 3) = ... (use recursion)

Now set a = pr(n^(1/4)), b = pr(n^(1/2)), c = pr(n^(1/3)). Notice that in this case Pk(x, a) = 0,
for k >= 4. To see this let q = p1 * p2 * ... * pk, with p1 <= p2 <= ... <= pk. But p1 > pa, thus
p1 > n^(1/4) >= n^(1/k). Thus, in general, pi > n^(1/k), and therefore multiplying over i = 1, 2, ... k,
we get q > n. Therefore the sums for Pk(x, a), for k >= 4 are empty. Therefore:

sum(p <= x, p prime) f(p) = sum(p <= pa, p prime) f(p) + phi(x, a) - f(1) - P2(x, a) - P3(x, a)
sum(p <= x, p prime) f(p) = sum(p <= pa, p prime) f(p) + phi(x, a) - 1 - P2(x, a) - P3(x, a)

Now let's solve for P2(x, a) and P3(x, a):

bi = pr(x / pi)
P2(x, a) = sum(q = pi * pj <= x, pa < pi < pj) f(q)
         = sum(i = a + 1, b) sum(j = i, bi) f(pi * pj)
         = sum(i = a + 1, b) sum(j = i, bi) pi * pj
         = sum(i = a + 1, b) pi * sum(j = i, bi) pj
         = sum(i = a + 1, b) pi * (sp(p(bi)) - sp(pi-1))
         = sum(i = a + 1, b) pi * (sp(x / pi) - sp(pi-1))

ci = pr((x / pi)^(1/2))
cij = pr(x / (pi * pj))
P3(x, a) = sum(q = pi * pj * pk <= x, pa < pi < pj < pk) f(q)
         = sum(i = a + 1, c) sum(j = i, ci) sum(k = j, cij) f(pi * pj * pk)
         = sum(i = a + 1, c) sum(j = i, ci) sum(k = j, cij) pi * pj * pk
         = sum(i = a + 1, c) sum(j = i, ci) pi * pj * sum(k = j, cij) pk
         = sum(i = a + 1, c) sum(j = i, ci) pi * pj * (sp(p(cij)) - sp(pj-1))
         = sum(i = a + 1, c) sum(j = i, ci) pi * pj * (sp(x / (pi * pj)) - sp(pj-1))

Source:

https://projecteuclid.org/download/pdf_1/euclid.ijm/1255455259

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
    l = 10^11
    ms = 10^9

    # Constants
    k = isqrt(l)

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

    prime_sums = copy(primes)
    for i in 2:length(prime_sums)
        prime_sums[i] = mod(prime_sums[i] + prime_sums[i - 1], ms)
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

    function phi_prime_counting(x, a)
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
            res -= phi_prime_counting(fld(x, primes[ai + 1]), ai)
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
        res = a - 1 + phi_prime_counting(x, a)

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

    function phi_prime_summation(x, a)
        # Base cases
        if a == 0
            return fld(x * (x + 1), 2)
        elseif x <= primes[a]
            return 1
        elseif a == 1
            return cld(x, 2) ^ 2
        end
        # Calculate for a = 2
        q = fld(x, 6)
        if x % 6 == 0
            s = 0
        elseif x % 6 == 5
            s = 12 * q + 6
        else
            s = 6 * q + 1
        end
        res = mod(6 * q ^ 2 + s, ms)
        # Use recursion
        for i in 2:(a - 1)
            p = primes[i + 1]
            res = mod(res - p * phi_prime_summation(fld(x, p), i), ms)
        end
        return res
    end

    function safe_prime_sums(a)
        if a < 1
            return 0
        end
        return prime_sums[a]
    end

    @memoize function meissel_lehmer_prime_summation(x)
        # Binary search
        if x <= k
            pos = binary_prime_counting(x)
            return safe_prime_sums(pos)
        end

        # Enumeration constants
        a = meissel_lehmer_prime_counting(integer_nth_root(x, 4))
        b = meissel_lehmer_prime_counting(integer_nth_root(x, 2))
        c = meissel_lehmer_prime_counting(integer_nth_root(x, 3))

        # Base answer
        res = mod(safe_prime_sums(a) - 1 + phi_prime_summation(x, a), ms)

        # Calculate P2(x, a)
        for i in (a + 1):b
            pi = primes[i]
            x_div_pi = fld(x, pi)
            res = mod(res - pi * (meissel_lehmer_prime_summation(x_div_pi) - safe_prime_sums(i - 1)), ms)
            # Calculate P3(x, a)
            if i <= c
                ci = meissel_lehmer_prime_counting(isqrt(x_div_pi))
                for j in i:ci
                    pj = primes[j]
                    x_div_pi_pj = fld(x_div_pi, pj)
                    res = mod(res - mod(pi * pj, ms) * (meissel_lehmer_prime_summation(x_div_pi_pj) - safe_prime_sums(j - 1)), ms)
                end
            end
        end

        return res
    end

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
    start = time()

    lmt = binary_prime_counting(isqrt(l))
    for i in 1:lmt
        p = primes[i]
        result = mod(result + p * phi_prime_counting(fld(l, p), i - 1), ms)
    end

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)

    result = mod(result + meissel_lehmer_prime_summation(l) - meissel_lehmer_prime_summation(isqrt(l)), ms)

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
