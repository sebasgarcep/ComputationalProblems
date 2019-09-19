#=
Approach:

We want to find the values of n for which 2 * n^2 - 1 is prime. A related
problem is finding the values of n for which 2 * n^2 - 1 = 0 (mod p) for
some prime p. Notice that the previous equation implies:

n^2 = 2^-1 (mod p)

And by Fermat's little theorem:

n^2 = 2^(p - 2) (mod p)

Also, a number is prime if it has no prime factors smaller or equal to its
square root. Therefore we only need to calculate primes up to the square root
of the largest value of t(n). If t(n) is below this below this bound, the multiplicity
of the prime numbers that divide it must add up to 1. Otherwise it must add up
to 0.

Finally we solve n^2 = 2^(p - 2) (mod p) using the Tonelli-Shanks algorithm. Using
the following claim we can exclude some prime numbers from the search:

Claim 1:
--------

2, 3, and 5 do not divide t(n).

Proof:
------

If n = 0 (mod p) then 2 * n^2 - 1 = -1 = p - 1 (mod p)
If n = 1 (mod p) then 2 * n^2 - 1 = 1 (mod p)
If n = - 1 (mod p) then 2 * n^2 - 1 = 1 (mod p)

Mod 2:
Already solved.

Mod 3:
Already solved.

Mod 5:
If n = 2 (mod 5), then 2 * n^2 - 1 = 2 * 4 - 1 = 8 - 1 = 7 = 2 (mod 5)
If n = 3 (mod 5), then 2 * n^2 - 1 = 2 * 9 - 1 = 18 - 1 = 17 = 2 (mod 5)

Finally, the following statement allows us to use a solution to the modular
equation to find all values of t(n) which satisfy that equation:

Claim 2:
--------

If p | t(n), then p | t(k * p +- n), where k is any integer.

Proof:
------

t(k * p +- n) = 2 * (k * p +- n)^2 - 1
              = 2 * (+- n)^2 - 1
              = 2 * n^2 - 1
              = 0 (mod p)

Euler's Criterion
-----------------

Let p be prime and n be a positive integer. Then n is a quadratic residue (i.e. a
square root modulo p) if and only if:

n^((p - 1) / 2) = 1 (mod p)

Proof:
------

If p = 2, then the result is trivial. Let p > 2.

<=] Let n^((p - 1) / 2) = 1 (mod p). Let y be a generator of the multiplicative group
of Zp. Therefore, for some k, y^k = n. Thus:

y^(k * (p - 1) / 2) = 1 (mod p)

Because the exponent has to be a multiple of p - 1, then k / 2 must be an integer.
Denote k' = k / 2. Let r be such that r = y^k'. Therefore:

r^2 = y^(2 * k') = y^k = n (mod p)

Therefore n is a quadratic residue.

=>] Let n be a quadratic residue. Then for some m, we have that n = m^2 (mod p). Thus:

n^((p - 1) / 2) = m^(p - 1) = 1 (mod p)

by Fermat's little theorem.

FIXME: missing proof for the Tonelli-Shank's algorithm.

=#


using Printf

function legendre(a, p)
    return powermod(a, (p - 1) >> 1, p)
end

function tonelli_shanks(n, p)
    if n < 0 || n >= p
        return tonelli_shanks(mod(n, p), p)
    end
    if legendre(n, p) != 1
        return nothing
    end
    s = 0
    q = p - 1
    while q & 1 == 0
        q >>= 1
        s += 1
    end
    if s == 1
        r = powermod(n, (p + 1) >> 2, p)
        if r < p - r
            return r, p - r
        else
            return p - r, r
        end
    end
    z = 2
    while p - 1 != legendre(z, p)
        z += 1
    end
    c = powermod(z, q, p)
    r = powermod(n, (q + 1) >> 1, p)
    t = powermod(n, q, p)
    m = s
    while t != 1
        tt = t
        i = 0
        while tt != 1
            tt = mod(tt^2, p)
            i += 1
            if i == m
                return nothing
            end
        end
        b = powermod(c, 1 << (m - i - 1), p)
        b2 = mod(b^2, p)
        r = mod(r * b, p)
        t = mod(t * b2, p)
        c = b2
        m = i
    end
    if mod(r^2, p) == n
        if r < p - r
            return r, p - r
        else
            return p - r, r
        end
    else
        return nothing
    end
end

function factor_multiplicity(n, k)
    r = 0
    nr = n
    while mod(nr, k) == 0
        r += 1
        nr = fld(nr, k)
    end
    return r
end

function t(n)
    return 2 * n^2 - 1
end

function main()
    n = 5 * 10^7

    data = [0 for k in 1:n]
    ub = isqrt(2 * n^2 - 1)
    slots = [true for k in 1:ub]
    slots[1] = false
    for k in 2:ub
        if slots[k]
            if k > 5
                c = powermod(2, k - 2, k)
                soln = tonelli_shanks(c, k)
                if soln !== nothing
                    (s1, s2) = soln
                    for r in s1:k:n
                        data[r] += factor_multiplicity(t(r), k)
                    end
                    for r in s2:k:n
                        data[r] += factor_multiplicity(t(r), k)
                    end
                end
            end
            for t in (2 * k):k:ub
                slots[t] = false
            end
        end
    end

    s = 0
    for (k, v) in enumerate(data)
        if k == 1
            continue
        end
        if t(k) <= ub && v == 1
            s += 1
        end
        if t(k) > ub && v == 0
            s += 1
        end
    end

    return s
end

start = time()

result = main()

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
