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

Tonelli-Shanks Algorithm
------------------------

Let p > 2 be a prime number and n be the number of which we want to calculate its square root.
First let's test whether a given number is a quadratic residue using Euler's criterion.
Then let's find values for Q and S such that p - 1 = Q * 2^S and Q is odd. If S = 1, then
p - 1 = 2 * Q. Thus p - 1 = 2 (mod 4) <=> p + 1 = 0 (mod 4). Now, notice that:

(n^((p + 1) / 4))^2 = n^((p + 1) / 2) = n * n^((p - 1) / 2) = n * 1 = n

where the last substitution comes from Euler's criterion. Therefore assume S > 1. Let's
find a value of z that doesn't satisfy Euler's criterion. Because half of the values will
not satisfy it, then we can easily find it by testing consecutive values for z until we
find one that doesn't.

Now let R = n^((Q + 1) / 2). If t = n^Q = 1 (mod p), then R is a square root of n as
R^2 = n^(Q + 1) = n * n^Q = n. Therefore assume it is not. Let M = S. Then R^2 = n * t (mod p)
and t is a 2^(M - 1)-th root of 1, because:

t^(2^(M - 1)) = t^(2^(S - 1)) = n^(Q * 2^(S - 1)) = n^((p - 1) / 2) = 1

by Euler's criterion. Therefore the idea is to use the values of R and t for M to find values
of R and t for M - 1. That way, when M = 1, t is a 2^0-th root of 1, i.e. t = 1 and we are done.

Now, let's find the least i, with 0 < i < M, such that t^(2^i) = 1. There must be at least one
as t^(2^(M - 1)) = 1. This can be found by repeatedly squaring t. The next value of R can be
found by multiplying it times a factor b. Therefore to mantain the invariant we need to multiply
t times b^2. So we must find a factor b such that t * b^2 is a 2^(M - 2)-th root of 1. That is:

(t * b^2)^(2^(M - 2)) = 1 (mod p)
t^(2^(M - 2)) * b^(2^(M - 1)) = 1 (mod p)

If t^(2^(M - 2)) = 1, then b = 1 and we are done. Otherwise:

b^(2^(M - 1)) = -1 (mod p)

Because we know that z^Q is a 2^(S - 1)-th root of -1, therefore, (z^Q)^2 is a 2^(S - 2)-th root
of -1, (z^Q)^4 is a 2^(S - 3)-th root of -1, (z^Q)^8 is a 2^(S - 4)-th root of -1, and so on.
Therefore we can find 2^i-th roots of -1 by repeatedly squaring z^Q.

In general, if for some iteration we have a value c such that it is a 2^(M - 1)-th root of -1,
we can use that c to find the 2^i-th root of -1 by repeatedly squaring it. This allows us to
find the next value of b, by setting b = c^(2^(M - i - 1)).

Finally, for the next iteration we must have that:

M <- i
t <- t * b^2
R <- R * b
c <- b^2

Because i < M, after a finite number of iterations the algorithm must halt. Also clearly,
setting c to b^2 preserved the fact that c must be a 2^(M - 1)-th root of -1.

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
