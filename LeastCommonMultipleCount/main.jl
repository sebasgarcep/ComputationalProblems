using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    test_value = Int64(floor(Float64(a)^(1.0 / b)))
    if (test_value + 1)^b <= a
        return test_value + 1
    end
    
    return test_value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^12

    # Algorithm parameters

    # Solution
    function triangular(x)
        a = (x & 1 == 0) ? (x >> 1) : x
        b = ((x + 1) & 1 == 0) ? ((x + 1) >> 1) : (x + 1)
        return a * b
    end

    function t(x)
        value = triangular(isqrt(x))
        max_u = isqrt(x)
        if max_u == fld(x, max_u)
            max_u -= 1
        end
        for u in 1:max_u
            value += u * (fld(x, u) - fld(x, u + 1))
        end
        return value
    end

    cache_size = isqrt(n)
    s_lo_cache = [-1 for _ in 1:cache_size]
    s_hi_cache = [-1 for _ in 1:cache_size]

    function s(x)
        if x <= 0
            return 0
        end
        if x <= cache_size
            if s_lo_cache[x] >= 0
                return s_lo_cache[x]
            end
        else
            if s_hi_cache[fld(n, x)] >= 0
                return s_hi_cache[fld(n, x)]
            end
        end
        value = t(x)
        for k in 2:isqrt(x)
            value -= s(fld(x, k^2))
        end
        if x <= cache_size
            s_lo_cache[x] = value
        else
            s_hi_cache[fld(n, x)] = value
        end
        return value
    end

    # Calculate g(N)
    max_u = isqrt(n)
    if max_u == fld(n, max_u)
        max_u -= 1
    end
    for u in 1:max_u
        result += s(u) * (fld(n, u) - fld(n, u + 1))
    end

    for k in isqrt(n):-1:1
        result += s(fld(n, k))
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
