include("../includes.jl")

using Printf

using .PrimeSieve
using .FenwickTree

function main()
    result = 0

    # Problem parameters
    n = 11_111_111
    m = 10^9 + 993

    # Algorithm parameters

    # Solution
    sieve = PrimeSieve.Calculator(n)
    limit = length(sieve.primes)

    result += mod(n + 1, m)
    result = mod(result, m)

    term = mod(n - sieve.primes[limit] + 1, m)
    term *= powermod(2, n, m)
    result += mod(term, m)
    result = mod(result, m)

    index_table = PrimeSieve.get_index_table(sieve)
    coefficients = [get_coefficient(sieve.primes, m, i) for i in 1:(limit - 1)]
    tree = FenwickTree.SumProduct(coefficients, m)
    factorization = zeros(Int64, limit)
    for r in 0:fld(n, 2)
        term = FenwickTree.get(tree, limit - 1)
        if r == n - r
            result = mod(result + term, m)
        else
            result = mod(result + 2 * term, m)
        end
        if r < n
            nume_factors = factorize(sieve.primes, n - r)
            for (p, e) in nume_factors
                idx = index_table[p]
                if idx <= limit - 1
                    factorization[idx] += e
                    next_value = mod(powermod(p, factorization[idx], m) * coefficients[idx], m)
                    FenwickTree.set(tree, idx, next_value)
                end
            end
            deno_factors = factorize(sieve.primes, r + 1)
            for (p, e) in deno_factors
                idx = index_table[p]
                if idx <= limit - 1
                    factorization[idx] -= e
                    next_value = mod(powermod(p, factorization[idx], m) * coefficients[idx], m)
                    FenwickTree.set(tree, idx, next_value)
                end
            end
        end
    end

    # Show result
    return result
end

function get_coefficient(primes, m, i)
    p_prev = i == 1 ? 1 : primes[i - 1]
    p_curr = primes[i]
    p_next = primes[i + 1]
    return mod(
        mod(p_next - p_curr, m) * invmod(p_curr - p_prev, m),
        m
    )
end

function factorize(primes, n)
    factors = []
    v = n
    for p in primes
        if p^2 > v
            break
        end
        e = 0
        while mod(v, p) == 0
            e += 1
            v = fld(v, p)
        end
        if e > 0
            push!(factors, (p, e))
        end
    end
    if v > 1
        push!(factors, (v, 1))
    end
    return factors
end

@time println(main())
