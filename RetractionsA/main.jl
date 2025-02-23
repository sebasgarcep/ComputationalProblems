include("../includes.jl")

using Printf
using Memoize

using .PrimeSieve

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7
    m = 10^9 + 7

    # Algorithm parameters

    # Solution
    sieve = PrimeSieve.Calculator(n)
    
    factors = [[] for _ in 1:n]
    for p in sieve.primes
        for k in p:p:n
            push!(factors[k], (p, 1))
        end
        f = p^2
        while f <= n
            for k in f:f:n
                _, e = factors[k][length(factors[k])]
                factors[k][length(factors[k])] = (p, e + 1)
            end
            f *= p
        end
    end

    q_factors = Dict()
    q = 1

    for k in 1:(n - 1)
        num_factors = factors[n - k + 1]
        for (p, e) in num_factors
            curr_e = get(q_factors, p, 0)
            if curr_e != 0
                q *= invmod(1 + powermod(p, curr_e, m), m)
                q = mod(q, m)
            end
            q_factors[p] = curr_e + e
            q *= 1 + powermod(p, curr_e + e, m)
            q = mod(q, m)
        end

        den_factors = factors[k]
        for (p, e) in den_factors
            curr_e = get(q_factors, p, 0)
            if curr_e != 0
                q *= invmod(1 + powermod(p, curr_e, m), m)
                q = mod(q, m)
            end
            q_factors[p] = curr_e - e
            if curr_e - e != 0
                q *= 1 + powermod(p, curr_e - e, m)
            end
            q = mod(q, m)
        end

        result += q
        result = mod(result, m)
    end

    result -= powermod(2, n, m) - 2
    result = mod(result, m)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
