#=
Approach:

If p = 2, then R(p) = 0. Thus, let p > 2. Notice that:

n^2 - 3 * n - 1 = 0 (mod p^2)
n^2 - (p^2 + 3) * n = 1 (mod p^2)
n^2 - 2 * (p^2 + 3) / 2 * n = 1 (mod p^2)
n^2 - 2 * (p^2 + 3) / 2 * n + (p^2 + 3)^2 / 4 = 1 + (p^2 + 3)^2 / 4 (mod p^2)
(n - (p^2 + 3) / 2)^2 = 1 + (p^2 + 3)^2 / 4 (mod p^2)

Let u = n - (p^2 + 3) / 2. Then we need to find a solution to:

u^2 = 1 + (p^2 + 3)^2 / 4 (mod p^2)

A solution to u^2 = 1 + (p^2 + 3)^2 / 4 (mod p) can be found using the Tonelli-Shank
algorithm. Then using Hansel's lemma we can lift this solution, as any root to the
previous polynomial must be simple (2 * u = 0 (mod p) implies u = 0 (mod p), which
is not a solution to the previous polynomial).

Lemma 1:
--------

For a given polynomial f(x) = an * x^n + an-1 * x^(n-1) + ... + a1 * x + a0,
with coefficients in the integers and n >= 0, let p be a prime and m > 0. Then
for any integer t, we have:

f(x + t * p^m) = f(x) + t * p^m * f'(x) (mod p^(m + 1))

Proof:
------

Notice that, for i >= 2:

(x + t * p^m)^i = x^i + i * x^(i - 1) * t * p^m + i * (i - 1) / 2 * x^(i - 1) * t^2 * p^(2 * m) + ...

Notice that clearly i * m >= m + 1, therefore mod p^(m + 1) these terms cancel out.
Thus, under the modulus:

(x + t * p^m)^i = x^i + i * x^(i - 1) * t * p^m

Clearly, d/dx[ x^i ] = i * x^(i - 1). Therefore the equation is satisfied for a
single term. Applying the same logic for each term we get the desired result for i > 2.

For i = 0, 1 the result is trivial.

Hensel's Lemma:
---------------

Let p be an odd prime, f in Z[x], and m, r in Z such that m > 0 and f(r) = 0 (mod p^m). Then:

1. If f'(r) != 0 (mod p) and f(r) != 0 (mod p^(m + 1)), then there is a unique integer t such that
1 <= t <= p - 1 and f(r + t * p^m) = 0 (mod p^(m + 1)). Specifically, t is determined by the equation
t * f'(r) = -f(r) / p^m (mod p).

2. If f'(r) = 0 (mod p) and f(r) = 0 (mod p^(m + 1)), then for any t such that 1 <= t <= p - 1,
f(r + t * p^m) = 0 (mod p^(m + 1)).

3. If f'(r) = 0 (mod p) and f(r) != 0 (mod p^(m + 1)) then there is no integer 1 <= t <= p - 1 such
that f(r + t * p^m) = 0 (mod p^(m + 1)).

Proof:
------

1. Clearly p^m | f(r), and also f(r) / p^m != 0 (mod p), otherwise f(r) = 0 (mod p^(m + 1)).
Also, because f'(r) != 0, it has a multiplicative inverse r, such that r * f'(t) = 1 (mod p).
Then -f(r) / p^m * r * f'(r) = -f(r) / p^m (mod p). Let t = -f(r) / p^m * r. Therefore:

t * f'(r) = -f(r) / p^m (mod p)

Then:

f(r + t * p^m) = f(r) + t * p^m * f'(r) = f(r) - p^m * f(r) / p^m = f(r) - f(r) = 0 (mod p^(m + 1))

2. f(r + t * p^m) = f(r) + t * p^m * f'(r) = 0 (mod p^(m + 1))

3. f(r + t * p^m) = f(r) + t * p^m * f'(r) = f(r) != 0 (mod p^(m + 1))

(http://math453spring2009.wikidot.com/hensel-s-lemma)
(https://en.wikipedia.org/wiki/Hensel%27s_lemma)

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

function hensel_lifting(f, f_prime, p, m, r)
    t = mod(-fld(f(r), p) * invmod(f_prime(r), p), p)
    s = mod(r + t * p^m, p^(m + 1))
    return s
end

function main()
    start = time()
    result = 0

    n = 10000000
    slots = [true for k in 1:n]
    slots[1] = false
    for k in 2:n
        if slots[k]
            if k > 2
                b = Int128((k^2 + 3) >> 1)
                c = Int128(1 + b^2)
                soln = tonelli_shanks(c, k)
                if soln !== nothing
                    (u1, u2) = soln
                    pp = u -> u^2 - c
                    pd = u -> 2 * u
                    l1 = hensel_lifting(pp, pd, k, 1, u1)
                    l2 = hensel_lifting(pp, pd, k, 1, u2)
                    r1 = mod(l1 + b, k^2)
                    r2 = mod(l2 + b, k^2)
                    result += min(r1, r2)
                end
            end
            for t in (2 * k):k:n
                slots[t] = false
            end
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
