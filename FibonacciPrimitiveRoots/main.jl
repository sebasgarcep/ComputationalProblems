#=
Approach:

Notice that:

x^(n + 2) = x^(n + 1) + x^n (mod p)
x^(n + 2) - x^(n + 1) - x^n = 0 (mod p)
x^n * (x^2 - x - 1) = 0 (mod p)

Becuase Zp is an integral domain, either x = 0 or x^2 - x - 1 = 0. The quadratic has at most
2 solutions which can be found by completing squares and then applying the Tonelli-Shanks algorithm
we can find a solution (p > 2):

x^2 - x - 1 = 0 (mod p)
x^2 - (p + 1) * x - 1 = 0 (mod p)
x^2 - (p + 1) * x = 1 (mod p)
x^2 - (p + 1) * x + (p + 1)^2 / 4 = 1 + (p + 1)^2 / 4 (mod p)
y^2 := (x - (p + 1) / 2)^2 = 1 + (p + 1)^2 / 4 (mod p)

Finally we need x^n = 1 (mod p), where n = p - 1. The order of x can be found by trying all
divisors of p - 1 (the order of the multiplicative group of Zp). If no proper divisor of p - 1
results in x^n = 1 (mod p), then the order of x must be p - 1 and it is a generator of the
multiplicative group of Zp.

=#

using Printf

function is_generator(n, p)
    for k in 2:isqrt(p - 1)
        if (p - 1) % k == 0
            if powermod(n, k, p) == 1
                return false
            end
            if powermod(n, fld(p - 1, k), p) == 1
                return false
            end
        end
    end
    return true
end

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

function main()
    start = time()
    result = 0

    n = 10^8

    # Primes 2 and 3 are included for some reason
    # So exclude them from the search
    result += 2 + 3

    slots = [i % 2 == 1 for i in 1:n]
    slots[1] = false
    slots[2] = true
    for p in 3:2:n
        if slots[p]
            # Evaluate prime
            if p > 3
                r = mod(1 + powermod(fld(p + 1, 2), 2, p), p)
                t = tonelli_shanks(r, p)
                if t !== nothing
                    y1, y2 = t
                    x1, x2 = y1 + fld(p + 1, 2), y2 + fld(p + 1, 2)
                    if is_generator(x1, p) || is_generator(x2, p)
                        result += p
                    end
                end
            end
            for t in (2 * p):p:n
                slots[t] = false
            end
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
