include("../includes.jl")

using Printf
using Polynomials

using .PrimeSieve

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    k = 7

    # Algorithm parameters
    limit = 10^6

    # Solution
    sieve = PrimeSieve.Calculator(limit)

    base_polynomial = Polynomial([1.0])
    for p in sieve.primes
        term_polynomial = Polynomial([1.0 - 1.0 / p^2, 1.0 / p^2])
        base_polynomial *= term_polynomial
        base_polynomial = Polynomial(coeffs(base_polynomial)[1:min(length(base_polynomial), k + 1)])
    end

    result = coeffs(base_polynomial)[k + 1]

    formatted = @sprintf("%.4e", result)
    result = replace(formatted, r"e([-+])0+" => s"e\1")

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
