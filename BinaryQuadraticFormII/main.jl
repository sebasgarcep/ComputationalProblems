using Printf
using Memoize

function s_2(n)
    return s(n) - s_1(n)
end

function t_2(n)
    return t(n) - t_1(n)
end

@memoize function t(n)
    value = 0
    m = Int64(floor(sqrt(Float64(n) / (2.0 + 5.0 / sqrt(3.0)))))
    u = 1
    while u^2 + 5 * u + 3 <= n
        v_limit = min(
            Int64(floor(Float64(u) / sqrt(3.0))),
            Int64(floor((-5.0 * Float64(u) + sqrt(13.0 * Float64(u)^2 + 12.0 * Float64(n))) / 6.0)),
        )
        value += v_limit

        u += 1
    end
    return value
end

@memoize function t_1(n)
    value = 0
    m = Int64(floor(sqrt(Float64(n) / (2.0 + 5.0 / sqrt(3.0)))))
    u = 1
    while u^2 + 5 * u + 3 <= n
        v_limit = min(
            Int64(floor(Float64(u) / sqrt(3.0))),
            Int64(floor((-5.0 * Float64(u) + sqrt(13.0 * Float64(u)^2 + 12.0 * Float64(n))) / 6.0)),
        )
        if mod(10 * u, 13) != 0 && v_limit >= mod(10 * u, 13)
            v_limit -= mod(10 * u, 13)
            value += 1
        end
        value += fld(v_limit, 13)

        u += 1
    end
    return value
end

@memoize function s(n)
    value = t(n)
    k = 2
    while k^2 <= n
        value -= s(fld(n, k^2))
        k += 1
    end
    return value
end

@memoize function s_1(n)
    value = t_1(n)
    k = 2
    while k^2 <= n
        if mod(k, 13) == 0
            value -= s(fld(n, k^2))
        else
            value -= s_1(fld(n, k^2))
        end
        k += 1
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 10^14

    # Algorithm parameters

    # Solution
    result += s_2(limit) + s_1(13 * limit)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
