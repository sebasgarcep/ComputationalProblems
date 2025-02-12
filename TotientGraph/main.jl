include("../includes.jl")

using Printf

using .Common: summation_formula
using .PrimeSieve
using .PrimeCount
using .PrimeSum

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    bound = 10^12
    modulo = 715827883

    # Algorithm parameters
    limit = 10^8

    # Solution
    sieve = PrimeSieve.Calculator(limit)
    prime_counter = PrimeCount.Calculator(bound, sieve)
    prime_adder = PrimeSum.Calculator(modulo, bound, sieve, prime_counter)

    for x in limit:-1:1
        _ = PrimeCount.get(prime_counter, fld(bound, x))
        _ = PrimeSum.get(prime_adder, fld(bound, x))
    end

    elapsed = time() - start
    @printf("Took: %.4f secs calculating pi/sigma\n", elapsed)
    start = time()

    for p in sieve.primes
        if p > isqrt(bound)
            break
        end

        # First sum
        result += mod(
            mod(p, modulo) * summation_formula(modulo, fld(bound, p)),
            modulo
        )
        result = mod(result, modulo)

        # Second sum
        result -= summation_formula(modulo, fld(bound, p))
        result = mod(result, modulo)

        k = 1
        while p^k <= bound
            # Third sum
            result -= summation_formula(modulo, fld(bound, p^k))
            result = mod(result, modulo)

            # Fourth sum
            result += mod(
                mod(p, modulo) * summation_formula(modulo, fld(bound, p^(k + 1))),
                modulo
            )
            result = mod(result, modulo)
            k += 1
        end
    end

    max_u = isqrt(bound)
    if max_u == fld(bound, max_u)
        max_u -= 1
    end

    for u in 1:max_u
        # Finish the first sum
        result += mod(
            mod(
                PrimeSum.get(prime_adder, fld(bound, u)) - PrimeSum.get(prime_adder, fld(bound, u + 1)),
                modulo
            ) * summation_formula(modulo, u),
            modulo
        )
        result = mod(result, modulo)

        # Finish the second sum
        # Finish the third sum
        result -= 2 * mod(
            mod(
                PrimeCount.get(prime_counter, fld(bound, u)) - PrimeCount.get(prime_counter, fld(bound, u + 1)),
                modulo
            ) * summation_formula(modulo, u),
            modulo
        )
        result = mod(result, modulo)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
