include("../includes.jl")

using Printf

using .PrimeSieve
using .PrimeCount

function main()
    # Problem parameters

    # Algorithm parameters
    n = 10^16

    # Solution
    limit = isqrt(n)
    sieve = PrimeSieve.Calculator(limit)
    prime_counter = PrimeCount.Calculator(n, sieve)

    result = 0.0
    for i in 1:length(sieve.primes)
        p = sieve.primes[i]
        r = 2
        t = 0.0
        while Int128(p)^r <= n
            t += Float64(r - 1) * (PrimeCount.phi(prime_counter, fld(n, p^r), i) - 1)
            r += 1
        end
        t = t / Float64(p - 1)
        result += t
    end

    result = result / Float64(n)

    factor = 10.0^12
    result = floor(result * factor) / factor
    result = @sprintf("%.12f", result)

    return result
end

@time println(main())
