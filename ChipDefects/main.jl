using Printf
using Polynomials
using SparseArrays

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 1000000
    k = 20000

    # Algorithm parameters

    # Solution
    term = 1.0
    for i = (n - k + 1):n
        term *= i / n
    end

    for x_two in 0:fld(k, 2)
        x_one = k - 2 * x_two
        result += term
        term *= (x_one - 1) * x_one / (2.0 * (x_two + 1) * (n - x_one - x_two + 1))
    end

    result = 1.0 - result

    # Show result
    println(@sprintf("%.10f", result))

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
