include("../includes.jl")

using Printf

using .PrimeSieve

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^8
    min_q = 2
    max_q = 3
    m = 10^9 + 9

    # Algorithm parameters

    # Solution
    sieve = PrimeSieve.Calculator(n)

    factorial_memo = [1 for _ in 1:(max_q * n)]
    for k in 2:(max_q * n)
        factorial_memo[k] = mod(factorial_memo[k - 1] * k, m)
    end

    for q in min_q:max_q
        for p in sieve.primes
            result += a(factorial_memo, q, p, m)
            result = mod(result, m)
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

function a(factorial_memo, q, p, m)
    if p == 2
        return mod(q * (q - 1), m)
    end
    term = mod((p - 1) * q, m)
    term = mod(term + binomial_mod(factorial_memo, q * p, p, m), m)
    return mod(term * invmod(p, m), m)
end

function binomial_mod(factorial_memo, n, k, m)
    return mod(
        factorial_memo[n] * invmod(factorial_memo[k] * factorial_memo[n - k], m),
        m
    )
end

main()
