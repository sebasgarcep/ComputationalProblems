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
    u = 2
    while u^2 + 1 <= n
        v_limit = min(u - 1, isqrt(n - u^2))
        value += v_limit
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

@memoize function t_1(n)
    value = 0
    u = 2
    while u^2 + 1 <= n
        v_limit = min(u - 1, isqrt(n - u^2))
        if mod(u, 2) == 1
            v_limit -= 1
            value += 1
        end
        value += fld(v_limit, 2)
        u += 1
    end
    return value
end

@memoize function s_1(n)
    value = t_1(n)
    k = 2
    while k^2 <= n
        if (k & 1) == 1
            value -= s_1(fld(n, k^2))
        else
            value -= s(fld(n, k^2))
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
    limit = 3141592653589793

    # Algorithm parameters

    # Solution
    result += s_2(limit)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
