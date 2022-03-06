using Printf
using Memoize

@memoize function f(n)
    if n == 0
        return 1
    end
    if n & 1 == 0
        return f(n >> 1) + f((n - 2) >> 1)
    else
        return f((n - 1) >> 1)
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = Int128(10)^25

    # Algorithm parameters

    # Solution
    result = f(n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
