using Printf
using Memoize

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

@memoize function r(n)
    value = Int128(n)^3
    for k in Int128(2):isqrt(n)
        value -= r(fld(n, k))
    end
    max_u = isqrt(n)
    if max_u == fld(n, max_u)
        max_u -= 1
    end
    for u in Int128(1):max_u
        value -= r(u) * (fld(n, u) - fld(n, u + 1))
    end
    return value
end

@memoize function s(n)
    value = Int128(n)^2
    for k in Int128(2):isqrt(n)
        value -= s(fld(n, k))
    end
    max_u = isqrt(n)
    if max_u == fld(n, max_u)
        max_u -= 1
    end
    for u in Int128(1):max_u
        value -= s(u) * (fld(n, u) - fld(n, u + 1))
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^10

    # Algorithm parameters

    # Solution
    # Memoize required values of r and s
    for k in 1:isqrt(n)
        r(Int128(k))
        s(Int128(k))
    end

    for k in isqrt(n):-1:2
        r(Int128(fld(n, k)))
        s(Int128(fld(n, k)))
    end

    # Calculate result
    result_full = r(Int128(n)) + 3 * s(Int128(n)) + 3
    result_str = string(result_full)
    result = result_str[1:9] * result_str[(length(result_str)-8):length(result_str)]

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
