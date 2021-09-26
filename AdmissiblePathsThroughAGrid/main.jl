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

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7
    mod_size = 10^9 + 7

    # Algorithm parameters

    # Solution
    fact_memo = [1 for _ in 0:(2 * n)]
    for k in 1:(2 * n)
        fact_memo[k + 1] = mod(fact_memo[k - 1 + 1] * mod(k, mod_size), mod_size)
    end

    function binomial_local(u, v)
        value = fact_memo[u + 1]
        value = mod(value * invmod(fact_memo[v + 1], mod_size), mod_size)
        value = mod(value * invmod(fact_memo[u - v + 1], mod_size), mod_size)
        return value
    end

    inadmissible = []
    for u in 2:iroot(2 * n, 4)
        for v in 1:(u - 1)
            if gcd(u, v) != 1 || ((u & 1) == 1 && (v & 1) == 1)
                continue
            end
            a = u^2 - v^2
            b = 2 * u * v
            c = u^2 + v^2
            x = a^2
            y = b^2
            z = c^2
            if x > n || y > n
                continue
            end
            k = 1
            while k^2 * x <= n && k^2 * y <= n
                push!(inadmissible, (k^2 * x, k^2 * y))
                push!(inadmissible, (k^2 * y, k^2 * x))
                k += 1
            end
        end
    end

    @memoize function explore(x, y)
        value = binomial_local(2 * n - x - y, n - x)
        for t in inadmissible
            (u, v) = t
            if u < x || v < y || (u == x && v == y)
                continue
            end
            value -= mod(binomial_local(u + v - x - y, u - x) * explore(u, v), mod_size)
            value = mod(value, mod_size)
        end
        return value
    end

    result = explore(0, 0)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
