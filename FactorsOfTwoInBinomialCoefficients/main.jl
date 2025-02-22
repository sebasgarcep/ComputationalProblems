include("../includes.jl")

using Printf
using Memoize

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^16

    # Algorithm parameters

    # Solution
    e = r(n)
    for k in 0:(e - 1)
        v = 1 << k
        result += k * v
        result += c(v)
    end
    v = 1 << e
    result += e * (n - v + 1)
    result += c(n - v + 1)
    result -= c(n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

function r(n)
    v = n
    e = 0
    while v > 0
        e += 1
        v = v >> 1
    end
    return e - 1
end

@memoize function c(n)
    if n <= 1
        return n
    end
    e = r(n)
    v = 1 << e
    return c(v - 1) + (n - v + 1) + c(n - v)
end

main()
