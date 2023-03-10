using Printf
using Memoize

function ilog4(m)
    res = 0
    while m > 0
        m = m >> 2
        res += 1
    end
    return res - 1
end

@memoize function s(m, p)
    if m <= 3
        res = mod(6 * m, p)
        return res
    end

    res = 0

    r = ilog4(m)
    t = m
    i = 0

    while t >= 0
        res += s(min(4^r - 1, t), p)
        res = mod(res, p)
        if i > 0
            term = 6
            term *= mod(4^r, p)
            term = mod(term, p)
            term *= mod(min(4^r - 1, t) + 1, p)
            term = mod(term, p)
            res += term
        end
        t -= 4^r
        i += 1
    end

    return res
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^18
    p = 10^9 + 7

    # Algorithm parameters
    memo_size = 10^7

    # Solution
    k = ilog4(3 * n + 1)
    m = n - fld(4^k - 1, 3) - 1
    
    result = mod(mod(4^k - 1, p) * mod(2^(2 * k - 1), p), p)
    result += mod(6 * mod(mod(4^k, p) * mod(m + 1, p), p), p)
    result = mod(result, p)
    result += s(m, p)
    result = mod(result, p)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
