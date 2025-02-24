include("../includes.jl")

using Printf

using .Common: summation_formula
using .PrimeSieve

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^14
    m = 10^9 + 7

    # Algorithm parameters

    # Solution
    limit = isqrt(n)
    sieve = PrimeSieve.Calculator(limit)

    start = time()

    mu_memo = [1 for _ in 1:limit]
    for p in sieve.primes
        for k in p:p:limit
            mu_memo[k] *= -1
        end
        for k in (p^2):(p^2):limit
            mu_memo[k] = 0
        end
    end

    w = 0
    for q in 1:limit
        if mu_memo[q] == 0
            continue
        end
        g = 0
        x = fld(n, q^2)
        for k in 1:isqrt(x)
            g += mod(mod(k, m) * mod(fld(x, k), m), m)
            g = mod(g, m)
        end

        u_limit = isqrt(x)
        if u_limit == fld(x, u_limit)
            u_limit -= 1
        end
        for u in 1:u_limit
            g += mod(
                mod(u, m) *
                mod(summation_formula(m, fld(x, u)) - summation_formula(m, fld(x, u + 1)), m),
                m
            )
            g = mod(g, m)
        end
        w += mod(mod(q, m) * mu_memo[q] * g, m)
        w = mod(w, m)
    end

    result = mod(w - summation_formula(m, n), m)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
