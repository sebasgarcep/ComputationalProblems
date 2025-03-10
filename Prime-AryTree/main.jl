include("../includes.jl")

using Printf

using .PrimeSieve

function main()
    # Problem parameters
    n = 10^7

    # Algorithm parameters

    # Solution
    sieve = PrimeSieve.Calculator(n)

    prime_factors = [[] for _ in 1:n]
    for p in sieve.primes
        for t in p:p:n
            push!(prime_factors[t], p)
        end
    end

    slots = [true for _ in 1:n]
    for p in sieve.primes
        if belongs_to_s(prime_factors, p)
            k = 2
        else
            k = 1
        end

        for t in p^k:p^k:n
            slots[t] = false
        end
    end

    result = 0
    for i in 1:n
        if slots[i]
            result += i
        end
    end

    return result
end

function belongs_to_s(prime_factors, p)
    if p == 2
        return true
    end

    if mod(p, 4) != 1
        return false
    end

    for q in prime_factors[p - 1]
        if !belongs_to_sr(p, q)
            return false
        end
    end

    return true
end

function belongs_to_sr(p, r)
    x = 0
    y = 0
    while true
        x = g(x, r, p)
        y = g(g(y, r, p), r, p)
        if x == 0 || y == 0
            return true
        elseif x == y
            return false
        end
    end
end

function g(x, r, m)
    return mod(powermod(x, r, m) + 1, m)
end

@time println(main())
