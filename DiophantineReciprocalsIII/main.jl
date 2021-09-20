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

function t(x)
    value = 0
    limit = isqrt(x)
    for y_prime in 2:limit
        max_x_prime = min(y_prime - 1, fld(limit, y_prime) - y_prime)
        for x_prime in 1:max_x_prime
            divisor = (x_prime + y_prime) * y_prime
            value += fld(x, divisor)
        end
        max_u = limit
        if max_u == fld(x, max_u)
            max_u -= 1
        end
        for u in 1:min(max_u, fld(x, y_prime^2))
            x_prime_inf = max(0, fld(x, (u + 1) * y_prime) - y_prime)
            x_prime_sup = min(y_prime - 1, fld(x, u * y_prime) - y_prime)
            if x_prime_inf >= x_prime_sup
                continue
            end
            value += u * (x_prime_sup - x_prime_inf)
        end
    end
    return value
end

@memoize function f(x)
    value = t(x)
    for k in 2:isqrt(x)
        value -= f(fld(x, k^2))
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^12

    # Algorithm parameters

    # Solution
    for k in isqrt(n):-1:2
        f(fld(n, k^2))
    end
    result = f(n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
