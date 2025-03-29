include("../includes.jl")

using Printf

using .Common: iroot
using .PrimeSieve

function main()
    # Problem parameters
    n = 10^18

    # Algorithm parameters
    data_size = 10^8
    factor_size = 10

    # Solution
    limit = iroot(n, 3)
    sieve = PrimeSieve.Calculator(limit)

    factorization = [[] for _ in 1:limit]
    for p in sieve.primes
        for t in p:p:limit
            push!(factorization[t], [p, 1])
        end

        k = 2
        while p^k <= limit
            for t in p^k:p^k:limit
                l = length(factorization[t])
                factorization[t][l][2] += 1
            end
            k += 1
        end
    end

    initial_k = 1
    initial_i = length(sieve.primes)
    initial_g = 0
    initial_m = Int128(1)
    num_factors = [[0, 0] for _ in 1:factor_size]
    tot_factors = Dict()
    result = generate(
        factorization,
        sieve.primes,
        n,
        num_factors,
        tot_factors,
        initial_k,
        initial_i,
        initial_g,
        initial_m,
    )

    return result
end

function generate(factorization, primes, n, num_factors, tot_factors, k, i, g, m)
    result = 0
    next_k = k + 1
    for a in i:-1:1
        p = primes[a]
        num_factors[k][1] = p
        next_i = a - 1
        if k == 1
            r = 3
        else
            r = 2
        end
        next_m = m * Int128(p)^r
        if next_m > n
            continue
        end

        for (q, e) in factorization[p - 1]
            tot_factors[q] = get(tot_factors, q, 0) + e
        end

        while next_m <= n
            num_factors[k][2] = r
            next_g = gcd(g, r)
            if next_g == 1 && is_totient_achilles(num_factors, k, tot_factors)
                result += 1
            end
            result += generate(
                factorization,
                primes,
                n,
                num_factors,
                tot_factors,
                next_k,
                next_i,
                next_g,
                next_m,
            )
            r += 1
            next_m *= p
        end

        for (q, e) in factorization[p - 1]
            tot_factors[q] -= e
            if tot_factors[q] == 0
                delete!(tot_factors, q)
            end
        end
    end
    return result
end

function is_totient_achilles(num_factors, k, tot_factors)
    tot_factors = copy(tot_factors)

    g = 0
    for i in 1:k
        p = num_factors[i][1]
        e = num_factors[i][2]
        f = get(tot_factors, p, 0)
        l = e - 1 + f
        if l < 2
            return false
        end
        g = gcd(g, e - 1 + f)
        delete!(tot_factors, p)
    end

    for (p, f) in tot_factors
        if f < 2
            return false
        end
        g = gcd(g, f)
    end

    return g == 1
end

@time println(main())
