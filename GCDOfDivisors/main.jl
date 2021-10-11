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
    n_max = 10^15

    # Algorithm parameters
    cache_size = isqrt(n_max)

    # Static variables
    s_cache = [-1 for k in 1:cache_size]

    # Solution
    function t(n)
        value = 0
        for k in 1:isqrt(n)
            value += fld(n, k)
        end
        max_u = isqrt(n)
        if max_u == fld(n, max_u)
            max_u -= 1
        end
        for u in 1:max_u
            value += u * (fld(n, u) - fld(n, u + 1))
        end
        return value
    end

    function s(k)
        if s_cache[k] >= 0
            return s_cache[k]
        end
        limit = fld(n_max, k^2)
        value = t(limit)
        for u in 2:isqrt(limit)
            value -= s(k * u)
        end
        s_cache[k] = value
        return value
    end

    # Calculate F(N)
    for k in isqrt(n_max):-1:1
        result += k * s(k)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
