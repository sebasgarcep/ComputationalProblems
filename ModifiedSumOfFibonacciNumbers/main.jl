include("../includes.jl")

using Memoize
using Printf

function w_pow(m, t)
    w = [
        1 1;
        1 0;
    ]
    if m == 0
        return w
    end
    r = w
    for _ in 1:m
        r = mod.(r * r, t)
    end
    r = mod.(r * w, t)
    return r
end

@memoize function x(n, t)
    if n == 0
        return [
            1;
            0;
        ]
    end
    if n == 1
        return [
            3;
            1;
        ]
    end
    m = 1
    while (1 << (m + 1)) <= n
        m += 1
    end
    k = n - (1 << m)
    ls = x((1 << m) - 1, t)
    rs = mod.(w_pow(m, t) * x(k, t), t)
    return mod.(ls + rs, t)
end

function main()
    # Problem parameters
    n = 10^18
    t = 10^9 + 7

    # Algorithm parameters

    # Solution

    result = x(n, t)[2]
    return result
end

@time println(main())
