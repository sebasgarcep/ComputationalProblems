include("../includes.jl")

using Printf
using Primes

using .PrimeSieve
using .QuadraticResidue: tonelli_shanks

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7
    m = 10^9 + 7

    # Algorithm parameters
    sieve = PrimeSieve.Calculator(n + 1)

    factors = [[] for _ in 1:(n + 1)]

    for p in sieve.primes
        if p == 2
            for x in 1:2:(n + 1)
                push!(factors[x], (p, 0))
            end
            continue
        end
        if mod(p, 4) != 1
            continue
        end
        a, b = tonelli_shanks(p - 1, p)
        for x in a:p:(n + 1)
            push!(factors[x], (p, 0))
        end
        for x in b:p:(n + 1)
            push!(factors[x], (p, 0))
        end
    end

    for x in 1:(n + 1)
        v = x^2 + 1
        num_found_factors = length(factors[x])
        for i in 1:num_found_factors
            p, e = factors[x][i]
            while mod(v, p) == 0
                e += 1
                v = fld(v, p)
            end
            factors[x][i] = (p, e)
        end
        if v > 1
            push!(factors[x], (v, 1))
        end
    end

    result = 1 # R(1^4 + 4) = R(5) = 1
    for k in 2:n
        # Calculate Q(k^4 + 4)
        left_factors = factors[k - 1]
        right_factors = factors[k + 1]
        q = 1
        for (p_l, e_l) in left_factors
            found = false
            for (p_r, e_r) in right_factors
                if p_l == p_r
                    found = true
                    q *= 1 + powermod(p_l, e_l + e_r, m)
                    q = mod(q, m)
                    break
                end
            end
            if !found
                q *= 1 + powermod(p_l, e_l, m)
                q = mod(q, m)
            end
        end
    
        for (p_l, e_l) in right_factors
            found = false
            for (p_r, _) in left_factors
                if p_l == p_r
                    found = true
                    break
                end
            end
            if !found
                q *= 1 + powermod(p_l, e_l, m)
                q = mod(q, m)
            end
        end

        result += q
        result = mod(result, m)

        # Subtract k^4 + 4
        result -= powermod(k, 4, m) + 4
        result = mod(result, m)
    end

    # Solution

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

function factorize(n)
    if n == 1
        return 1
    end
    for x in 2:2
        y = x
        d = 1
        while d == 1
            x = pollard_rho_g(x, n)
            y = pollard_rho_g(pollard_rho_g(y, n), n)
            d = gcd(abs(x - y), n)
        end

        if d != n
            return d
        end
    end
    return nothing
end

function pollard_rho_g(x, n)
    return mod(x^2 - 1, n)
end

main()
