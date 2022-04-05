using Printf
using Primes

function triangular(k)
    return (k * (k + 1)) >> 1
end

function f2(n)
    factorization = factor(4 * n + 1)
    value = 1
    for (p, c) in factorization
        if p & 3 == 3 && c & 1 == 1
            return 0
        elseif p & 3 == 1
            value *= (c + 1)
        end
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 17526 * 10^9

    # Algorithm parameters

    # Solution
    k = 0
    while triangular(k) <= n
        result += f2(n - triangular(k))
        k += 1
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
