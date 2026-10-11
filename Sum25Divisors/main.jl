include("../includes.jl")

using Printf

function sigma_1_mod_25(p, e)
    t = 0
    for r in 0:e
        t = mod(t + powermod(p, r, 25), 25)
    end
    return t
end

function main()
    # Problem parameters
    n = 10^15

    # Algorithm parameters

    # Solution
    result = 0

    limit = Common.iroot(n, 4)
    primes = PrimeSieve.Calculator(limit).primes

    # First case
    limit_24 = Common.iroot(n, 24)
    for p in primes
        if p > limit_24
            break
        end
        if sigma_1_mod_25(p, 24) == 0
            n = p^24
            result += n
        end
    end

    # Second case
    for a in 1:(length(primes) - 1)
        p = primes[a]
        for b in (a + 1):length(primes)
            q = primes[b]
            if p * q > limit
                break
            end
            if mod(sigma_1_mod_25(p, 4) * sigma_1_mod_25(q, 4), 25) == 0
                n = p^4 * q^4
                result += n
            end
        end
    end

    return result
end

@time println(main())
