using Printf
using Memoize

function t1(n)
    r = fld(n + 1, 4)
    value = fld(r * (r + 1) * (2 * r + 4), 6)
    if fld(n + 1, 2) & 1 == 0
        value -= fld(r * (r + 1), 2)
    end
    return value
end

function p(m)
    r = fld(m, 2)
    value = -2 - 2 * r - 3 * r * (r + 1)
    if mod(m, 2) == 0
        value -= r - 2 * (m + 1)
    end
    return value
end

function q(m)
    r = fld(m, 2)
    value = 4 + 3 * r * (r + 1) * (2 * r + 1) + 6 * r * (r + 1) + 4 * r
    if mod(m, 2) == 0
        value -= (r - 2 * (m + 1))^2
    end
    return value
end

function t2(n)
    value = 0
    value += fld((n + 1) * (n + 2) * (fld(2 * n, 3) - fld(n + 1, 2)), 2)
    temp = (2 * n + 3) * (p(fld(2 * n, 3)) - p(fld(n + 1, 2))) + (q(fld(2 * n, 3)) - q(fld(n + 1, 2)))
    value += fld(temp, 2)
    return value
end

function t(n)
    return t1(n) + t2(n)
end

@memoize function s(n)
    value = t(n)
    
    for k in 2:isqrt(n)
        value -= s(fld(n, k))
    end

    max_u = isqrt(n)
    if max_u == fld(n, max_u)
        max_u -= 1
    end
    for u in 1:max_u
        value -= s(u) * (fld(n, u) - fld(n, u + 1))
    end

    return value
end

function t_naive(n)
    value = 0
    for a in 1:n
        for b in a:n
            if a + b >= n
                break
            end
            for c in b:min(a + b - 1, n - a - b)
                value += 1
            end
        end
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = Int128(10)^7

    # Algorithm parameters

    # Solution
    result = s(n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
