# FIXME: not finished yet.

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

function cubic_residue(a, p)
    return powermod(a, fld(p - 1, 3), p) == 1
end

function tonelli_shanks_cubic(a, p)
    # Clean input variables
    if a < 0 || a >= p
        return tonelli_shanks(mod(a, p), p)
    end
    # Assert whether p = 1 (mod 3)
    if mod(p, 3) != 1
        return nothing
    end
    # Assert whether a is a cubic residue
    if !cubic_residue(a, p)
        return nothing
    end
    # Find the non-residue z
    z = 2
    while cubic_residue(z, p)
        z += 1
    end
    # Factor p - 1
    s = 0
    q = p - 1
    while mod(q, 3) == 0
        q = fld(q, 3)
        s += 1
    end
    # Initialize variables
    m = s
    c = powermod(z, q, p)
    w = powermod(c, 3^(s - 1), p)
    t = powermod(a, q, p)
    r = powermod(a, fld(q + 1, 3), p)
    # Loop
    while t != 1
        t_prev, t_curr = 1, t
        i = 0
        while t_curr != 1
            t_prev, t_curr = t_curr, mod(t_curr^3, p)
            i += 1
        end
        if t_prev == w
            b = powermod(c, 2 * 3^(m - i - 1), p)
        else
            b = powermod(c, 3^(m - i - 1), p)
        end
        b3 = powermod(b, 3, p)
        t = mod(t * b3, p)
        r = mod(r * b, p)
        c = b3
        m = i
    end
    return r
end

function quadratic_mod(a, b, p)
    d = invmod(2, p) * a
    d = mod(d, p)
    n = powermod(d, 2, p) - b
    n = mod(n, p)
    y1, y2 = tonelli_shanks(n, p)
    x1, x2 = nothing, nothing
    if y1 !== nothing
        x1 = mod(y1 - d, p)
    end
    if y2 !== nothing
        x2 = mod(y2 - d, p)
    end
    return x1, x2
end

function special_quintic(p)
    y, _ = tonelli_shanks(5, p)
    a = invmod(2, p) * (y - 1)
    a = mod(a, p)
    c = mod(-1 - a, p)
    x1 = p - 1
    x2, x3 = quadratic_mod(a, 1, p)
    x4, x5 = quadratic_mod(c, 1, p)
    return x1, x2, x3, x4, x5
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    println(tonelli_shanks_cubic(7, 19))

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
