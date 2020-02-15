using Printf

function legendre(a, p)
    return powermod(a, (p - 1) >> 1, p)
end

function tonelli_shanks(n, p)
    if n < 0 || n >= p
        return tonelli_shanks(mod(n, p), p)
    end
    if legendre(n, p) != 1
        return nothing, nothing
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
                return nothing, nothing
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
        return nothing, nothing
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7
    m = 10^18

    # Algorithm parameters

    # Solution
    l = isqrt(1 + 4 * n^2)
    largest_factor = [1 for _ in 1:n]
    remainder = [1 + 4 * k^2 for k in 1:n]

    slots = [true for _ in 1:l]
    slots[1] = false
    if l >= 2
        slots[2] = false
        for p in (2 * l):2:l
            slots[p] = false
        end
    end
    for p in 3:2:l
        if slots[p]
            k1, k2 = tonelli_shanks(-invmod(4, p), p)
            if k1 !== nothing
                for k in k1:p:n
                    largest_factor[k] = p
                    while remainder[k] % p == 0
                        remainder[k] = fld(remainder[k], p)
                    end
                end
            end
            if k2 !== nothing
                for k in k2:p:n
                    largest_factor[k] = p
                    while remainder[k] % p == 0
                        remainder[k] = fld(remainder[k], p)
                    end
                end
            end
            for t in p^2:p:l
                slots[t] = false
            end
        end
    end

    for k in 1:n
        if largest_factor[k] > 1
            if remainder[k] > 1
                largest_factor[k] = remainder[k]
                result = mod(result + largest_factor[k], m)
            else
                result = mod(result + largest_factor[k], m)
            end
        else
            largest_factor[k] = 1 + 4 * k^2
            result = mod(result + 1 + 4 * k^2, m)
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
