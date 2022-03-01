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

@memoize function f(p, k, d0, d1, d2, d3, d4, d5, d6, d7, d8, d9)
    total = d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8 + d9
    if total == 0
        return 0
    end
    if total == 1
        if d0 == 1
            return 0
        elseif d1 == 1
            return mod(k - 1, p) == 0 ? 1 : 0
        elseif d2 == 1
            return mod(k - 2, p) == 0 ? 1 : 0
        elseif d3 == 1
            return mod(k - 3, p) == 0 ? 1 : 0
        elseif d4 == 1
            return mod(k - 4, p) == 0 ? 1 : 0
        elseif d5 == 1
            return mod(k - 5, p) == 0 ? 1 : 0
        elseif d6 == 1
            return mod(k - 6, p) == 0 ? 1 : 0
        elseif d7 == 1
            return mod(k - 7, p) == 0 ? 1 : 0
        elseif d8 == 1
            return mod(k - 8, p) == 0 ? 1 : 0
        else
            return mod(k - 9, p) == 0 ? 1 : 0
        end
    end
    value = 0
    for r in 0:9
        k_prime = mod((k - r) * invmod(10, p), p)
        d0_prime = d0 - (r == 0 ? 1 : 0)
        d1_prime = d1 - (r == 1 ? 1 : 0)
        d2_prime = d2 - (r == 2 ? 1 : 0)
        d3_prime = d3 - (r == 3 ? 1 : 0)
        d4_prime = d4 - (r == 4 ? 1 : 0)
        d5_prime = d5 - (r == 5 ? 1 : 0)
        d6_prime = d6 - (r == 6 ? 1 : 0)
        d7_prime = d7 - (r == 7 ? 1 : 0)
        d8_prime = d8 - (r == 8 ? 1 : 0)
        d9_prime = d9 - (r == 9 ? 1 : 0)
        if d0_prime >= 0 &&
            d1_prime >= 0 &&
            d2_prime >= 0 &&
            d3_prime >= 0 &&
            d4_prime >= 0 &&
            d5_prime >= 0 &&
            d6_prime >= 0 &&
            d7_prime >= 0 &&
            d8_prime >= 0 &&
            d9_prime >= 0
            value += f(
                p,
                k_prime,
                d0_prime,
                d1_prime,
                d2_prime,
                d3_prime,
                d4_prime,
                d5_prime,
                d6_prime,
                d7_prime,
                d8_prime,
                d9_prime,
            )
        end
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    result = f(11, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
